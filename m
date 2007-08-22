Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 08:02:06 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:14809 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022587AbXHVHCD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2007 08:02:03 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1INkE4-0001Dd-00; Wed, 22 Aug 2007 09:02:00 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id D0A5211ACC6; Wed, 22 Aug 2007 08:59:30 +0200 (CEST)
Date:	Wed, 22 Aug 2007 08:59:30 +0200
To:	Glauber de Oliveira Costa <glommer@gmail.com>
Cc:	Chris Wedgwood <cw@f00f.org>, Adrian Bunk <bunk@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: RFC: drop support for gcc < 4.0
Message-ID: <20070822065930.GA6459@alpha.franken.de>
References: <20070821132038.GA22254@ff.dom.local> <20070821093103.3c097d4a.randy.dunlap@oracle.com> <20070821173550.GC30705@stusta.de> <20070821182505.GA20968@puku.stupidest.org> <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Aug 21, 2007 at 05:41:04PM -0300, Glauber de Oliveira Costa wrote:
> On 8/21/07, Chris Wedgwood <cw@f00f.org> wrote:
> > On Tue, Aug 21, 2007 at 07:35:50PM +0200, Adrian Bunk wrote:
> >
> > > Are there any architectures still requiring a gcc < 4.0 ?
> >
> > Yes, sadly in some places (embedded) there are people with older
> > compiler who want newer kernels.
> 
> Last time I tried a mips build, it would fail the compile unless I was
> using _exactly_ 3.4.4 (I didn't tried older versions, but did try
> 3.4.6, for ex.). So I also think the 3.4 series will still have to be
> around for a while.

that's fixed and I'm happiliy building the MIPS tree with gcc 3.3.3.
And I would be very unhappy to upgrade all my crosscompiler just because
someone thinks nobody build -rc kernel with older compilers. I do.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
