Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 14:26:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:49392 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022783AbXCZN0u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 14:26:50 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 301589AA4; Mon, 26 Mar 2007 22:25:30 +0900 (JST)
Date:	Mon, 26 Mar 2007 22:25:30 +0900 (JST)
Message-Id: <20070326.222530.25910042.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org, ths@networkno.de
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070325221919.GA12088@linux-mips.org>
References: <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
	<4606AA74.3070907@gentoo.org>
	<20070325221919.GA12088@linux-mips.org>
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
X-archive-position: 14688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007 23:19:19 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> --- a/include/asm-mips/stackframe.h
> +++ b/include/asm-mips/stackframe.h
> @@ -79,7 +79,7 @@
>  #else
>  		MFC0	k0, CP0_CONTEXT
>  #endif
> -#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
> +#if !defined(CONFIG_KERNEL_LOADS_IN_CKSEG0) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
>  		lui	k1, %highest(kernelsp)
>  		daddiu	k1, %higher(kernelsp)
>  		dsll	k1, 16

CONFIG_KERNEL_LOADS_IN_CKSEG0 is not defined on 32-bit kernel.

#if defined(CONFIG_64BIT) && (!defined(CONFIG_KERNEL_LOADS_IN_CKSEG0) || __GNUC__ < 4)

Perhaps?
---
Atsushi Nemoto
