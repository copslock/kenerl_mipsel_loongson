Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g569DBnC000360
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 02:13:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g569DBkA000359
	for linux-mips-outgoing; Thu, 6 Jun 2002 02:13:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from oval.algor.co.uk (oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g569D1nC000355
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 02:13:03 -0700
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g569EYd19700;
	Thu, 6 Jun 2002 10:14:34 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id KAA03263;
	Thu, 6 Jun 2002 10:14:33 +0100 (BST)
Date: Thu, 6 Jun 2002 10:14:33 +0100 (BST)
Message-Id: <200206060914.KAA03263@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: cgd@broadcom.com
Cc: dom@algor.co.uk, "Eric Christopher" <echristo@redhat.com>,
   "Johannes Stezenbach" <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
Subject: Re: [Fwd: Current state of MIPS16 support?]
In-Reply-To: <yov5n0u8c401.fsf@broadcom.com>
References: <3CBFEAA9.9070707@algor.co.uk>
	<15566.28397.770794.272735@gladsmuir.algor.co.uk>
	<1022870431.3668.19.camel@ghostwheel.cygnus.com>
	<15614.12481.424601.806779@gladsmuir.algor.co.uk>
	<mailpost.1023291613.28112@news-sj1-1>
	<yov5n0u8c401.fsf@broadcom.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I wholeheatedly agree that it would be a really good thing if we were
all working around a common, recent, source tree...

I'm finding this discussion useful because it's identifying people who
are working in the area, and I'm wondering whether we can come
together in the short term on building a better regression test
suite...

> There seems to have been some confusion in the community about which
> versions to use, etc.  But, for most purposes, i've found that the
> latest releases have worked "pretty well" -- certainly well enough to
> use for development with a small number of patches...

Difference in perception here.

Algorithmics have been maintaining GNU C for about ten years for our
'embedded' customers, some of whom have very large and demanding code
bases.  

Up to and including the 2.96+ release we currently work with, no GCC
version we've taken on has been fit for use by our MIPS customers
without a large number of fixes, including significant changes to
nominally non-machine-dependent code.

If you experienced a big improvement in quality on moving to some more
recent version, I'd love to know and that's worth telling everyone.

But if you're saying "it's always been more or less all right" then we
are bound to suspect you're not looking hard enough...

> Presumably your customers desire both features of new GCC/binutils,
> but also want support for your improvements.

They want high reliability (which requires fairly lengthy
development schedules) and the latest version... I'm sure yours do
too, but the requirements compete somewhat.

> FWIW, it's not that hard to get changes back in if you try.

Thanks for the encouragement.

Dominic Sweetman, 
Algorithmics Ltd
