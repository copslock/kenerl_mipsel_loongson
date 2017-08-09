Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 10:15:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57143 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995200AbdHIIPDHgSDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 10:15:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0B62070DABC4A;
        Wed,  9 Aug 2017 09:14:55 +0100 (IST)
Received: from [10.20.78.47] (10.20.78.47) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 9 Aug 2017
 09:14:56 +0100
Date:   Wed, 9 Aug 2017 09:14:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH] MIPS: math-emu: do not use bools for arithmetic
In-Reply-To: <20170731092151.116438-1-manuel.lauss@gmail.com>
Message-ID: <alpine.DEB.2.00.1708090349390.17596@tp.orcam.me.uk>
References: <20170731092151.116438-1-manuel.lauss@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.47]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 31 Jul 2017, Manuel Lauss wrote:

> I'm unsure whether the patch is really correct, due to the unexpected
> binary size reduction.  I do not have a hardfloat mips32 userland at hand
> therefore I'd appreciate it if someone could test it!

 What exactly are you unsure about?  Double operations using odd register 
indices in the 32-bit FPR mode are architecturally unpredictable.  Is this 
what concerns you?

> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index f08a7b4facb9..f3a9bf5285e0 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -830,12 +830,12 @@ do {									\
>  } while (0)
>  
>  #define DIFROMREG(di, x)						\
> -	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
> +	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0 ? 1 : 0)], 0))

 Umm, I find the expression somewhat hard to follow.  How about:

	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) ^ 1))

?

>  #define DITOREG(di, x)							\
>  do {									\
>  	unsigned fpr, i;						\
> -	fpr = (x) & ~(cop1_64bit(xcp) == 0);				\
> +	fpr = (x) & ~(cop1_64bit(xcp) == 0 ? 1 : 0);			\

 Likewise:

	fpr = (x) & ~(cop1_64bit(xcp) ^ 1);				\

?

  Maciej
