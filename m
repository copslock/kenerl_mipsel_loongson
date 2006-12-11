Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 18:16:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:47597 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039491AbWLKSQm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Dec 2006 18:16:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBBIGeNe028049;
	Mon, 11 Dec 2006 18:16:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBBIGe2i028044;
	Mon, 11 Dec 2006 18:16:40 GMT
Date:	Mon, 11 Dec 2006 18:16:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 2/3] Setup min_low_pfn/max_low_pfn correctly
Message-ID: <20061211181640.GA25769@linux-mips.org>
References: <1165420110699-git-send-email-fbuihuu@gmail.com> <11654201103291-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11654201103291-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 04:48:29PM +0100, Franck Bui-Huu wrote:

> The old code was assuming that min_low_pfn was always 0. This
> means that we can't handle platforms with a big hole at start
> of memory since mem_map[] size would blew up.

It was - and IP22 was paying a high price for that.  It's currently 1MB
on 32-bit and 1.75MB on 64-bit kernels - but used to be much higher in
the past.

Btw, I think you're confusing the terms here; your patch description reads
wrong while the patch looks fine.  PFN is page frame number, not physical
frame number.  To avoid wasting dead mem_map[] entries idealy the pfn for
the first allocatable page should be zero.
So ignoring NUMA and discontig memory for a moment (those make everything
more complicated ...) PFN 0 is the first entry in mem_map[] - which usually
but not necessarily is physical address 0x0.

> This patch does not relax this constraint but it's a first
> step to achieve that.

> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 89440a0..8e58d7f 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -271,7 +271,6 @@ static void __init bootmem_init(void)
>  static void __init bootmem_init(void)
>  {
>  	unsigned long reserved_end;
> -	unsigned long highest = 0;
>  	unsigned long mapstart = -1UL;

Assigning a negative number to an unsigned long variable ...

>  	unsigned long bootmap_size;
>  	int i;
> @@ -284,6 +283,13 @@ static void __init bootmem_init(void)
>  	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
>  
>  	/*
> +	 * max_low_pfn is not a number of pages. The number of pages
> +	 * of the system is given by 'max_low_pfn - min_low_pfn'.
> +	 */
> +	min_low_pfn = -1UL;

Assigning a negative number to an unsigned long variable ...

  Ralf
