Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA80641 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Feb 1999 14:53:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA29400
	for linux-list;
	Tue, 23 Feb 1999 14:50:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA06127
	for <linux@engr.sgi.com>;
	Tue, 23 Feb 1999 14:50:04 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08520
	for <linux@engr.sgi.com>; Tue, 23 Feb 1999 14:49:58 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA22897
	for <linux@engr.sgi.com>; Tue, 23 Feb 1999 23:49:54 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id XAA02851;
	Tue, 23 Feb 1999 23:23:47 +0100
Message-ID: <19990223232347.A2847@uni-koblenz.de>
Date: Tue, 23 Feb 1999 23:23:47 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Old Mips systems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, got another pile of email from people asking about the state of Linux
for the RC3030 and similar.  Here is slightly edited the bootup of Linux
on an embedded machine that is derived from Mips Computer Systems, Inc. (RIP)
own systems.  Any port to another system, will be easy, especially when
combining the DECstation and Baget R3000 effort's results with that.

Stay tuned, more soon,

  Ralf

Fast ethernet (FEN): 10 MBit/s, half duplex

Autoboot: Waiting to load bfs()/tftpboot/193.98.169.22/vmlinux (CTRL-C to abort)
loading

Fast ethernet (FEN): 10 MBit/s, half duplex
Obtaining /tftpboot/193.98.169.22/vmlinux from server linux
1002832+0+107396 entry: 0x800205dc
CPU revision is: 00002110
Primary instruction cache 16kb, linesize 32 bytes)
Primary data cache 16kb, linesize 32 bytes)
Linux version 2.2.1 (ralf@indy) (gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)) #496 Tue Feb 23 19:40:23 MET 1999
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 99.94 BogoMIPS
Memory: 14960k/16380k available (844k kernel code, 444k data)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
MIPS Zilog8530 serial driver version 1.32
tty00 at 0xbf022003 (irq = 8) is a Zilog8530
tty01 at 0xbf020003 (irq = 8) is a Zilog8530
tty02 at 0xbf026003 (irq = 8) is a Zilog8530
tty03 at 0xbf024003 (irq = 8) is a Zilog8530
tty04 at 0xbf032003 (irq = 8) is a Zilog8530
tty05 at 0xbf030003 (irq = 8) is a Zilog8530
tty06 at 0xbf036003 (irq = 8) is a Zilog8530
tty07 at 0xbf034003 (irq = 8) is a Zilog8530
tty08 at 0xbf03a003 (irq = 8) is a Zilog8530
tty09 at 0xbf038003 (irq = 8) is a Zilog8530
tty10 at 0xbf03e003 (irq = 8) is a Zilog8530
tty11 at 0xbf03c003 (irq = 8) is a Zilog8530
tulip.c:v0.89H 5/23/98 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21140 Tulip at 0x1f090000, EEPROM not present, 00 00 ad 00 e3 0a, IRQ 4.
eth0:  MII transceiver found at MDIO address 8, config 1000 status 786d.
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 193.98.169.11, my address is 193.98.169.22
Looking up port of RPC 100003/2 on 193.98.169.11
Looking up port of RPC 100005/1 on 193.98.169.11
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 48k freed
INIT: version 2.74 booting
Activating swap partitions
hostname: exterminata.mips-man.org
Checking root filesystems.

Remounting root filesystem in read-write mode.
Checking filesystems.

Mounting local filesystems.
Setting clock: Mon Feb 23 23:00:00 MET 1999
Enabling swap space.
Initializing random number generator...
INIT: Entering runlevel: 3
Mounting remote filesystems.
Starting system loggers: syslogd klogd 
Starting at daemon: atd 
Starting cron daemon: crond 
Starting portmapper: portmap 
Starting INET services: inetd 
Starting sshd: sshd 
Starting sendmail: sendmail 

Red Hat Linux release 5.2 (Apollo)
Kernel 2.2.1 on a mips

exterminata.mips-man.org login: 
