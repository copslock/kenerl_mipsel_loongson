Received:  by oss.sgi.com id <S42229AbQGXE4Q>;
	Sun, 23 Jul 2000 21:56:16 -0700
Received: from chmls05.mediaone.net ([24.147.1.143]:52872 "EHLO
        chmls05.mediaone.net") by oss.sgi.com with ESMTP id <S42220AbQGXEzx>;
	Sun, 23 Jul 2000 21:55:53 -0700
Received: from pianoman.cluster.toy (h00001c600ed5.ne.mediaone.net [24.147.29.131])
	by chmls05.mediaone.net (8.8.7/8.8.7) with ESMTP id AAA24064
	for <linux-mips@oss.sgi.com>; Mon, 24 Jul 2000 00:55:29 -0400 (EDT)
Message-Id: <200007240455.AAA24064@chmls05.mediaone.net>
Date:   Mon, 24 Jul 2000 00:55:49 EDT
From:   John Clemens <clemej@alum.rpi.edu>
To:     linux-mips@oss.sgi.com
Subject: Indigo2 bootinfo problems (2.2.14 OK, anything after=NOT)
Reply-To: clemej@alum.rpi.edu
X-Mailer: Spruce 0.7.1 for X11 w/smtpio 0.7.9
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing





Hello..

I'm being bitten by the post-2.2.14-including-2.4.0-does-not-boot syndrome.

Everything I've triend, even the pre-compiled kernels from Simple Linux
don't work, except for th 2.2.14 kernels. (and the earlier 2.2 kernels I
compiled around christmastime last year, when I had time to work on this
before.)

It's in indigo2, R4400 - 200Mhz, XZ graphics (but tried with the cards
pulled to no avail).  Most kernels just print the numbers right after you
type boot and the nothing else.  But if you boot with 2.2.14, then it boots
just fine.
I'm enclosing a boot log of the 2.2.14 boot to show what prom and arcs
version I'm running.. maybe they're provide some clues?

john.c


>> boot vml-2214 boot=/bin/bash console=ttyS0 nfsroot=192.168.8.1:/sl
130768+22320+3184+341792+48560d+4604+6816 entry: 0x8ffa60d0
ARCH: SGI-IP22
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 132923392 bytes (129808K,126MB)
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 2048K linesize 128
Linux version 2.2.14 (wesolows@fallout) (gcc version egcs-2.91.66 19990314
(egc0
MC: SGI memory controller Revision 3
Vino: ID:00 Rev:00
0x00 0x00 0x088134c34 0x00
0x00 0x00 0x00 0x00
calculating r4koff... 000f43d0(1000400)
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 99.94 BogoMIPS
Memory: 125788k/261652k available (1140k kernel code, 2844k data)
Dentry hash table entries: 16384 (order 5, 128k)                           
   Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Starting kswapd v 1.5
initialize_kbd: Keyboard failed self test
Detected PS/2 Mouse Port.
SGI Zilog8530 serial driver version 1.00
Keyboard timeout[2]
Keyboard timeout[2]
tty00 at 0xbfbd9830 (irq = 37) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 37) is a Zilog8530                              
   DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
Linux video capture interface: v1.00
loop: registered device at major 7
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled May 18 2000 at 16:33:06
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled May 18 2000 at 16:33:06
scsi0 : SGI WD93
scsi1 : SGI WD93
scsi : 2 hosts.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: QUANTUM
XP32150 C
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4404489 [2150 MB] [2.2
GB]   sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:09:07:b3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.8.1, my address is 192.168.8.5
Partition check:
 sda: sda1 sda2 sda3 sda4
Looking up port of RPC 100003/2 on 192.168.8.1
Looking up port of RPC 100005/1 on 192.168.8.1
VFS: Mounted root (NFS filesystem) readonly.
Freeing prom memory: 768k freed
Freeing unused kernel memory: 60k freed
Running /etc/rc. . .
Performing file system check                                               
   sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:09:07:b3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.8.1, my address is 192.168.8.5
Partition check:
 sda: sda1 sda2 sda3 sda4
Looking up port of RPC 100003/2 on 192.168.8.1
Looking up port of RPC 100005/1 on 192.168.8.1
VFS: Mounted root (NFS filesystem) readonly.
Freeing prom memory: 768k freed
Freeing unused kernel memory: 60k freed
Running /etc/rc. . .
Performing file system check                                               
    
 

-- 
- --
/* John Clemens     http://www.rpi.edu/~clemej _/ "I Hate Quotes"       */
/* ICQ: 7175925     clemej@rpi.edu           _/    -- Samuel L. Clemens */ 
/* RPI Comp. Eng. 2000, Linux Parallel/Network/OS/Driver Specialist     */
