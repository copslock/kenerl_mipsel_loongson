Received:  by oss.sgi.com id <S305195AbQDRVft>;
	Tue, 18 Apr 2000 14:35:49 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14957 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305188AbQDRVfW>; Tue, 18 Apr 2000 14:35:22 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA04474; Tue, 18 Apr 2000 14:39:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA99182; Tue, 18 Apr 2000 14:34:50 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA93827
	for linux-list;
	Tue, 18 Apr 2000 14:21:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA89950
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:21:16 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06150
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Apr 2000 14:21:15 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7EC2F7DD; Tue, 18 Apr 2000 23:21:16 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1D2DE8FC4; Tue, 18 Apr 2000 23:16:52 +0200 (CEST)
Date:   Tue, 18 Apr 2000 23:16:52 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418231652.A866@paradigm.rfc822.org>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de> <20000418105348.A1247@paradigm.rfc822.org> <20000418140410.A6271@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000418140410.A6271@uni-koblenz.de>; from Ralf Baechle on Tue, Apr 18, 2000 at 02:04:10PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 02:04:10PM -0700, Ralf Baechle wrote:
> On Tue, Apr 18, 2000 at 10:53:48AM +0200, Florian Lohoff wrote:
> 
> > But the (kernel) fix from Ralph concerning the sleep? syscalls seems
> > to be incorrect or buggy - When calling top the display refreshes
> > multiple times a second without a sleep and on the console i get
> > an.
> > 
> > Setting flush to zero for top.
> > schedule_timeout: wrong timeout value fffbd0b2 from 800942b8 
> 
> I'm fairly sure that my patch is not buggy - I haven't made any :-)

Hasnt been there somethign with a missing syscall you wanted to add
again to all kernels ? I remembered dark but couldnt find anything
in the cvs. :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
