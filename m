Received:  by oss.sgi.com id <S305173AbQCALNt>;
	Wed, 1 Mar 2000 03:13:49 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:61006 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQCALNa>;
	Wed, 1 Mar 2000 03:13:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA22156; Wed, 1 Mar 2000 03:08:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA17930
	for linux-list;
	Wed, 1 Mar 2000 03:03:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA62949
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Mar 2000 03:03:31 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA06024
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 03:03:29 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C2ED77F5; Wed,  1 Mar 2000 12:03:24 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 043E98FC3; Wed,  1 Mar 2000 11:50:53 +0100 (CET)
Date:   Wed, 1 Mar 2000 11:50:53 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: 2.3.47 success on Decstation 5000/150, problems with login
Message-ID: <20000301115053.A4608@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i just succeeded in compiling current CVS 2.3.47 and succeeded booting
the same kernel.


This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 32
Linux version 2.3.47 (root@193.189.250.44) (gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)) #2 Wed Mar 1 08:21:08 GMT 2000
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Calibrating delay loop... 49.81 BogoMIPS
Memory: 62584k/65536k available (1012k kernel code, 2952k reserved, 72k data, 48k init)
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
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
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
Partition check:
 sda: sda1 < sda5 sda6 sda7 sda8 sda9 sda10 >
esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8388315 [4095 MB] [4.1 GB]
 sdb: sdb1 sdb2
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 193.189.250.46, my address is 193.189.250.44
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 48k freed

The problem is that i am NOT able to log in via SSH afterwards which
works flawlessly with 2.3.21 i am running right now ... Might this
be a devpts PTY98 problem ?

--------------------------------------------------------
(flo@ping)~# ssh root@repeat.rfc822.org
root@repeat.rfc822.org's password: 
Warning: Remote host denied X11 forwarding, perhaps xauth program could not be run on the server side.
Connection to repeat.rfc822.org closed by remote host.
Connection to repeat.rfc822.org closed.
--------------------------------------------------------

Ideas ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
