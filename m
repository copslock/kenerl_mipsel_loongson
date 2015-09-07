Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 18:07:51 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007250AbbIGQHtoZyU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 18:07:49 +0200
Date:   Mon, 7 Sep 2015 17:07:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using
 MIPS16
In-Reply-To: <1441640982-17547-1-git-send-email-yszhou4tech@gmail.com>
Message-ID: <alpine.LFD.2.20.1509071700480.10227@eddie.linux-mips.org>
References: <1441640982-17547-1-git-send-email-yszhou4tech@gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49130
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

> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
> index 8f2d184..8b9a390 100644
> --- a/arch/mips/include/uapi/asm/swab.h
> +++ b/arch/mips/include/uapi/asm/swab.h
> @@ -8,6 +8,11 @@
>  #ifndef _ASM_SWAB_H
>  #define _ASM_SWAB_H
>  
> +/*
> + * Enable the optimized version only when compiling without MIPS16.
> + */
> +#ifndef __mips16
> +
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>  
> @@ -66,4 +71,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
>  #define __arch_swab64 __arch_swab64
>  #endif /* __mips64 */
>  #endif /* MIPS R2 or newer or Loongson 3A */
> +#endif /* ifndef __mips16 */
>  #endif /* _ASM_SWAB_H */

 I think it will best go with the main #if which checks the conditions 
that have to be met for this optimisation to be possible; there is no gain 
from nesting the conditions here.

 Also you need a second patch paired with this to undo your previous 
`nomips16' change which will be no longer needed (and in the case of the 
`.set' part not wanted either).

  Maciej
