Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:14:27 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35597 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867263Ab3LRNOBIzMP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7C91928A924;
        Wed, 18 Dec 2013 14:11:43 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 53C1F2846CB;
        Wed, 18 Dec 2013 14:11:40 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 02/13] MIPS: allow asm/cpu.h to be included from assembly
Date:   Wed, 18 Dec 2013 14:12:00 +0100
Message-Id: <1387372331-23474-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Add guards around the enum to allow including cpu.h from assembly.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d2035e1..e71b491 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -249,6 +249,8 @@
 
 #define FPIR_IMP_NONE		0x0000
 
+#if !defined(__ASSEMBLY__)
+
 enum cpu_type_enum {
 	CPU_UNKNOWN,
 
@@ -301,6 +303,7 @@ enum cpu_type_enum {
 	CPU_LAST
 };
 
+#endif /* !__ASSEMBLY */
 
 /*
  * ISA Level encodings
-- 
1.8.5.1
