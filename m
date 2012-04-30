Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:36:17 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56982 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2D3Lee (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 05/14] MIPS: parse chosen node on boot
Date:   Mon, 30 Apr 2012 13:33:00 +0200
Message-Id: <1335785589-32532-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33085
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
 arch/mips/kernel/prom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 271ad98..dc6dedf 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -108,4 +108,6 @@ void __init __dt_setup_arch(struct boot_param_header *bph)
 
 	initial_boot_params = bph;
 	size = be32_to_cpu(bph->totalsize);
+
+	early_init_devtree(initial_boot_params);
 }
-- 
1.7.9.1
