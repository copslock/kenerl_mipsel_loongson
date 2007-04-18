Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 13:02:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62345 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021721AbXDRMCn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 13:02:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IC2fOi021083;
	Wed, 18 Apr 2007 13:02:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IC2eTL021082;
	Wed, 18 Apr 2007 13:02:40 +0100
Date:	Wed, 18 Apr 2007 13:02:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 4/16] TO_PHYS_MASK for loongson2
Message-ID: <20070418120240.GD3938@linux-mips.org>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11766507661133-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 15, 2007 at 11:25:53PM +0800, tiansm@lemote.com wrote:

> diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
> index 964c5ed..a4d9a07 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -145,7 +145,7 @@
>  #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
>  #endif
>  
> -#if defined (CONFIG_CPU_R10000)
> +#if defined (CONFIG_CPU_R10000) || defined (CONFIG_CPU_LOONGSON2)
>  #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
>  #endif

How about we define TO_PHYS_MASK to 2^57-1 for all processors instead?

The use of TO_PHYS_MASK is to strip of the high bits of of a XKPHYS kernel
virtual address.  Allowing for the top 2 region and 3 cache mode bits that
would leave 59 bits.  If we also allow for the macro to be used for
stripping off the 2 R10000 "uncached attribute" bits we would be down to
57 bits.  Not sure if that would be useful - but we got gobs of address
space to burn and adding yet another #ifdef for every new 64-bit processor
or even variant to addrspace.h isn't really the way to go.

  Ralf
