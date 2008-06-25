Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2008 08:47:44 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:13550 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20040256AbYFYHri (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jun 2008 08:47:38 +0100
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:Mime-Version:Content-Type:In-Reply-To:
	Sender; bh=DPZoLC/PIMX8PnYok//2Q0L7BgRGOutqmDCjPMXiQT8=; b=Hg+sj
	vKffkgaXTO3ymvSPiz2TgC4rH6ierWyf0tauevjOOL8QxssO/blSiZwBBfug/v9e
	BkCRJ7mAiPAuu1V/LcyDZQEbPRmWTn7O8HfL2842KGj5Gherc21ST5zUPQqUX9tP
	GW6bqemuKYQFW50e+w8kF8X337Cirb1lZcEtrc=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1KBPhe-0002s0-6U; Wed, 25 Jun 2008 08:46:06 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1KBPhb-00040P-GO; Wed, 25 Jun 2008 08:46:03 +0100
Date:	Wed, 25 Jun 2008 08:46:02 +0100
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	cooloney@kernel.org, dev-etrax@axis.com, dhowells@redhat.com,
	gerg@uclinux.org, yasutake.koichi@jp.panasonic.com,
	linux-parisc@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
	chris@zankel.net, linux-mips@linux-mips.org,
	ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080625074602.GA14791@flint.arm.linux.org.uk>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.4.2.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Mon, Jun 23, 2008 at 08:48:09PM +0300, Adrian Bunk wrote:
> diff --git a/include/asm-arm/ptrace.h b/include/asm-arm/ptrace.h
> index 7aaa206..8382b75 100644
> --- a/include/asm-arm/ptrace.h
> +++ b/include/asm-arm/ptrace.h
> @@ -139,8 +139,6 @@ static inline int valid_user_regs(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -#endif	/* __KERNEL__ */
> -
>  #define pc_pointer(v) \
>  	((v) & ~PCMASK)
>  
> @@ -153,10 +151,10 @@ extern unsigned long profile_pc(struct pt_regs *regs);
>  #define profile_pc(regs) instruction_pointer(regs)
>  #endif
>  
> -#ifdef __KERNEL__
>  #define predicate(x)		((x) & 0xf0000000)
>  #define PREDICATE_ALWAYS	0xe0000000
> -#endif
> +
> +#endif /* __KERNEL__ */
>  
>  #endif /* __ASSEMBLY__ */
>  

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
