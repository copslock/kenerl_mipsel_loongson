Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 11:50:46 +0100 (CET)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55653 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007800AbaLJKuSv7rOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2014 11:50:18 +0100
Received: by mail-wi0-f174.google.com with SMTP id h11so10773813wiw.1
        for <multiple recipients>; Wed, 10 Dec 2014 02:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wjiNZKXFrBW9nPtPFOcQR/7XA11WKcvzxXb5Y5U54eE=;
        b=mF1+Pfkr1xMM6LylxZkM8fzOElrkXIN6pcqftnLBNyv6PcJs+VQLKZxuRVYIz5MDde
         ayFkbj/WPt58uHCvupV5OulujWKZrWC5nJjEKGbPPHZ5wSG6E0+Audmy3qVq2892YRmk
         RJSB19uxUE7vl3DGOXQiTm8vl6U3eYZOyJ4kWELKXnxO95yWXvv18EzEDAGXvoyHTb/X
         FU+s7Y5zxZzoI1KQMPgijJDqdEe7Fyv0w0vSw9pvLTxMd8RYgWHFTMg1ZfnUtBjMWmCs
         juql5GgBQRiLwRHzcDktnXyCLRYlusCZ4FTTf0Sc5X48taHPmilnIMY7922ELV9NyI7c
         LNdg==
X-Received: by 10.194.88.169 with SMTP id bh9mr5121783wjb.99.1418208613659;
        Wed, 10 Dec 2014 02:50:13 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id mc10sm17394697wic.24.2014.12.10.02.50.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 02:50:12 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM47XX: Use strnchr to avoid reading out of the buffer
Date:   Wed, 10 Dec 2014 11:49:54 +0100
Message-Id: <1418208594-16235-3-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1418208594-16235-1-git-send-email-zajec5@gmail.com>
References: <1418208594-16235-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
This code is there for YEARS, so I think it can wait for 3.20.
---
 arch/mips/bcm47xx/nvram.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index a68e5f9..2975187 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -177,7 +177,7 @@ static int nvram_init(void)
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
-	int err;
+	int data_left, err;
 
 	if (!name)
 		return -EINVAL;
@@ -194,7 +194,9 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 	end[0] = '\0';
 	end[1] = '\0';
 	for (; *var; var = value + strlen(value) + 1) {
-		eq = strchr(var, '=');
+		data_left = end - var;
+
+		eq = strnchr(var, data_left, '=');
 		if (!eq)
 			break;
 		value = eq + 1;
-- 
1.8.4.5
