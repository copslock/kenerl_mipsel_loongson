Return-Path: <SRS0=QFq2=QF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D8C169C4
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC2214DA
	for <linux-mips@archiver.kernel.org>; Tue, 29 Jan 2019 08:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bsCX9wum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfA2Iso (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:48:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39058 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2Iso (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 29 Jan 2019 03:48:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so16712041wmi.4
        for <linux-mips@vger.kernel.org>; Tue, 29 Jan 2019 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AaSFeRpsz9hY5VgVHJfh99EOJhLu4T8KSsOuMiN9rtg=;
        b=bsCX9wum1V37xrILImhlz+b8q1N0XjJVl4LtffOVS92jc4gqQ1ahRWKTwnvyD+v4eX
         tboQS8fDyKtPxikjmfTfioQKyQLbLuiofB1x4W7mX7hGrKfDzrxUG/1hRO+e1uvPtIha
         Cen73PV0kDtU24B6ZT0p6nbXl8iVM5SAdFjgghVMvSper02jI2ZOMhvSrtVNMZPF5hYh
         qR8x5dFRVHRbn4pzR0eYgvfleuCOhFsehjPkhvP1+a0cb0OhvdR/blJLXwW1E3ty8kYW
         k7LpdXLTfd4se/N8a3766RamP6lm5jAuYsyw1SEI3AkRhQwLPqAAyZ/SVRlUGMIetu+u
         bf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AaSFeRpsz9hY5VgVHJfh99EOJhLu4T8KSsOuMiN9rtg=;
        b=lugmYK5s8zRnULiOayF6GRSbXO4+Um55LZ2QpcXKGBTZFOZnp6oJ+qBD2sQFKleaQx
         +Cu6p7TdC/fjzp1TniT4wz2E4VppXJIzi/3TfZgjnuVyPGTQWtNt75YSYEFHp7UqOCe0
         nnWB6ai/tBRrwq7zmzCY02V+UbRrB0WeUrMopmBl6uEJp3nDHFS7ShGHd6Skm8Jcpm1q
         wKtIkMJWoR8+iDd25w/+bP4Mut25IbUjM1eDxu2dQAm5YZk4GhctJuVMCxg0nLR4p0Hu
         p22hA5ADVQq1uc+CqqcMZbWwhOer5TEM+NKs9HF/jW85+h/T/ooCA0SPD9N14AuIZkVK
         97Tw==
X-Gm-Message-State: AJcUukcb+HxFnOoUgS/8pz/4Is4qnn67AvXh+0cVUmJ0xNCGIyNk42ul
        5CSpBXfwKFyPsTG0Fzpov3vP2MJtZZChSg==
X-Google-Smtp-Source: ALg8bN40378QL9nTZQna63Q73k82t05CtpE0K/4TkgoVzzJ+hCzO3LGaXJ6nFkEKCqI33wLhYslpEw==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr19910343wmc.7.1548751722039;
        Tue, 29 Jan 2019 00:48:42 -0800 (PST)
Received: from localhost (aputeaux-684-1-12-29.w90-86.abo.wanadoo.fr. [90.86.215.29])
        by smtp.googlemail.com with ESMTPSA id y34sm310125474wrd.68.2019.01.29.00.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 00:48:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Burton <paul.burton@mips.com>,
        "linux-mips\@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     Paul Burton <pburton@wavecomp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: VDSO: Use same -m%-float cflag as the kernel proper
In-Reply-To: <20190128222106.19100-1-paul.burton@mips.com>
References: <20190128222106.19100-1-paul.burton@mips.com>
Date:   Tue, 29 Jan 2019 09:48:40 +0100
Message-ID: <7h8sz3rgrb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Paul Burton <paul.burton@mips.com> writes:

> The MIPS VDSO build currently doesn't provide the -msoft-float flag to
> the compiler as the kernel proper does. This results in an attempt to
> use the compiler's default floating point configuration, which can be
> problematic in cases where this is incompatible with the target CPU's
> -march= flag. For example decstation_defconfig fails to build using
> toolchains in which gcc was configured --with-fp-32=xx with the
> following error:
>
>     LDS     arch/mips/vdso/vdso.lds
>   cc1: error: '-march=r3000' requires '-mfp32'
>   make[2]: *** [scripts/Makefile.build:379: arch/mips/vdso/vdso.lds] Error 1
>
> The kernel proper avoids this error because we build with the
> -msoft-float compiler flag, rather than using the compiler's default.
> Pass this flag through to the VDSO build so that it too becomes agnostic
> to the toolchain's floating point configuration.
>
> Note that this is filtered out from KBUILD_CFLAGS rather than simply
> always using -msoft-float such that if we switch the kernel to use
> -mno-float in the future the VDSO will automatically inherit the change.
>
> The VDSO doesn't actually include any floating point code, and its
> .MIPS.abiflags section is already manually generated to specify that
> it's compatible with any floating point ABI. As such this change should
> have no effect on the resulting VDSO, apart from fixing the build
> failure for affected toolchains.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> References: https://lore.kernel.org/linux-mips/1477843551-21813-1-git-send-email-linux@roeck-us.nets/
> References: https://kernelci.org/build/id/5c4e4ae059b5142a249ad004/logs/

Tested-by: Kevin Hilman <khilman@baylibre.com>
