Received:  by oss.sgi.com id <S554022AbRAQNOM>;
	Wed, 17 Jan 2001 05:14:12 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:45577 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S554008AbRAQNNu>;
	Wed, 17 Jan 2001 05:13:50 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id B31687D0E; Wed, 17 Jan 2001 13:13:48 +0000 (GMT)
Date:   Wed, 17 Jan 2001 13:13:48 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     macro@ds2.pg.gda.pl
Cc:     ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: Kernel Report - 010117 (2.4.0)
Message-ID: <20010117131348.A29427@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20010117125603.A29302@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010117125603.A29302@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Wed, Jan 17, 2001 at 12:56:03PM +0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

OK..this is the same machine, same kernel, but with the #define DEBUG:

>> bootp():/vmlinux root=/dev/sda3 console=ttyS0
Obtaining /vmlinux from server slinky
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
ARCS MEMORY DESCRIPTOR dump:
[0,a8748674]: base<00000000> pages<00000001> type<Exception Block>
[1,a8748690]: base<00000001> pages<00000001> type<ARCS Romvec Page>
[2,a8748658]: base<00008002> pages<000001d6> type<Standlong Program
Pages>
[3,a8748aa0]: base<000081d8> pages<00000568> type<Generic Free RAM>
[4,a8748a70]: base<00008740> pages<000000c0> type<ARCS Temp Storage
Area>
[5,a8748a54]: base<00008800> pages<00005800> type<Generic Free RAM>
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 128 bytes.
Linux version 2.4.0 (ian@slinky) (gcc version 2.95.3 19991030
(prerelease)) #3 1
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 001d6000 @ 08002000 (reserved)
 memory: 00568000 @ 081d8000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 05800000 @ 08800000 (usable)
On node 0 totalpages: 57344
zone(0): 57344 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda3 console=ttyS0
Calibrating system timer... 1000000 [200.00 MHz CPU]
zs0: console input
Console: ttyS0 (Zilog8530)
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 128 bytes.
Linux version 2.4.0 (ian@slinky) (gcc version 2.95.3 19991030
(prerelease)) #3 1
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 001d6000 @ 08002000 (reserved)
 memory: 00568000 @ 081d8000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 05800000 @ 08800000 (usable)
On node 0 totalpages: 57344
zone(0): 57344 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda3 console=ttyS0
Calibrating system timer... 1000000 [200.00 MHz CPU]
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... Calibrating delay loop... 99.94 BogoMIPS
99.94 BogoMIPS
Memory: 91792k/95648k available (1560k kernel code, 3856k reserved, 88k
data, 7)
Memory: 91792k/95648k available (1560k kernel code, 3856k reserved, 88k
data, 7)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Checking for 'wait' instruction... Checking for 'wait' instruction...
unavaila.
 unavailable.
POSIX conformance testing by UNIFIX
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Starting kswapd v1.8
initialize_kbd: Keyboard failed self test
initialize_kbd: Keyboard failed self test
Keyboard timed out[1]
Keyboard timed out[1]
Keyboard timed out[1]
Keyboard timed out[1]
pty: 256 Unix98 ptys configured
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
DS1286 Real Time Clock Driver v1.0
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
streamable misc devices registered (keyb:150, gfx:148)
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 eth0: SGI Seeq8003 08:08:00:00:69:69:08:08:9d:9d:ec
ec

SCSI subsystem driver Revision: 1.00
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0wd33c93-0:
chip=WD33c93B/13 no0
 debug_flags=0x00
           setup_args=           setup_args=,,,,,,,,,,,,,,,,,,

           Version 1.25 - 09/Jul/1997, Compiled Jan 17 2001 at 11:41:43
           Version 1.25 - 09/Jul/1997, Compiled Jan 17 2001 at 11:41:43
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0wd33c93-1:
chip=WD33c93B/13 no0
 debug_flags=0x00
           setup_args=           setup_args=,,,,,,,,,,,,,,,,,,

           Version 1.25 - 09/Jul/1997, Compiled Jan 17 2001 at 11:41:43
           Version 1.25 - 09/Jul/1997, Compiled Jan 17 2001 at 11:41:43
scsi0 : SGI WD93
scsi0 : SGI WD93
scsi1 : SGI WD93
scsi1 : SGI WD93
 sending SDTR  sending SDTR
0101030301013f3f0c0csync_xfer=2csync_xfer=2c  VendoA

  Type:   Direct-Access       Type:   Direct-Access
ANSI S2

Detected scsi disk sda at scsi0, channel 0, id 4, lun 0
Detected scsi disk sda at scsi0, channel 0, id 4, lun 0
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Partition check:
Partition check:
 sda: sda: sda1 sda1 sda2 sda2 sda3 sda3 sda4 sda4 sda5 sda5 sda6 sda6

SGI Zilog8530 serial driver version 1.00
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21)tty00 at 0xbfbd9830 (irq = 21) is a
Zilog8530
 is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21)tty01 at 0xbfbd9838 (irq = 21) is a
Zilog8530
 is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: IP Protocols: ICMP, ICMP, UDP, UDP, TCP
TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
TCP: Hash tables configured (established 16384 bind 16384)
Sending BOOTP requests...Sending BOOTP requests..... OK
 OK
IP-Config: Got BOOTP answer from 192.168.0.11, IP-Config: Got BOOTP
answer from3
my address is 192.168.0.13
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 768kb freed
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 72k freed
Freeing unused kernel memory: 72k freed
INIT: version 2.78 booting


Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |        Proofread carefully to see if you any words out.         |
 \-----------------------------------------------------------------/
