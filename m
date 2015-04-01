Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 08:23:31 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33948 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007000AbbDAGX3oj-rf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 08:23:29 +0200
Received: by wixo5 with SMTP id o5so22411954wix.1;
        Tue, 31 Mar 2015 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=G+LjEIO0Bn9RH+voQrR/T8YKYcq/Hw6uMhEByu3H1zQ=;
        b=CSrS+RN1bk6GzHRSDqrpvenxaLFUpu5Ql/xhyEp9JJ/aqPyNySDmr/Ei/TDm7SwEQ2
         D8m0dJ98Q9RbYpsUOWgnFxvb8cQ2tTaagyhzFfwxSdLLRObfDrKFCBoNB8yIJjwHLQQz
         lXaOBM0xmmFJznEOs/wtch/auep6/ijfCd9NdBZqAjLjId6MmrRzcoR9fCrL3Dn/5fwe
         fSFfCS7n0Lcsmjxwpvc+WUsP1oWfkmvVwjLtoN7uHC95JqPhdgwbTl58pG5uyTVyr1No
         fz2DMroonimm6//TTMwioU0HVhDZsUeqorZIum2uhKQEU3lidf3ow2HnOhVXIN18KY2q
         4RWQ==
X-Received: by 10.180.77.40 with SMTP id p8mr11683671wiw.1.1427869405617;
        Tue, 31 Mar 2015 23:23:25 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id dm6sm1588096wib.22.2015.03.31.23.23.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 23:23:24 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/3] MIPS: BCM47XX: Include io.h directly and fix brace indent
Date:   Wed,  1 Apr 2015 08:23:03 +0200
Message-Id: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46676
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

We use IO functions like readl & ioremap_nocache, so include linux/io.h

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 6a97732..2357ea3 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -11,6 +11,7 @@
  * option) any later version.
  */
 
+#include <linux/io.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -203,7 +204,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 		if (eq - var == strlen(name) &&
 		    strncmp(var, name, eq - var) == 0)
 			return snprintf(val, val_len, "%s", value);
-		}
+	}
 	return -ENOENT;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_getenv);
-- 
1.8.4.5
