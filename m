Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:32:06 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36779
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011137AbaJJW3vTw0jZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:51 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 10/10] MIPS: lantiq: refactor the falcon sysctrl code
Date:   Sat, 11 Oct 2014 00:02:34 +0200
Message-Id: <1412978554-31344-11-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43235
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

There is a lot of redundant code. Put this into a helper function.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/sysctrl.c |   97 ++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index c000b56..dbfe18d 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -63,17 +63,26 @@
 #define ACTS_PADCTRL3	0x00200000
 #define ACTS_PADCTRL4	0x00400000
 
-#define sysctl_w32(m, x, y)	ltq_w32((x), sysctl_membase[m] + (y))
-#define sysctl_r32(m, x)	ltq_r32(sysctl_membase[m] + (x))
+#define sysctl_w32(m, val, reg)	ltq_w32((val), sysctl_membase[m] + (reg))
+#define sysctl_r32(m, reg)	ltq_r32(sysctl_membase[m] + (reg))
 #define sysctl_w32_mask(m, clear, set, reg)	\
 		sysctl_w32(m, (sysctl_r32(m, reg) & ~(clear)) | (set), reg)
 
-#define status_w32(x, y)	ltq_w32((x), status_membase + (y))
-#define status_r32(x)		ltq_r32(status_membase + (x))
+#define status_w32(val, reg)	sysctl_w32(3, val, reg)
+#define status_r32(reg)		sysctl_r32(3, reg)
 
-static void __iomem *sysctl_membase[3], *status_membase;
+static const char * const sysctrl_compatible[] = {
+	"lantiq,sys1-falcon",
+	"lantiq,syseth-falcon",
+	"lantiq,sysgpe-falcon",
+	"lantiq,status-falcon",
+	"lantiq,ebu-falcon"
+};
+
+static void __iomem *sysctl_membase[ARRAY_SIZE(sysctrl_compatible)];
 void __iomem *ltq_sys1_membase, *ltq_ebu_membase;
 
+
 void falcon_trigger_hrst(int level)
 {
 	sysctl_w32(SYSCTL_SYS1, level & 1, SYS1_HRSTOUTC);
@@ -182,62 +191,38 @@ static inline void clkdev_add_sys(const char *dev, unsigned int module,
 	clkdev_add(&clk->cl);
 }
 
+void __iomem * __init sysctrl_init(const char *compatible)
+{
+	struct device_node *np;
+	struct resource res;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	if (!np)
+		panic("Failed to load node '%s'", compatible);
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("Failed to get '%s' resources", compatible);
+
+	if (request_mem_region(res.start, resource_size(&res), res.name) < 0)
+		pr_err("Failed to request '%s' mem-region\n", compatible);
+
+	base = ioremap_nocache(res.start, resource_size(&res));
+	if (!base)
+		panic("Failed to remap '%s' resources", compatible);
+
+	return base;
+}
+
 void __init ltq_soc_init(void)
 {
-	struct device_node *np_status =
-		of_find_compatible_node(NULL, NULL, "lantiq,status-falcon");
-	struct device_node *np_ebu =
-		of_find_compatible_node(NULL, NULL, "lantiq,ebu-falcon");
-	struct device_node *np_sys1 =
-		of_find_compatible_node(NULL, NULL, "lantiq,sys1-falcon");
-	struct device_node *np_syseth =
-		of_find_compatible_node(NULL, NULL, "lantiq,syseth-falcon");
-	struct device_node *np_sysgpe =
-		of_find_compatible_node(NULL, NULL, "lantiq,sysgpe-falcon");
-	struct resource res_status, res_ebu, res_sys[3];
 	int i;
 
-	/* check if all the core register ranges are available */
-	if (!np_status || !np_ebu || !np_sys1 || !np_syseth || !np_sysgpe)
-		panic("Failed to load core nodes from devicetree");
-
-	if (of_address_to_resource(np_status, 0, &res_status) ||
-			of_address_to_resource(np_ebu, 0, &res_ebu) ||
-			of_address_to_resource(np_sys1, 0, &res_sys[0]) ||
-			of_address_to_resource(np_syseth, 0, &res_sys[1]) ||
-			of_address_to_resource(np_sysgpe, 0, &res_sys[2]))
-		panic("Failed to get core resources");
-
-	if ((request_mem_region(res_status.start, resource_size(&res_status),
-				res_status.name) < 0) ||
-		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
-				res_ebu.name) < 0) ||
-		(request_mem_region(res_sys[0].start,
-				resource_size(&res_sys[0]),
-				res_sys[0].name) < 0) ||
-		(request_mem_region(res_sys[1].start,
-				resource_size(&res_sys[1]),
-				res_sys[1].name) < 0) ||
-		(request_mem_region(res_sys[2].start,
-				resource_size(&res_sys[2]),
-				res_sys[2].name) < 0))
-		pr_err("Failed to request core reources");
-
-	status_membase = ioremap_nocache(res_status.start,
-					resource_size(&res_status));
-	ltq_ebu_membase = ioremap_nocache(res_ebu.start,
-					resource_size(&res_ebu));
-
-	if (!status_membase || !ltq_ebu_membase)
-		panic("Failed to remap core resources");
-
-	for (i = 0; i < 3; i++) {
-		sysctl_membase[i] = ioremap_nocache(res_sys[i].start,
-						resource_size(&res_sys[i]));
-		if (!sysctl_membase[i])
-			panic("Failed to remap sysctrl resources");
-	}
+	for (i = 0; i < ARRAY_SIZE(sysctrl_compatible); i++)
+		sysctl_membase[i] = sysctrl_init(sysctrl_compatible[i]);
+
 	ltq_sys1_membase = sysctl_membase[0];
+	ltq_ebu_membase = sysctl_membase[4];
 
 	falcon_gpe_enable();
 
-- 
1.7.10.4
