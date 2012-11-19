Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2012 19:27:51 +0100 (CET)
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:60078 "EHLO
        viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825670Ab2KSS1aZQQyF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2012 19:27:30 +0100
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
        id C6FE8801F3; Mon, 19 Nov 2012 13:27:24 -0500 (EST)
From:   Bill Pemberton <wfp5p@virginia.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 034/493] MIPS: remove use of __devexit_p
Date:   Mon, 19 Nov 2012 13:19:43 -0500
Message-Id: <1353349642-3677-34-git-send-email-wfp5p@virginia.edu>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
X-archive-position: 35036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wfp5p@virginia.edu
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
Return-Path: <linux-mips-bounce@linux-mips.org>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-mips@linux-mips.org 
---
 arch/mips/mti-sead3/sead3-i2c-drv.c       | 2 +-
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
index 0375ee6..114a167 100644
--- a/arch/mips/mti-sead3/sead3-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
@@ -383,7 +383,7 @@ static struct platform_driver sead3_i2c_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sead3_i2c_platform_probe,
-	.remove		= __devexit_p(sead3_i2c_platform_remove),
+	.remove		= sead3_i2c_platform_remove,
 	.suspend	= sead3_i2c_platform_suspend,
 	.resume		= sead3_i2c_platform_resume,
 };
diff --git a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
index 46509b0..587d5b5 100644
--- a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
@@ -408,7 +408,7 @@ static struct platform_driver i2c_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= i2c_platform_probe,
-	.remove		= __devexit_p(i2c_platform_remove),
+	.remove		= i2c_platform_remove,
 	.suspend	= i2c_platform_suspend,
 	.resume		= i2c_platform_resume,
 };
-- 
1.8.0
