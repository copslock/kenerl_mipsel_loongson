Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 16:09:12 +0200 (CEST)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33875 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014356AbcCaOJJrsLlm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 16:09:09 +0200
Received: by mail-lf0-f49.google.com with SMTP id c62so60482740lfc.1;
        Thu, 31 Mar 2016 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VByF78s0BAEzgFnXOI1YXnuda/gIl2q5f2HBaCUFtME=;
        b=XRGuVBAVEutymEAfwKgnRu7hyD2QYqpWCnCOwNUnYMNZ25ifPft9tPONBpC+o1vTK/
         bsBl6AqWVlPwy504gfhvzqjz9SS6tfOuV0t6Drv/Yv5CqzgqR/wE+/PaB+v/K9kqEHiH
         L2D+J/LYfigggRBeJ56MiowCntZfhX3dD5GMbqtORRNjcmNuOoUmKvqio5m5exOW/f5T
         yAmEmJk2fOUYUFq9ITQvqgwZ+TnfErOCcn14hfNit3SGJDGLKKD3RYqPoK9QHVP2/LS9
         lBH78aMLtLk3mpy3TqqiD08pBWJ6o9bppuF/r17oB5yXFh40LA4tsOB3+KKuTsHM74zr
         fMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VByF78s0BAEzgFnXOI1YXnuda/gIl2q5f2HBaCUFtME=;
        b=EzbuFcwh0RL18oTwwjwPf1Dft7uBJU2ZYUsSqcbAGfZllFdOcIydKlsnLSVU0+mWt/
         pwtK7IzwwQY3ycHsA7ttH9jwBVz+wzVN5nKt38QzqKp655yh1PUyTC2OX/CAcH7C+g78
         JUUheeelw28Zh4ASHN6keSjMGqFX783GX9m2hPMT3eWEZtqRKMeRrIOzu3UDXRDxq7LE
         kK2cpicNzt266TsCSnF/Cs++8XX/QE1fejmPF8DherRyWF2N9l6jn0KzdWj8zYbPhqel
         8D7RDQ7IW3K/6gojbPWDIDC2sSYj75lX7NmNcy7dkSn0x0nlrDUw2t7Amw1r9gAS3B3o
         0+Rw==
X-Gm-Message-State: AD7BkJKBvOmhCLe+5eZLx2vrFP63OAFlbrBTdCRhdA50DRWxNGDn90lLSsMw0keXs9YLLg==
X-Received: by 10.25.145.149 with SMTP id t143mr6636740lfd.37.1459433344472;
        Thu, 31 Mar 2016 07:09:04 -0700 (PDT)
Received: from puro.NIISI (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id rg10sm1291094lbc.21.2016.03.31.07.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 07:09:03 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fixup! MIPS: ath79: Disable platform code for OF boards.
Date:   Thu, 31 Mar 2016 17:09:00 +0300
Message-Id: <1459433340-12526-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

---
 arch/mips/ath79/setup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 897f49a..7adab18 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -215,9 +215,11 @@ void __init plat_mem_setup(void)
 		ath79_detect_sys_type();
 		ath79_ddr_ctrl_init();
 
-	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
-	/* OF machines should use the reset driver */
-	_machine_restart = ath79_restart;
+		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
+
+		/* OF machines should use the reset driver */
+		_machine_restart = ath79_restart;
+	}
 
 	_machine_halt = ath79_halt;
 	pm_power_off = ath79_halt;
-- 
2.7.0
