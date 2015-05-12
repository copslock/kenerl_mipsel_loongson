Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 18:46:47 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35365 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026420AbbELQq3UWpdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 18:46:29 +0200
Received: by widdi4 with SMTP id di4so162448992wid.0;
        Tue, 12 May 2015 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J0SLQlQ6e71rdlyiLhFRK+d6h+elO+S6hrFpb9flfGE=;
        b=Y5qpAWWVhJayui4W1QoVtRpeCR0bfLXwG85eBgI20wgaK7I/FaxRwogGKFMG6PyXhc
         tnUK16IX4sC5JmBkTrmHfTaYNs78JB3Yqbch5MHYWs0JSN+GNOHAGfKOR4K4LRHdLb/+
         TuOOatn+wHxP6erVpELRT/XcXS2YFoDXDruHL5+FjqWiliKEBcnj4e2Rc/CiT0ZOWDC5
         38rGuya178x5ZCSKvdAx+Z4y/xd0HIaXr8ZKT1LtU9vaqp82fkkG2aoiV2zyUczvkUcI
         OuhfOlQ0YL9jOX/42IuMW6mYx7pEcaXVV7baJSPuXWHxRvnDPWFjJ8AMgAz4mdg01hBE
         d5tw==
X-Received: by 10.194.60.43 with SMTP id e11mr32725919wjr.36.1431449186385;
        Tue, 12 May 2015 09:46:26 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id lh8sm16616610wjc.23.2015.05.12.09.46.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 09:46:25 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Hante Meuleman <meuleman@broadcom.com>,
        Ian Kent <raven@themaw.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47XX: Simplify function looking for NVRAM entry
Date:   Tue, 12 May 2015 18:46:12 +0200
Message-Id: <1431449172-11352-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1431449172-11352-1-git-send-email-zajec5@gmail.com>
References: <1431449172-11352-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47349
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

First of all it shouldn't modify copied NVRAM just to make sure it can
loop over all entries. It's enough to just compare current position
pointer with the end of buffer address.
Secondly buffer is guaranteed to be \0 ended, so we don't need strnchr.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index dee1c32..95d028c 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -171,7 +171,7 @@ static int nvram_init(void)
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
-	int data_left, err;
+	int err;
 
 	if (!name)
 		return -EINVAL;
@@ -184,19 +184,16 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 
 	/* Look for name=value and return value */
 	var = &nvram_buf[sizeof(struct nvram_header)];
-	end = nvram_buf + sizeof(nvram_buf) - 2;
-	end[0] = '\0';
-	end[1] = '\0';
-	for (; *var; var = value + strlen(value) + 1) {
-		data_left = end - var;
-
-		eq = strnchr(var, data_left, '=');
+	end = nvram_buf + sizeof(nvram_buf);
+	while (var < end && *var) {
+		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		value = eq + 1;
 		if (eq - var == strlen(name) &&
 		    strncmp(var, name, eq - var) == 0)
 			return snprintf(val, val_len, "%s", value);
+		var = value + strlen(value) + 1;
 	}
 	return -ENOENT;
 }
-- 
1.8.4.5
