Received:  by oss.sgi.com id <S305174AbQA2DfM>;
	Fri, 28 Jan 2000 19:35:12 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:64617 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305173AbQA2DfD>; Fri, 28 Jan 2000 19:35:03 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA03937; Fri, 28 Jan 2000 19:40:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA06012
	for linux-list;
	Fri, 28 Jan 2000 19:27:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA30224
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jan 2000 19:27:53 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from glacier.binc.net (glacier.binc.net [205.173.176.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03194
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 19:27:51 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from spanky.yaberk.int (msn-1-124.x2.binc.net [198.70.31.124])
	by glacier.binc.net (8.8.8/8.8.6) with ESMTP id VAA16566;
	Fri, 28 Jan 2000 21:27:48 -0600
Received: (from kenwills@localhost)
	by spanky.yaberk.int (8.9.3/8.9.3) id VAA02705;
	Fri, 28 Jan 2000 21:28:49 -0600 (CST)
	(envelope-from kenwills@mailbag.com)
Date:   Fri, 28 Jan 2000 21:25:41 -0600
From:   Ken Wills <kenwills@mailbag.com>
To:     linux@cthulhu.engr.sgi.com
Cc:     ralf@oss.sgi.com
Subject: (forw)
Message-ID: <20000128212848.A2635@spanky.yaberk.int>
Reply-To: re:bugsinwchan@yaberk.int
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre1i
X-Mailer: Mutt http://www.mutt.org/
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

My dmesg gives me: (It's chopped slightly).

: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (established 8192 bind 16384)
Starting kswapd v1.6
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
pty: 256 Unix98 ptys configured
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jan 16 2000 at 02:27:32
scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE ST31230N  Rev: 0272
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: Quantum   Model: XP32150W          Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2070235 [1010 MB] [1.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 4406960 [2151 MB] [2.2 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:09:24:b4 
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.1.8, my address is 192.168.1.4
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 768k freed
Freeing unused kernel memory: 60k freed
Unable to find swap-space signature
Adding Swap: 40464k swap-space (priority -1)
Unable to find swap-space signature
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
...
...
Many of these messages
...
...
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan
Bug in get_wchan

This is on a 133mhz R4600 Indy - 96mb ram.  Linux 2.3.21.
This is the only odd thing I notice, top looks fine.
Anything I can do to help?

-- 

Ken Wills
kenwills@mailbag.com
