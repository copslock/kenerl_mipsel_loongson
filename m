Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Aug 2006 16:29:07 +0100 (BST)
Received: from p549F5796.dip.t-dialin.net ([84.159.87.150]:9197 "EHLO
	p549F5796.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20040096AbWHEP3C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Aug 2006 16:29:02 +0100
Received: from mba.ocn.ne.jp ([210.190.142.172]:37843 "HELO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with SMTP id S1099485AbWHEP3F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Aug 2006 17:29:05 +0200
Received: from localhost (p7188-ipad202funabasi.chiba.ocn.ne.jp [222.146.78.188])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA6FBA8C7; Sun,  6 Aug 2006 00:28:52 +0900 (JST)
Date:	Sun, 06 Aug 2006 00:30:28 +0900 (JST)
Message-Id: <20060806.003028.41630495.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Cleanup bootmem_init()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D34C84.9090902@innova-card.com>
References: <44D34C84.9090902@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 04 Aug 2006 15:32:52 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> This function although doing simple things is hard to follow. It's
> mainly due to:
> 
>     - a lot of #ifdef
>     - bad local names
>     - redundant tests
> 
> So this patch try to address these issues. It also do not use
> max_pfn global which is marked as an unused exported symbol.

Looks good for me, except this:

> -	if (max_low_pfn > MAXMEM_PFN) {
> -		max_low_pfn = MAXMEM_PFN;
> -#ifndef CONFIG_HIGHMEM
> -		/* Maximum memory usable is what is directly addressable */
> -		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
> -		       MAXMEM >> 20);
> -		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
> +	if (highest > PFN_DOWN(HIGHMEM_START)) {
> +#ifdef CONFIG_HIGHMEM
> +		highstart_pfn = PFN_DOWN(HIGHMEM_START);
> +		highend_pfn = highest;
>  #endif
> +		highest = PFN_DOWN(HIGHMEM_START);
>  	}

You drop two warnings here.  I'm afraid this leads so many "I have 1GB
memory but can not use all of them. Why?" questions.

BTW, "Use a HIGHMEM enabled kernel" might not be good.  I suppose Ralf
wants something like this :-)

#if defined(CPU_SUPPORTS_64BIT_KERNEL) && defined(SYS_SUPPORTS_64BIT_KERNEL)
		printk(KERN_WARNING "Use a 64-bit kernel.\n");
#elif defined(CPU_SUPPORTS_HIGHMEM) && defined(SYS_SUPPORTS_HIGHMEM)
		printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
#else
		/* put a good excuse here... */
#endif

---
Atsushi Nemoto
