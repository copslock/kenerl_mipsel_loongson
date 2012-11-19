Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2012 19:30:24 +0100 (CET)
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:33191 "EHLO
        viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828016Ab2KSS2ulUu1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2012 19:28:50 +0100
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
        id 2BCBE80446; Mon, 19 Nov 2012 13:27:52 -0500 (EST)
From:   Bill Pemberton <wfp5p@virginia.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 485/493] mips: remove use of __devexit
Date:   Mon, 19 Nov 2012 13:27:14 -0500
Message-Id: <1353349642-3677-485-git-send-email-wfp5p@virginia.edu>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
X-archive-position: 35042
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

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-mips@linux-mips.org 
---
 arch/mips/mti-sead3/sead3-i2c-drv.c       | 2 +-
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
index 51270bc..7aa2225 100644
--- a/arch/mips/mti-sead3/sead3-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
@@ -345,7 +345,7 @@ out:
 	return ret;
 }
 
-static int __devexit sead3_i2c_platform_remove(struct platform_device *pdev)
+static int sead3_i2c_platform_remove(struct platform_device *pdev)
 {
 	struct pic32_i2c_platform_data *priv = platform_get_drvdata(pdev);
 
diff --git a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
index 219d1db..664ddab 100644
--- a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
@@ -361,7 +361,7 @@ out:
 	return ret;
 }
 
-static int __devexit
+static int
 i2c_platform_remove(struct platform_device *pdev)
 {
 	struct i2c_platform_data *priv = platform_get_drvdata(pdev);
-- 
1.8.0
