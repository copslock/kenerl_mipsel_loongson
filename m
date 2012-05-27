Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 May 2012 04:19:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49085 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901164Ab2E0CTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 May 2012 04:19:47 +0200
Date:   Sun, 27 May 2012 03:19:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Douglas Leung <douglas@mips.com>
Subject: Re: [PATCH] MIPS: Add support for the MIPS32 4Kc family I/D
 caches.
In-Reply-To: <20120522173245.GB5884@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1205270312110.3701@eddie.linux-mips.org>
References: <1337614412-29035-1-git-send-email-sjhill@mips.com> <20120522173245.GB5884@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 22 May 2012, Ralf Baechle wrote:

> > diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> > index 18546fa..bca1447 100644
> > --- a/arch/mips/mm/c-r4k.c
> > +++ b/arch/mips/mm/c-r4k.c
> > @@ -1000,7 +1000,7 @@ static void __cpuinit probe_pcache(void)
> >  			c->icache.linesz = 2 << lsize;
> >  		else
> >  			c->icache.linesz = lsize;
> > -		c->icache.sets = 64 << ((config1 >> 22) & 7);
> > +		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
> >  		c->icache.ways = 1 + ((config1 >> 16) & 7);
> >  
> >  		icache_size = c->icache.sets *
> > @@ -1020,7 +1020,7 @@ static void __cpuinit probe_pcache(void)
> >  			c->dcache.linesz = 2 << lsize;
> >  		else
> >  			c->dcache.linesz= lsize;
> > -		c->dcache.sets = 64 << ((config1 >> 13) & 7);
> > +		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
> >  		c->dcache.ways = 1 + ((config1 >> 7) & 7);
> >  
> >  		dcache_size = c->dcache.sets *
> 
> Good catch.  I'm amazed how long we were able to get away with this bug.

 It was not a bug, or at least not an active one.  The new encoding was 
only added with revision 3 of the architecture or thereabouts, so not so 
long ago.  It used to be reserved previously, so we just handled it 
arbitrarily (though perhaps we should have panicked instead on 
encountering it indeed).

> I guess it only covers a rather esotheric cache configuration.
> 
> I wonder what variant of the 4Kc is affected by this?  So far none has
> an I-cache with only 32 lines per way.

 It must be a recent addition; is the 4Kc maintained anymore actually?  
I've thought it was replaced with the 4KEc entirely, hmm...

  Maciej
