Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA3025746 for <linux-archive@neteng.engr.sgi.com>; Sun, 5 Apr 1998 05:47:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id FAA8008322
	for linux-list;
	Sun, 5 Apr 1998 05:45:54 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA8041712;
	Sun, 5 Apr 1998 05:45:52 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id FAA07209; Sun, 5 Apr 1998 05:45:46 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA11304;
	Sun, 5 Apr 1998 14:45:43 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id OAA04421;
	Sun, 5 Apr 1998 14:06:12 +0200
Message-ID: <19980405140612.03263@uni-koblenz.de>
Date: Sun, 5 Apr 1998 14:06:12 +0200
To: linux-mips@fnet.fr
Cc: linux-mips@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: EGCS on MIPS
References: <19980404120554.31953@uni-koblenz.de> <19980404124037.00257@loria.fr> <199804050908.KAA00232@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804050908.KAA00232@gladsmuir.algor.co.uk>; from Dominic Sweetman on Sun, Apr 05, 1998 at 10:08:10AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Apr 05, 1998 at 10:08:10AM +0100, Dominic Sweetman wrote:

> It's possible that Linux would be better served by the more steady
> approach favoured by Richard Stallman, but then that's why 2.8 has
> been such a long time coming.

Alot of the Linux comunity are pretty upset with the pace at which GCC 2.8
(and the FSF) is advancing.  Several people asked me for EGCS but
_nobody_ for GCC 2.8.  Guess that voting has a clear result ...

> > A bad point for linux/mips is that the generated code is n32/64.
> 
> Firstly, that's an option; the EGCS compiler supports many options,
> including Linux' current standard (best called o32, probably,
> following SGI standards.)

Agreed.  There's a couple of comments in the EGCS source however which say
that certain o32 things are broken.  I didn't research details but I think
those comments only apply to IRIX6 and so far I however I didn't run into
any trouble with the o32 support of EGCS.  Which might mean not to much since
the EGCS 1.0.2 port for Linux/MIPS is now 20 hours or so old.

> Secondly, maybe that's a good thing; at a meeting at MIPS embedded
> compiler suppliers agreed informally that we should offer n32 as a new
> standard for demanding applications.  You may like to think about
> migrating Linux/MIPS to something other than o32/ECOFF.

O32 is an implication of being R3000 friendly.  If 32 bit microprocessors
would vanish from earth's surface next night I'd immediately go for n32 or 64.

The only binaries which we in other formats than ELF are bootloaders etc.
I think a.out was burried over two years ago and we never had any ECOFF
userland.

  Ralf
