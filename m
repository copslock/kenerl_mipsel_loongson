Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBELPrM09758
	for linux-mips-outgoing; Fri, 14 Dec 2001 13:25:53 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBELPlo09748
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 13:25:47 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC3G1G>; Fri, 14 Dec 2001 15:25:40 -0500
Message-ID: <25369470B6F0D41194820002B328BDD21423ED@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: "'Justin Carlson '" <justincarlson@cmu.edu>,
   Dinesh Nagpure
	 <dinesh_nagpure@ivivity.com>
Cc: "'linux-mips@oss.sgi.com '" <linux-mips@oss.sgi.com>
Subject: RE: 2.4.16 on mips-malta, networking fails...
Date: Fri, 14 Dec 2001 15:25:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Boot time msgs are :

 PCI: Probing PCI hardware on host bus 0.
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 Starting kswapd         
 pty: 256 Unix98 ptys configured 
 Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI edttyS00 at 0x03f8 (irq = 4) is a 16550A 
ttyS01 at 0x02f8 (irq = 3) is a 16550A  
block: 128 slots per queue, batch=32 
RAMDISK driver initialized: 16 RAM disks of 30720K size 1024 blocksize
loop: loaded (max 8 devices)

pcnet32_probe_pci: found device 0x001022.0x002000
ioaddr=0x001200  resource_flags=0x000101

eth0: PCnet/FAST III 79C973 at 0x1200, 00 d0 a0 00 01 29

pcnet32: pcnet32_private lp=a7f9b000 lp_dma_addr=0x7f9b000 assigned IRQ 10.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de


Apparently the device is being detected.
I am using ramdisk root which i created using busybox v0.60.1 and dont have
ifconfig or route built into it.

Dinesh
                                                   
-----Original Message-----
From: Justin Carlson
To: Dinesh Nagpure
Cc: linux-mips@oss.sgi.com
Sent: 12/14/01 3:03 PM
Subject: Re: 2.4.16 on mips-malta, networking fails...

On Fri, 2001-12-14 at 14:52, Dinesh Nagpure wrote:
> Hello,
> I am trying kernel v2.4.16 on mips-malta, but networking does not seem
to be
> working for me.
> ping errors out saying sendto: Network is unreachable.
> I have AMD PCNet32 PCI support enabled under Network device
support-Ethernet
> (10 or 100)- EISA, VLB, PCI and onboard controllers. 
> Any ideas?
> 

Is the network device being detected by the driver, e.g. do you see
any status messages from the driver on bootup?

What commands are you using to initialize the interface?  What
does ifconfig say?  How about route -n?

-Justin
