Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA65319 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 13:18:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA77879
	for linux-list;
	Sun, 19 Jul 1998 13:18:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA39500
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 13:18:21 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from ms21.hinet.net (ms21.hinet.net [168.95.4.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA28789
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 13:18:19 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (mjhsieh@helix.life.nthu.edu.tw [140.114.98.34])
	by ms21.hinet.net (8.8.8/8.8.8) with ESMTP id EAA11165
	for <linux%cthulhu.engr.sgi.com@ms21.hinet.net>; Mon, 20 Jul 1998 04:18:17 +0800 (CST)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id EAA00302;
	Mon, 20 Jul 1998 04:18:16 +0800
Message-ID: <19980720041815.A298@helix.life.nthu.edu.tw>
Date: Mon, 20 Jul 1998 04:18:15 +0800
From: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
To: Linux <linux%cthulhu.engr.sgi.com@ms21.hinet.net>
Subject: Re: [Q] How to reboot automatically?
References: <19980718164741.A868@life.nthu.edu.tw> <19980719041810.G489@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980719041810.G489@uni-koblenz.de>; from ralf@uni-koblenz.de on Sun, Jul 19, 1998 at 04:18:10AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 04:18:10AM +0200, ralf@uni-koblenz.de wrote:
> On Sat, Jul 18, 1998 at 04:47:41PM +0800, Francis M. J. Hsieh wrote:
> > Can the bios remeber to reboot as "boot /vmlinux root=/dev/sdb1" ?
> Try the ARC environment variable OsLoadOptions.  See also the IRIX manpages
> about the firmware.

Well, OSLoadOptions saves only 12 character. Maybe I was at the wrong way,
there is few document about firmware. neither the manpages nor the online
books contain helpful information.

-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
