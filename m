Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 15:08:10 +0100 (BST)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:64251 "EHLO simek")
	by linux-mips.org with ESMTP id <S8225202AbTDNOII>;
	Mon, 14 Apr 2003 15:08:08 +0100
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 1954cK-0000DZ-00; Mon, 14 Apr 2003 16:07:28 +0200
Date: Mon, 14 Apr 2003 16:07:18 +0200
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
Message-ID: <20030414140717.GA805@simek>
References: <3E98F206.5050206@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E98F206.5050206@gentoo.org>
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 13, 2003 at 01:13:42AM -0400, Kumba wrote:
> 	Greetings,

Hi,

> 	Couple issues I've tried to bring up on this ML, but I think was 
> blocked due my having an AOL.com address (which most people on this list 
> probably categorize as spam).  Anyways...
> 
> 	The two issues I've run into are my failure to get a kernel compiled 
> from linux-mips.org CVS to actually boot, and linux, when I use a 
> working kernel, does not detect the full 320MB of ram in my machine.
> 
> 	On the first issue, the kernel builds fine, just does not boot.  
> 	There is no output from the kernel on why it refuses to boot.  It just 
> stops responding to any input, and I hear no disk activity from the machine 
> indicating it's actually doing something.  I even tried with with an 
> antiquitated 2.4.3 kernel apparently off CVS as well, same result. 
> However, using a stock kernel off kernel.org plus a debian patch for 
> 2.4.19, a workable kernel can be built and it boots fine.  I've since 
> modified this debian patch to work with newer kernels (up to 
> 2.4.21-pre7), and it works, no problems.  I have no further idea what is 
> wrong in this case.

I'd say you've tried cvs kernel at the times when support for R4400
caches was broken. I put kernel I'm currently running at
http://www.linux-mips.org/~ladis/vmlinux.gz (gunzip it :)), as you can
see from dmesg at the end of this mail CPU used in your machine is the
same. If kernel I provided doesn't boot for you I'd like to ask you for
help with debugging (kernel was build from cvs updated at 8:30 CEST)

> 	On the second issue, a "hinv" command at the PROM Monitor lists my 
> machine as having 320MB of ram, however the kernel is apparently only 
> detecting 256.  Upon the advice of Keith Wesolowski of Project Foobazco, 
> I enabled the DEBUG #define in arch/mip/arc/memory.c to see what the ARC 
> Memory descriptor dump was like.  Keith said the dump indicated that 
> whatever was going on between the kernel and the PROM/ARC, the kernel 
> was specifically being told there is 256MB of ram.

This is known bug, but unfortunately I have not enough RAM to meet it...

> 	For reference, the first eight slots are filled with 32meg SIMMs, 
> 	and the last four filled with four 16MB simms, for a total of 320MB.  I 
> tried testing only the four 16MB simms in the first bank, and both hinv 
> and the kernel reported a functional amount of ram roughly equal to 
> 64MB.  I tried putting 128MB in bank 1, 64MB in bank 2, and the 
> remaining 128MB in bank 3, thinking linux just doesn't see the last bank 
> of ram...ARC/PROM still reported 320MB, the kernel said 256MB.
> 
> 	Really I'm at a loss as to what is wrong.  I do know that when I 
> briefly had installed an IP28 mainboard + R10K module, and all the ram 
> and booted Thiemo's experimental 2.5.1 IP28 kernel, it saw all 320MB of 
> ram.  However, that being a totally different mainboard, such 
> information is probably not pertinent to this little investigation here...
> 
> 	I've included a log of what hinv says, my attempt to boot a CVS 
> 	kernel, and a working kernel.  Of notice, is with the CVS kernel, I also 
> enabled DEBUG in arch/mips/arc/memory.c, and that did print debug output , 
> however nothing further to indicate the CVS kernel booting.  My PROM 
> chip also says this information: P/N: 070-1367-010, 3895 S6275.  I 
> include that only on the odd circumstance I have an extremely weird 
> PROM.  Who knows...
> 
> 	If any other information is needed, let me know, I'll provide 
> 	whatever I can.  It may not seem like much, it's only another 64MB of ram 
> not available, but it's definitely out of the norm, so I figure it's worth 
> a good look into.
> 
> --Kumba
> Gentoo/Sparc/Mips Developer

> // hinv output
> 
>                    System: IP22
>                 Processor: 250 Mhz R4400, with FPU
>      Primary I-cache size: 16 Kbytes
>      Primary D-cache size: 16 Kbytes
>      Secondary cache size: 2048 Kbytes
>               Memory size: 320 Mbytes
>                 SCSI Disk: scsi(0)disk(1)
>                 SCSI Disk: scsi(0)disk(2)
>                SCSI CDROM: scsi(0)cdrom(4)
>                     Audio: Iris Audio Processor: version A2 revision 1.1.0
> 
> 
> 
> 
> // linux-mips CVS kernel Boot attempt
> 
> >> boot -f 2421pm
> ARCS MEMORY DESCRIPTOR dump:
> [0,a8748a48]: base<00000000> pages<00000001> type<Exception Block>
> [1,a8748a64]: base<00000001> pages<00000001> type<ARCS Romvec Page>
> [2,a8748a2c]: base<00008002> pages<000001dd> type<Standalone Program Pages>
> [3,a87492fc]: base<000081df> pages<00000561> type<Generic Free RAM>
> [4,a87492cc]: base<00008740> pages<000000c0> type<ARCS Temp Storage Area>
> [5,a87492b0]: base<00008800> pages<0000f800> type<Generic Free RAM>
> 
> 
> 
> 
> // 2.4.21-pre7 off kernel.org + modified debian patch
> 
> >> boot -f 2421p7d
> ARCS MEMORY DESCRIPTOR dump:
> [0,a8748a48]: base<00000000> pages<00000001> type<Exception Block>
> [1,a8748a64]: base<00000001> pages<00000001> type<ARCS Romvec Page>
> [2,a8748a2c]: base<00008002> pages<000001ee> type<Standalone Program Pages>
> [3,a87492fc]: base<000081f0> pages<00000550> type<Generic Free RAM>
> [4,a87492cc]: base<00008740> pages<000000c0> type<ARCS Temp Storage Area>
> [5,a87492b0]: base<00008800> pages<0000f800> type<Generic Free RAM>
> ARCH: SGI-IP22
> PROMLIB: ARC firmware Version 1 Revision 10
> CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
> CPU revision is: 00000460
> FPU revision is: 00000500
> Primary instruction cache 16kb, linesize 16 bytes.
> Primary data cache 16kb, linesize 16 bytes.
> Secondary cache sized at 2048K linesize 128 bytes.
> Linux version 2.4.21-pre7 (root@isengard) (gcc version 3.2.2) #2 Sat Apr 12 17:3
> 0:18 EDT 2003
> MC: SGI memory controller Revision 3
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 001ee000 @ 08002000 (reserved)
>  memory: 00550000 @ 081f0000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 0f800000 @ 08800000 (usable)
> On node 0 totalpages: 98304
> zone(0): 36864 pages.
> zone(1): 61440 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/sda3
> EISA: Probing bus...
> EISA: slot 4 : TCM5970 detected.
> EISA: Detected 1 card.
> ISA support compiled in.
> Calibrating system timer... 1250000 [250.00 MHz CPU]
> GIO: Scanning for GIO cards...
> GIO: Card 0x7f @ 0x1f000000
> GIO: Card 0x04 @ 0x1f400000
> Console: colour dummy device 80x25
> zs0: console input
> Console: ttyS0 (Zilog8530), 38400 baud
> Calibrating delay loop... 124.92 BogoMIPS
> Memory: 255108k/259392k available (1603k kernel code, 4284k reserved, 108k data,
>  88k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Checking for 'wait' instruction...  unavailable.
> POSIX conformance testing by UNIFIX
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x1
> parport0: PC-style at 0x278 [PCSPP,TRISTATE,EPP]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
it can't work ;)
> initialize_kbd: Keyboard failed self test
> keyboard: Timeout - AT keyboard not present?(ed)
> keyboard: Timeout - AT keyboard not present?(f4)
> pty: 256 Unix98 ptys configured
> DS1286 Real Time Clock Driver v1.0
> lp0: using parport0 (polling).
> tipar: parallel link cable driver, version 1.18
> tipar: registering to devfs : major = 115, minor = 0, node = 0
> tipar0: using parport0 (polling).
> tipar0: link cable not found.
> Hardware Watchdog Timer for SGI IP22: 0.2
> sgiseeq.c: David S. Miller (dm@engr.sgi.com)
> eth0: SGI Seeq8003 08:00:69:0a:6d:33
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> 3c59x: 3Com EISA 3c590 Vortex 10Mbps at 0x4000. Vers LK1.1.16
>  ff:ff:ff:ff:ff:ff, IRQ 3
>   product code ffff rev ffff.15 date 15-31-127
> Full duplex capable
>   1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interfac
> e.
>   Enabling bus-master transmits and early receives.
> 3c59x: scatter/gather enabled. h/w checksums disabled
> SCSI subsystem driver Revision: 1.00
> wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
>            Version 1.25 - 09/Jul/1997, Compiled Apr 12 2003 at 16:25:26
> wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
>            Version 1.25 - 09/Jul/1997, Compiled Apr 12 2003 at 16:25:26
> scsi0 : SGI WD93
> scsi1 : SGI WD93
>  sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST19171W
>  Rev: 2219
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>  sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model: DCHS09F  CLAR09
>  Rev: SG53
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>  sending SDTR 0103013f08sync_xfer=28  Vendor: TOSHIBA   Model: CD-ROM XM-5701TA
>  Rev: 1557
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
> Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
> SCSI device sda: 17783112 512-byte hdwr sectors (9105 MB)
> Partition check:
>  /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3 p4 p5 p6 p7 p8 p9
> SCSI device sdb: 17796078 512-byte hdwr sectors (9112 MB)
>  /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3 p4
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
> scsi0 channel 0 : resetting for second half of retries.
> SCSI bus is being reset for host 0 channel 0.
> scsi0: reset.  sending SDTR 0103013f08sync_xfer=28<3>sr0: CDROM (ioctl) error, c
> ommand: 0x1a 00 2a 00 80 00
> sr00:00: sns =  0  0
> Non-extended sense class 0 code 0x0
> Raw sense data:0x00 0x00 0x00 0x00
> sr0: scsi-1 drive
> Uniform CD-ROM driver Revision: 3.12
> SGI Zilog8530 serial driver version 1.00
> tty00 at 0xbfbd9830 (irq = 45) is a Zilog8530
> tty01 at 0xbfbd9838 (irq = 45) is a Zilog8530
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  sending SDTR 0103013f0csync_xfer=2c<6>kjournald starting.  Commit interval 5 se
> conds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Mounted devfs on /dev
> Freeing prom memory: 768kb freed
> INIT: version 2.84 booting
[snip]

ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
CPU revision is: 00000460
FPU revision is: 00000500
Primary instruction cache 16kb, physically tagged, direct mapped, linesize 16 bytes
Primary data cache 16kb direct mapped, linesize 16 bytes
Secondary cache sized at 1024K, linesize 128 bytes.
Linux version 2.4.21-pre4 (ladis@simek) (gcc version 3.2) #11 Po dub 14 09:10:06 CEST 2003
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 001be000 @ 08002000 (reserved)
 memory: 00580000 @ 081c0000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 03800000 @ 08800000 (usable)
On node 0 totalpages: 49152
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=any
Calibrating system timer... 1000000 [200.00 MHz CPU]
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530), 9600 baud
Calibrating delay loop... 99.94 BogoMIPS
Memory: 60816k/62976k available (1431k kernel code, 2160k reserved, 104k data, 76k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
initialize_kbd: Keyboard failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
DS1286 Real Time Clock Driver v1.0
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 45) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 45) is a Zilog8530
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:ad:02 
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Apr 14 2003 at 09:11:31
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Apr 14 2003 at 09:11:31
scsi0 : SGI WD93
scsi1 : SGI WD93
SGI HAL2 revision 1.1.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.50.22, my address is 192.168.50.56
IP-Config: Complete:
      device=eth0, addr=192.168.50.56, mask=255.255.255.0, gw=192.168.50.1,
     host=indigo2, domain=ckdenergo.cz, nis-domain=(none),
     bootserver=192.168.50.22, rootserver=192.168.50.22, rootpath=/exports/ip22
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.50.22
Looking up port of RPC 100005/1 on 192.168.50.22
VFS: Mounted root (nfs filesystem).
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 76k freed

regards,
	ladis
