Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2007 22:57:53 +0000 (GMT)
Received: from ra.tuxdriver.com ([70.61.120.52]:28428 "EHLO ra.tuxdriver.com")
	by ftp.linux-mips.org with ESMTP id S20028909AbXKRW5n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Nov 2007 22:57:43 +0000
Received: from linville-t61.local (azure.tuxdriver.com [70.61.120.53])
	(authenticated bits=0)
	by ra.tuxdriver.com (8.14.0/8.13.7) with ESMTP id lAIMov1H017455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 18 Nov 2007 17:51:02 -0500
Received: from linville-t61.local (linville-t61.local [127.0.0.1])
	by linville-t61.local (8.14.1/8.14.1) with ESMTP id lAIMlrIi012682;
	Sun, 18 Nov 2007 17:47:53 -0500
Received: (from linville@localhost)
	by linville-t61.local (8.14.1/8.14.1/Submit) id lAIMlqdr012681;
	Sun, 18 Nov 2007 17:47:52 -0500
Date:	Sun, 18 Nov 2007 17:47:52 -0500
From:	"John W. Linville" <linville@tuxdriver.com>
To:	Steve Brown <sbrown@cortland.com>
Cc:	linux-mips@linux-mips.org, mb@bu3sch.de
Subject: Re: ohci-ssb driver on a Broadcom BCM5354
Message-ID: <20071118224752.GB12263@tuxdriver.com>
References: <47408305.5090804@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47408305.5090804@cortland.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

You probably want to make Michael Buesch aware of this issue.

John

On Sun, Nov 18, 2007 at 01:23:01PM -0500, Steve Brown wrote:
> The 5354 has a dual ohci/ehci usb core. It's in an ASUS WL520gu wifi 
> router. The ohci hcd driver registers, but times out reading a descriptor 
> from the device.
>
> Any suggestions on how to track down the problem?
>
> I'm using 2.6.32.1 kernel from the openwrt project with the "ohci SSB bus 
> glue" and "Fix ohci-ssb with !CONFIG_PM" patches from linux-mips.  If there 
> is a better test frame, let me know and I'll build it and test that.
>
> Is this driver known to work with some combination of Broadcom hardware?
>
> The ohci/usb interface does work w/ the software provided with the WL520gu.
>
> Steve
>
> usbcore: registered new interface driver usbfs                              
>                                                                            
> usbcore: registered new interface driver hub                                
>                                                                            
> usbcore: registered new device driver usb                                   
>                                                                            
> ohci_hcd ssb0:1: SSB OHCI Controller                                        
>                                                                            
> ohci_hcd ssb0:1: new USB bus registered, assigned bus number 1              
>                                                                            
> ohci_hcd ssb0:1: irq 5, io mem 0x18003000                                   
>                                                                            
> usb usb1: configuration #1 chosen from 1 choice                             
>                                                                            
> hub 1-0:1.0: USB hub found                                                  
>                                                                            
> hub 1-0:1.0: 2 ports detected                                               
>                                                                            
> USB Universal Host Controller Interface driver v3.0                         
>                                                                            
> Initializing USB Mass Storage driver...                                     
>                                                                            
> usbcore: registered new interface driver usb-storage                        
>                                                                            
> USB Mass Storage support registered.   usb 1-1: new full speed USB device 
> using ohci_hcd and address 2                                                
>                                         
> usb 1-1: device descriptor read/64, error -145                              
>                                                                            
>
> ===================
>
>> root@OpenWrt:/# cat /proc/bus/usb/devices                                  
>>                                                                            
>>                                                                            
>>                                                                            
>>   T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2        
>>                                                                            
>>    B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0                          
>>                                                                            
>>     D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1           
>>                                                                            
>>      P:  Vendor=0000 ProdID=0000 Rev= 2.06                                 
>>                                                                            
>>       S:  Manufacturer=Linux 2.6.23.1 ssb-usb-ohci                         
>>                                                                            
>>        S:  Product=SSB OHCI Controller                                     
>>                                                                            
>>         S:  SerialNumber=ssb0:1                                            
>>                                                                            
>>          C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA                            
>>                                                                            
>>           I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 
>> Driver=hub                                                                 
>>                      E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms         
>>                                                                            
>>                       
>                                                             

-- 
John W. Linville
linville@tuxdriver.com
