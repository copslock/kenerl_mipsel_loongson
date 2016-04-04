Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:12:10 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35564 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024739AbcDDIMIqug93 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 10:12:08 +0200
Received: by mail-lf0-f67.google.com with SMTP id c62so21974180lfc.2
        for <linux-mips@linux-mips.org>; Mon, 04 Apr 2016 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93kPr8MaiMEgkqNNQtrPDGEEtEtpmR0JSEBPWMPz/Co=;
        b=jiArvXw+zKZ+1Y04IFtjX6X8KoI6nP9HPYuMykRt3RcIWBHK22iPd7s9uWLiit+eNv
         SnMZWvlvKG1n+6d2Q9hSAX0ObtE4m8JqvBANCWh0Lv8dMDQ1/isaRcDRsq8QK3bkCYiW
         cx3YOsRFZULrzKNgaQOYuX8fIVWtS/cmA4YJ/NQWWlW7NomgHEficECvwS5fbpY+lezJ
         YU9898srlEeqj3EunXepkmhvL6cnic9wkHE/EI1h9Lc3jcPS1HgvlGT8rtoBsLRM2mLV
         DuKwFzpctKRsqOCn7TN1/Uq9CWamxizZKHgAMKDaADTE4s6fSc+cSeWL7TCnuhvG0BRB
         EoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93kPr8MaiMEgkqNNQtrPDGEEtEtpmR0JSEBPWMPz/Co=;
        b=KD7cVcxzGqORi5acZ7vc8pPeXg1SjqiiItt97HyzPuHq5S2RSXaytBPGng7r/zb19S
         nkSAOmjfEz7nMnPxfwfQwvO8Ws+AodCDvkGe+gOK+5UHonXcReSwgEScy8SJHwYI3azu
         KYQlpl9qiyNUtfkqAGzQjj3C1x+Y1h6Qvh2mQ4BX/hGzaaz33iAQRb18V+hO2P28kSmJ
         /5Llx8mmME98khPnShLai9qHXTl1VcuQ20SQnrUIxQ9WTgQ7dvUbkKZGUsXVpKFg0CX5
         uBKqFAt2F6bTszgpzQ7Z1ZIKb/q7FgvMGxdJdHhwA6RMR5iNRsxIc1YKx3JjpRM7RUN1
         moUA==
X-Gm-Message-State: AD7BkJLzBE9l4pqL17DuVTlNj8sdsQ+VVXVsVnQoDp5M72EFtwXp5oB9+2Kz/hTGT2MzZw==
X-Received: by 10.194.173.234 with SMTP id bn10mr36998550wjc.149.1459757523318;
        Mon, 04 Apr 2016 01:12:03 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id c144sm12533177wmd.0.2016.04.04.01.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 01:12:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2] bmips: add support for BCM63268
Date:   Mon,  4 Apr 2016 10:11:57 +0200
Message-Id: <1459757517-14897-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459684846-11308-1-git-send-email-noltari@gmail.com>
References: <1459684846-11308-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

This SoC is very similar to BCM63168 and Broadcom usually refers to them as
BCM63268.
Use alphabetical order for bmips quirks.
Add BCM63268 and missing BCM63168 to device tree documentation.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: keep support for BCM63168

 Documentation/devicetree/bindings/mips/brcm/soc.txt | 3 ++-
 arch/mips/bmips/setup.c                             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e58a4f6..7a08c3e 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -4,7 +4,8 @@ Required properties:
 
 - compatible: "brcm,bcm3384", "brcm,bcm33843"
               "brcm,bcm3384-viper", "brcm,bcm33843-viper"
-              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
+              "brcm,bcm63168", "brcm,bcm63268", "brcm,bcm6328",
+              "brcm,bcm6358", "brcm,bcm6368",
               "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
               "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
 
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 38b5bd5..7cca770 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -112,10 +112,11 @@ static void bcm6368_quirks(void)
 static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
+	{ "brcm,bcm63168",              &bcm6368_quirks                 },
+	{ "brcm,bcm63268",              &bcm6368_quirks                 },
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
 	{ "brcm,bcm6358",		&bcm6358_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
-	{ "brcm,bcm63168",		&bcm6368_quirks			},
 	{ },
 };
 
-- 
2.1.4
