Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KK25c24109
	for linux-mips-outgoing; Fri, 20 Jul 2001 13:02:05 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KK23V24106
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 13:02:03 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id WAA04271
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 22:02:01 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15NgTD-0002uU-00
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 22:01:55 +0200
Date: Fri, 20 Jul 2001 22:01:55 +0200
To: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
Message-ID: <20010720220155.D16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107201749.KAA05236@saturn.mikemac.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Mike McDonald wrote:
> 
>   What's the status of linux for the I2 R10K? Any hope at all? I'm
> well aware of the problems SGI had getting Irix to work on it. (I was
> part of ISD then.)

A few days ago I posted about some success booting my ip28 AKA
Indigo2 R10000 Impact Ready. A updated version of the bootlog is
appended.

Used Tools:
- CVS binutils, hacked to allow assembly and linking of 64bit
  non-pic executables.
- GCC snapshot as of 2001-05-01 with some patch by Ralf to work
  better for R10000 and one more by myself.
- CVS linux from oss, patched to recognize an ip28 and to work
  in a real 64bit address space.

The Patches are available at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/src
The script I use to crosscompile is at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/edit

Current State:
The Kernel boots via bootp/tftp/nfs into an initshell, execution
of not too complex programs may or may not succeed, it's pretty at
random. /sbin/init itself seems to run, too, but all(?) spawned
processes crash due to unaligned access/illegal instruction in
kernel space. The serial console drops characters on high
throughput.

If you want to try it out, the kernel is available at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/mips64-linux-ip28-2001-07-20.tar.gz


Thiemo


-------------------------------------------------
>> bootp(): init=/bin/sash
Setting $netaddr to 10.0.0.5 (from server rembrandt)
Obtaining  from server rembrandt
1750384+278528+259632 entry: 0xa8000000201b4000
ARCH: SGI-IP28
PROMLIB: ARC firmware Version 64 Revision 0
Linux version 2.4.5-1 (ths@rembrandt) (gcc version 3.1 20010501 (experimental)) #78 Mon Jul 16 17:06:48 CEST 2001
Loading R10000 MMU routines.
CPU implementation 9, CPU revision 37
Primary instruction cache 32kb, linesize 64 bytes
Primary data cache 32kb, linesize 32 bytes
Secondary cache sized at 1024K, linesize 128
MC: SGI memory controller Revision 5
On node 0 totalpages: 262144
zone(0): 262144 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: init=/bin/sash
Entering 64-bit mode.
calculating r4koff... 000d5bea(875498)
Console: colour dummy device 80x25
zs0: console I/O
Console: ttyS0 (Zilog8530), 9600 baud
Calibrating delay loop... 174.89 BogoMIPS
Memory: 488192k/917500k available (1709k kernel code, 429308k reserved, 132k data, 88k init)
Dentry-cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 65536 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 7, 524288 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
initialize_kbd: Keyboard failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
block: queued sectors max/low 321560kB/190488kB, 960 slots per queue
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0b:35:da
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jul 16 2001 at 02:37:07
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jul 16 2001 at 02:37:07
scsi0 : SGI WD93
scsi1 : SGI WD93
SGI Zilog8530 serial driver version 1.01
ttyS0 at 0xbfbd9830 (irq = 21) is a Zilog8530
ttyS1 at 0xbfbd9838 (irq = 21) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.5
IP-Config: Complete:
      device=eth0, addr=10.0.0.5, mask=255.0.0.0, gw=10.0.0.1,
     host=10.0.0.5, domain=, nis-domain=(none),
     bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=/home/linux-mips
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/2 on 10.0.0.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing prom memory: 1024kb freed
Freeing unused kernel memory: 88k freed
Stand-alone shell (version 3.4)
> -ls
.
..
bin
boot
data.tar.gz
dev
etc
home
lib
lost+found
mipsroot-rh7.tar.bz2
mnt
opt
proc
root
sbin
tmp
usr
var
> ls
bin   data.tar.gz  etc   lib         mipsroot-rh7.tar.bz2  opt   root  tmp  var
boot  dev          home  lost+found  mnt                   proc  sbin  usr
> ls
pid 9: killed by signal 11
>
