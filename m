Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 14:30:51 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48066 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903755Ab2EBM3Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2012 14:29:25 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 05/14] MIPS: parse chosen node on boot
Date:   Wed,  2 May 2012 14:27:35 +0200
Message-Id: <1335961659-21358-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
References: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Call early_init_devtree from inside __dt_setup_arch to allow parsing of the
chosen node.

Signed-off-by: John Crispin <blogic@openwrt.org>

---
Changes in V2
* rebase on previous patch

 arch/mips/kernel/prom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 4c788d2..f11b2bb 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -105,4 +105,6 @@ void __init __dt_setup_arch(struct boot_param_header *bph)
 	}
 
 	initial_boot_params = bph;
+
+	early_init_devtree(initial_boot_params);
 }
-- 
1.7.9.1
