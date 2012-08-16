Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:27:02 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49343 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903480Ab2HPJ05 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:26:57 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 1/4] MIPS: lantiq: adds support for nmi and ejtag bootrom vectors
Date:   Thu, 16 Aug 2012 11:25:39 +0200
Message-Id: <1345109142-1756-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 34199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Register nmi and ejatg bootrom vectors for FALC-ON SoC.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/prom.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
index c1d278f..aa94979 100644
--- a/arch/mips/lantiq/falcon/prom.c
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/kernel.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
 #include <asm/io.h>
 
 #include <lantiq_soc.h>
@@ -84,4 +86,7 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 		unreachable();
 		break;
 	}
+
+	board_nmi_handler_setup = ltq_soc_nmi_setup;
+	board_ejtag_handler_setup = ltq_soc_ejtag_setup;
 }
-- 
1.7.9.1
