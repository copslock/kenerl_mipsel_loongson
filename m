Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 08:08:19 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:25325 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225073AbUJUHIN>;
	Thu, 21 Oct 2004 08:08:13 +0100
Received: (qmail 10851 invoked from network); 21 Oct 2004 07:08:06 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@62.77.73.201)
  by smtp.seznam.cz with SMTP; 21 Oct 2004 07:08:06 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1CKX4b-0000cj-00; Thu, 21 Oct 2004 09:09:21 +0200
Date: Thu, 21 Oct 2004 09:09:21 +0200
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.9] KSEG/CKSEG fixes
Message-ID: <20041021070921.GA2297@umax645sx>
References: <20041021001427.GA25441@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021001427.GA25441@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 05:14:27PM -0700, Tom Rini wrote:
> The following is needed to get an SB1250 to compile & boot in 64bit
> mode (briefly tested).
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> --- linux-2.6.9.orig/arch/mips/mm/c-sb1.c
> +++ linux-2.6.9/arch/mips/mm/c-sb1.c
> @@ -488,7 +488,11 @@ void ld_mmu_sb1(void)
>  	/* Special cache error handler for SB1 */
>  	memcpy((void *)(CAC_BASE   + 0x100), &except_vec2_sb1, 0x80);
>  	memcpy((void *)(UNCAC_BASE + 0x100), &except_vec2_sb1, 0x80);
> +#ifdef CONFIG_MIPS64
> +	memcpy((void *)CKSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
> +#else
>  	memcpy((void *)KSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
> +#endif

I don't think this is best solution. Thomas Bogendoerfer messed with
KSEG/CKSEG definitions recently and idea is to create board specific
header file spaces.h

	ladis
