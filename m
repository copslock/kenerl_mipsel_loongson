Received:  by oss.sgi.com id <S305160AbQAPBjV>;
	Sat, 15 Jan 2000 17:39:21 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36215 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQAPBjE>; Sat, 15 Jan 2000 17:39:04 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA05898; Sat, 15 Jan 2000 17:43:00 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA13099
	for linux-list;
	Sat, 15 Jan 2000 17:28:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA04285
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 15 Jan 2000 17:28:06 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09371
	for <linux@cthulhu.engr.sgi.com>; Sat, 15 Jan 2000 17:28:00 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-20.uni-koblenz.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA09525;
	Sun, 16 Jan 2000 02:27:55 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAPBUp>;
	Sun, 16 Jan 2000 02:20:45 +0100
Date:   Sun, 16 Jan 2000 02:20:45 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/MIPS <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel sources?
Message-ID: <20000116022045.C12714@uni-koblenz.de>
References: <005e01bf5f7d$fc1cf490$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <005e01bf5f7d$fc1cf490$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Jan 15, 2000 at 06:28:40PM +0100, Kevin D. Kissell wrote:

> As Ralf says, it's very accurate *if* you have an accurate picture of
> the CPU's clock frequency.  The usual mechanism of measuring
> the progress of the count register against elapsed time on a TOD
> clock has been known to be inaccurate on some platforms due
> to skew between the visibility to software and the actual timing
> event, so be careful.

The only machine where we actually calibrate the CPU counter is the Indy
where due to a hardware bug we cannot use the external timers as source
of interrupts.

In fact the current Linux kernel would even panic if it ever would find
an Indy working as per spec ;-)

We could improve that meassurement by rounding to the nearest crystal
known to be used on IP22 CPU modules plus maybe add an eventual user /
xntpd suplied fudge factor for deviations of the exact crystal frequency.

  Ralf
