Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA86593 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Aug 1998 17:55:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA92385
	for linux-list;
	Fri, 28 Aug 1998 17:55:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA49486
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Aug 1998 17:54:59 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id RAA24544
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Aug 1998 17:54:57 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id UAA01236; Fri, 28 Aug 1998 20:53:23 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Aug 1998 20:53:18 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: NFS activity
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13799.17468.796285.670751@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Here follows an approximation of the tail of the nfsd output
culminating in the failure of the installer with the message "Fatal
error opening RPM database."  All of this occurs after package
selection.

Thanks,

Mike
-- 
Michael Hill
somewhere near Toronto
mdhill@interlog.com

nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:00 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 561152
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:00 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 634880
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:00 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 638976
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:00 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 630784
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:08 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 184320
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 lookup [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        fh:/disk/installfs n:mntSwap000
nfsd[173] 08/28/98 19:39        new_fh = /disk/installfs/mntSwap000
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 217088
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 221184
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 385024
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 389120
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/lib/libc-2.0.6.so: 4096 bytes at 598016
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 lookup [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        fh:/disk/installfs/dev n:tty5
nfsd[173] 08/28/98 19:39        new_fh = /disk/installfs/dev/tty5
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 565248
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 569344
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 757760
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:00 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 761856
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/lib/libc-2.0.6.so: 4096 bytes at 122880
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/lib/libc-2.0.6.so: 4096 bytes at 126976
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/lib/libc-2.0.6.so: 4096 bytes at 73728
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:39 read [1 69/12/31 19:01:13 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:39        /disk/installfs/sbin/install2: 4096 bytes at 225280
nfsd[173] 08/28/98 19:39 result: 0
nfsd[173] 08/28/98 19:41 read [1 69/12/31 19:01:32 localhost.localdomain 0.0]
nfsd[173] 08/28/98 19:41        /disk/installfs/sbin/install2: 4096 bytes at 258048
nfsd[173] 08/28/98 19:41 result: 0
