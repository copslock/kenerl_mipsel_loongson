Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA80518 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Sep 1998 14:06:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA84419
	for linux-list;
	Tue, 22 Sep 1998 14:05:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA62345
	for <linux@engr.sgi.com>;
	Tue, 22 Sep 1998 14:05:57 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.bizarre.nl (9dyn84.breda.casema.net [195.96.116.84]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09857
	for <linux@engr.sgi.com>; Tue, 22 Sep 1998 14:05:53 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.bizarre.nl (8.9.0/8.9.0) with ESMTP id XAA00443
	for <linux@engr.sgi.com>; Tue, 22 Sep 1998 23:11:19 +0200
Message-ID: <36081277.17A50BC9@infopact.nl>
Date: Tue, 22 Sep 1998 23:11:19 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: challenge s boots linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I have successfully booted linux on a challenge S. but the problem is
that the kernel wants to write his output to the console, which isn't
mij serial port unfortunatelly.

Does anyone have a kernel for me from which i can continue my quest of
installing linux on a challenge s ? :)

Below you'll find my kernel booting information for whom is interested.

Regards,

Richard Hartensveld

Command Monitor.  Type "exit" to return to the menu.
>> boot bootp():/vmlinux
72912+9440+3024+331696+23768d+3644+5808 entry: 0x8ff9a950
Setting $netaddr to 192.168.6.31 (from server perron-null)
Obtaining /vmlinux from server perron-null
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 131379200 bytes (128300K,125MB)
ARCH: SGI-IP22
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00002310
Primary instruction cache 32kb, linesize 32 bytes)
Primary data cache 32kb, linesize 32 bytes)
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2)
#29 Thu Ju
l 9 22:19:39 EDT 1998
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 512K, linesize 32 bytes.
calculating r4koff... 000dbd5e(900446)
zs0: console input
zs0: console I/O
Calibrating delay loop... 179.81 BogoMIPS
Memory: 125208k/261732k available (1216k kernel code, 3456k data)
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
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: IBM
DORS-32160
 Rev: W80D
  Type:   Direct-Access                      ANSI SCSI revision: 02

 Rev: W80D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model:
DCAS-34330
 Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 6, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0

GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8467200 [4134 MB] [4.1

GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:41:7b
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.6.1, my address is 192.168.6.31

Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
Looking up port of RPC 100003/2 on 192.168.6.1
Looking up port of RPC 100005/1 on 192.168.6.1
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed
Warning: unable to open an initial console.
