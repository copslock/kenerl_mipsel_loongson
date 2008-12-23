Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2008 21:15:49 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:14059 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24208029AbYLWVPq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Dec 2008 21:15:46 +0000
Received: (qmail 25095 invoked from network); 23 Dec 2008 22:15:45 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 23 Dec 2008 22:15:45 +0100
Date:	Tue, 23 Dec 2008 22:15:43 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] Alchemy: provide cpu feature overrides.
Message-ID: <20081223221543.22078f74@scarran.roarinelk.net>
In-Reply-To: <20081223163703.GA9952@linux-mips.org>
References: <1229973668-18182-1-git-send-email-mano@roarinelk.homelinux.net>
	<1229973668-18182-2-git-send-email-mano@roarinelk.homelinux.net>
	<20081223143909.GD5981@linux-mips.org>
	<20081223172954.06b301cb@scarran.roarinelk.net>
	<20081223163703.GA9952@linux-mips.org>
Organization: Private
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.14.5; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Tue, 23 Dec 2008 17:37:03 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Dec 23, 2008 at 05:29:54PM +0100, Manuel Lauss wrote:
> 
> > > > Code generated for Alchemy does not use all MIPS32r1 features.  Add cpu
> > > > feature overrides tailored for Alchemy chips and help GCC create better
> > > > code.  As a nice sideeffect the size of the resulting kernel is reduced
> > > > by a few kilobytes (~200kB for a non-modular db1200 devboard build).
> > > 
> > > The enormous size difference is probably 99% due to atomic and bitops
> > > which exist in LL/SC and non-LL/SC versions and without the header gcc
> > > will expand the inline function each time.  That will hurt, also
> > > performance.  Also the big size difference suggests that we may want to
> > > outline some or all of these functions.
> > 
> > You are of course correct:
> > 
> >    text    data     bss     dec     hex filename                                                                                                                
> > 3890074  124400  436528 4451002  43eaba vmlinux
> > 3890070  124400  436528 4450998  43eab6 vmlinux+mips32r1
> > 3690742  124396  436528 4251666  40e012 vmlinux++llsc
> > 3666386  124332  436528 4227246  4080ae vmlinux+++all
> 
> Thanks for the numbers.  I'm a little surprised that there are only
> 4 byte difference between the first two variants?
> 
>   Ralf

Sorry, error on my side: one has to define constants for all
mipsXXrY variants to get a good result:

3890074  124400  436528 4451002  43eaba vmlinux
3880034  124400  436528 4440962  43c382 vmlinux+mips_r
3690742  124396  436528 4251666  40e012 vmlinux++llsc
3666386  124332  436528 4227246  4080ae vmlinux+++all

Happy holidays,
	Manuel Lauss.
