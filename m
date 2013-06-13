Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 22:55:24 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:58488 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835275Ab3FMUzUAGiZ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 22:55:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UnEY5-0005JR-9H; Thu, 13 Jun 2013 15:55:13 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 1/3] MIPS: sead3: Fix ability to perform a soft reset.
Date:   Thu, 13 Jun 2013 15:55:04 -0500
Message-Id: <1371156906-31563-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
References: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36859
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

The soft reset register address and reset value to be written are
incorrect for the SEAD-3 platform. This patch fixes them such that
the SEAD-3 can actually perform a soft reset instead of causing an
exception. Also remove usage of 'include/asm/mips-boards/generic.h'
header file.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mti-sead3/sead3-reset.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-reset.c b/arch/mips/mti-sead3/sead3-reset.c
index 20475c5..e6fb244 100644
--- a/arch/mips/mti-sead3/sead3-reset.c
+++ b/arch/mips/mti-sead3/sead3-reset.c
@@ -9,7 +9,9 @@
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
-#include <asm/mips-boards/generic.h>
+
+#define SOFTRES_REG	0x1f000050
+#define GORESET		0x4d
 
 static void mips_machine_restart(char *command)
 {
@@ -35,5 +37,4 @@ static int __init mips_reboot_setup(void)
 
 	return 0;
 }
-
 arch_initcall(mips_reboot_setup);
-- 
1.7.2.5
