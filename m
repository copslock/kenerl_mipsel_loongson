Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 09:14:46 +0100 (CET)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44165 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeCWIOij8X29 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 09:14:38 +0100
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180323081429euoutp017fd0512af79dfd65f60c5c6e6c82ffe8~efo1QEjbb1535115351euoutp01j;
        Fri, 23 Mar 2018 08:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180323081429euoutp017fd0512af79dfd65f60c5c6e6c82ffe8~efo1QEjbb1535115351euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1521792869;
        bh=x/GuGYr4YZMcNAvEgVETqk2/LVlscrJ/lg2M6MQX5Qo=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=Hw/0teYFrbonRf6ZO1w43t54JUmnk+NslwNoBZHcgbSd8bZ4n6dAZJl4VKiD5+UYF
         pTYUV3F/Ci4mQYVbWAlINnnlHDNCbNT3qAX/3hG8fVKKmYp+83StbR/aJ10Q03ww/q
         cwbuGECquj0ffol/sx4A2bBlRTEHD1XO8alFJSVs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180323081428eucas1p256a25b14020f87cffc9611099fd4eac7~efo0FOOfu0426004260eucas1p2X;
        Fri, 23 Mar 2018 08:14:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.AA.17380.367B4BA5; Fri, 23
        Mar 2018 08:14:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180323081426eucas1p1197a70772d3b4fdfef2ccd63275399d5~efoySK32H2931929319eucas1p1r;
        Fri, 23 Mar 2018 08:14:26 +0000 (GMT)
X-AuditID: cbfec7f4-6f9ff700000043e4-a6-5ab4b763f1ab
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.7E.04183.267B4BA5; Fri, 23
        Mar 2018 08:14:26 +0000 (GMT)
Received: from [106.116.147.30] by eusync4.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0P6100B5CAW0MF30@eusync4.samsung.com>; Fri, 23 Mar 2018 08:14:26
        +0000 (GMT)
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
To:     Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mm@kvack.org,
        stable@vger.kernel.org, James Hogan <james.hogan@mips.com>,
        linux-arm-kernel@lists.infradead.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <e117a68e-69d6-2f9d-b6bb-7a8b0025e2b4@samsung.com>
Date:   Fri, 23 Mar 2018 09:14:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7rJ27dEGUyYJmYxZ/0aNov5TRvY
        LBb+/MVqsXXTXjaL8+c3sFtsenyN1eLyrjlsFhOmTmK3uLfmP6vFjPP7mCzm/JnCbHH7Mq/F
        pT0qFgs2PmK0uD9pL5MDv0dLcw+bx6ZVnUDi0yR2j9nnzrF5nJv9gcXjxIzfLB5HV65l8ti8
        pN7j9ZGHLB5Ltt5k9Pi8SS6AO4rLJiU1J7MstUjfLoErY/6J9ywFd/Ur1t4+wdjAOFWti5GT
        Q0LARGLmlfvsXYxcHEICKxglpn2exAySEBL4zCjx51YqTFH7yx4WiKJljBIPT7xkhXCeM0r0
        vb3EClIlLOAtcfbxYhYQW0QgQOLvoolMIEXMAueYJTb0PmEDSbAJGEp0ve0Cs3kF7CTW990G
        s1kEVCUuTdsJtJqDQ1QgRuL1HzeIEkGJH5Pvgc3kFHCS2LdxGVg5s4CVxLN/rawQtrzE5jVv
        mSFscYnm1ptgl0oIrGOX+HG0lQXiBReJGY9OsUPYwhKvjm+BsmUkLk/uhqqpl+j7foQJormH
        UWJvy1QmiIS1xOHjF6G28UlM2jYd7FAJAV6JjjYhiBIPib4XK6HmOEosnf4DGlxTGSW27Oxg
        nsAoNwvJQ7OQPDELyROzkDyxgJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmB6O/3v
        +JcdjLv+JB1iFOBgVOLhXXByc5QQa2JZcWXuIUYJDmYlEd7vc7dECfGmJFZWpRblxxeV5qQW
        H2KU5mBREueN06iLEhJITyxJzU5NLUgtgskycXBKNTBGRa3c5fNFesWrzyw1guJrRLO+JtyX
        /fy3g59tJcfp6hkbZkzhLdkobHTq5JbpUouexG7s3RXKf7XzqfVZhc/XV1zN1O3ZmFxgUX3q
        savqayH/CL/mwt9H+b/Mtl+qnPK6M4dzk8nVKwZJBf1lQQe/mjivcGgqb69U+GEhF1bV9WX+
        d+tHOqZKLMUZiYZazEXFiQBdDyedawMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xa7pJ27dEGTxaLWgxZ/0aNov5TRvY
        LBb+/MVqsXXTXjaL8+c3sFtsenyN1eLyrjlsFhOmTmK3uLfmP6vFjPP7mCzm/JnCbHH7Mq/F
        pT0qFgs2PmK0uD9pL5MDv0dLcw+bx6ZVnUDi0yR2j9nnzrF5nJv9gcXjxIzfLB5HV65l8ti8
        pN7j9ZGHLB5Ltt5k9Pi8SS6AO4rLJiU1J7MstUjfLoErY/6J9ywFd/Ur1t4+wdjAOFWti5GT
        Q0LARKL9ZQ9LFyMXh5DAEkaJZ4dms0I4zxklVv3YwwJSJSzgLXH28WIgm4NDRMBP4t/eDJAa
        ZoELzBJvJm1ghmiYzigxY/0rNpAGNgFDia63XWA2r4CdxPq+22A2i4CqxKVpO5lBbFGBGImp
        HzeyQtQISvyYfA9sGaeAk8S+jcvA6pkFzCS+vDzMCmHLS2xe85YZwhaXaG69yTKBUWAWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAo3Hbs55YdjF3vgg8xCnAw
        KvHwPpi+JUqINbGsuDL3EKMEB7OSCO/3uUAh3pTEyqrUovz4otKc1OJDjNIcLErivOcNKqOE
        BNITS1KzU1MLUotgskwcnFINjNcDZu3wT7g9yeb/Jxmpr0k3+FzWvt1+dN6G9HN8dd6PlXxe
        dM5lDuX+qHrT6ndKoXMTz0apc88a279Jflly58r3ReU6X4pr7/wUzr2Rd7Vz78S1sipLZm3m
        N105Z+XkmWd7xVIP6Ln2cF11y0xle2ev/TfW9uRsZqZHs2Y0LDEpeaW8QJvxuLUSS3FGoqEW
        c1FxIgA7yZbIvgIAAA==
X-CMS-MailID: 20180323081426eucas1p1197a70772d3b4fdfef2ccd63275399d5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180316075352epcas5p3d95b13f9382ff7bbce83b8177e8e3ad6
X-RootMTR: 20180316075352epcas5p3d95b13f9382ff7bbce83b8177e8e3ad6
References: <CGME20180316075352epcas5p3d95b13f9382ff7bbce83b8177e8e3ad6@epcas5p3.samsung.com>
        <1521186916-13745-1-git-send-email-chenhc@lemote.com>
Return-Path: <m.szyprowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
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

On 2018-03-16 08:55, Huacai Chen wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
>
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
>
> V2: Fix build on ARM.
> V3: Fix build on SuperH.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

This patch breaks booting on ARM Exynos4210 based boards (tested with
next-20180323, exynos_defconfig, both Trats and Origen fails to boot).
That's a bit strange, because all other Exynos SoC works fine (I've
checked 3250, 4412, 5250, 5410 and 542x). I really have no idea what
is so specific inc case of Exynos4210, that causes this failure.

> ---
>   arch/arm/boot/compressed/head.S        | 4 ++++
>   arch/arm/boot/compressed/misc.c        | 7 -------
>   arch/mips/boot/compressed/decompress.c | 7 -------
>   arch/mips/boot/compressed/head.S       | 4 ++++
>   arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>   arch/sh/boot/compressed/head_64.S      | 4 ++++
>   arch/sh/boot/compressed/misc.c         | 7 -------
>   7 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 45c8823..bae1fc6 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -547,6 +547,10 @@ not_relocated:	mov	r0, #0
>   		bic	r4, r4, #1
>   		blne	cache_on
>   
> +		ldr	r0, =__stack_chk_guard
> +		ldr	r1, =0x000a0dff
> +		str	r1, [r0]
> +
>   /*
>    * The C runtime environment should now be setup sufficiently.
>    * Set up some pointers, and start decompressing.
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 16a8a80..e518ef5 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -130,11 +130,6 @@ asmlinkage void __div0(void)
>   
>   unsigned long __stack_chk_guard;
>   
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> -
>   void __stack_chk_fail(void)
>   {
>   	error("stack-protector: Kernel stack is corrupted\n");
> @@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>   {
>   	int ret;
>   
> -	__stack_chk_guard_setup();
> -
>   	output_data		= (unsigned char *)output_start;
>   	free_mem_ptr		= free_mem_ptr_p;
>   	free_mem_end_ptr	= free_mem_ptr_end_p;
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..5ba431c 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -78,11 +78,6 @@ void error(char *x)
>   
>   unsigned long __stack_chk_guard;
>   
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> -
>   void __stack_chk_fail(void)
>   {
>   	error("stack-protector: Kernel stack is corrupted\n");
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>   {
>   	unsigned long zimage_start, zimage_size;
>   
> -	__stack_chk_guard_setup();
> -
>   	zimage_start = (unsigned long)(&__image_begin);
>   	zimage_size = (unsigned long)(&__image_end) -
>   	    (unsigned long)(&__image_begin);
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index 409cb48..00d0ee0 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -32,6 +32,10 @@ start:
>   	bne	a2, a0, 1b
>   	 addiu	a0, a0, 4
>   
> +	PTR_LA	a0, __stack_chk_guard
> +	PTR_LI	a1, 0x000a0dff
> +	sw	a1, 0(a0)
> +
>   	PTR_LA	a0, (.heap)	     /* heap address */
>   	PTR_LA	sp, (.stack + 8192)  /* stack address */
>   
> diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
> index 7bb1681..e84237d 100644
> --- a/arch/sh/boot/compressed/head_32.S
> +++ b/arch/sh/boot/compressed/head_32.S
> @@ -76,6 +76,10 @@ l1:
>   	mov.l	init_stack_addr, r0
>   	mov.l	@r0, r15
>   
> +	mov.l	__stack_chk_guard_addr, r0
> +	mov.l	__stack_chk_guard_val, r1
> +	mov.l	r1, @r0
> +
>   	/* Decompress the kernel */
>   	mov.l	decompress_kernel_addr, r0
>   	jsr	@r0
> @@ -97,6 +101,10 @@ kexec_magic:
>   	.long	0x400000F0	/* magic used by kexec to parse zImage format */
>   init_stack_addr:
>   	.long	stack_start
> +__stack_chk_guard_val:
> +	.long	0x000A0DFF
> +__stack_chk_guard_addr:
> +	.long	__stack_chk_guard
>   decompress_kernel_addr:
>   	.long	decompress_kernel
>   kernel_start_addr:
> diff --git a/arch/sh/boot/compressed/head_64.S b/arch/sh/boot/compressed/head_64.S
> index 9993113..8b4d540 100644
> --- a/arch/sh/boot/compressed/head_64.S
> +++ b/arch/sh/boot/compressed/head_64.S
> @@ -132,6 +132,10 @@ startup:
>   	addi	r22, 4, r22
>   	bne	r22, r23, tr1
>   
> +	movi	datalabel __stack_chk_guard, r0
> +	movi	0x000a0dff, r1
> +	st.l	r0, 0, r1
> +
>   	/*
>   	 * Decompress the kernel.
>   	 */
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..fe4c079 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -106,11 +106,6 @@ static void error(char *x)
>   
>   unsigned long __stack_chk_guard;
>   
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> -
>   void __stack_chk_fail(void)
>   {
>   	error("stack-protector: Kernel stack is corrupted\n");
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>   {
>   	unsigned long output_addr;
>   
> -	__stack_chk_guard_setup();
> -
>   #ifdef CONFIG_SUPERH64
>   	output_addr = (CONFIG_MEMORY_START + 0x2000);
>   #else

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
