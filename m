Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 18:18:18 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34194 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009561AbbDAQSQu2UqO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 18:18:16 +0200
Received: by wgbdm7 with SMTP id dm7so59028263wgb.1;
        Wed, 01 Apr 2015 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=0qXQ+ju1cFW/2l+FHqM15wqrM/8z+z0Scdni/idaEpc=;
        b=WCZ2hf2e3DX0b9EuuDGdQNKZF3MiAwurXTA8f5CI2xiL9wf4A0YftmfTIWnEWFg5pV
         hephCsZWb/H9ewoZCMkbMOw+mrSEPUDrfd0Hi0xvyGZVtWEyxor2fmPNs3xQhNSBruQT
         0f0fOnX+xo18reZxv7zAZJUH50uLP4Hsi8KY5IJMwxi+8yq9hpqUKyFC2K8/JbhyBcs4
         0j36619XEyYA9TRAca94WkUOxCCRJrPDxrKEhs14pS9NR7PWJJ2z7heH6rylZ7eNimF2
         QZRZOSLgCbp77p0/NL7rfFEr0UBF0PLGGYvxaKAbjG38GQ/j+Bxtb3Rjmo2/QdMYak/L
         oerg==
X-Received: by 10.180.219.102 with SMTP id pn6mr16193568wic.50.1427905092698;
        Wed, 01 Apr 2015 09:18:12 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fm10sm3830398wib.7.2015.04.01.09.18.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 09:18:11 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM47XX: Keep ID entries for non-standard devices together
Date:   Wed,  1 Apr 2015 18:18:01 +0200
Message-Id: <1427905082-29972-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46690
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
 arch/mips/bcm47xx/board.c | 48 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 4016481..3615f48 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -40,20 +40,6 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_model_name[] __initconst = {
 	{ {0}, NULL},
 };
 
-/* model_no */
-static const
-struct bcm47xx_board_type_list1 bcm47xx_board_list_model_no[] __initconst = {
-	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "WL700"},
-	{ {0}, NULL},
-};
-
-/* machine_name */
-static const
-struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst = {
-	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "WRTSL54GS"},
-	{ {0}, NULL},
-};
-
 /* hardware_version */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initconst = {
@@ -202,6 +188,18 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_board_type_rev[] __initconst
 	{ {0}, NULL},
 };
 
+/*
+ * Some devices don't use any common NVRAM entry for identification and they
+ * have only one model specific variable.
+ * They don't deserve own arrays, let's group them there using key-value array.
+ */
+static const
+struct bcm47xx_board_type_list2 bcm47xx_board_list_key_value[] __initconst = {
+	{{BCM47XX_BOARD_ASUS_WL700GE, "Asus WL700"}, "model_no", "WL700"},
+	{{BCM47XX_BOARD_LINKSYS_WRTSL54GS, "Linksys WRTSL54GS"}, "machine_name", "WRTSL54GS"},
+	{ {0}, NULL},
+};
+
 static const
 struct bcm47xx_board_type bcm47xx_board_unknown[] __initconst = {
 	{BCM47XX_BOARD_UNKNOWN, "Unknown Board"},
@@ -225,20 +223,6 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 		}
 	}
 
-	if (bcm47xx_nvram_getenv("model_no", buf1, sizeof(buf1)) >= 0) {
-		for (e1 = bcm47xx_board_list_model_no; e1->value1; e1++) {
-			if (strstarts(buf1, e1->value1))
-				return &e1->board;
-		}
-	}
-
-	if (bcm47xx_nvram_getenv("machine_name", buf1, sizeof(buf1)) >= 0) {
-		for (e1 = bcm47xx_board_list_machine_name; e1->value1; e1++) {
-			if (strstarts(buf1, e1->value1))
-				return &e1->board;
-		}
-	}
-
 	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0) {
 		for (e1 = bcm47xx_board_list_hardware_version; e1->value1; e1++) {
 			if (strstarts(buf1, e1->value1))
@@ -314,6 +298,14 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 				return &e2->board;
 		}
 	}
+
+	for (e2 = bcm47xx_board_list_key_value; e2->value1; e2++) {
+		if (bcm47xx_nvram_getenv(e2->value1, buf1, sizeof(buf1)) >= 0) {
+			if (!strcmp(buf1, e2->value2))
+				return &e2->board;
+		}
+	}
+
 	return bcm47xx_board_unknown;
 }
 
-- 
1.8.4.5
