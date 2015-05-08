Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 02:52:46 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34197 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012807AbbEHAwp1hs7i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 02:52:45 +0200
Received: by iget9 with SMTP id t9so21742677ige.1;
        Thu, 07 May 2015 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gMBkEFU2Se+1TAZ+hSuvTTUvA1F0DYF9Tgq4/ElyvW4=;
        b=ee5dIH0dHTUxCe+TlRL1hfvA+BwI8LbNZv/3To5wNjDasZATf2z1tZEKvUCRlyNWqf
         /w38cS+t+k1KyJA0TH1Yd2t2+lFu4KuzIhNmEz0p0wDcqmGX+xn9WypjDru0jYZHuBNv
         QkTlE5VDlTdeqJZVvXi1zVdWf1N7krwbZoFhPnuRjyy2J52XSvlmRAE0Ymn2y0DgXR+C
         GlxzAA7nxuqfYQdB1eZk227hatT28ScW/3sM8oyrwPJA9aBf6pEneTf9VInJKR2yXmJH
         aMKgyYT9/3rfEe60a+3Mp5OX8H0urQhgwkiFJAA8ELawAfXKgy3SYlBhJqW6lxAJ29uD
         LRkA==
X-Received: by 10.50.79.165 with SMTP id k5mr1140337igx.19.1431046361586;
        Thu, 07 May 2015 17:52:41 -0700 (PDT)
Received: from nick-System-Product-Name.hitronhub.home (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id k37sm2421025iod.39.2015.05.07.17.52.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 17:52:40 -0700 (PDT)
From:   Nicholas Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     akpm@linux-foundation.org, kumba@gentoo.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips:Fix build error for ip32_defconfig configuration
Date:   Thu,  7 May 2015 20:52:36 -0400
Message-Id: <1431046356-27882-1-git-send-email-xerofoify@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

This fixes the make error when building the ip32_defconfig
configuration due to using sgio2_cmos_devinit rather then
the correct function,sgio2_rtc_devinit in a device_initcall
below this function's definition.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/mips/sgi-ip32/ip32-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 0134db2..2a7efcb 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -130,9 +130,9 @@ struct platform_device ip32_rtc_device = {
 	.resource		= ip32_rtc_resources,
 };
 
-+static int __init sgio2_rtc_devinit(void)
+static  __init int sgio2_rtc_devinit(void)
 {
 	return platform_device_register(&ip32_rtc_device);
 }
 
-device_initcall(sgio2_cmos_devinit);
+device_initcall(sgio2_rtc_devinit);
-- 
2.1.4
