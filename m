Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 10:41:54 +0200 (CEST)
Received: from guitar.tcltek.co.il ([192.115.133.116]:34429 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992212AbeC1IlpaOinL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 10:41:45 +0200
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id F3DA644004A;
        Wed, 28 Mar 2018 11:41:42 +0300 (IDT)
Date:   Wed, 28 Mar 2018 11:41:41 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mm@kvack.org,
        stable@vger.kernel.org, James Hogan <james.hogan@mips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180328084141.vseuroknkrxhraps@sapphire.tkos.co.il>
References: <1522226296-3091-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522226296-3091-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180223
Return-Path: <baruch@tkos.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baruch@tkos.co.il
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

Hi Huacai,

On Wed, Mar 28, 2018 at 04:38:16PM +0800, Huacai Chen wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> V1 -> V2: Fix build on ARM.
> V2 -> V3: Fix build on SuperH.
> V3 -> V4: Initialize __stack_chk_guard in C code as a constant.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 20 insertions(+), 21 deletions(-)

This diffstat doesn't match the patch below. The patch touches no .S file.

baruch

> 
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 16a8a80..e8fe51f 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -128,12 +128,7 @@ asmlinkage void __div0(void)
>  	error("Attempting division by 0!");
>  }
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  {
>  	int ret;
>  
> -	__stack_chk_guard_setup();
> -
>  	output_data		= (unsigned char *)output_start;
>  	free_mem_ptr		= free_mem_ptr_p;
>  	free_mem_end_ptr	= free_mem_ptr_end_p;
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..81df904 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -76,12 +76,7 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>  	unsigned long zimage_start, zimage_size;
>  
> -	__stack_chk_guard_setup();
> -
>  	zimage_start = (unsigned long)(&__image_begin);
>  	zimage_size = (unsigned long)(&__image_end) -
>  	    (unsigned long)(&__image_begin);
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..c15cac9 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -104,12 +104,7 @@ static void error(char *x)
>  	while(1);	/* Halt */
>  }
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>  {
>  	unsigned long output_addr;
>  
> -	__stack_chk_guard_setup();
> -
>  #ifdef CONFIG_SUPERH64
>  	output_addr = (CONFIG_MEMORY_START + 0x2000);
>  #else

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
