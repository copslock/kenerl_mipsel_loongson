Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2009 16:50:24 +0000 (GMT)
Received: from tenor.i-cable.com ([203.83.115.107]:10492 "HELO
	tenor.i-cable.com") by ftp.linux-mips.org with SMTP
	id S21102842AbZBTQuW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Feb 2009 16:50:22 +0000
Received: (qmail 17999 invoked by uid 508); 20 Feb 2009 16:50:13 -0000
Received: from 203.83.114.122 by tenor (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.21631 secs); 20 Feb 2009 16:50:13 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 20 Feb 2009 16:50:12 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n1KGo7Qt003282;
	Sat, 21 Feb 2009 00:50:12 +0800 (CST)
Date:	Sat, 21 Feb 2009 00:50:01 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] implement syscall pciconfig_iobase
Message-ID: <20090220164926.GA28041@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20090220130156.GA14095@adriano.hkcable.com.hk> <20090220145127.GD19924@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090220145127.GD19924@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 14:51 Fri 20 Feb     , Ralf Baechle wrote:
> On Fri, Feb 20, 2009 at 09:01:57PM +0800, Zhang Le wrote:
> 
> > Currently, xorg-server on loongson need a patch:
> > http://www.gentoo-cn.org/gitweb/?p=loongson;a=blob;f=x11-base/xorg-server/files/xorg-server-1.5.3-loongson.patch;h=9c48b3752b7f14b6603524f46ae832f312e7c6fe;hb=HEAD#l37
> > Please note that line 37, the last parameter to mmap, which is the ioBase_phys,
> > is hardcoded.
> > 
> > This patch no long applies to xorg-server git master.
> 
> It should have been rejected by the maintainer before.  This was obviously
> fragile and had no fighting chance to ever work on anything but a Fulong.

Exactly.

[snip]

> # lspci -vvv -s 1d.1
> 00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
> 	Subsystem: Dell Device 01fe
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 21
> 	Region 4: I/O ports at 6f60 [size=32]
> 	Kernel driver in use: uhci_hcd
> 
> Now let's see how to find this in sysfs:
> 
> # ls -l /sys/bus/pci/devices/0000:00:1d.1/resource*
> -r--r--r-- 1 root root 4096 2009-02-20 14:13 /sys/bus/pci/devices/0000:00:1d.1/resource
> -rw------- 1 root root   32 2009-02-20 14:20 /sys/bus/pci/devices/0000:00:1d.1/resource4
> # cat /sys/bus/pci/devices/0000:00:1d.1/resource
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 0x0000000000006f60 0x0000000000006f7f 0x0000000000020101
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 0x0000000000000000 0x0000000000000000 0x0000000000000000
> 
> So if you want to mmap the 4th resource, just mmap the file
> /sys/bus/pci/devices/0000:00:1d.1/resource4.  This leaves how to obtain
> the "0000:00:1d.1" - you have to find it by looking at the vendor and device
> files in every file in /proc/bus/pci/devices/ which contain the PCI vendor
> and device ID as hex numbers.  For my example device here:
> 
> [root@h5 0000:09:00.0]# cat device 
> 0x1673
> [root@h5 0000:09:00.0]# cat vendor 
> 0x14e4
> [root@h5 0000:09:00.0]#
> 
> Hopefully X finally has some nice infrastructure for this sort of stuff.
> 
> And for completeness sake, directly looking at the BARs in the PCI config
> space is another method but this one is deprecated these days as it may
> not work on some complex systems.
> 
> # od -A x -t x4 -j 0x10 -N 0x20 /proc/bus/pci/00/1d.1 
> 000010 00000000 00000000 00000000 00000000
> 000020 00006f61 00000000 00000000 01fe1028
> 000030
> #

Thank you for the above comment! It is very informative! 
I will try to make a new patch.

Zhang, Le
