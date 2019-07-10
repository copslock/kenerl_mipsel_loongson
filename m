Return-Path: <SRS0=EetP=VH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB2C74A21
	for <linux-mips@archiver.kernel.org>; Wed, 10 Jul 2019 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462142084B
	for <linux-mips@archiver.kernel.org>; Wed, 10 Jul 2019 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765145;
	bh=TvIYigy0Bf458ARoYJR+lIAzAVW32Q+zCs3htN50YFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oH4P4FsysEHc/zf+wv7nelGkKP7jxN+J6vBOPrLKK+pzKpVAmWPQO8XpwkT0TFBcX
	 tGqUIA/vFUumYYjn0YKXOTL1DD8Hkq9Q535amZTs4C3v39GXNsTJdISpF9cVrbnsAo
	 2zGBHVL0Gh8n7gGBu9burSkFTrcHcrUnUQRC2yVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGJNZl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJNZk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 10 Jul 2019 09:25:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D787A2064B;
        Wed, 10 Jul 2019 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765139;
        bh=TvIYigy0Bf458ARoYJR+lIAzAVW32Q+zCs3htN50YFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eX9ZzqH6pqN88Uqghq+OYeQgOiUPblilOt1ruqmmlPIMENmN+dxYtWWv3Yq2amFbI
         LDtJTQQ1b/um0wiQeYo/JHi4IeBRalMLwk/LB26dPlW6rtCF/OFhonm3olB3u1SwY7
         rnSwgLdcakjndWNB0IxuKSgaOAGdD0NYXVF4OaBs=
Date:   Wed, 10 Jul 2019 14:25:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk,
        ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH] arm64: vdso: Fix ABI regression in compat vdso
Message-ID: <20190710132532.r27yryvt25ex76xk@willie-the-truck>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <20190710130452.44111-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710130452.44111-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Jul 10, 2019 at 02:04:52PM +0100, Vincenzo Frascino wrote:
> Prior to the introduction of Unified vDSO support and compat layer for
> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> In the current implementation, AT_SYSINFO_EHDR is defined even if the
> compat vdso layer is not built and this causes a regression in the
> expected behavior of the ABI.
> 
> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> tasks is defined only when CONFIG_GENERIC_COMPAT_VDSO and
> CONFIG_COMPAT_VDSO are enabled.

I think you could do a better job in the changelog of explaining what's
actually going on here. The problem seems to be that you're advertising
the presence of a non-existent vDSO to userspace.

> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 3c7037c6ba9b..b7992bb9d414 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>  ({									\
>  	set_thread_flag(TIF_32BIT);					\
>   })
> -#ifdef CONFIG_GENERIC_COMPAT_VDSO
> +#if defined(CONFIG_COMPAT_VDSO) && defined(CONFIG_GENERIC_COMPAT_VDSO)

Can't this just be #ifdef CONFIG_COMPAT_VDSO ?

John -- can you give this a whirl, please?

Cheers,

Will
