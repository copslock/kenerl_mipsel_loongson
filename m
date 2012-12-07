Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:52:16 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60253 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822126Ab2LGEwPUZR8- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:52:15 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgpuz-0007KH-6n; Thu, 06 Dec 2012 22:52:09 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: dsp: Fix DSP mask for registers.
Date:   Thu,  6 Dec 2012 22:52:03 -0600
Message-Id: <1354855923-28310-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

The DSP bit mask for the rddsp and wrdsp instructions was wrong.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/dsp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index e9bfc08..7bfad05 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -16,7 +16,7 @@
 #include <asm/mipsregs.h>
 
 #define DSP_DEFAULT	0x00000000
-#define DSP_MASK	0x3ff
+#define DSP_MASK	0x3f
 
 #define __enable_dsp_hazard()						\
 do {									\
-- 
1.7.9.5
