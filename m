Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56FBNnC025709
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 08:11:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56FBNjs025708
	for linux-mips-outgoing; Thu, 6 Jun 2002 08:11:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56FBHnC025704
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 08:11:17 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Thu, 06 Jun 2002 08:12:48 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-2.sj.broadcom.com (mail-sj1-2 [10.16.128.232])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g56FDE1S027666; Thu, 6 Jun 2002 08:13:14 -0700 (PDT)
Received: (from cgd@localhost) by mail-sj1-2.sj.broadcom.com (
 8.9.1/SJ8.9.1) id IAA10448; Thu, 6 Jun 2002 08:13:14 -0700 (PDT)
To: "Dominic Sweetman" <dom@algor.co.uk>
cc: "Eric Christopher" <echristo@redhat.com>,
   "Johannes Stezenbach" <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?]
References: <3CBFEAA9.9070707@algor.co.uk>
 <15566.28397.770794.272735@gladsmuir.algor.co.uk>
 <1022870431.3668.19.camel@ghostwheel.cygnus.com>
 <15614.12481.424601.806779@gladsmuir.algor.co.uk>
 <mailpost.1023291613.28112@news-sj1-1> <yov5n0u8c401.fsf@broadcom.com>
 <200206060914.KAA03263@mudchute.algor.co.uk>
From: cgd@broadcom.com
Date: 06 Jun 2002 08:13:14 -0700
In-Reply-To: "Dominic Sweetman"'s message of
 "Thu, 6 Jun 2002 10:14:33 +0100 (BST)"
Message-ID: <yov54rgga19x.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 10E1A47A1116645-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At Thu, 6 Jun 2002 10:14:33 +0100 (BST), Dominic Sweetman wrote:
> Difference in perception here.

Noted.


> Up to and including the 2.96+ release we currently work with, no GCC
> version we've taken on has been fit for use by our MIPS customers
> without a large number of fixes, including significant changes to
> nominally non-machine-dependent code.
>
> If you experienced a big improvement in quality on moving to some more
> recent version, I'd love to know and that's worth telling everyone.
> 
> But if you're saying "it's always been more or less all right" then we
> are bound to suspect you're not looking hard enough...

"I don't know."  I didn't really spend a _lot_ of time staring at the
gnu toolchain until about 2 or 3 years ago (mips tools, 2 or so years
8-).  Before that, i relied on tools that others had massaged ... and
invariably, yes, they did have at least a few "important" bug fixes
(often pulled in from later development versions of the tools).  I
think even going back 2 and change years, we had some problems with
the versions of gcc at that time, and, for some sets of compile flags
(for us, -membedded-pic) a _lot_ of problems with binutils.

As of gcc 3.0.4 and w/ binutils 2.12.1 (with patches to each, but
generally not bug-fixes .... though we undoubtedly still have a few),
at least for us, they seem to work well for linux and for some amount
of stand-alone embedded development work.

I wouldn't disagree, BTW, that the current tools for mips seem to have
some shortcomings.  I also wouldn't claim that we've comprehensively
tested the tools.  8-)


I think the goal of improving test suites to show additional bugs is a
very good one.  Personally, I've been trying to make sure regression
tests get added for bugs we find & fix, but there will always be more
bugs to find.



chris
