Received:  by oss.sgi.com id <S305188AbQAEWPY>;
	Wed, 5 Jan 2000 14:15:24 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:22301 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305186AbQAEWPB>;
	Wed, 5 Jan 2000 14:15:01 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07269; Wed, 5 Jan 2000 14:15:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA40429
	for linux-list;
	Wed, 5 Jan 2000 13:45:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA73296
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 13:44:57 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA02138
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 13:44:03 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 58D8D80E; Wed,  5 Jan 2000 22:43:52 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A39478F7A; Wed,  5 Jan 2000 22:18:39 +0100 (CET)
Date:   Wed, 5 Jan 2000 22:18:39 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Decstation 5000/150 2.3.21 Boot successs
Message-ID: <20000105221839.A980@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
this is is a short output of the 2.3.21 booting on the Decstation
5000/150 ... This is the current oss.sgi.com CVS.

--------------------------------------------------------------
This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 32
Linux version 2.3.21 (root@repeat) (gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)) #1 Tue Jan 4 18:39:20 GMT 2000
Calibrating delay loop... 49.81 BogoMIPS
Memory: 62652k/65532k available (1068k kernel code, 1524k data)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (no parity)
    slot 0: DEC      PMAZ-AA  V5.3d   
    slot 1: DEC      PMAZ-AA  V5.3b   
    slot 2: DEC      PMAF-FA  V1.1    
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (established 4096 bind 8192)
Starting kswapd v1.6
DECstation Z8530 serial driver version 0.03
tty00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
tty01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
tty02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
tty03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
scsi : 3 hosts.
  Vendor: Quantum   Model: XP34300           Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: SEAGATE   Model: ST15150N          Rev: 8902
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI disks total.
esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8399520 [4101 MB] [4.1 GB]
esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8388315 [4095 MB] [4.1 GB]
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 193.189.250.46, my address is 193.189.250.44
-----------------------------------------------------

I see some more ugly things:

Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source
Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source
Setting flush to zero for dpkg-source.
Unimplemented exception for insn 4620a0a4 at 0x0046f084 in dpkg-source.
Should send SIGFPE to dpkg-source

And this ...

Bug in get_wchan

This seems to be a result of buggy "procps" ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
