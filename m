Received:  by oss.sgi.com id <S305154AbQCHRAl>;
	Wed, 8 Mar 2000 09:00:41 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36127 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQCHRAU>; Wed, 8 Mar 2000 09:00:20 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA09202; Wed, 8 Mar 2000 09:03:36 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA98172; Wed, 8 Mar 2000 08:59:49 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA87910
	for linux-list;
	Wed, 8 Mar 2000 08:48:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA25367
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 08:48:36 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09387
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 08:48:32 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407931AbQCHQSF>;
	Wed, 8 Mar 2000 13:18:05 -0300
Date:   Wed, 8 Mar 2000 13:18:05 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     "Bradley D. LaRonde" <brad@ltc.com>,
        "Andrew R. Baker" <andrewb@uab.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: FP emulation patch available
Message-ID: <20000308131805.C872@uni-koblenz.de>
References: <Pine.LNX.3.96.1000306220330.12659B-100000@lithium> <097a01bf87eb$ebe4d4d0$b8119526@ltc.com> <200003071022.KAA00275@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200003071022.KAA00275@gladsmuir.algor.co.uk>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Mar 07, 2000 at 10:22:22AM +0000, Dominic Sweetman wrote:

> Bradley D. LaRonde (brad@ltc.com) writes (re the FPA emulator out of
> Algorithmics via Kevin Kissell):
> 
> > I would jump right on this but I really need it for 2.3.47+.
> 
> It's good to see our donation to the Linux project being taken up
> enthusiastically , but didn't SGI have some code like this?

They even have two emulators, an old one written in assembler and a newer
one written in C.  I haven't looked more closely but I think that they're
both full emulators and the (C) situation would allow me to reuse the
code for Linux.  In any case, it's a non-trivial piece of code, so I want
to double check with them.

> I mean, you can't have a serious MIPS run-time system without an FP
> emulator, can you?

Depends.  After a few years without this FPU stuff we've found only a
surprisingly small number of applications that run into problems.  After
all the only FPU instruction many programs execute is $fcr31.  Just
configuring all the kernel FPU code away therefore is a good thing
for many embedded configurations.

  Ralf
