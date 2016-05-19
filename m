Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 22:07:57 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34212 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031195AbcESUHjRNo0e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 22:07:39 +0200
Received: by mail-wm0-f65.google.com with SMTP id n129so23964341wmn.1;
        Thu, 19 May 2016 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BmvpYHug6MkN9U67eDQDE6fMpY8RCIl6VOMxTV9VbI=;
        b=Z1Bl/8gNIf2zKOr1h+idaZqiTR4Gi+z7MXbe2K7ldbJ53hfXLH5SJ8VwLo3LAnde0s
         rNMt4DdwQwlEBJyxKdRu1nxXea/niE3C4SX8sis/t9XkSkyt/BrbIG7GqJN38aQWpH+I
         Q25SkTICnWZOzsjw84Rr4AQf5mgPW5ChPTNBc1XpOMUu7x7Xbom/euCgXZ9afzilhMPs
         9PSamvcTg0hM0+0+Aq4yN6tLbzTxJKP0uiOlOd66LW3DHo7fRk+URpgPXlpvjUt1nGYL
         SHqHZvP7PtQAi0OrOr7MEGmwarp9MxAxmtxhhZBOpOqhfnSkp3VhzzHvI3wE5X5WADuC
         iFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BmvpYHug6MkN9U67eDQDE6fMpY8RCIl6VOMxTV9VbI=;
        b=arlVAnDI9hi2VUlfLxC1McGpkAFacu5dJN0uVEJCCe/UM4a6SUMJMTIFCap+85IAId
         fptjZBD6GyVhym74TrWCplwxq/P1blpsnJzD1QeHCcqmK+o7K/pspFZTdd2EAf2LFAzW
         UtZz74cjQvvyzF+I6aG1Il0qrD2OjoZjBvcm8TMK40coGdlVfE6weI0tUy/N8KQoKvBb
         Y+v9tckz4wBl7TgRGQgouI7MaUqfpb6CmtOQO2X6lYCAOib7Z5RDEmLJFXwwPbCUWFCK
         /KEsKejYF5k1zIr+XoZwyke81J6xvi69CFSTtygy5EMHTkJCVMIFCxWvdSFJD3pebh5F
         pp7g==
X-Gm-Message-State: AOPr4FVp+oRPNFd3vmxHCfKxGfjErW9MRTnTdrc6W/s1px5QmPzO3JY9pCLKMpGc75vvdQ==
X-Received: by 10.28.51.197 with SMTP id z188mr36354701wmz.64.1463688454036;
        Thu, 19 May 2016 13:07:34 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id az2sm16111423wjc.6.2016.05.19.13.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 13:07:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/3] MIPS: ralink: fix MT7628 wled_an pinmux gpio
Date:   Thu, 19 May 2016 22:07:35 +0200
Message-Id: <1463688456-23795-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53548
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

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/ralink/mt7620.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index caabee1..9f80492 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -196,10 +196,10 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 };
 
 static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
-	FUNC("rsvd", 3, 35, 1),
-	FUNC("rsvd", 2, 35, 1),
-	FUNC("gpio", 1, 35, 1),
-	FUNC("wled_an", 0, 35, 1),
+	FUNC("rsvd", 3, 44, 1),
+	FUNC("rsvd", 2, 44, 1),
+	FUNC("gpio", 1, 44, 1),
+	FUNC("wled_an", 0, 44, 1),
 };
 
 #define MT7628_GPIO_MODE_MASK		0x3
-- 
2.1.4
