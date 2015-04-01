Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 08:23:49 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34536 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014432AbbDAGXchpRyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 08:23:32 +0200
Received: by wgbdm7 with SMTP id dm7so42015894wgb.1;
        Tue, 31 Mar 2015 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=phE8FpvVAZSbj58rNap0khws4+IZbItW06zU2lCPowg=;
        b=p+A65J5HvwRzt5ls6Si1Ko9BJQvBDmxzIarXDnH4Cgj3hHUyTbr9V1RhipYtAW/Et7
         ts5yfrL2cGguvrqxxzkc7FTliAZB6qzryn3TQH4ZiolRJOTq89uEktfiCwfRXt65AFpk
         WkeGKTMX5Swxtm8GIAI+7WLvt00iiVnF5/ds+tNGdJxTLLDHdl6/cUV8WzJIP7B8fH90
         LLwIHF1zg4zjWZxRJb65vyIo6z6JScNAxo/A/Kb1fbH35z2zgyK/amYgjQxqC735kXgI
         hXzzCzU4Z2p7lrS3ty+EfBiySrrYuUg851aZ5i/iOiUgwyxTojFTUgNK/U0Yn4T/GtUm
         l2gA==
X-Received: by 10.180.87.33 with SMTP id u1mr11724816wiz.20.1427869408486;
        Tue, 31 Mar 2015 23:23:28 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id dm6sm1588096wib.22.2015.03.31.23.23.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 23:23:27 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/3] MIPS: BCM47XX: Increase NVRAM buffer size to 64 KiB
Date:   Wed,  1 Apr 2015 08:23:04 +0200
Message-Id: <1427869385-23333-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46677
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

For years Broadcom devices use 64 KiB NVRAM partition size and some of
them indeed have it filled in more than 50%. This change allows reading
whole NVRAM e.g. on Netgear WNDR4500 and Netgear R8000.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2357ea3..2ac7482 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -20,7 +20,7 @@
 #include <linux/bcm47xx_nvram.h>
 
 #define NVRAM_MAGIC			0x48534C46	/* 'FLSH' */
-#define NVRAM_SPACE			0x8000
+#define NVRAM_SPACE			0x10000
 #define NVRAM_MAX_GPIO_ENTRIES		32
 #define NVRAM_MAX_GPIO_VALUE_LEN	30
 
-- 
1.8.4.5
