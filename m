Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6EHamh28369
	for linux-mips-outgoing; Sat, 14 Jul 2001 10:36:48 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6EHakV28366
	for <linux-mips@oss.sgi.com>; Sat, 14 Jul 2001 10:36:46 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id TAA337434;
	Sat, 14 Jul 2001 19:36:44 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15LTLG-0007MD-00; Sat, 14 Jul 2001 19:36:34 +0200
Date: Sat, 14 Jul 2001 19:36:34 +0200
To: linux-mips@oss.sgi.com
Subject: SUCCESS: Booting a real 64bit Kernel on Indigo2 R10000 (IP28)
Message-ID: <20010714193634.B24615@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

as exclaimed in the Subject, I have now a 64bit Kernel booting
into /bin/sash on my IP28. Unfortunately, it crashes immediately
at the first keystroke.

In Detail, I used the following software:

- Current binutils CVS with my patch to partially support
  mips64-linux (It's barely enough to build a Kernel).

- An GCC CVS snapshot of 2001-05-01 (later ones do not work)
  with a patch from Ralf to support R10000 and an patch to
  make it bootstrap for mips64-linux.

- Current linux oss CVS with a large patch for mips64 support.

I got with this:

- A real 64bit Kernel image without linker crashes etc.
  No objcopy tricks, the Kernel is loaded at 0xa800000000000000.

- The Kernel uses new-style interrupts (the old ones were confusing
  and crashed on my first attempts to use the serial console).

- The sgiseeq ethernet works, it gets the bootp parameters and
  allows nfs-mounting the rootfs.

- The serial console seems to work also, as good as it can be
  predicted with an immediatly crashing init-shell.


Thiemo


Setting $netaddr to 10.0.0.5 (from server rembrandt)
Obtaining  from server rembrandt
1750448+278528+259632 entry: 0xa8000000201b4000
ARCH: SGI-IP28
PROMLIB: ARC firmware Version 64 Revision 0
Linux version 2.4.5-1 (ths@rembrandt) (gcc version 3.1 20010501 (experimental)) #52 Sat Jul 14 15:46:49 CEST 2001
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
Kernel command line: rw init=/bin/sash
Entering 64-bit mode.
calculating r4koff... 000d5ba8(875432)
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
           Version 1.25 - 09/Jul/1997, Compiled Jul 14 2001 at 15:41:11
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jul 14 2001 at 15:41:11
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
VFS: Mounted root (nfs filesystem).
Freeing prom memory: 1024kb freed
Freeing unused kernel memory: 88k freed
Stand-alone shell (version 3.4)
>
