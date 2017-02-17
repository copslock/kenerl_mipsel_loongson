Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 20:46:18 +0100 (CET)
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:3204
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992196AbdBQTqJCXHeL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2017 20:46:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ejyzcmssmABHeMopIhlGegzLV3rTLWPcE0zONc6M3jA=;
 b=dXZPpvAq3YHy22uuB7UUSg3qTqiyB0+TmwGhCDAsSKbrQFCKBcxBNiE0E7qX2pZAT+4zsLFagNSQwsAvAcDGNbU2F1scGvyVUf/0pgmaovqpz3XM/BuGH4awX7bHaqM3N8hUVlHemP4A665wB+DAfcBP0sNGYoi13crw5FRLjpw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1977.namprd07.prod.outlook.com (10.163.141.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.888.16; Fri, 17 Feb 2017 19:45:59 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: cavium-octeon: Remove vestiges of CONFIG_CAVIUM_OCTEON_2ND_KERNEL
Date:   Fri, 17 Feb 2017 11:45:55 -0800
Message-Id: <20170217194555.11407-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0015.namprd07.prod.outlook.com (10.141.52.143) To
 CY1PR0701MB1977.namprd07.prod.outlook.com (10.163.141.19)
X-MS-Office365-Filtering-Correlation-Id: ebaa0c00-7b06-45e5-2dc7-08d4576d9940
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;3:n77wpd8SjE14pQop+1xop3cN3Dfqj10FytkVSLUkHYmB3g1PvM6JjH42IRoFC0e9p/17QqEZkHqf+tjFkPKnOfnDlU6Lm2OrjpLKLu5SNFfbp5EFXbQ9IwW0qes0jrBkYEJjp0tONk/qZz5JeCFop7mOrGVMXhAxmdgxYxDwXvRpiI29sDtRibqDITjHJmKTnsNYR02HSA9bkX5l3Ml6KTB7UBMhINDoYPItqrlpGHFAusmiISkemudO6Lg9vSMouAOZeFPvOBz1KFghcb741g==;25:30aR6Xc8t/KeZ+Q5x/QfYnGBMRAbcdtiCJXy7pl6zqOK6YcTfShVdUXY4M+utghLL1T2lEhmMJJl7cmeMXKT8F+1h7uHDCXX4/BAXZTY0JLRYZUftPSSbuyNjWBD1vQcIhkKVAAqN/tbzu9EMqx982h0MaQfR+OefGhOAXOue/b8YGV86YDaAjEcnfQi4ul1o4/jBdEomxCQXX6B76Q7PelCZ2k/db9QTGA06797NaAv1yGqDWQXE34FOGVDvtAJ4kRJuFP4HNWkvNTZcsndMaEt0uytnbqNoFA1fxW7ZPOovm+jroIoYrKdI/xyOJLRAxXSjV+9kgC52y5tSxha8hTfYXrlhwiCYqM5UOxHegtX5nVxyWnooLJO6+9pmQFZM4yH7DrD6t9gJsGhtUy6852qD/X7yU12dI4TZh9hQPqi/iIbHFzjMkzdrUCpBeo8gz4v+YwSeW45bSWUW79J8A==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;31:7aXdy8fvD/2nxXpeJVN1MRKIRHlEcTVAu67Cry60KnPfqsT78FeN37K6FyjYrchQG/sGeOUXldzxMyzUMAyGBvg1QRg0lUJ8RnlAfyHEQ3X6pyZzAWlRl9AkxFhgiZvnjWlCGWGiXddfv+c6K7m2YVAux5/zu9eAXN6tVCGeXHY4c8OQLTJ65MZn2eBeloLn6WjtDHwuxyhkBNprMIOVGI5VYNgrpZXgBzthjVVW8667GXOhihQDXv9cX0s0Xu5o;20:ZDpvKwXMVdQqXUqzgcd1Ifvxi6pgJkj8ngyd2LGiV8HIbjjf4rXEbvDkNnLDeWaO+swyxVSTZjNXw/qsJ0OcGmwEK3rnBfoMMw8PXlHz5Ms7xdQm2kr0CF1eSAaCp+4IY21JXZNZrO8XE+SZmnbDHh8lA/dS4pVKYEfBRiC+3W5zCKJhXcUxy2hcoUO0hkTFa6HW2XNQTZNG3qiS32a1w5xruDMgKzPFu1ZSw/q8WyrJac7pZjVfK2rOskbaO6QeYS8KCOtkG4Avc5z9GAqByz5+4FLslSspUFl5nXuQTLeKO9obIDFGwQEoyiWNpl7zoeM7WlbCZNDeEk1QJ6dk7ErFMtBtKPcibTXKzNDHtgmvolvSRiCmZbjWBviWK3gdO7ONgn4AkIzD4veDqQlVjzZXDTF+tpS+k02dKYQE1xWgv+GOCU4RJyBAQ8yZybAJKSZxOhqWMyDPH0D9+634MYMdpvshcmLS4K1Yvqd9QUbP5qd8VHxjZarSzop+qVaQ
X-Microsoft-Antispam-PRVS: <CY1PR0701MB19775926D901DC07854B8019975D0@CY1PR0701MB1977.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123564025)(20161123560025)(20161123558025)(20161123562025)(20161123555025)(6072148);SRVR:CY1PR0701MB1977;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;4:WKnk4UUk2RETzV8jhuuhVY3025qtcQPyj7bF7TziccYnsrY2N9j9kNgakPhzy0CqIEGgJ03Kh68wzSgqFSerDjQiT2fpy0yK9onXbYC2vzTCOOlCsWQK14P0sR3MwGtAi9GqQSt3SqzNhhT9s90pFBc1hOUd+u/Hqs8XSr9FbZszrUDRIaOHYbZUcfhID/e3pic7dERHe0Uof6AoB713ipnZ1vOoDC+FDO0jtmuxgxVTd3EG3yrWaIDf7LfdouZVwnAlpT7HGhgewdnUKrDK6Na4QkCGt2KOgXgCjtPYhFUw2QsEuVn2PLBz7EHcYvtQpLSoWBQDBVZGejEtkND8Btm1v4S93wPcAzWRgyqU0lVpcAhnAmGS75ZuvDlyNfqvFyn5eN5Yg+oqI5cigWdoycvSUuBGTmA/FbV12aatT88oNXGT/nZzTP9CUOy5bKLyntXNXYZCrkhgCNN7ZMrMoZ9DuzxHabkUDkHNhdztn+mgmTHhrwgG9wdZtkTY8eByY/uyZypRhrF46ojy0aEamkdbY3VEw3P/f+H7TJ6dpK8z1HpScdWFQAKTGGL3g5CSGdQZUc3SOdbIPrOGCwRldTEGCpTIKFV/W9EoSGi2dTc=
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(199003)(8676002)(105586002)(36756003)(50226002)(6666003)(106356001)(69596002)(53416004)(575784001)(6512007)(66066001)(101416001)(6916009)(5003940100001)(6486002)(81166006)(2906002)(4326007)(6506006)(47776003)(25786008)(54906002)(38730400002)(48376002)(189998001)(33646002)(86362001)(97736004)(6116002)(50986999)(81156014)(1076002)(5660300001)(42186005)(7736002)(92566002)(3846002)(50466002)(53936002)(305945005)(110136004)(68736007)(107886003)(15760500002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1977;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1977;23:WOg83HSA8O2d2yq/7/y9KKDtt/QW8NR5Rap6CqG?=
 =?us-ascii?Q?bYBQA6byNAInFxB+4xwv6rXC14jEryhZRa/9owT6Y9sjRie5Jety5tiXWNRw?=
 =?us-ascii?Q?Ph8+WXL6Zf6qb26bNnZkqaypx9gM8bTEGkjjIVGGOM74RyxUWHyM8Rtu3qvq?=
 =?us-ascii?Q?y2wt5QFMrn+0fNh0PJtGnjimeU00I3ynuC3PCHM/18lYAoHwHcmmpklOhK9M?=
 =?us-ascii?Q?sj8ChBOUb4M6n9EZ4g7tw5BkYittu6N1ue/oAUjU28PH1lJ7flYn7NOWCMup?=
 =?us-ascii?Q?l/Li+cOalxs2AHQkZnZokkgR9GKojLIfBzmynLPuqHrDn4UAOWaEaBM+a5rh?=
 =?us-ascii?Q?mj7wSJQdBYkWXjxTNuJ9PoLZqMTX8O1HmD8YHhZQ23BLs8+MDxYRgYSYX7Re?=
 =?us-ascii?Q?sEU9TdzpLNPbEGUHcAO5nWPCc+BqOIvZOBI2559p/JxLxv+RNiP2qFhJ1axS?=
 =?us-ascii?Q?ZH48cBq+tvza/SSzg2KpCO4Gh5F2ieRFzIkcWQahvgYbYP2Dd4CEg3iw/+ty?=
 =?us-ascii?Q?M6VCc+sddfpwelrjpE3LM8KrKLTofC+T81/KKR9O70E1KA8jSNcqz/TuEyOG?=
 =?us-ascii?Q?z42Vn3mSAkE+w0Gpt9EKhZlNn9gdIv1+TeVoOxy5Kc8UqPM5wBGLtIXyLA1z?=
 =?us-ascii?Q?gRSBAIY22zp3IvWcZBpY6xmEGeh/DRIAHRTlVXB6ZkpygKL0p6l5qf7vK/G8?=
 =?us-ascii?Q?ceDwdjptw7kKGW+nKlUlV3X2nkK8Ziwt4NEUuZ/4h2KkTBryymoJ3P5BAFva?=
 =?us-ascii?Q?J3CywnIz9cxW/VZ8m2JviTkW+jKOzsTW2aWxmFtaUwpSQAiZHnZmeEw2gA6Y?=
 =?us-ascii?Q?FsW6j44Ow8H9Q5wymoNRm4n0mwFCfJSMB+Bx4vLbeTYHz8jAoinQuCE6NsaI?=
 =?us-ascii?Q?paFdLrwQAml5nqN59StHpFYsy4OhcIRwVxdIVJLN1v6F2TuKwLc0a+lKoBVH?=
 =?us-ascii?Q?cFUE998S7KNISSJvsyJI53THUSYvDf6iyp2oy41LtZcp/qAeqn1JaI/VsWtZ?=
 =?us-ascii?Q?5kRhxCQuTxNdkMSe0Prcynw4eXog2o7LXDyctRkLRGmR0+FN7hX9Z9OzU+DL?=
 =?us-ascii?Q?RGopqCtxk0exuhRS6G3ebGTyZWAvr0Z1AChCYwOQErUCBNRL2mkgfo+xo0Oy?=
 =?us-ascii?Q?Hmu3TthXHbp3ztpWHIZIYwNG+frDwksOtWZYYjlUBptn6BexzbD86gZ013N8?=
 =?us-ascii?Q?ARXvYJa6bSjwFovkMxz7ENmjHTWd0CaoDW48v?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;6:S9fXjt4dIGmHEufyWw0W1Uhh0CNVxKxynqZcV0ntqpV3ipVupnd5tOBednfo24wi+LHjbU5oa4Sycrz6x2Pwc5SaCRP/yvmRa0jjSfHfd10ysOoudoJ4N+Hb6epqdJf0MNswLcborLIDgiMxBwnaMF5ihPVg/zMKHD/EVMLDDK74Ghzp8Tmq1qfU5jURyYR/2wcAME+dgVvrv00G3FFxrVwsgnbtaR2PT8+QFUKEJpCDTut4gqSRPYThCyMAe3B6MwHc/LzvwIQUHzA3ZNgwFAyyCnEKeLZtRgSmPO1V515FsvLwmEADY6FwQwRUvRHv0HScIdJ+46b3yZhmvce+i2ENGluK8AAb+ftt3fWDFK+KLcaaDV65wSxqlPY8uRwnKlpF1O5vXLuMG/1Ta4UlOw==;5:jFw3G6RKFANH6HAX8P+EDl8XRJVJyzwUQUciaCcbdK6m/wmkL0EfVjB9ezgp5jdPCwMm5AsXwYuwARV8jZCWswhvPKwaR7C0em5KpzY7NKiP/WWhJzsBg3GdVUZxf+KNafWc4yxidPwXxoppQNZ0nw==;24:tTJjqoE/5CEGLHNW67G+H6NLDDVMJ/iGSWt1/3C+Un5xGQfri3KHqlpwd1iFgG7NglIwH0C4bn1h7Mb0J77VSzckosNhbbHEabAdXhCn+es=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;7:+lK9vuk5hMlf91BvpFXMF3qsWYSGrQrfqXxagbJR+vhOEc9XAIferfkonsT7jgOiwdVu/8hCA1nrk5lloct9K9Z6pi4n8AEVjZWp2WDka6jE461bnX9H7xaNMu3NWaq6NU+Xj+fvkdE7wDMlMCPvMLOGQLU86BUxTyAQxsLRO+VaaIiWd/6tdKX++DO6IXKla+Tm5fXbeetUaER8pd8kQCa5j9VrxK6nPuDoJN3hC2NXRHTit3MHqQi8LRpsgTyI/7O20DqPje6UlZgvjXH5Tr+Pl1PvI9L898sSaL2dwfaAhscCUS59CSWZkGEyft+0F/1Vx6o/lBv0IUBtQPiLbQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2017 19:45:59.5149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1977
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

This config option never really worked, and has bit-rotted to the
point of being completely useless.  Remove it completely.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig  |  9 ---------
 arch/mips/cavium-octeon/Platform |  4 ----
 arch/mips/cavium-octeon/setup.c  | 12 +-----------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index c370426..5c0b562 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -25,15 +25,6 @@ endif # CPU_CAVIUM_OCTEON
 
 if CAVIUM_OCTEON_SOC
 
-config CAVIUM_OCTEON_2ND_KERNEL
-	bool "Build the kernel to be used as a 2nd kernel on the same chip"
-	default "n"
-	help
-	  This option configures this kernel to be linked at a different
-	  address and use the 2nd uart for output. This allows a kernel built
-	  with this option to be run at the same time as one built without this
-	  option.
-
 config CAVIUM_OCTEON_LOCK_L2
 	bool "Lock often used kernel code in the L2"
 	default "y"
diff --git a/arch/mips/cavium-octeon/Platform b/arch/mips/cavium-octeon/Platform
index 8a301cb..45be853 100644
--- a/arch/mips/cavium-octeon/Platform
+++ b/arch/mips/cavium-octeon/Platform
@@ -4,8 +4,4 @@
 platform-$(CONFIG_CAVIUM_OCTEON_SOC)	+= cavium-octeon/
 cflags-$(CONFIG_CAVIUM_OCTEON_SOC)	+=				\
 		-I$(srctree)/arch/mips/include/asm/mach-cavium-octeon
-ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
-load-$(CONFIG_CAVIUM_OCTEON_SOC)	+= 0xffffffff84100000
-else
 load-$(CONFIG_CAVIUM_OCTEON_SOC)	+= 0xffffffff81100000
-endif
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 9a2db1c..33fe437 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -374,14 +374,8 @@ void octeon_write_lcd(const char *s)
  */
 int octeon_get_boot_uart(void)
 {
-	int uart;
-#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
-	uart = 1;
-#else
-	uart = (octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_CONSOLE_UART1) ?
+	return (octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_CONSOLE_UART1) ?
 		1 : 0;
-#endif
-	return uart;
 }
 
 /**
@@ -901,14 +895,10 @@ void __init prom_init(void)
 	}
 
 	if (strstr(arcs_cmdline, "console=") == NULL) {
-#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
-		strcat(arcs_cmdline, " console=ttyS0,115200");
-#else
 		if (octeon_uart == 1)
 			strcat(arcs_cmdline, " console=ttyS1,115200");
 		else
 			strcat(arcs_cmdline, " console=ttyS0,115200");
-#endif
 	}
 
 	mips_hpt_frequency = octeon_get_clock_rate();
-- 
2.9.3
