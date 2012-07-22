Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 08:58:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55374 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903439Ab2GVG43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 08:56:29 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/5] MIPS: lantiq: platform specific CLK fixup
Date:   Sun, 22 Jul 2012 08:56:01 +0200
Message-Id: <1342940161-1421-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33953
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

As we use CLKDEV_LOOKUP but dont have support for COMMON_CLK yet, we need to
provide our own version of of_clk_get_from_provider().

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/clk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index d3bcc33..ce2f129 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -135,6 +135,11 @@ void clk_deactivate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_deactivate);
 
+struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+{
+	return NULL;
+}
+
 static inline u32 get_counter_resolution(void)
 {
 	u32 res;
-- 
1.7.9.1
