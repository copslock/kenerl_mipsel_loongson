Received:  by oss.sgi.com id <S305195AbQDRV5k>;
	Tue, 18 Apr 2000 14:57:40 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52335 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305188AbQDRV5X>; Tue, 18 Apr 2000 14:57:23 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA02511; Tue, 18 Apr 2000 15:01:23 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA96209
	for linux-list;
	Tue, 18 Apr 2000 14:47:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA98665
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:47:42 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04417
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Apr 2000 14:47:40 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6C4BD7D9; Tue, 18 Apr 2000 23:47:42 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1FE9A8FC4; Tue, 18 Apr 2000 23:43:20 +0200 (CEST)
Date:   Tue, 18 Apr 2000 23:43:20 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418234320.C866@paradigm.rfc822.org>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de> <20000418105348.A1247@paradigm.rfc822.org> <20000418140410.A6271@uni-koblenz.de> <20000418231652.A866@paradigm.rfc822.org> <20000418143959.C6271@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000418143959.C6271@uni-koblenz.de>; from Ralf Baechle on Tue, Apr 18, 2000 at 02:39:59PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 02:39:59PM -0700, Ralf Baechle wrote:
> On Tue, Apr 18, 2000 at 11:16:52PM +0200, Florian Lohoff wrote:
> 
> > Hasnt been there somethign with a missing syscall you wanted to add
> > again to all kernels ? I remembered dark but couldnt find anything
> > in the cvs. :)
> 
> Oh yes, it just got lost.  It's now in the works.

-----------flo
> But the (kernel) fix from Ralph concerning the sleep? syscalls seems
> to be incorrect or buggy - When calling top the display refreshes
> multiple times a second without a sleep and on the console i get
> an.
-----------flo

I stand corrected - It hasnt even been applied :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
