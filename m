Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2016 20:17:12 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33608 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992617AbcH0SQIi7h-j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Aug 2016 20:16:08 +0200
Received: by mail-pa0-f68.google.com with SMTP id vy10so6415900pac.0;
        Sat, 27 Aug 2016 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1hD3FvyIQVc4CZQGRZ4h3hyyYYXWmltOMW6n/FuZ3c=;
        b=ZNuzROYJGBSA2QaQc75OCHW2/1IIwiaLVZL9opb8D5Xy5hFL+/1HqnPzhsMdjOaR4w
         QHffYlnQMZ8KasOouFUiwX6lyfj2ka1s6hYj7iXSqXPO1apPjpTewjx78dZSBr4GOEkN
         I9WRw6IU/wtcoHDI3HpR6KKuph5zRAq7tWjfQ+sfCEP0p2UQXrVNP0pbZ4eLINDCKTGI
         q8JWEza1HzXzeHZZJc3MPt7wKOqYeLFehcv5SHATYtDPRJquaRPro1zadFKG+cs8CCe8
         2ki0LluOW4DyBnRnHqb99/Z5WDa4cD5z3oaKU6C5XIw2yHoYUGPEPYY44S58ILTRUUce
         htaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1hD3FvyIQVc4CZQGRZ4h3hyyYYXWmltOMW6n/FuZ3c=;
        b=Zlsg30ado/a5xO5k0U23YYQRdg8+aI8lYUowahx5t2k6CPGQbV6d/iJEY3QNEbXqZn
         +XjSLHQB3EOqzVDsaepW4IQ2Fe4kppZ+mIWBbgNmaxzbORUavXjtsUdjBQNsc3kDyUkv
         k7oSo1lhWesIZD76JUvROSwkOqNDvUXNGJ/RHTUYgBPrj0xWHy90Ds6iEZfZJlr8SQt5
         4UZh9onPSx5nM7It8pBLL8gp8+WWzm+T+ky618WiRu06zPt6X6oppyHSbsKVowuhvJnP
         MP3kHnaoqWeUTIWBC6pROm5LdbxYJUpbEh06SgdfMxEpAXL4FtCukQy6lY/MWtnkHAmP
         TYpw==
X-Gm-Message-State: AE9vXwMIn4klWLeHqZlpKj4ra0o6Zes2vB+2FTdRnXUvG0v/EFRPKP0y7NRRbWPL1jPXJA==
X-Received: by 10.66.193.7 with SMTP id hk7mr17074224pac.78.1472321762871;
        Sat, 27 Aug 2016 11:16:02 -0700 (PDT)
Received: from localhost.localdomain ([1.22.68.54])
        by smtp.gmail.com with ESMTPSA id y6sm37747529pav.1.2016.08.27.11.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:16:02 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 3/4] hw_random: jz4780-rng: Add RNG node to jz4780.dtsi
Date:   Sat, 27 Aug 2016 23:44:56 +0530
Message-Id: <1472321697-3094-4-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

This patch adds RNG node to jz4780.dtsi.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b868b42..f11d139 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -36,7 +36,7 @@
 
 	cgu: jz4780-cgu@10000000 {
 		compatible = "ingenic,jz4780-cgu";
-		reg = <0x10000000 0x100>;
+		reg = <0x10000000 0xD8>;
 
 		clocks = <&ext>, <&rtc>;
 		clock-names = "ext", "rtc";
@@ -44,6 +44,11 @@
 		#clock-cells = <1>;
 	};
 
+	rng: jz4780-rng@100000D8 {
+		compatible = "ingenic,jz4780-rng";
+		reg = <0x100000D8 0x8>;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.5.0
