Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g566TenC028592
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 5 Jun 2002 23:29:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g566Td5v028591
	for linux-mips-outgoing; Wed, 5 Jun 2002 23:29:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g566TTnC028588
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 23:29:29 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Wed, 05 Jun 2002 23:31:26 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g566VR1S026256; Wed, 5 Jun 2002 23:31:27 -0700 (PDT)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id XAA26787; Wed, 5 Jun 2002 23:31:26 -0700 (PDT)
To: dom@algor.co.uk
cc: "Eric Christopher" <echristo@redhat.com>,
   "Johannes Stezenbach" <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?]
References: <3CBFEAA9.9070707@algor.co.uk>
 <15566.28397.770794.272735@gladsmuir.algor.co.uk>
 <1022870431.3668.19.camel@ghostwheel.cygnus.com>
 <15614.12481.424601.806779@gladsmuir.algor.co.uk>
 <mailpost.1023291613.28112@news-sj1-1>
From: cgd@broadcom.com
Date: 05 Jun 2002 23:31:26 -0700
In-Reply-To: dom@algor.co.uk's message of
 "Wed, 5 Jun 2002 15:40:14 +0000 (UTC)"
Message-ID: <yov5n0u8c401.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 10E1DE341126298-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At Wed, 5 Jun 2002 15:40:14 +0000 (UTC), "Dominic Sweetman" wrote:
> I fear it's "when time permits" at the moment.  The number of changes
> is sufficiently large that it will take concentrated effort for 2-4
> weeks, and this is very difficult to find.

For what it's worth, if you expend the effort while you go, it saves
much time in the long run, both in terms of maintaining the changes,
and merging them.


> During most of the last few years (as I understand it) it has been
> difficult to establish a baseline to patch against, or find someone
> who had the time to attend to bug reports.

As someone who's been maintaining a MIPS toolchain (based on gcc,
binutils, etc.) for a couple of years, I dunno that that makes sense.

There seems to have been some confusion in the community about which
versions to use, etc.  But, for most purposes, i've found that the
latest releases have worked "pretty well" -- certainly well enough to
use for development with a small number of patches -- for linux mips
and other mips targets.  We've been using gcc 3.0.x now for a while;
last i looked the linux mips pages recommended against that, and I
really don't understand why...  Soon we'll be switching to 3.1.


> > Almost 90% of the bug reports I see are against IRIX.
> 
> That does suggest you're missing some pretty large chunks of the
> community!


> > People have to "re-invent the wheel" because the changes never make
> > it back into the official sources - everyone has their own one offs.
> > If we fix this then the work that all of the disparate groups are
> > doing will at least go toward a common goal. 
> 
> We believe that a large number of man hours will be required to
> identify and merge all major valuable features and then chase out
> the bugs, before there can be a release which everyone has reason to
> adopt.
> 
> We certainly can't afford to put in those hours unless we win
> contracts; I suspect Red Hat can't, either.

This puts you into an interesting position:

Presumably your customers desire both features of new GCC/binutils,
but also want support for your improvements.

The way it looks to me, by not getting your changes put back into the
public sources as you go, you've managed both to make a large chunk of
work for yourself if you want to catch up and to put yourself at a
competitive disadvantage in the eyes of customers who place high value
in current GCC features.


FWIW, it's not that hard to get changes back in if you try.  Over the
past couple of years, basically starting as an "outsider," i've
managed to get ... about a hundred fifty patches -- ranging from tiny
or trivial bug fixes to fairly huge changes -- pushed back into the
public sources, and have even managed to be appointed the mips gdb
'sim' maintainer...  The result is, many of the tool problems we found
have now been fixed, and since we put in test case entries where
possible should stay fixed, and now our source merges are much easier
and go much more quickly.



cgd
