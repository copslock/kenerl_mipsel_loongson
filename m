Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA01562 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 13:07:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA13480
	for linux-list;
	Thu, 27 May 1999 13:06:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA47409
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 13:06:07 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from poptart.corp.home.net (poptart.svr.home.net [24.0.26.24]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08780
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 13:06:04 -0700 (PDT)
	mail_from (rck@corp.home.net)
Received: from rck-lap (nt-dhcp198.media.home.net [24.0.22.198])
          by poptart.corp.home.net (Netscape Messaging Server 3.54)
           with SMTP id AAA2A56; Thu, 27 May 1999 13:05:50 -0700
Message-Id: <4.1.19990527124423.00930cd0@mail>
X-Sender: rck@mail
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1 
Date: Thu, 27 May 1999 13:03:32 -0700
To: Ralf Baechle <ralf@uni-koblenz.de>, Robert Keller <rck@corp.home.net>
From: "Robert Keller" <rck@corp.home.net>
Subject: Re: after the kernel seems to live
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <19990527121840.T866@uni-koblenz.de>
References: <4.1.19990526115716.03f65930@mail>
 <4.1.19990526115716.03f65930@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

At 12:18 PM 5/27/99 +0200, Ralf Baechle wrote:
>What CPU is being used on that eval board?  If it's one that isn't yet
>supported in our sources then I suspect you have a problem either with the
>cacheflushing routines themselfes or the calls to them in the network
>driver.  What NIC are you using, btw?  We've got patches around for a
>couple of those which are most often being used with MIPS machines.

Its a VR5000 (D30500S2),  2.2.1 seems to recognize it as a
type 24 (0x18).  Presently, I'm using a PCI 3c905 despite the
fact that the eval board has a 21140 (albeit with a completely
bogus SROM) built in to it.  I have my own patches to 3c59x.c
tulip.c and even tlan.c to get them working to varying degrees.
I'd still be interested in comparing my patches with the ones
you have...

How can I make sure that I'm not haveing cacheflushing problems?

>Unless you're using extremly old binaries I'm highly confident that the
>binaries which you are using are ok.

I'm presently using declinuxroot-990518.tgz from ftp.linux.sgi.com,
so should I assume that it should just work?

I'll include the boot sequence below...

...robert

hello world
prom: start_kernel
prom: altuna_setup
prom: setup_arch done
prom: paging_init done
prom: trap_init done
prom: init_IRQ done
prom: sched_init done
prom: time_init done
prom: parse_options done
Loading R4000 MMU routines.
CPU revision is: 00002321
Primary instruction cache 32kb, linesize 32 bytes)
Primary data cache 32kb, linesize 32 bytes)
Linux version 2.2.1 (rck@senna.rest.home.net) (gcc version egcs-2.90.27 980315
(egcs-1.0.2 release)) #393 Wed May 26 17:23:24 PDT 1999
hello world (printk)
mips_cputype = 0x18
mips_machtype = 0x0
PCI controller (vendor 0x1033 - device 0x5a), revision 2.
calling paging_init with start = 0xa021f5c4, end = 0xa3fff000
pcictrl_l  = 0x80000000
pcictrl_h  = 0x20000000
intctrl_l  = 0x30000000
intctrl_h  = 0x000000a0
intstat0_l = 0x00000000
intstat0_h = 0x00000000
intstat1_l = 0x00000000
intstat1_h = 0x00040000
intclr_l   = 0x00000000
intclr_h   = 0x00000000
intppes_l  = 0x00000004
inside time_init
calculating r4koff... 000f425c(1000028)
parse_options, parsing ''
calling console_init with start = 0xa07c835c, end = 0xa3fff000
prom: console_init done
calling kmem_cache_init with start = 0xa07c835c, end = 0xa3fff000
kmem_cache_init done
Calibrating delay loop... 6.55 BogoMIPS
calibrate_delay done
Memory: 57556k/589820k available (924k kernel code, 6024k data)
mem_init done
kmem_cache_sizes_init 0xa07c9020/0xa07c9020
kmem_cache_sizes_init done
uidcache_init done
filescache_init done
dcache_init done
vma_init done
buffer_init done
signals_init done
inode_init done
file_table_init done
ipc_init done
Checking for 'wait' instruction...  available.
check_bugs done
POSIX conformance testing by UNIFIX
smp_init done
kernel_thread done
init
do_basic_setup
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
chr_dev_init
tty_init
calling rs_init
Serial driver version 4.27 with no serial options enabled
autoconfig - port = 0xa60003f8
autoconfig - port = 0xbfa00300
ttyS00 at 0xa60003f8 (irq = 2) is a 16550A
ttyS01 at 0xbfa00300 (irq = 0) is a 8250
returned from rs_init
tty_init done
chr_dev_init done
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
eth0: 3Com 3c905 Boomerang 100baseTx at 0xa7000000,  00:60:08:31:06:75, IRQ 4
  Internal config register is 16302d8, transceivers 0xe040.
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: Overriding PCI latency timer (CFLT) setting of 0, new value is 32.
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
3c59x.c:v0.99H-WOL 2/24/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
IP-Config: Entered.
eth0: Initial media type MII.
eth0: MII #24 status 786d, link partner capability 0021, setting half-duplex.
eth0: vortex_open() InternalConfig 016302d8.
request_irq 4, eth0 -> 0xa3ff7160
eth0: vortex_open() irq 4 media status 8802.
eth0:  Filling in the Rx ring.
IP-Config: Opened eth0 (able=3)
BOOTP: XID=e7505dc7
Sending BOOTP and RARP requests...<7>eth0: Trying to send a packet, Tx index 0.
ic_rarp_send
BOOTP: Got extension 01 ff ff ff 80
BOOTP: Got extension 03 18 00 13 81
BOOTP: Got extension 06 18 00 13 87
eth0: Trying to send a packet, Tx index 1.
. OK
ic_rarp_recv
IP-Config: Got BOOTP answer from 24.0.19.146, my address is 24.0.19.228
IP-Config: device=eth0, local=e4130018, server=92130018, boot=92130018,
gw=81130018, mask=80ffffff
IP-Config: host=24.0.19.228, domain=(none), path=`'
Looking up port of RPC 100003/2 on 24.0.19.146
eth0: Trying to send a packet, Tx index 2.
eth0: Trying to send a packet, Tx index 3.
Looking up port of RPC 100005/1 on 24.0.19.146
eth0: Trying to send a packet, Tx index 4.
eth0: Trying to send a packet, Tx index 5.
eth0: Trying to send a packet, Tx index 6.
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 44k freed
eth0: Trying to send a packet, Tx index 7.
eth0: Trying to send a packet, Tx index 8.
request_irq 2, serial -> 0xa3ff7a60
eth0: Trying to send a packet, Tx index 9.
eth0: Trying to send a packet, Tx index 10.
eth0: Trying to send a packet, Tx index 11.
eth0: Trying to send a packet, Tx index 12.
eth0: Trying to send a packet, Tx index 13.
eth0: Trying to send a packet, Tx index 14.
eth0: Trying to send a packet, Tx index 15.
eth0: Trying to send a packet, Tx index 16.
[init:1] Illegal instruction at a01cd3d4 ra=a01459b8
[init:1] Illegal instruction at a01cd3d8 ra=a01459b8
[init:1] Illegal instruction at a01cd3dc ra=a01459b8
[init:1] Illegal instruction at a01cd3e0 ra=a01459b8
[init:1] Illegal instruction at a01cd3e4 ra=a01459b8
[init:1] Illegal instruction at a01cd3e8 ra=a01459b8
[init:1] Illegal instruction at a01cd3ec ra=a01459b8
[init:1] Illegal instruction at a01cd3f0 ra=a01459b8
[init:1] Illegal instruction at a01cd3f4 ra=a01459b8
[init:1] Illegal instruction at a01cd3f8 ra=a01459b8
[init:1] Illegal instruction at a01cd3fc ra=a01459b8
[init:1] Illegal instruction at a01cd400 ra=a01459b8
[init:1] Illegal instruction at a01cd404 ra=a01459b8
[init:1] Illegal instruction at a01cd408 ra=a01459b8
