Return-Path: <SRS0=jxI9=VI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9639C74A51
	for <linux-mips@archiver.kernel.org>; Thu, 11 Jul 2019 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3FE21655
	for <linux-mips@archiver.kernel.org>; Thu, 11 Jul 2019 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562838314;
	bh=fCmvtSnN5KcuFoyLXltopennSHZGXM/xZ3ZSn2MCAkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N/GDSRzZloS8rKOJSTfUFyMEsd5Acz30HQ12jhH8P8s0eXLYv0iYrV+w0Y8l/PJXQ
	 UGzy78sUyEbpEZVmw/ZzBNpaaFQY5ak7ZFj00qNO7OLlvVtgth6yOUeWwYvoc0FQaG
	 Naqx6QH3mSLoinBTqbZrZlCONL+AKtoUe5Bvj9So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGKJpO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKJpO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Jul 2019 05:45:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7E420872;
        Thu, 11 Jul 2019 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562838313;
        bh=fCmvtSnN5KcuFoyLXltopennSHZGXM/xZ3ZSn2MCAkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msKHFoq1k7Hqwov4CLkE1ZEAbs1wTC7Q18jlnlcjXlM0AkkuxcfbcStOXB9miXgCJ
         5d74po+3Nlt9RbYtxyX8i5luTtfSyihwcZXy/t819iQWVpHaNBqUftSeNtf76ElQVI
         lQbiMqDAOvUJBQ5kwOGGbgW3h/xX3YrpNVoA5jqU=
Date:   Thu, 11 Jul 2019 10:45:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        andre.przywara@arm.com, arnd@arndb.de, huw@codeweavers.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, linux@armlinux.org.uk, ralf@linux-mips.org,
        salyzyn@android.com, luto@kernel.org, paul.burton@mips.com,
        john.stultz@linaro.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, tglx@linutronix.de, sthotton@marvell.com,
        pcc@google.com
Subject: Re: [PATCH v2] arm64: vdso: Fix ABI regression in compat vdso
Message-ID: <20190711094505.rwy6t6wu2cvmvwr6@willie-the-truck>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <20190710140119.23417-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710140119.23417-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Jul 10, 2019 at 03:01:19PM +0100, Vincenzo Frascino wrote:
> Prior to the introduction of Unified vDSO support and compat layer for
> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> In the current implementation, AT_SYSINFO_EHDR is defined even if the
> compat vdso layer is not built and this causes a regression in the
> expected behavior of the ABI.
> 
> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> tasks is defined only when CONFIG_COMPAT_VDSO is enabled.
> 
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 3c7037c6ba9b..b618017205a3 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>  ({									\
>  	set_thread_flag(TIF_32BIT);					\
>   })
> -#ifdef CONFIG_GENERIC_COMPAT_VDSO
> +#ifdef CONFIG_COMPAT_VDSO
>  #define COMPAT_ARCH_DLINFO						\
>  do {									\
>  	/*								\

Acked-by: Will Deacon <will@kernel.org>

I can take this at -rc1 via arm64 unless tglx plans to send it during the
rest of the merge window. Please let me know.

Will
