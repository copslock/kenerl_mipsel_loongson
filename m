Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 00:21:17 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56209 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827897Ab3FLWVMPD4wI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 00:21:12 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UmtPa-0002fa-6q; Wed, 12 Jun 2013 17:21:02 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: sead3: Fix incorrect values for soft reset.
Date:   Wed, 12 Jun 2013 17:20:56 -0500
Message-Id: <1371075656-21374-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

The soft reset register address and reset value to be written to
the register are incorrect for the SEAD-3 platform. This patch
fixes them such that the SEAD-3 can actually perform a soft reset
instead of causing a NMI exception.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mips-boards/generic.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index bd9746f..61db690 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -26,8 +26,8 @@
 /*
  * Reset register.
  */
-#define SOFTRES_REG	  0x1f000500
-#define GORESET		  0x42
+#define SOFTRES_REG	  0x1f000050
+#define GORESET		  0x4d
 
 /*
  * Revision register.
-- 
1.7.2.5
