Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2003 18:13:57 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10481 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225382AbTKCSNp>;
	Mon, 3 Nov 2003 18:13:45 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA12987;
	Mon, 3 Nov 2003 10:13:06 -0800
Subject: Re:
From: Pete Popov <ppopov@mvista.com>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <000001c3a018$ed5efb30$800101df@radium>
References: <000001c3a018$ed5efb30$800101df@radium>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1067883270.19090.41.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Nov 2003 10:14:30 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


Lyle,

>  0ST 2003<4>calculating r4koff... 00493e00(4800000)
> CPU frequency 480.00 MHz


This doesn't look right. Please do another pull of the linux-mips tree.
A few days ago I fixed a masking problem (0x7f vs 0x3f) that resulted in
a bogus CPU frequency reading. The serial baud rate value is calculated
based on the CPU frequency so if the CPU frequency we calculate is
wrong, the uart baud rate will be off too. 

Do a cvs update and if that doesn't fix the problem, let me know.

Pete

> set_au1x00_lcd_clock: warning: LCD clock too high (60000
> KHz)<4>Calibrating dela
> y loop... 478.41 BogoMIPS
> Memory:8r9804k/32768k available (1257k kernel code, 2964k reserved, 84k
> data, 76
> k init, 0k highmem)<6>Dentry cache hash table entries: 4096 (order: 3,
> 32768 byt
> es)
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<4>Checking
> for 'wait
> ' instruction... unavailable.
> POSIX conformance testing by UNIFIX
> Autoconfig PCI channel 0x80267b18
> X1Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
>  04k data, 76k init, 0k highmem)
> 00:0c.0 Class 0104: 1103:0007 (rev 01)
>         I/O at 0x00000300 [size=0x8]
>         I/O at 0x00000308 [size=0x4]
>         I/O at 0x00000310 [size=0x8]
>         I/O at 0x00000318 [size=0x4]
>         I/O at 0x00000400 [size=0x100]
> Non-coherent PCI accesses enabled<6>Linux NET4.0 for Linux 2.4<6>Based
> upon Swan
> sea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapda6>Journalled Block Device driver loaded
> pty: 256 Unix98 ptys configured<6>Serial driver version 1.01
> (2001-02-08) with n
> o serial options enabled
>  eata, 76k init, 0k highmem)<6>ttyS00 at 0xb1100000 (irq = 0) is a 16550
> ttyS01 at 0xb1200000 (irq = 1) is a 16550<6>ttyS02 at 0xb1300000 (irq =
> 2) is a
> 16550
> ttyS03 at 0xb1400000 (irq = 3) is a 1655056>loop: loaded (max 8 devices)
> )(is a 16550<4>au1000eth.c:1.4 ppopov@mvista.com
> eth0: Au1x Ethernet found at 0xb1500000, irq 28<4>ethaddr not set in
> boot prom<6
> >eth0: Broadcom BCM5222 10/100 BaseT PHY at phy address 3<6>eth0: Using
> Broadcom
>  BCM5222 10/100 BaseT PHY as default<6>Uniform Multi-Platform E-IDE
> driver Revis
> ion: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx<6>HP
> T371: IDE controller at PCI slot 07:0c.0<6>HPT371: chipset revision
> 1<6>HPT371:
> not 100% native mode: will probe irqs later
> HPT37X: using 33MHz PCI clock<6>    ide0: BM-DMA at 0x0408-0x040, BIOS
> settings:
>  hd:pio, hd:pio
> HPT371: port 0x0310 already claimed by ide0
> NET4: Linux TCP/IP 1.0 for NET4.0<6>IP Protocols: ICMP, UDP, TCP, IGMP
> 6>IP: routing cache hash table of 512 buckets, 4Kbytes
> verride with idebus=xx=6>TCP: Hash tables configured (established 2048
> bind 4096
> )
> 
> 
> 
