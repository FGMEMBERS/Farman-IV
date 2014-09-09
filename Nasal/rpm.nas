# ***********************************************
# **** Forcer les rpm à 0 si moteur arrêté   ****
# **** BARANGER Emmanuel                2012 ****
# ***********************************************

var running0 = props.globals.getNode("/engines/engine[0]/running",1);
var starter0 = props.globals.getNode("/controls/engines/engine[0]/starter",1);
var enginerpm0 = props.globals.getNode("/engines/engine[0]/rpm");

var update_rpm = func 
{
  if (!(running0.getBoolValue()) and !(starter0.getBoolValue())) {
    enginerpm0.setValue(0);
  }
}

var main_loop = func {
  update_rpm();
  settimer(main_loop, 0);
}

setlistener("/sim/signals/fdm-initialized", func {
  main_loop();
});
