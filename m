Return-Path: <SRS0=HboV=W5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1020C3A5A4
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 00:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD63121881
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 00:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="S/oy66zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfIBAvz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 20:51:55 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:36188 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729199AbfIBAvz (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 20:51:55 -0400
Received: from mxback23o.mail.yandex.net (mxback23o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::74])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id EA3F41C80256;
        Mon,  2 Sep 2019 03:51:51 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback23o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WtKzKtt7ZD-ppdeO6Pl;
        Mon, 02 Sep 2019 03:51:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567385511;
        bh=B5HfclklUYD6BFkr1nd1SiAd8SZjO9jgPtoh65ds9n0=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=S/oy66zyaMPdfZrNjSEWz7pt8w/nxxa0TBXLwniZ4rCiinItyqSn9eoH+UY4GD7nl
         3bljkUZg37SoNnWC46dlcKgKCp9u6O9q6paVOnIP/SF7+ot72rrQFnVi60SaYJnyFg
         u5BFt/ixAicDrevC1QchjE9siYmnKF2j7W61nKec=
Authentication-Results: mxback23o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xbnWNyAmLw-pavOqPAP;
        Mon, 02 Sep 2019 03:51:39 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] MIPS: Drop Loongson _CACHE_* definitions
To:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     Paul Burton <pburton@wavecomp.com>, Huacai Chen <chenhc@lemote.com>
References: <20190831154145.7328-1-paul.burton@mips.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <4aa7f599-159b-fe4e-2772-0920e4e8638b@flygoat.com>
Date:   Mon, 2 Sep 2019 08:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190831154145.7328-1-paul.burton@mips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


ÔÚ 2019/8/31 23:41, Paul Burton Ð´µÀ:
> _CACHE_CACHABLE_NONCOHERENT is defined as 3<<_CACHE_SHIFT by default, so
> there's no need to define it as such specifically for Loongson.
>
> _CACHE_CACHABLE_COHERENT is not used anywhere in the kernel, so there's
> no need to define it at all.
>
> Finally the comment found alongside these definitions seems incorrect -
> it suggests that we're defining _CACHE_CACHABLE_NONCOHERENT such that it
> actually provides coherence, but the opposite seems to be true & instead
> the unused _CACHE_CACHABLE_COHERENT is defined as the typically
> incoherent value.
>
> Delete the whole thing, which will have no effect on the compiled code
> anyway.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Huacai Chen <chenhc@lemote.com>
> ---
>
>   arch/mips/include/asm/pgtable-bits.h | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 5f1ced8cba07..409ae01ed7be 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -221,13 +221,6 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>   
>   #define _CACHE_CACHABLE_NONCOHERENT (5<<_CACHE_SHIFT)
>   
> -#elif defined(CONFIG_CPU_LOONGSON3)
> -
> -/* Using COHERENT flag for NONCOHERENT doesn't hurt. */
> -
> -#define _CACHE_CACHABLE_NONCOHERENT (3<<_CACHE_SHIFT)  /* LOONGSON       */
> -#define _CACHE_CACHABLE_COHERENT    (3<<_CACHE_SHIFT)  /* LOONGSON-3     */
> -
>   #elif defined(CONFIG_MACH_INGENIC)
>   
>   /* Ingenic uses the WA bit to achieve write-combine memory writes */
