Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA666362 for <linux-archive@neteng.engr.sgi.com>; Sat, 16 May 1998 12:45:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA80234
	for linux-list;
	Sat, 16 May 1998 12:44:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA79728
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 16 May 1998 12:44:14 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id MAA22202
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 May 1998 12:44:11 -0700 (PDT)
	mail_from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA01410; Sat, 16 May 1998 15:43:07 -0400
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 16 May 1998 15:43:05 -0400 (EDT)
To: linux@cthulhu.engr.sgi.com
Subject: Re: Evidence of Drive Activity to Report
In-Reply-To: <19980511093314.12884@uni-koblenz.de>
References: <13652.59663.188834.236218@mdhill.interlog.com>
	<13653.59491.302730.251578@mdhill.interlog.com>
	<35566E3B.109CCAA3@detroit.sgi.com>
	<19980511093314.12884@uni-koblenz.de>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <13661.60018.777703.724185@mdhill.interlog.com>
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > 
 > Both cases sound like a bad /etc/fstab.  Try adding init=/bin/sh to your
 > firmware command like arguments.  You'll get a completly uninitialized
 > system.   Run e2fsck, then you should be able to remount / rw and fix
 > the fstab.
 > 

What should fstab look like?  Mine has a single entry (with
root-be-0.03) for /proc.

I get a bash prompt but e2fsck hangs.

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
