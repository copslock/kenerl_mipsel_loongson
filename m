Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA24952
	for <pstadt@stud.fh-heilbronn.de>; Sun, 22 Aug 1999 02:09:51 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA08144; Sat, 21 Aug 1999 17:06:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA82267
	for linux-list;
	Sat, 21 Aug 1999 17:02:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA43607
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 21 Aug 1999 17:02:26 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from paladin.real-time.com (paladin.real-time.com [206.10.252.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07269
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 17:02:24 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from real-time.com (mondas.dalekchess.org [206.147.104.202])
	by paladin.real-time.com (8.8.8/8.8.8) with ESMTP id TAA21539
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 19:02:23 -0500 (CDT)
Message-ID: <37BF3CFF.ABB1A32B@real-time.com>
Date: Sat, 21 Aug 1999 18:57:51 -0500
From: Cory Jon Hollingsworth <cory@real-time.com>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Tandem and Hard Hat, the Saga continues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

   It boots and runs!!!!

    I've spent most of today installing (through trial and error) Hard
Hat on the the Tandem.  And It looks like I have been successful!

Check it out:

[root@Terminus /proc]# cat cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V5.0
system type             : SGI Indy
BogoMIPS                : 74.96
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 10718
VCEI exceptions         : 31543
[root@Terminus /proc]# dmesg |head
ARCH: SGI-IP22
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 265719808 bytes (259492K,253MB)
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
CPU revision is: 00000450
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.2.1 (tsbogend@james.franken.de) (gcc version 2.7.2.3)
#519 Mon Mar 29 01:24:17 MEST 1999

    The installation process certainly wasn't what I would call smooth,
but it was worth it.

    Thanks to everyone who provided me hints on identifying this
machine.  I have never had access to an Indy/Indigo/Challenge S before,
so identifying this machine on my own would have been a total guess
without the resources of this list and its archive.

    Now the fun begins.

    Thanks again.
