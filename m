Received:  by oss.sgi.com id <S553932AbRAPT2t>;
	Tue, 16 Jan 2001 11:28:49 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:22025 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553928AbRAPT2h>;
	Tue, 16 Jan 2001 11:28:37 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id AE99B7D0E; Tue, 16 Jan 2001 19:28:36 +0000 (GMT)
Date:   Tue, 16 Jan 2001 19:28:36 +0000
From:   Ian Chilton <ian@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Current CVS (010116) Boots OK
Message-ID: <20010116192836.A26863@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

Just cross compiled the kernel with GCC 2.95.2 and Binutils 2.10.1 and
booted my Indy R4600:

Command Monitor.  Type "exit" to return to the menu.
>> bootp():/vmlinux console=ttyS0
Obtaining /vmlinux from server slinky
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
Loading R4000 MMU routines.
CPU revision is: 00002020
Primary instruction cache 16kb, linesize 32 bytes.
Primary data cache 16kb, linesize 32 bytes.
Linux version 2.4.0 (ian@slinky) (gcc version 2.95.3 19991030
(prerelease)) #1 1
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 001c5000 @ 08002000 (reserved)
 memory: 00579000 @ 081c7000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 05800000 @ 08800000 (usable)
On node 0 totalpages: 57344
zone(0): 57344 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0
Calibrating system timer... 500000 [100.00 MHz CPU]
NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9
revision AD
NG1: Screensize 1280x1024
Console: colour SGI Newport 160x64
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 99.73 BogoMIPS
Memory: 91868k/95716k available (1517k kernel code, 3848k reserved, 84k
data, 6)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard reset failed, no ACK
DS1286 Real Time Clock Driver v1.0
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
streamable misc devices registered (keyb:150, gfx:148)
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:2c:d1
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 16 2001 at 19:12:00
scsi0 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model:
DCAS-34330      A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.0.11, my address is
192.168.0.12
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.11
Looking up port of RPC 100005/2 on 192.168.0.11
Root-NFS: Server returned error -13 while mounting /export/tftpboot
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00



I'll boot it into a system @ the weekend.


Thanks to those who helped to fix the kernel!!


Bye for Now,

Ian


                                \|||/ 
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |         Budget: A method for going broke methodically.          |
 \-----------------------------------------------------------------/
