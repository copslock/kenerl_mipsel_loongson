Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:06:19 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33769 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012508AbaKMGF75Udqq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:05:59 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1XonXV-0007Qu-0V; Thu, 13 Nov 2014 00:05:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 05/11] MIPS: mm: c-r4k: Ensure CCA is set to non-coherent on UP kernels.
Date:   Thu, 13 Nov 2014 00:05:37 -0600
Message-Id: <1415858743-24492-6-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44092
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

From: Markos Chandras <markos.chandras@imgtec.com>

In case the YAMON bootloader is being used, it will set the Config0/K0
value to 0x5 if a multicore processor is detected. This may have
undesired effects if a CM is present since certain cache operations
may broadcast and go through the CM even if we run a UP kernel.
Therefore it's best to ensure that we are in non coherent mode
in UP kernels even if CM is present.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mm/c-r4k.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1559360..076e660 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1595,8 +1595,17 @@ early_param("cca", cca_setup);
 
 static void coherency_setup(void)
 {
-	if (cca < 0 || cca > 7)
-		cca = read_c0_config() & CONF_CM_CMASK;
+	if (cca < 0 || cca > 7) {
+		/*
+		 * Set CCA to non-coherent to ensure that the UP kernel
+		 * behaves properly even on MC processors where the ROM
+		 * may have prepared the C0 registers for SMP operation.
+		 */
+		if (!config_enabled(CONFIG_SMP))
+			cca = _CACHE_CACHABLE_NONCOHERENT >> _CACHE_SHIFT;
+		else
+			cca = read_c0_config() & CONF_CM_CMASK;
+	}
 	_page_cachable_default = cca << _CACHE_SHIFT;
 
 	pr_debug("Using cache attribute %d\n", cca);
-- 
1.7.10.4
