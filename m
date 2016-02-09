Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:56:25 +0100 (CET)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33138 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012371AbcBIU4Iq9opb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:08 +0100
Received: by mail-pf0-f169.google.com with SMTP id q63so29515978pfb.0;
        Tue, 09 Feb 2016 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8AlQ5XnRz+kf/b8fYiAecYgRKEh6S09vsoJL1mWoe60=;
        b=vm04xRj00jjaG4mxbamP39KfvdlN/Y9VMSpNoV8+zxc4uzrVq7xwIGFaW7qApi8TDf
         cjQe61RkMt+6nLPTFxXOY1rUk+vRfz8Zc3LCjD5cmX3trMKloNoFbzdyI9OKWWUkUFoK
         YZD/8MeV5bshuWLUkzPE5cJFu86ZIqTOVRUXERx9p4MVaM0aBlcD/1OGzp7eFDC2jkXl
         ImqJSN81khPt9OKzHU0gu26k+c3u22Tx+ubK+OGemweHBogtCE4ZoX0VknRCKgHTzADR
         LGdbMWknp87GNl9HiovI6CpOFa59wTNDt6VvW5Ij5S7BOv+DkYpPzNDgDV/cIvERHuTF
         cJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8AlQ5XnRz+kf/b8fYiAecYgRKEh6S09vsoJL1mWoe60=;
        b=dADswhkpozbQkXtzsz2oNaTOpeSDUxngIg91ms0f51upNiUOQfYIvc4jFv9TgI/kxV
         J/QC8P4Ha+Pq2AvgPnJDNi6xSYLIq9dCF7b8GWI3HbLhUZD3d5+9Eqk4laiQ5pOL0xJ9
         lakThwjw6i0hXq31M4pdrKzViwHBuf+cW90vIGqNignCY00hGg2cfRVVxuhINeapxjCu
         yFElE14UAt1b3pNAtxa5VGb/GMtCLwOAJ/LaimEUSapoaQVt3EAsXboobOagDmAwcmkG
         gIQpFc0A1nVdoA1WbW1CIYeYI3ABlaovTsl/xeio+TwRepUJ7vRykU8XMWLJSo4PpSYc
         BZuQ==
X-Gm-Message-State: AG10YOS6oVWHi+J0D87HzXRd0BmRfNAF4QBxNvpkPujhDWhtbIPc4o6Aemq8aVELY6aWuw==
X-Received: by 10.98.7.219 with SMTP id 88mr53420649pfh.49.1455051363114;
        Tue, 09 Feb 2016 12:56:03 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
Date:   Tue,  9 Feb 2016 12:55:49 -0800
Message-Id: <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Disable pref 30 by utilizing the standard quirk method and matching the
affected SoCs: 7344, 7436, 7425.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bmips/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 35535284b39e..9c8f15daf5e9 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -100,12 +100,28 @@ static void bcm6368_quirks(void)
 	bcm63xx_fixup_cpu1();
 }
 
+static void bmips5000_pref30_quirk(void)
+{
+	__asm__ __volatile__(
+	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
+	"	lui	$9, 0x0100\n"
+	"	or	$8, $9\n"
+	/* disable "pref 30" on buggy CPUs */
+	"	lui	$9, 0x0800\n"
+	"	or	$8, $9\n"
+	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
+	: : : "$8", "$9");
+}
+
 static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
 	{ "brcm,bcm63168",		&bcm6368_quirks			},
+	{ "brcm,bcm7344",		&bmips5000_pref30_quirk		},
+	{ "brcm,bcm7346",		&bmips5000_pref30_quirk		},
+	{ "brcm,bcm7425",		&bmips5000_pref30_quirk		},
 	{ },
 };
 
-- 
2.1.0
