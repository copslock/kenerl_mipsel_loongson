Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 17:31:26 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:56297 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20023167AbYGIQbY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2008 17:31:24 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.dynamic.dsl.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 0FEC8E30CAF;
	Wed,  9 Jul 2008 18:31:22 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 55D9D580D9; Wed,  9 Jul 2008 18:32:12 +0200 (CEST)
Date:	Wed, 9 Jul 2008 18:32:12 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-sparse@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Message-ID: <20080709163212.GA1227@uranus.ravnborg.org>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp> <20080708204547.GA16742@uranus.ravnborg.org> <20080710.011818.26096759.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080710.011818.26096759.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 10, 2008 at 01:18:18AM +0900, Atsushi Nemoto wrote:
> On Tue, 8 Jul 2008 22:45:47 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > > The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
> > > sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> > > pre_buffer overflow.
> > 
> > Why does mips have this need when all other archs does not?
> > We should fix sparse so it is dynamically allocated - but
> > that is not an excuse for mips to use odd stuff like this.
> > 
> > So please someone from mips land explain why this is needed.
> 
> This was introduced by commit 59b3e8e9aac69d2d02853acac7e2affdfbabca50.
> ("[MIPS] Makefile crapectomy.")
> 
> Before the commit, CHECKFLAGS was adjusted like this:
> 
> CHECKFLAGS-y				+= -D__linux__ -D__mips__ \
> 					   -D_MIPS_SZINT=32 \
> 					   -D_ABIO32=1 \
...

So the expalnation seems that gcc for mips define much more
than the usual gcc does.
My gcc define 76 symbols for i386.

And we use this stuff in the kernel.

OK - thanks for the details.

	Sam
