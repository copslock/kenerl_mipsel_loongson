Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA20666 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 13:53:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA99556
	for linux-list;
	Thu, 15 Oct 1998 13:52:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA73703
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Oct 1998 13:52:41 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: from lil.sv.usweb.com ([207.44.155.155]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id NAA03626
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Oct 1998 13:52:36 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: (qmail 10542 invoked by uid 500); 15 Oct 1998 20:50:32 -0000
To: linux@cthulhu.engr.sgi.com
Subject: Partial Success Report
From: Jeff Coffin <jcoffin@sv.usweb.com>
Date: 15 Oct 1998 13:50:31 -0700
Message-ID: <m3ww618s88.fsf@lil.sv.usweb.com>
X-Mailer: Gnus v5.5/Emacs 20.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi All, 

I've been reading this list for the past many months as I slowly and
infrequently try to bring a dead Indy R5000 back to life, then get
Linux up on it.  The box had a dead disk and still has a bad graphics
board, but I've managed to get IRIX installed and operational on one
disk, another one installed and fx'd from IRIX; all from the serial
console (minicom) and remote X on my x86 Linux (RedHat 5.1) box.

I think there's something very wrong with the gfx card 'cause when I
try to start X under IRIX it complains about a failed context switch
and loops with the same error message for a few iterations, then
hangs. (Sorry I don't have the message with me, it's at home.  I can
post tonight it if it's relevant)

Last night I got the HardHat kernel to boot via the bootp method
described in the Howto and, as expected from the experiences of
Richard Hartensveld, it hung looking for a console.  I then grabbed
newer kernels (2.1.116 and 2.1.121) from the /pub/test on the ftp
server and attmepted to get them loaded by the same mechanism, but
both of them hang after loading via tftp.

I don't know where to go from here, so I'm looking for ideas.  Hinv
and the boot log from the hardhat kernel boot are below.

I'm thinking about removing the gfx board entirely and seeing if that
has any effect, will that do me any good?

Any help or suggestions would be appreciated.


--jeff


>> hinv
              System: IP22
           Processor: 180 Mhz R5000, with FPU
Primary I-cache size: 32 Kbytes
Primary D-cache size: 32 Kbytes
Secondary cache size: 512 Kbytes
         Memory size: 64 Mbytes
            Graphics: GR3-XZ
           SCSI Disk: scsi(0)disk(2)
           SCSI Disk: scsi(0)disk(3)
               Audio: Iris Audio Processor: version A2 revision 4.1.0



boot:
Command Monitor.  Type "exit" to return to the menu.
>> $linux
72912+9440+3024+331696+23768d+3644+5808 entry: 0x8bf9a950
Setting $netaddr to 192.168.0.30 (from server lil)
Obtaining /vmlinux from server lil
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 64270336 bytes (62764K,61MB)
ARCH: SGI-IP22
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00002310.
Primary instruction cache 32kb, linesize 32 bytes)
Primary data cache 32kb, linesize 32 bytes)
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2) #29 Thu J8
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
calculating r4koff... 000dbda6(900518)
zs0: console input
zs0: console I/O
Calibrating delay loop... 179.81 BogoMIPS
Memory: 60444k/196196k available (1216k kernel code, 2684k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5
Adv: about to run setup()
initialize_kbd: Keyboard reset failed, no ACK
SGI Zilog8530 serial driver version 1.00
Keyboard timeout
Keyboard timeout
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
Ramdisk driver initialized : 16 ramdisks of 4096K size
loop: registered device at major 7
WD93: Driver version 1.25 compiled on Jul  7 1998 at 16:59:57
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBM DORS-32160  D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST31055N        2
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2069860 [1010 MB] [1.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:43:7c
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.0.20, my address is 192.168.0.30
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
Looking up port of RPC 100003/2 on 192.168.0.20
Looking up port of RPC 100005/1 on 192.168.0.20
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed
Warning: unable to open an initial console
                                     
