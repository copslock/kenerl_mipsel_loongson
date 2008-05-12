Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 15:34:53 +0100 (BST)
Received: from www.church-of-our-saviour.org ([69.25.196.31]:47072 "EHLO
	thunker.thunk.org") by ftp.linux-mips.org with ESMTP
	id S20030699AbYELOeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 15:34:50 +0100
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JvZ9E-0003cm-HT; Mon, 12 May 2008 10:37:04 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JvZ6g-00067i-5p; Mon, 12 May 2008 10:34:26 -0400
Date:	Mon, 12 May 2008 10:34:26 -0400
From:	Theodore Tso <tytso@mit.edu>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080512143426.GB7029@mit.edu>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@mit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 05:54:24PM +0400, Dmitri Vorobiev wrote:
> 
> Yep. The export is missing. Attached patch was build-tested for a
> Malta config with ext4 enabled as a module.

Thanks, Dmitri!  

What is the Linux-mips' team preference for feeding this patch to
Linus?  This technically isn't a regression, since it was broken in
2.6.25, but it would be nice to get this to Linus sooner rather than
later.  Should I push it with a batch of ext4 fixes, or do you want to
push it via the mips tree?  (Davem asked me to push the sparc export
via ext4, while the ppc arch, it went via the ppc tree.  So whichever
is your preference; I'm easy.  :-)

   	     	     		     	    - Ted


> From cb55ed7d958cf4abb58dd1d6e46e09447b5694b0 Mon Sep 17 00:00:00 2001
> From: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
> Date: Mon, 12 May 2008 17:49:19 +0400
> Subject: [PATCH 1/1] [MIPS] Export empty_zero_page as a GPL symbol
> 
> The empty_zero_page symbol is needed for the ext4 driver and
> should therefore be exported. This fixes the following error
> reported by Martin Michlmayr:
> 
> >>>>>>>
> 
> MODPOST 1516 modules
> ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
> 
> >>>>>>
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
> ---
>  arch/mips/mm/init.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index ecd562d..618a418 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -70,7 +70,10 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
>   * any price.  Since page is never written to after the initialization we
>   * don't have to care about aliases on other CPUs.
>   */
> -unsigned long empty_zero_page, zero_page_mask;
> +unsigned long empty_zero_page;
> +EXPORT_SYMBOL_GPL(empty_zero_page);
> +
> +unsigned long zero_page_mask;
>  
>  /*
>   * Not static inline because used by IP27 special magic initialization code
> -- 
> 1.5.3
> 
