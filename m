Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 14:46:26 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007446AbbIGMqXnxjJ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 14:46:23 +0200
Date:   Mon, 7 Sep 2015 13:46:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: UAPI: Disable __arch_swab{16,32} when using
 MIPS16
In-Reply-To: <1441628857-24342-1-git-send-email-yszhou4tech@gmail.com>
Message-ID: <alpine.LFD.2.20.1509071341160.10227@eddie.linux-mips.org>
References: <1441628857-24342-1-git-send-email-yszhou4tech@gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49126
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

On Mon, 7 Sep 2015, Yousong Zhou wrote:

> index 8f2d184..8396d5a 100644
> --- a/arch/mips/include/uapi/asm/swab.h
> +++ b/arch/mips/include/uapi/asm/swab.h
> @@ -16,6 +16,10 @@
>  #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
>      defined(_MIPS_ARCH_LOONGSON3A)
>  
> +/*
> + * Enable the optimized version only when compiling without MIPS16.
> + */
> +#ifndef __mips16
>  static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
>  {
>  	__asm__(
> @@ -44,6 +48,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  	return x;
>  }
>  #define __arch_swab32 __arch_swab32
> +#endif /* ifndef __mips16 */
>  
>  /*
>   * Having already checked for MIPS R2, enable the optimized version for

 Please #ifdef-out all the functions, there's nothing about
`__arch_swab64' making it worth being a special exception.

  Maciej
