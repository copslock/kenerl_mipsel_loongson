Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2007 18:23:16 +0000 (GMT)
Received: from spamgate.koyote.com ([204.11.24.49]:61592 "EHLO
	spamgate.koyote.com") by ftp.linux-mips.org with ESMTP
	id S20022867AbXKRSXG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Nov 2007 18:23:06 +0000
Received: from localhost (test [127.0.0.1])
	by spamgate.koyote.com (Postfix) with ESMTP id 57329CBF8D
	for <linux-mips@linux-mips.org>; Sun, 18 Nov 2007 12:21:06 -0600 (CST)
Received: from spamgate.koyote.com ([127.0.0.1])
	by localhost (spamgate.koyote.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id PG9luhf4f5wI for <linux-mips@linux-mips.org>;
	Sun, 18 Nov 2007 12:21:04 -0600 (CST)
Received: from mail.localdomain (mail.enetonline.net [204.11.24.29])
	by spamgate.koyote.com (Postfix) with ESMTP id 261D8CBC7D
	for <linux-mips@linux-mips.org>; Sun, 18 Nov 2007 12:21:04 -0600 (CST)
Received: from mythtv.ewol.com (unknown [66.209.47.173])
	by mail.localdomain (Postfix) with ESMTP id 3ECDE3F8A4D
	for <linux-mips@linux-mips.org>; Sun, 18 Nov 2007 12:23:02 -0600 (CST)
Message-ID: <47408305.5090804@cortland.com>
Date:	Sun, 18 Nov 2007 13:23:01 -0500
From:	Steve Brown <sbrown@cortland.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: ohci-ssb driver on a Broadcom BCM5354
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sbrown@cortland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbrown@cortland.com
Precedence: bulk
X-list: linux-mips

The 5354 has a dual ohci/ehci usb core. It's in an ASUS WL520gu wifi 
router. The ohci hcd driver registers, but times out reading a 
descriptor from the device.

Any suggestions on how to track down the problem?

I'm using 2.6.32.1 kernel from the openwrt project with the "ohci SSB 
bus glue" and "Fix ohci-ssb with !CONFIG_PM" patches from linux-mips.  
If there is a better test frame, let me know and I'll build it and test 
that.

Is this driver known to work with some combination of Broadcom hardware?

The ohci/usb interface does work w/ the software provided with the WL520gu.

Steve

usbcore: registered new interface driver 
usbfs                                                                                                         

usbcore: registered new interface driver 
hub                                                                                                           

usbcore: registered new device driver 
usb                                                                                                              

ohci_hcd ssb0:1: SSB OHCI 
Controller                                                                                                                   

ohci_hcd ssb0:1: new USB bus registered, assigned bus number 
1                                                                                         

ohci_hcd ssb0:1: irq 5, io mem 
0x18003000                                                                                                              

usb usb1: configuration #1 chosen from 1 
choice                                                                                                        

hub 1-0:1.0: USB hub 
found                                                                                                                             

hub 1-0:1.0: 2 ports 
detected                                                                                                                          

USB Universal Host Controller Interface driver 
v3.0                                                                                                    

Initializing USB Mass Storage 
driver...                                                                                                                

usbcore: registered new interface driver 
usb-storage                                                                                                   

USB Mass Storage support registered.   
usb 1-1: new full speed USB device using ohci_hcd and address 
2                                                                                        

usb 1-1: device descriptor read/64, error 
-145                                                                                                         


===================

> root@OpenWrt:/# cat 
> /proc/bus/usb/devices                                                                                                             
>  
>                                                                                                                                                       
>  
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 
> 2                                                                                     
>  
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  
> 0                                                                                                        
>  
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  
> 1                                                                                          
>  
> P:  Vendor=0000 ProdID=0000 Rev= 
> 2.06                                                                                                                 
>  
> S:  Manufacturer=Linux 2.6.23.1 
> ssb-usb-ohci                                                                                                          
>  
> S:  Product=SSB OHCI 
> Controller                                                                                                                       
>  
> S:  
> SerialNumber=ssb0:1                                                                                                                               
>  
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  
> 0mA                                                                                                                
>  
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 
> Driver=hub                                                                                     
>  
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 
> Ivl=255ms                                                                                                         
>  
                                                             
