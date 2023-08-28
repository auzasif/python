EIRPu = float(input('Enter the uplink EIRP: '))
EIRPd = float(input('Enter the downlink EIRP: '))
GTRu = float(input('Enter the uplink G/T: '))
GTRd = float(input('Enter the downlink G/T: '))
FSLu = float(input('Enter the uplink FSL: '))
FSLd = float(input('Enter the downlink FSL: '))
RFLu = float(input('Enter the uplink RFL: '))
RFLd = float(input('Enter the downlink RFL: '))
AAu = float(input('Enter the uplink AA: '))
AAd = float(input('Enter the downlink AA: '))
AMLu = float(input('Enter the uplink AML: '))
AMLd = float(input('Enter the downlink AML: '))
lossu = FSLu + RFLu + AAu + AMLu
print('uplink loss: ',lossu)
lossd = FSLd + RFLd + AAd + AMLd
print('downlink loss: ',lossd)
CNRu = EIRPu + GTRu - lossu + 228.6
print('Total carrier to noise ratio for uplink is:','{:.2f}'.format(CNRu),'decilog')
CNRd = EIRPd + GTRd - lossd + 228.6
print('Total carrier to noise ratio for downlink is:','{:.2f}'.format(CNRd),'decilog')
CNRt = (CNRu * CNRd)/(CNRu + CNRd)
print('Total carrier to noise ratio is: ','{:.2f}'.format(CNRt),'decilog')