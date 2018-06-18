from ina219 import INA219
import sys

measure = float(sys.argv[1])

ina = INA219(shunt_ohms=0.1,
  max_expected_amps = measure,
  address=0x40)

ina.configure(voltage_range=ina.RANGE_16V,
  gain=ina.GAIN_AUTO,
  bus_adc=ina.ADC_128SAMP,
  shunt_adc=ina.ADC_128SAMP)

v = ina.voltage()
i = ina.current()
p = ina.power()
print (v,i,p)
