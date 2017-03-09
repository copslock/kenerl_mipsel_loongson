Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 15:17:10 +0100 (CET)
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:13369
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993133AbdCIOQSXCqjT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 15:16:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/DivQMYhpeu6bjT7EFPK9yz6TMqN5ZDpLoGzBEPya5Y=;
 b=HWA+eu4ACV8h7toEMjqiKX2DY4qj4EuBEXV3N2veaXax78k4Z/H3xXakVZzly8qQY6bXO/fOJ/J4Re3Uo4iecEWa0FgBlsudcx+ZXpURh6crKrJ8EbwU0Y2AqymM+1s42JXiijxvcW/KMvTbOd2F/GoSRHM3OKfNxpRhlnjjVKc=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from white.inter.net (173.22.239.243) by
 MWHPR07MB3216.namprd07.prod.outlook.com (10.172.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 9 Mar 2017 14:16:09 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Clean up platform code.
Date:   Thu,  9 Mar 2017 08:16:03 -0600
Message-Id: <1489068963-9836-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR07CA0038.namprd07.prod.outlook.com (10.255.223.151) To
 MWHPR07MB3216.namprd07.prod.outlook.com (10.172.96.150)
X-MS-Office365-Filtering-Correlation-Id: 4b925ccf-5128-4737-3567-08d466f6d5b5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:MWHPR07MB3216;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;3:dB1uUy3Ea4LZB/csN9OLbXLPvlnRRHb5d1zg3//MqQfrcGjspffr8l9hDoO0rvQDPqFredN25dfsJdjntv9B8XOe2R1+eXmu34d/QRw4lI4UVKSbpnaymefYPwzSAalHQdBWhm+TW/etGk334oyCNJPGobP8GhrWbwRBAAXi7wG9RESIQUoD+l4M2reZLD4vhOihj7p3CCuVmw9kxNFxywVAkIePBzssqdM8IUbCjaCrBVbAqur/aPb4t7mzEc9nohyXqnzh2So271M78V9EBg==;25:1Y9ZeNB5TlwPZWeiu8VdWo+zjWT71IKPQ5PHqa3I499ifKBVScTCefUzYE7nt67pMSHXf6GV9iCb8Fi4FRRvYmSitmu4Ckh0qa7TktkWsF5pZF+m0I9uZvKkalOF6weowNuM/FnGGeH/ob+SjtvjzR5yVaqY/efTNOjlIRkwi4GBvUzEe3xIv5Lj2GyFDpUP3loaa/8rzrjejvLdNhn6gc3KM5HMlR6KLgSWByNvAZePpxIaH5HaDhraQfCzbCsJaNCDXQqPs2n+hDE2cGN2cz/m/lAAdbgDu6TeEAMXkoc7xXwzisDmI3qjktS66bA365cjr5D5qmFx0Ttbzn8qsMqyv4jGmWij4IyCjmFNtab37lF+/hF1KEfyMBPqgTFHhobXPRnnXdfrs2nn7lopTtOV5EYV85+ehA7sB3hJ/dz+cettvHCtHfxUDBwcbMnDlxKHOhcdnUetYtKr9xfqgQ==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;31:ctKHGlIb4Mrj7KY5KaMy8iQSLXsKRh9HSOx0jXNO0feohMwn4KldZpkuVfLb3uFof7Ky42mQ8bq3+rP3zyHPsLTeBY/wkq2RycCMWPsWjDhLWQlcgYlSOuIAuEvafTFQEA7SyJOq6yj8Jf4t+PXybUnQH1MSS7KFvVfe7+RDz6Fy6UWCGGWR65DrhCg23YktgALShAGpkGTg8ttOPGaQd4pL5vY7bhqwWahGWZ5WYNq8JX85LB9HWBE+yGZYVFPogUycqt5qvXy6ob0Q6GRNH6UGuRFK12EN7F0VqhfC+ns=;20:fAeaheB3aVpLHNxP1MW8H5pABVqs34A/5391xiB6bILdWAk2yojAYdHnsGPoBIpd74ESAE0MGGlecgwwhfJc+bdtzd2bK+xhPrs+WY3yIGteD/+oygcz5SXqYhfn6ZFeUHQRGvNTlHWbx0uRoO1XUb98D90MHwcHgYwFK3RbwKlN9+/t6Z/fVdsZR2ZQNETLltE8lZ82e0/2HIEx+mRkOHJHAhjtHzZhBU0oOs0m9qTwA+12jQ+zRkLfIcVi0tDny+nMPLB/MsGg6RHnUpoxrFRuKHBVRmT0h04RnIKkPMEj13jBzl6auMLi4IH1325JXPU2tGIporAZZ6dYBT1WxQPOv/JCAQDghM/A+xvokox5CBZ5vSt5xFOJPFuS0YVM/OCffI6pHahDZ/rMBDA1LAQAi588e2ghxTRy7XKaNhtPrg6D8GaQ9s10w55FxSNnHwc5dJlaPT8yMGJCkG7WVwPX3HnCMoZYQw1XyPxDzH6pn3jQD8VKA7nL0M/+uq15
X-Microsoft-Antispam-PRVS: <MWHPR07MB3216EF57E1C2A52C35DDE8C580210@MWHPR07MB3216.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123562025)(20161123560025)(20161123555025)(20161123558025)(20161123564025)(6072148);SRVR:MWHPR07MB3216;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3216;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;4:LCImmPXy+cgyWzePOtYog6tVghcxD+K3r+gaFCFphuEs1ODuzvThlL5wEhZ9y8ZFcBUcqIBqXX33iOzcaCOtlwlaG9W6k0xq5NtJ61iPk4lg7R0PREqQ1Lp+/YCRFogbmOmHtRdb/icYRALdcH72QxNdJATntn5DgHf0/WT23H/NU3JxwXvnLp6VgxTsgMCU970pb2MZg7APVpR1klJtTklQHzDbB5NtKHjk5Mqsmr9CHuoGZmRwDch1eA3juO5SbsrcWJ0n+EZ2To5Bqx9AklLQzHp5W3bWoeb6gYm+cALR/vMpYyorEQDUaXVLvL7q3PedLt/CJkDGWNzoG75JH+1FOqDevvf86vw3NDF58QuoyMfSaYRPWFkRcdh5yJz2cDiiUWl40pDLuiWprCRL3v78OdNkpewd4mYhq+hiitT8S7exaTXJK0phhiEjxnAM+9S3G3Q6JCqInLUPCqYbp41JN5k8C9zx9/l9FjEiskQaofPkxoEN1CNY1A/Nvya2KxwWgVu/6xQyAn5PYg5VFMTimvvZs2GbFWzv+uJmAbDbR+BwDZqAoaL69JJqWfztjvHL9jx85NRIaskIbM/sFEtIk4QHfVMR4r5qj8n1Wx8=
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(5660300001)(47776003)(53416004)(2351001)(42186005)(6506006)(66066001)(48376002)(25786008)(6512007)(50986999)(50466002)(6666003)(3846002)(6116002)(189998001)(2361001)(6486002)(6916009)(86362001)(5003940100001)(81166006)(7736002)(33646002)(36756003)(53936002)(50226002)(38730400002)(110136004)(4326008)(2906002)(305945005)(8676002)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3216;H:white.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;23:LCxkwB2TxHW9wNHz4GQRFOV42Ea3OyA2LiF5Fg4dl6tT0GTZjdJsM/5f+kcMYCrqX83+sBJ8W0t1B0RqacxMdNDpkDFox+ZTLAwyWOcCfeeKzKxcV71fh62HmAl3J/AeohrOVD94/MPD4GSUfDgrWbkHt1RP7gRceO76BUJVtmQgUARcEr6M+4+dloE+QdYKy/AHy1kapicCNfw97g0u09u4w6sZat+ORECMaCXnvuAEFrlwLfIxsrVZTM3i3EvRU1UNAATLDpIL8ee3ATN6V4gnn1pju48OoB1VYayXMtj3PBg5UH+QDPv9OuQqbd83cLhXex+gSQ5cC6JXAI85IIiBf/ubbezFFcIEyE+2Ka5/Q0PLzVTSVJrrP/8iknkXEE1mkAkEnQGCMt8sMO5eqgupviRmKil/wLNEzlMGk2BdUf4TKjSTRUFIiOqfTvXPze7JeIgr69Q9NUYV2BELZWxmWieXIGMPwLAUnKEbE1WDFRruDtUN3lJ4atXxIZjtiJ8kvasEdq5aiZQjlM9cNXy5x7DrSuCH3QO1E6eRrhrsMrYjxcQ5pM/YDazGRHcfMqdvuF07+/s+Xt+XzwORENX2z0qjZzWaPo+WCCnq4DC0NpU7p+pgLcHma2KyRLCzp0kheoaszDHZDTvB3IikCewQ3OuzJDpz8rA2FW7r6aVA7k01aJF6fHn2UEk1wuIUsE833DzbG6eJzonX+uSTEtQSPDr58pvOUlAEmUc49UEFeKAzrACjnWSJOgqB4KDBeh6BtzA7e3blb/cYITnfwUQFTN/tghWpc9QI6SbDNPjApjnq68vaHEhg1qSqcqWPFF1dKKcVsAgIBH9JZxZ5KkPtHOztmbKwJnVWAytXkb2ypvsjTptj0q5jnUZ/08sweo/UpEu2F/bSsjv+TFhbWkSNrnF17QxJF34y00eWDEM=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;6:iPYz5TtdgNb+Usb7IXqE9GRLOUvT0jc4kO0h67jYgyowMVMQ5CSpu0N6rQwX/SQlIvYIJTyyBoPZktIxDvQoexDfvb2chfvRUivDA+E/+oDPUcQ9PNRtR+y0pUpFIkFDZsl+UEAneui+g75r9lf2rJO7w9xnkGO/QbzG7LCv03YKy4eK601XNOO4p97r1V3ByegPT92v6uzl/xTbpZ9SpaXi/LZblw1SGobdJOiR/V4jwzFQenxE3zO60aOdydr8/VrJfrnncOmb1liawc3UdLMtstjNSp7+bM6HssIgqueV2KQ9FtQH/d3yCAOtS6UwRe37IFQYPv7iI0hACDo0scRYbnnT+m3aTQmCTaLUEBLnD4+i58M824A67a/0BoDaugAxtXAiK/aqpYFnG9ktow==;5:O6zQgvAl5kcMsL7nL680WwK9/TyKs6Siz4FhX3JZ/okm/y1j2gTTiJX8KDi6sB+b2qRBniunQt148vmZ5y5DqJkBPH34asCkw+2XhsJOoaiTD73TZyUFgLf6nZQamz3nB/1RnMmyvrGKu28d6sTEMQ==;24:lhtmJCEpmYgMwj9h5KIiSoftsPeTbMzaLvYcy2jZm5thob7qJszbR2cn561yJnVPeeiFhbSUAQHLRcfvpLXalhN8oMJA5P9EhhKWb/7DykU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3216;7:Th8sBGitectHnCUrvvuRtpZo/Y1l5upavUua9neiKGxmMvL4oMpopteSalFHN7/e/38RrRsWtZKZgGRrQ6aFGmgXsq6/I2SsNIQhQvhl03UcLCdzmv9lsvvr5zH1BfhQ4n3SqTZhY+Fcvrv29hBU7llMgDu84FPyT0ywOL5EBD/AdMwo6ARFtsnC6ARQTwGupoul1GdKtZb5YFF3fSgxgQb5XsgpH0hNRapVmSL531rJpmlOQUekeAroY0Xx3pa/3ZV0SjucA8Omp6npy4RaePfxKinOnEVuem49fDDJ0hZXh4AqQiyv2iHOnNSCdlxakCjvNpLV8w7RfVDsDFRAwQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2017 14:16:09.4961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3216
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Remove unused headers and fix warnings from checkpatch.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 72d2a5e..1a1e11f 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -7,8 +7,6 @@
  * Copyright (C) 2008 Wind River Systems
  */
 
-#include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/etherdevice.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
@@ -440,7 +438,7 @@ static int __init octeon_rng_device_init(void)
 }
 device_initcall(octeon_rng_device_init);
 
-static struct of_device_id __initdata octeon_ids[] = {
+const struct of_device_id octeon_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "cavium,octeon-6335-uctl", },
 	{ .compatible = "cavium,octeon-5750-usbn", },
@@ -479,6 +477,7 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 	alt_phy_handle = fdt_getprop(initial_boot_params, eth, "cavium,alt-phy-handle", NULL);
 	if (alt_phy_handle) {
 		u32 alt_phandle = be32_to_cpup(alt_phy_handle);
+
 		alt_phy = fdt_node_offset_by_phandle(initial_boot_params, alt_phandle);
 	} else {
 		alt_phy = -1;
@@ -577,6 +576,7 @@ static void __init octeon_fdt_rm_ethernet(int node)
 	if (phy_handle) {
 		u32 ph = be32_to_cpup(phy_handle);
 		int p = fdt_node_offset_by_phandle(initial_boot_params, ph);
+
 		if (p >= 0)
 			fdt_nop_node(initial_boot_params, p);
 	}
@@ -726,6 +726,7 @@ int __init octeon_prune_device_tree(void)
 
 	for (i = 0; i < 2; i++) {
 		int mgmt;
+
 		snprintf(name_buffer, sizeof(name_buffer),
 			 "mix%d", i);
 		alias_prop = fdt_getprop(initial_boot_params, aliases,
@@ -741,6 +742,7 @@ int __init octeon_prune_device_tree(void)
 						 name_buffer);
 			} else {
 				int phy_addr = cvmx_helper_board_get_mii_address(CVMX_HELPER_BOARD_MGMT_IPD_PORT + i);
+
 				octeon_fdt_set_phy(mgmt, phy_addr);
 			}
 		}
@@ -749,6 +751,7 @@ int __init octeon_prune_device_tree(void)
 	pip_path = fdt_getprop(initial_boot_params, aliases, "pip", NULL);
 	if (pip_path) {
 		int pip = fdt_path_offset(initial_boot_params, pip_path);
+
 		if (pip	 >= 0)
 			for (i = 0; i <= 4; i++)
 				octeon_fdt_pip_iface(pip, i);
@@ -765,6 +768,7 @@ int __init octeon_prune_device_tree(void)
 
 	for (i = 0; i < 2; i++) {
 		int i2c;
+
 		snprintf(name_buffer, sizeof(name_buffer),
 			 "twsi%d", i);
 		alias_prop = fdt_getprop(initial_boot_params, aliases,
@@ -795,11 +799,11 @@ int __init octeon_prune_device_tree(void)
 
 	for (i = 0; i < 2; i++) {
 		int i2c;
+
 		snprintf(name_buffer, sizeof(name_buffer),
 			 "smi%d", i);
 		alias_prop = fdt_getprop(initial_boot_params, aliases,
 					name_buffer, NULL);
-
 		if (alias_prop) {
 			i2c = fdt_path_offset(initial_boot_params, alias_prop);
 			if (i2c < 0)
@@ -822,6 +826,7 @@ int __init octeon_prune_device_tree(void)
 
 	for (i = 0; i < 3; i++) {
 		int uart;
+
 		snprintf(name_buffer, sizeof(name_buffer),
 			 "uart%d", i);
 		alias_prop = fdt_getprop(initial_boot_params, aliases,
@@ -861,6 +866,7 @@ int __init octeon_prune_device_tree(void)
 		int len;
 
 		int cf = fdt_path_offset(initial_boot_params, alias_prop);
+
 		base_ptr = 0;
 		if (octeon_bootinfo->major_version == 1
 			&& octeon_bootinfo->minor_version >= 1) {
@@ -910,6 +916,7 @@ int __init octeon_prune_device_tree(void)
 			fdt_nop_property(initial_boot_params, cf, "cavium,dma-engine-handle");
 			if (!is_16bit) {
 				__be32 width = cpu_to_be32(8);
+
 				fdt_setprop_inplace(initial_boot_params, cf,
 						"cavium,bus-width", &width, sizeof(width));
 			}
@@ -1035,6 +1042,7 @@ int __init octeon_prune_device_tree(void)
 		} else  {
 			__be32 new_f[1];
 			enum cvmx_helper_board_usb_clock_types c;
+
 			c = __cvmx_helper_board_usb_get_clock_type();
 			switch (c) {
 			case USB_CLOCK_TYPE_REF_48:
-- 
1.9.1
