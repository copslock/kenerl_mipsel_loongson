Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jul 2017 12:42:18 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33737
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992993AbdGQKmIBmHBa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jul 2017 12:42:08 +0200
Received: by mail-wm0-x242.google.com with SMTP id 65so2454373wmf.0
        for <linux-mips@linux-mips.org>; Mon, 17 Jul 2017 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=UEBLncNdgRPNdy9iYdad94+Bb+XNqfc4XJacieKg/rs=;
        b=t0oX0Q7zYla00tlUG2OuxG+fKO0/zuasK6/R5GZz3e3acTIjZ1quLaCEq9f3QXinl+
         FeFPE9g6MBSzvLVEdVloR5xJCarxphXr8P4Cf0Ix42Gta2EujxhEY9FDcEXpekKf2aKv
         jzROTUT3YVOh67uvhRl537pnkNOzY0EMcc+WdQIKfVPh/XZ/vrljYSkC2r+pGMwoGHof
         8kej2auoE82h8eurJAleMqW7ggAf7H1Trvxmtf+mV+qiiUUKcUep+MKIbM41TI8bae4h
         S6DQ7BpW+EmDdP7z5QT+V/ESCP7p5M1L9t2KBVILj8RpdCn9PffnF+umpLrtwg9u7FJy
         5EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=UEBLncNdgRPNdy9iYdad94+Bb+XNqfc4XJacieKg/rs=;
        b=RJpDXkZ8nERoA/VYJyaluaD/DUjHh2I2L8XiLTYD6a8SjG12pJkqPs4cw9w3OzL5Np
         584SSvcJHmBG/txf+ygcUyIuuOsBQT9+z6hRqirk2ascgxb78/siiITIT4yLzSjXnmcm
         LTpB03jEqlIommRS1WebxFpGKMgUk/ypPk+CNmp1SdJqbT6a6S7Ov1CYBIdPEZKIvX2b
         1FKERy98dXpa2VP20POVo05OOp4TpiGoH1Qjp5X5QyBWDPqUbz6ZgAwIuhMPUbgbK1eD
         EpSzDO3Ke0Z7uEbpj4QbLUO20LT89fda7vx6BtZcH3p0xNmBc33zP2ua2nRh8BfpdQ8x
         +XRw==
X-Gm-Message-State: AIVw112mg0Qvls72XZrgmueHJOLUdqH7PlPdWMhrBNbuEetEEefWcV3c
        86evTYhrBSwwOXMocwg=
X-Received: by 10.80.164.72 with SMTP id v8mr16698295edb.49.1500288122426;
        Mon, 17 Jul 2017 03:42:02 -0700 (PDT)
Received: from android-f8911984c6e3e13 (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id g25sm9026709eda.59.2017.07.17.03.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 03:42:01 -0700 (PDT)
Date:   Mon, 17 Jul 2017 11:41:57 +0100
In-Reply-To: <1500285489-31044-1-git-send-email-matt.redfearn@imgtec.com>
References: <d5581fe0-2420-655b-3c3c-25c316f05576@mev.co.uk> <1500285489-31044-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] CLOCKSOURCE: Fix CLKSRC_PISTACHIO dependencies
To:     linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     akpm@linux-foundation.org, kbuild-all@01.org, arnd@arndb.de
From:   James Hogan <james.hogan@imgtec.com>
Message-ID: <BC6E5053-B7F3-40C3-80AD-E316CC6D4E1A@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 17 July 2017 10:58:09 BST, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>In v4.13, CLKSRC_PISTACHIO can select TIMER_OF on architectures without
>GENERIC_CLOCKEVENTS, resulting in a struct clock_event_device missing
>some required features.
>Fix this by depending on GENERIC_CLOCKEVENTS. Additionally, since
>Pistachio is a MIPS based SoC, also depend on the MIPS architecture.
>
>Thanks to kbuild test robot for finding this error
>(https://lkml.org/lkml/2017/7/16/249)
>
>Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>---
>
> drivers/clocksource/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>index fcae5ca6ac92..40ebb117709b 100644
>--- a/drivers/clocksource/Kconfig
>+++ b/drivers/clocksource/Kconfig
>@@ -262,7 +262,8 @@ config CLKSRC_LPC32XX
> 
> config CLKSRC_PISTACHIO
> 	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
>-	depends on HAS_IOMEM
>+	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
>+	depends on MIPS

Its already only configurable when COMPILE_TEST=y anyway, otherwise must be selected, so unless there's a hard build time dependency on mips i don't think this is necessary. it will prevent build testing in x86 allmodconfig.

cheers
James

> 	select TIMER_OF
> 	help
> 	  Enables the clocksource for the Pistachio SoC.


--
James Hogan
