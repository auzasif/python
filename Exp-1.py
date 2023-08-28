import math
f = float(input('Enter the frequency in MHz: '))
l = 300/f
print('Thus the wavelength, L : ', l)
d = float(input('Enter the distance in Km: '))
gt = float(input('Enter the transmitting antenna gain in dB:'))
gr = float(input('Enter the receiving antenna gain in dB:'))
pt = float(input('Enter the transmitted power in dB: '))
l1 = 20*math.log(d, 10)
l2 = 20*math.log(f, 10)
ls = 32.44 + l1 + l2
print('The path loss is:', '{:.2f}'.format(ls), 'dB')
pr = pt + gt + gr - ls
print('The received power is:', '{:.2f}'.format(pr), 'dB')
pp = pr/10
prw = math.pow(10, pp)
print('The received power is: ', prw, 'watts')
