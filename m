Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2012 11:10:38 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:37762 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903500Ab2FQJKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jun 2012 11:10:34 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1SgBV6-0006Ku-00; Sun, 17 Jun 2012 11:10:28 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id E6B3F1BB7B0; Sun, 17 Jun 2012 11:09:43 +0200 (CEST)
Date:   Sun, 17 Jun 2012 11:09:43 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        loongson-dev@googlegroups.com
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120617090943.GA29077@alpha.franken.de>
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com>
 <20120616121513.GP2039@vicerveza.homeunix.net>
 <20120616125847.GR2039@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20120616125847.GR2039@vicerveza.homeunix.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 33678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Jun 16, 2012 at 02:58:47PM +0200, Lluís Batlle i Rossell wrote:
> Hello again,
> 
> On Sat, Jun 16, 2012 at 02:15:13PM +0200, Lluís Batlle i Rossell wrote:
> > > From what I can tell, ldc1 is a valid MIPS32 instruction, so this
> > > should probably be something like
> > > 
> > >         case ld_op:
> > > #ifndef CONFIG_64BIT
> > >                 return sigill;
> > > #endif
> > 
> > I agree! I'll repost with these fixes.
> 
> Well, I think I take my words back. Handling the ldc1/sdc1 cases in MIPS32 is
> tricker than I thought first, because I can't use ldl/ldr or sdl/sdr there.
> Given my ability with mips assembly, I leave the patch as is.
> 
> In 'patchwork' I had set the patch first to superseeded, but then I set it back
> to New.

why is there a reason for this ? Unaligned FPU access shouts to me simply
broken code, go fix that. But maybe I'm wrong ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
