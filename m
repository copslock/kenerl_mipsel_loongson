Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 16:20:27 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36836 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011186AbbENOUZpE8Wv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 16:20:25 +0200
Received: by iepk2 with SMTP id k2so60187065iep.3;
        Thu, 14 May 2015 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gMBkEFU2Se+1TAZ+hSuvTTUvA1F0DYF9Tgq4/ElyvW4=;
        b=DsoNO5B+eKwHxuO9ikAa7xtnn2vrf1IdrLSr5Zt+UOT7IQ77epQbyycD2QcL5LESXR
         8/ab04howFrcLeGzDJgAVo+XT8xFknUgfCASLlB+iLcTd5Vq2An6DfX2h74cwiwePf5U
         /nRqH7ALpvTBL6VA9U/Anxjuap3MEOq5/ESWm6kxZEp1Fcv3j1B3XCnltOb5g0jVIYbR
         rV84qE3IsjeTcWFa4DKN8OeGmktAEdURYkfKjw4EsJSK3RNxr/8nNoBRfmOglBLm3YDm
         2nf8ngqKo7qFX42neat3dsRH6khqzRAqKjo5S7PjAj5SMWxKSj5Kh0DcuvgYSmepasbL
         yjxw==
X-Received: by 10.42.102.142 with SMTP id i14mr14975034ico.90.1431613222198;
        Thu, 14 May 2015 07:20:22 -0700 (PDT)
Received: from nick-System-Product-Name.hitronhub.home (CPEbc4dfb2691f3-CMbc4dfb2691f0.cpe.net.cable.rogers.com. [99.231.110.121])
        by mx.google.com with ESMTPSA id j20sm5938437igt.16.2015.05.14.07.20.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 07:20:21 -0700 (PDT)
From:   Nicholas Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     akpm@linux-foundation.org, kumba@gentoo.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mips:Fix build error for ip32_defconfig configuration
Date:   Thu, 14 May 2015 10:20:17 -0400
Message-Id: <1431613217-2517-1-git-send-email-xerofoify@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47399
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
