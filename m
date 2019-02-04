Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7865FC282CB
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D6D2083B
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfBDWl5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:57 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60572 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfBDWl5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:57 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3B60530082;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/5] MIPS: OCTEON: add fixed-link nodes to in-kernel device tree
Date:   Tue,  5 Feb 2019 00:41:45 +0200
Message-Id: <20190204224149.8139-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Currently OCTEON ethernet falls back to phyless operation on
boards where we have no known PHY address or a fixed-link node.
Add fixed-link support for boards that need it, so we can clean up
the platform code and ethernet driver from some legacy code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../boot/dts/cavium-octeon/octeon_3xxx.dts    |  8 +++++++
 arch/mips/cavium-octeon/octeon-platform.c     | 24 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
index 0fa3dd1819ff..1c50cca4ea53 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
@@ -180,10 +180,18 @@
 				ethernet@0 {
 					phy-handle = <&phy2>;
 					cavium,alt-phy-handle = <&phy100>;
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
 				};
 				ethernet@1 {
 					phy-handle = <&phy3>;
 					cavium,alt-phy-handle = <&phy101>;
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
 				};
 				ethernet@2 {
 					phy-handle = <&phy4>;
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1f9ba60f7375..b4073750822d 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -458,6 +458,23 @@ static bool __init octeon_has_88e1145(void)
 	       !OCTEON_IS_MODEL(OCTEON_CN56XX);
 }
 
+static bool __init octeon_has_fixed_link(int ipd_port)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
+	case CVMX_BOARD_TYPE_CUST_NB5:
+	case CVMX_BOARD_TYPE_EBH3100:
+		/* Port 1 on these boards is always gigabit. */
+		return ipd_port == 1;
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		/* Ports 0 and 1 connect to the switch. */
+		return ipd_port == 0 || ipd_port == 1;
+	}
+	return false;
+}
+
 static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 {
 	const __be32 *phy_handle;
@@ -592,6 +609,7 @@ static void __init octeon_fdt_pip_port(int iface, int i, int p, int max)
 	int eth;
 	int phy_addr;
 	int ipd_port;
+	int fixed_link;
 
 	snprintf(name_buffer, sizeof(name_buffer), "ethernet@%x", p);
 	eth = fdt_subnode_offset(initial_boot_params, iface, name_buffer);
@@ -609,6 +627,12 @@ static void __init octeon_fdt_pip_port(int iface, int i, int p, int max)
 
 	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
 	octeon_fdt_set_phy(eth, phy_addr);
+
+	fixed_link = fdt_subnode_offset(initial_boot_params, eth, "fixed-link");
+	if (fixed_link < 0)
+		WARN_ON(octeon_has_fixed_link(ipd_port));
+	else if (!octeon_has_fixed_link(ipd_port))
+		fdt_nop_node(initial_boot_params, fixed_link);
 }
 
 static void __init octeon_fdt_pip_iface(int pip, int idx)
-- 
2.17.0

