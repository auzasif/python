import math
pt = float(input('Enter the iput power in watts:'))
Pt = 10*math.log(pt, 10)  # calculation transmitted power in db
Gt = float(input('Enter the transmitting antenna gain in db'))
Gr = float(input('Enter the recieving antenna gain in db'))
EIRP = Pt + Gt  # calculating Eirp
d = float(input('Enter the distance in Km:'))
f = float(input('Enter the frecquency im MHz:'))
fsl = 32.4 + 20*math.log(d, 10) + 20*math.log(f, 10)  # calculating path loss
rfl = float(input('Enter the reciver feeder loss in db :'))
aa = float(input('Enter the atmospheric absrption in db :'))
aml = float(input('Enter the antenna misalignment loss in db :'))
pl = float(input('Enter the polarization loss in db :'))
losses = fsl + rfl + aa + aml + pl
print('Total loss=' + str(losses) + 'Db.')
P = EIRP + Gr - losses
print('Total losses power ='+str(P) + 'db')
