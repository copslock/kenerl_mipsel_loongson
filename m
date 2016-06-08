Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2016 09:59:40 +0200 (CEST)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33012 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034638AbcFHH7i3uxyw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2016 09:59:38 +0200
Received: by mail-lf0-f43.google.com with SMTP id s64so338858lfe.0
        for <linux-mips@linux-mips.org>; Wed, 08 Jun 2016 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4ZyfFexrEMHdtJPdwZB37LYn8rUlkKeskJAUxDZg94w=;
        b=dVmP0p8qDBSAjI1+f4nNwKiYJETy6ylzDkgxjzOGJ20OhnISO1iMN9qXqLDdrTZCld
         OhCoLJd8mHTStNMJWFboOUxR93P2+CGwob7Ua1QznnMi6Endi+fllOZIDZwpDAGEleC5
         vV6F59/kKWTFranCuBGofLM+mC+kuPvFZ3yCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ZyfFexrEMHdtJPdwZB37LYn8rUlkKeskJAUxDZg94w=;
        b=SY3tI1ilLL2FfoK0YZ8lubZ0X7UvWUS02fAZlhf2GBQZJAboUfV2qNV74lsUirYVVr
         sfbEL06tPkauXi9007mtCamS/bbarydtfYBWZibnFxqk3xRDi7fWoE3mwtfjT88n2I72
         ZbqI1xsTzbI172s1OTvpRLAq8FYCo6Iu4IrgqztKxE9/VPNmsTXM9KBx+b5fAz3w6Edj
         JV6A7hVAhO7uV1QrvxaeuulCqC16sbu5iGC5bXwKXOPTkqIj8jcwjxsoJLZmVA0avKOA
         7IhpnMdCKjM2+iHvpRFNbPw6Ye3hFNZZyX8LddxxRnIPbJDlPbUDsZV6yt5b8bX+sbwI
         b5mQ==
X-Gm-Message-State: ALyK8tIjhnp86RRgp2l65pOO68q9/wzjvF5qtRSr5abuFKXcZf0ay98ZzjGp6e4PIJcZ83kT
X-Received: by 10.25.158.73 with SMTP id h70mr3678497lfe.41.1465372772996;
        Wed, 08 Jun 2016 00:59:32 -0700 (PDT)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m7sm1021lbr.6.2016.06.08.00.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2016 00:59:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] MIPS: delete use of ARCH_WANT_OPTIONAL_GPIOLIB
Date:   Wed,  8 Jun 2016 09:59:29 +0200
Message-Id: <1465372769-6809-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.11
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

The Loongson1 added a new instance of ARCH_WANT_OPTIONAL_GPIOLIB
which is no longer required to have GPIOLIB available in
Kconfig. Delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Ralf, please apply this patch directly to your tree.
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939b9b75..4753c8750351 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1406,7 +1406,6 @@ config CPU_LOONGSON1B
 	bool "Loongson 1B"
 	depends on SYS_HAS_CPU_LOONGSON1B
 	select CPU_LOONGSON1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
-- 
2.4.11
