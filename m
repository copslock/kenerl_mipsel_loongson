Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 19:32:51 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:48068 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903694Ab2EVRcr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2012 19:32:47 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4MHWkc2010312;
        Tue, 22 May 2012 18:32:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4MHWjWU010311;
        Tue, 22 May 2012 18:32:45 +0100
Date:   Tue, 22 May 2012 18:32:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, Douglas Leung <douglas@mips.com>
Subject: Re: [PATCH] MIPS: Add support for the MIPS32 4Kc family I/D caches.
Message-ID: <20120522173245.GB5884@linux-mips.org>
References: <1337614412-29035-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337614412-29035-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 21, 2012 at 10:33:32AM -0500, Steven J. Hill wrote:

> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/mm/c-r4k.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 18546fa..bca1447 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1000,7 +1000,7 @@ static void __cpuinit probe_pcache(void)
>  			c->icache.linesz = 2 << lsize;
>  		else
>  			c->icache.linesz = lsize;
> -		c->icache.sets = 64 << ((config1 >> 22) & 7);
> +		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
>  		c->icache.ways = 1 + ((config1 >> 16) & 7);
>  
>  		icache_size = c->icache.sets *
> @@ -1020,7 +1020,7 @@ static void __cpuinit probe_pcache(void)
>  			c->dcache.linesz = 2 << lsize;
>  		else
>  			c->dcache.linesz= lsize;
> -		c->dcache.sets = 64 << ((config1 >> 13) & 7);
> +		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
>  		c->dcache.ways = 1 + ((config1 >> 7) & 7);
>  
>  		dcache_size = c->dcache.sets *

Good catch.  I'm amazed how long we were able to get away with this bug.
I guess it only covers a rather esotheric cache configuration.

I wonder what variant of the 4Kc is affected by this?  So far none has
an I-cache with only 32 lines per way.

  Ralf
