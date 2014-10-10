Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:30:09 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36770
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011014AbaJJW3QRS-r1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:16 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 03/10] MIPS: lantiq: reboot gphy on restart
Date:   Sat, 11 Oct 2014 00:02:27 +0200
Message-Id: <1412978554-31344-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43228
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

A reboot sometimes lead to a none working phy. An explicit reboot fixes the
problem.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/reset.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index a1e06b7..fe68f9a 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -176,8 +176,15 @@ void ltq_rst_init(void)
 
 static void ltq_machine_restart(char *command)
 {
+	u32 val = ltq_rcu_r32(RCU_RST_REQ);
+
+	if (of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200"))
+		val |= RCU_RD_GPHY1_XRX200 | RCU_RD_GPHY0_XRX200;
+
+	val |= RCU_RD_SRST;
+
 	local_irq_disable();
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | RCU_RD_SRST, RCU_RST_REQ);
+	ltq_rcu_w32(val, RCU_RST_REQ);
 	unreachable();
 }
 
-- 
1.7.10.4
