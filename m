Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 15:49:50 +0100 (BST)
Received: from webmail16.rediffmail.com ([IPv6:::ffff:203.199.83.26]:35525
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225208AbTDIOtt>; Wed, 9 Apr 2003 15:49:49 +0100
Received: (qmail 6143 invoked by uid 510); 9 Apr 2003 14:52:28 -0000
Date: 9 Apr 2003 14:52:28 -0000
Message-ID: <20030409145228.6142.qmail@webmail16.rediffmail.com>
Received: from unknown (210.210.49.69) by rediffmail.com via HTTP; 09 apr 2003 14:52:28 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: Problem in pci-bridge or NIC driver..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am not able to conclude whether my problem belongs to pci-bridge 
side or towards my NIC drivers.

1> I am using thee network cards in my BSP process ..Intel 82557 , 
RealTek 8139 and 3COM
3c905b ..all these three card works fine on different machine.

2>I have great difficulty in having serial eeprom and mdio 
interface both working and responding correctly to pci 
transactions.

3>in pci io space i can't use 82557 and RTL8139 cards as simply i 
amn't able to read serial eeprom and hence their MAC addresss 
remains undetected  while on other machine same two card's serial 
eeprom responds fine in pci io space as well.
serial eeprom response in pci mem space is fine but other nasty 
problems.

However my 3com card serial eeprom responds perfectly fine on my 
developement system.

So, where is the probelm ..i am confused..

4>but my 3COM card MII interface doesn't respond ( it is having 
only pci io bar) in pci io space.

while i am yet to get diagnostic reports from mii diag programmes 
for these card..meantime I want a hint if I need to see anything 
on PCI bridge side.

Best Regards,
Ashish Anand


_______________________________________________________________________
Odomos - the only  mosquito protection outside 4 walls -
Click here to know more!
http://r.rediff.com/r?http://clients.rediff.com/odomos/Odomos.htm&&odomos&&wn
