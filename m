Received:  by oss.sgi.com id <S305162AbQA3Nmr>;
	Sun, 30 Jan 2000 05:42:47 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:23361 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQA3NmU>;
	Sun, 30 Jan 2000 05:42:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08760; Sun, 30 Jan 2000 05:45:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA14144
	for linux-list;
	Sun, 30 Jan 2000 05:30:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA17590
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jan 2000 05:30:45 -0800 (PST)
	mail_from (R.vandenBerg@inter.NL.net)
Received: from altrade.nijmegen.inter.nl.net (altrade.nijmegen.inter.nl.net [193.67.237.6]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA00638
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 05:30:43 -0800 (PST)
	mail_from (R.vandenBerg@inter.NL.net)
Received: from whale.dutch.mountain by altrade.nijmegen.inter.nl.net
	via hn51-34.Hoorn.NL.net [193.79.46.198] with ESMTP
	id OAA09129 (8.8.8/3.41); Sun, 30 Jan 2000 14:30:40 +0100 (MET)
Received: from localhost(really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with smtp
	id <m12EuQY-00024aC@whale.dutch.mountain>
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 14:30:06 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #2 built 1996-Nov-26)
Date:   Sun, 30 Jan 2000 14:30:05 +0100 (MET)
From:   Richard van den Berg <R.vandenBerg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@oss.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
In-Reply-To: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com>
Message-ID: <Pine.LNX.3.95.1000130142648.3037A-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, 30 Jan 2000, Kevin D. Kissell wrote:

> Note, however, that the incident below happened
> on an R4000 platform, not an R3K.   It's probably
> more significant that it was on a DECstation, thus
> a little-endian platform.

More specific the DECstation platform.

> >(root@repeat)~# ps axl
> >Unknown HZ value! (0) Assume 100.

The HZ_TO_STD problem Ralf asked to fix caused by a overhaul of
fs/proc/array.c, I'm working on a patch.

Regards,
Richard
