Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:38:09 +0100 (CET)
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:2752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993103AbdKBAgyRPffm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ppa3RHk6GaWC96XywCXu84rWxnEGPHIK640uMd5r5+E=;
 b=ZPBXfh69wtog0ISM7Udgx3KGM9W4SQW2Uuyyvn2ApwE1GfFkJiaU6DHliTe7q3KLkM7ji0y1PsnBNHu+zE0MbucWSSi7qCEN0i2AqEZAmGX5hYlEZC7wMX0QXyiTS+G1zkBAjzmnJoZTOfE7OH+7W6Tas9+3VHuXOx9utnTq6j0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:36 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Date:   Wed,  1 Nov 2017 17:36:03 -0700
Message-Id: <20171102003606.19913-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c21cc34-4e56-4262-b3b8-08d52189c9f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:tCNfsVrDzqKiYKM9CVJATzKGX3VBFUK1Nb1afb1tNtmMWW2eNJd4pnDStXoFoZt085cKRxhXwnXAgGsfz45gvhEFhj6zxZsLCh8jAHSarP7aSls52fHsXIALKdqoOeqPJUaYAUnGk34zk2dSF/sD81f+Yt1Hq2zdREMiL7xCmkavauAMkZqmIQYlF/RMIQRIC06kg3u0PTu1mbUQ3etPKg3DGdtUnpWny1UHnYv1u+yY74Qb3RP/0GxfyCcNRoxf;25:CDsBcQLQa7Uowd1gwUDnXWtsL0uC/Az5L0rooomqj5YyAI94pk8kjxvRUM+WSgQVXwvJgQg8KRrRgqzXXj6GLzKiJbqP4EkyYZ6hhsuE5Y59Iz/G3SQlPLeY4bXJsw44LcvZg6CgQmpSjLlK0uHxEmchHqguh7APxD7OTb22g/dEqN2JvQ0gEmZ5oelozIMuh3nWdkwCfAqNKbWDSJ+VhqGUnzBEzQMjm6WQ+dww/J6DrowLv+FmVpjjPJdrMAxHi3sFM6jQwhi4909FGpicc6wFKFSn97nQovRF4gstAUTG9+J3xvnG3IdeM8R6qtWCWhn/ypx4qFRPCE29Wt6Reg==;31:EmD241meJGrAIqhgfx+kx1ixhEa+v/gqAZpXAPg4AOlB3qviidpwbr2N36iO2BuktIpQ8du7TVM0bwUol/5tbp2I80j6dgULxU7LssMcCw8sPm5icO1I3Y/ofG0ZMKFAHFaJxxflm9BKKZ/PT8AqywIuAss/wYiOC93D6sfN7AiaHUzg+WHrLTCu4UH0bsCEN16igQkqczpqSVeb4cVCRySBvUBttfBMh0/ThWquOVk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:KXnM3XvadwUR3KDBuFHe96MTePcofZUd0YlG7bvBPNXWQruYvW4Bk/FnZ+TXAZd+yxDkYn+/NWIMWWxXjnwnzHVDCvzhTujBTtBHZSj4OhhzBbmud0zW2E1XRD6Y3P0a2n4vHY7d76zhGKhIULOGU2AiOPBAFANBijikT3LhNgAWwAcCFa/+yGGIh1MeMpqecF1B9AeI5DAvuUGjkuE50eZFyl0cuVvnhY1309ok49obMbhgGhgMuE3LU1np0WYt/VcS4ugiR4ZuIPy3qOr/ldOON5D7p0l/DCymPlobDZ367nsDcaTu1sMMoVql/pSR4DhaJIaI0ryb9Ubju2kMsjcEHmjxI3RTDicqDLvBqdwZD/Jqk0wMyniboZbDmxYzUSt9DgPtwGV4xA0r8flHbZ/s01/1yCGN4OAbNm0iSGJroOjf7OTYnuRC6E9+iLg3iMQFzV/b9NN53YJyea9aqsjSFa/PvQ0bk4ZtSgI6jQfK77SGSvjP3Er0+UiafkDO;4:0evc87d8tYIyi2FnefH+cTjcDMTkzKTpAUu2fGJrUWy6XAqO5pxEQhnnD0IQcK/rnSClNsXN5z3MMGxkZWZTXbJHk+hQK6xf32010OrpztIYmSTdNpT+GYXk6xqeZXo8uTR5HzQ1v5aJRa5FM2XiHBzu0K266Z8xOTsH+ImxXoX4QUtZExK5Ho004y385qaNMGtSvwmpe0TKmt434QCC+oT6UFqdU387bmLCKRh5rFkz/OscTJ7CPxTl6NPgtrCyvRvG2v/NT2s+Wey7XnL40Q==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496E178C24AA2B35B548073975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(76176999)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(575784001)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:pCiMlvY189rGv6hXzpavDHb07KfrzdJ9Zgn6qUJuf?=
 =?us-ascii?Q?WvPO7ZyBQFJykwf7ey/s0YJbWF2lYoFRMJXKIJKemlzFDPHet57mq5mRbj4E?=
 =?us-ascii?Q?oiFI844290qecZSEAyJhvYxc/YXRCY+RpnU/7xm5+1dfowIeW25BVbf6YLbM?=
 =?us-ascii?Q?C1zlHS/GxgZ83JEp8H6e6k6CIzTsmnSbwLqkxx5668F9zLlsx8kJ4xpwLTaj?=
 =?us-ascii?Q?qno1V4n/INI/LwGbVXU3fBYEHnnUQpRnX9CBQWN49i2oLfsBHVids+cmYZMl?=
 =?us-ascii?Q?91szTTePaJJMAXymrSwbBCQuUt9U5n8KclO+ZLBxcRny2o+bMe+DEyQABQnB?=
 =?us-ascii?Q?iYfA0qRGTjJIuIJpGQEn0yWSvVhmnS+Fjuus6Q9OTCrz+OsKTrdgZNZI9TWn?=
 =?us-ascii?Q?uMaCY0fLdd1ZVbMERCKY6n9i6rG8UQJ7uo8uE8Xfg33pKDB1r+h3uKAOiFFu?=
 =?us-ascii?Q?+MvG1dGblJ/d3qJd8YSAMg9xSuWmNS2IMSynaJxJwneJ68VQxXyhYME5VIzs?=
 =?us-ascii?Q?i3l+B+X5EaAJxPzCHL/RCRga7aa8wGcS4zgE5CwrdRVfy6amC9jH5CPEVKuV?=
 =?us-ascii?Q?j0YVLqPBelS5Uo50Dg5rb7C8rV6/kv7SuwqKX52cIrHLUW7n/FP/1CKuYG/X?=
 =?us-ascii?Q?27rNMslWfP7n0nmyaD/qPwd/zoOsmuygxNxrGltYzull/pERTG02PBHyhSfj?=
 =?us-ascii?Q?hLm9eYmdocS3MITN3lLKMogTeV5F60SI9KbqBBF3oBmQ5swT7LZb97atExMN?=
 =?us-ascii?Q?gFbDx+YcK10b/eLINBycS9TJt3THuc7JcD2zEGT22F/Q6kBSK4JdTxobUoop?=
 =?us-ascii?Q?zl6VJzEoR5H24EPoDToN6SThEob+OiBedvscaZDoW4i43bW3jAdjVRYjzVoK?=
 =?us-ascii?Q?RHPnUgnHLK/7HX/1ZG+NX70LfGk7hyyGK+GX3PbsbOULOK8b8eVp+5sLFyBV?=
 =?us-ascii?Q?vmREtivsowkeYBAqicC9h/Qa9m33WdM/vto/mApJb1KTtyEzcfnPqSZhX5Jz?=
 =?us-ascii?Q?WO3xKSm6OTVzRSShfVEn4P1xZe/n3eeHgRq1MIOE5dUNp62g4tvy0sLqqlAB?=
 =?us-ascii?Q?dI3USmZq6iymP6L48xbFplKBpEzAbjaGuSAl9bMHQM0+CvI101WlCE8IRuCp?=
 =?us-ascii?Q?rrtJLeIF6M1sYO1fln6EQzz2VnsQ97FXhtH03hdhStA1F+Ducli84qH4Wjyz?=
 =?us-ascii?Q?E1TtpMPV2JLzyq947OkvNN+TYRAcvaUasH7?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:H5Y3itDSTydKqnWwY6xlqEF0JfTdtf/qXd2mKqDD/hnDQp18EUudEfhZSSpx+ukixPZKF0okYk9lQYyPWwm9Lk+/gIsNPGsah32+ZroJNpIxRRwWXlBvrCx4wJbKOtQWvj3Bidn86AxvWajsmXte0fYtGmNIQUeA0dyJq7JyQrmLPwCjmDm3bwUx1b0ZfsWaibc9KWdMViz47YYalHyFBbMxSEfxDoH9WAJ2o95kNtVCGvBJOmKeS8Ecvl66rL5Vea7FIK2v2PhAfDhfP6mDIYYNAViOvLzq2AJKYAX06rk4hacY8xT9MVD56lHIl9KZoBiXg08ySBElEdMmndw9+LQUccRDXJHLwB+rioJMgik=;5:C3FNBDqSUQzunV3GtsB2x5MMpIMTpptxev290xG4o9o3cueyvr1AGnwd7sq9bRKAVpPKKZgOKbMzNyHJIvv383Z5b/UsvjGV6wGcFPf8gBWGcWqQF71QCEMfgG52F8/WwQYlGu9xF1W/BMFYySDrMo805T+tJd37fycMl0gYRWI=;24:AIyP7EKNJVRzgySCMlpZZ9cvdFaVhwUQYLL3AX7NrPAVRgUTpclRQzrdtOCoQQU3DhSl6kJjHHI3z4mJDSI5iU/NkwtK53np72l0kB6uguQ=;7:7VYO085OOKyv4rwzLlkyDO+rCKtp9fmGOPntZaLRM0E5R32QYRdl3s4H9uTbYlv2bYmCZU5G7edx1GNPRRbEfcgOrb33bN3IW4d7yIwg0wD9cJ9gnifcIx3Saa7HvirLcN1lIIWp7KtyGTHVtPr5+XYvXN5Y1NuGx16ID72y1cQ+qPtlFcwy8r9QK33t2SM6rScyf4r74ZnyH4EoU71ZaO0sp1VXsJBOD8dQMQK2E1eW8Q+R3zO1KMBKbTxlZg0B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:36.6013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c21cc34-4e56-4262-b3b8-08d52189c9f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60649
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

From: Carlos Munoz <cmunoz@cavium.com>

From the hardware user manual: "The FPA is a unit that maintains
pools of pointers to free L2/DRAM memory. To provide QoS, the pools
are referenced indirectly through 1024 auras. Both core software
and hardware units allocate and free pointers."

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig       |  10 +
 arch/mips/cavium-octeon/Makefile      |   1 +
 arch/mips/cavium-octeon/octeon-fpa3.c | 363 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h |  15 ++
 4 files changed, 389 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/octeon-fpa3.c

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 5c0b56203bae..211ef5b57214 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -86,4 +86,14 @@ config OCTEON_ILM
 	  To compile this driver as a module, choose M here.  The module
 	  will be called octeon-ilm
 
+config OCTEON_FPA3
+	tristate "Octeon III fpa driver"
+	default "n"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This option enables a Octeon III driver for the Free Pool Unit (FPA).
+	  The FPA is a hardware unit that manages pools of pointers to free
+	  L2/DRAM memory. This driver provides an interface to reserve,
+	  initialize, and fill fpa pools.
+
 endif # CAVIUM_OCTEON_SOC
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 0a299ab8719f..0ef967399702 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
 obj-$(CONFIG_USB)		      += octeon-usb.o
+obj-$(CONFIG_OCTEON_FPA3)	      += octeon-fpa3.o
diff --git a/arch/mips/cavium-octeon/octeon-fpa3.c b/arch/mips/cavium-octeon/octeon-fpa3.c
new file mode 100644
index 000000000000..65e8081b6a3b
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-fpa3.c
@@ -0,0 +1,363 @@
+/*
+ * Driver for the Octeon III Free Pool Unit (fpa).
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015-2017 Cavium, Inc.
+ */
+
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+
+
+/* Registers are accessed via xkphys */
+#define SET_XKPHYS			(1ull << 63)
+#define NODE_OFFSET			0x1000000000ull
+#define SET_NODE(node)			((node) * NODE_OFFSET)
+
+#define FPA_BASE			0x1280000000000ull
+#define SET_FPA_BASE(node)		(SET_XKPHYS + SET_NODE(node) + FPA_BASE)
+
+#define FPA_GEN_CFG(n)			(SET_FPA_BASE(n)           + 0x00000050)
+
+#define FPA_POOLX_CFG(n, p)		(SET_FPA_BASE(n) + (p<<3)  + 0x10000000)
+#define FPA_POOLX_START_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10500000)
+#define FPA_POOLX_END_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10600000)
+#define FPA_POOLX_STACK_BASE(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10700000)
+#define FPA_POOLX_STACK_END(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10800000)
+#define FPA_POOLX_STACK_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10900000)
+
+#define FPA_AURAX_POOL(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20000000)
+#define FPA_AURAX_CFG(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20100000)
+#define FPA_AURAX_CNT(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20200000)
+#define FPA_AURAX_CNT_LIMIT(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20400000)
+#define FPA_AURAX_CNT_THRESHOLD(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20500000)
+#define FPA_AURAX_POOL_LEVELS(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20700000)
+#define FPA_AURAX_CNT_LEVELS(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20800000)
+
+static inline u64 oct_csr_read(u64 addr)
+{
+	return __raw_readq((void __iomem *)addr);
+}
+
+static inline void oct_csr_write(u64 data, u64 addr)
+{
+	__raw_writeq(data, (void __iomem *)addr);
+}
+
+static DEFINE_MUTEX(octeon_fpa3_lock);
+
+static int get_num_pools(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 64;
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) || OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 32;
+	return 0;
+}
+
+static int get_num_auras(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 1024;
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) || OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 512;
+	return 0;
+}
+
+/**
+ * octeon_fpa3_init - Initialize the fpa to default values.
+ * @node: Node of fpa to initialize.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_init(int node)
+{
+	static bool init_done[2];
+	u64 data;
+	int aura_cnt, i;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	if (init_done[node])
+		goto done;
+
+	aura_cnt = get_num_auras();
+	for (i = 0; i < aura_cnt; i++) {
+		oct_csr_write(0x100000000ull, FPA_AURAX_CNT(node, i));
+		oct_csr_write(0xfffffffffull, FPA_AURAX_CNT_LIMIT(node, i));
+		oct_csr_write(0xffffffffeull, FPA_AURAX_CNT_THRESHOLD(node, i));
+	}
+
+	data = oct_csr_read(FPA_GEN_CFG(node));
+	data &= ~GENMASK_ULL(9, 4);
+	data |= 3 << 4;
+	oct_csr_write(data, FPA_GEN_CFG(node));
+
+	init_done[node] = 1;
+ done:
+	mutex_unlock(&octeon_fpa3_lock);
+	return 0;
+}
+EXPORT_SYMBOL(octeon_fpa3_init);
+
+/**
+ * octeon_fpa3_pool_init - Initialize a pool.
+ * @node: Node to initialize pool on.
+ * @pool_num: Requested pool number (-1 for don't care).
+ * @pool: Updated with the initialized pool number.
+ * @pool_stack: Updated with the base of the memory allocated for the pool
+ *		stack.
+ * @num_ptrs: Number of pointers to allocated on the stack.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_pool_init(int node, int pool_num, int *pool, void **pool_stack, int num_ptrs)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	u64 pool_stack_start, pool_stack_end, data;
+	int stack_size, rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_pool", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, get_num_pools());
+	*pool = res_mgr_alloc(tag, pool_num, true);
+	if (*pool < 0) {
+		rc = -ENODEV;
+		goto error;
+	}
+
+	oct_csr_write(0, FPA_POOLX_CFG(node, *pool));
+	oct_csr_write(128, FPA_POOLX_START_ADDR(node, *pool));
+	oct_csr_write(GENMASK_ULL(41, 7), FPA_POOLX_END_ADDR(node, *pool));
+
+	stack_size = (DIV_ROUND_UP(num_ptrs, 29) + 1) * 128;
+	*pool_stack = kmalloc_node(stack_size, GFP_KERNEL, node);
+	if (!*pool_stack) {
+		pr_err("Failed to allocate pool stack memory pool=%d\n",
+		       pool_num);
+		rc = -ENOMEM;
+		goto error_stack;
+	}
+
+	pool_stack_start = virt_to_phys(*pool_stack);
+	pool_stack_end = round_down(pool_stack_start + stack_size, 128);
+	pool_stack_start = round_up(pool_stack_start, 128);
+	oct_csr_write(pool_stack_start, FPA_POOLX_STACK_BASE(node, *pool));
+	oct_csr_write(pool_stack_start, FPA_POOLX_STACK_ADDR(node, *pool));
+	oct_csr_write(pool_stack_end, FPA_POOLX_STACK_END(node, *pool));
+
+	data = (2 << 3) | BIT(0);
+	oct_csr_write(data, FPA_POOLX_CFG(node, *pool));
+
+	mutex_unlock(&octeon_fpa3_lock);
+	return 0;
+
+error_stack:
+	res_mgr_free(tag, *pool);
+error:
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_pool_init);
+
+/**
+ * octeon_fpa3_release_pool - Release a pool.
+ * @node: Node pool is on.
+ * @pool: Pool to release.
+ */
+void octeon_fpa3_release_pool(int node, int pool)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_pool", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_free(tag, pool);
+
+	mutex_unlock(&octeon_fpa3_lock);
+}
+EXPORT_SYMBOL(octeon_fpa3_release_pool);
+
+/**
+ * octeon_fpa3_aura_init - Initialize an aura.
+ * @node: Node to initialize aura on.
+ * @pool: Pool the aura belongs to.
+ * @aura_num: Requested aura number (-1 for don't care).
+ * @aura: Updated with the initialized aura number.
+ * @num_bufs: Number of buffers in the aura.
+ * @limit: Limit for the aura.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_aura_init(int node, int pool, int aura_num, int *aura, int num_bufs, unsigned int limit)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	u64 data, shift;
+	unsigned int drop, pass;
+	int rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_aura", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, get_num_auras());
+	*aura = res_mgr_alloc(tag, aura_num, true);
+	if (*aura < 0) {
+		rc = -ENODEV;
+		goto error;
+	}
+
+	oct_csr_write(0, FPA_AURAX_CFG(node, *aura));
+
+	/* Allow twice the limit before saturation at zero */
+	limit *= 2;
+	data = limit;
+	oct_csr_write(data, FPA_AURAX_CNT_LIMIT(node, *aura));
+	oct_csr_write(data, FPA_AURAX_CNT(node, *aura));
+
+	oct_csr_write(pool, FPA_AURAX_POOL(node, *aura));
+
+	/* No per-pool RED/Drop */
+	oct_csr_write(0, FPA_AURAX_POOL_LEVELS(node, *aura));
+
+	shift = 0;
+	while ((limit >> shift) > 255)
+		shift++;
+
+	drop = (limit - num_bufs / 20) >> shift;	/* 95% */
+	pass = (limit - (num_bufs * 3) / 20) >> shift;	/* 85% */
+
+	/* Enable per aura RED/drop */
+	data = BIT(38) | (shift << 32) | (drop << 16) | (pass << 8);
+	oct_csr_write(data, FPA_AURAX_CNT_LEVELS(node, *aura));
+
+error:
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_aura_init);
+
+/**
+ * octeon_fpa3_release_aura - Release an aura.
+ * @node: Node to aura is on.
+ * @aura: Aura to release.
+ */
+void octeon_fpa3_release_aura(int node, int aura)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_aura", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_free(tag, aura);
+
+	mutex_unlock(&octeon_fpa3_lock);
+}
+EXPORT_SYMBOL(octeon_fpa3_release_aura);
+
+/**
+ * octeon_fpa3_alloc - Get a buffer from a aura's pool.
+ * @node: Node to free memory to.
+ * @aura: Aura to free memory to.
+ *
+ * Returns allocated buffer pointer if successful
+ * Returns NULL on error.
+ */
+void *octeon_fpa3_alloc(u64 node, int aura)
+{
+	u64 buf_phys, addr;
+	void *buf = NULL;
+
+	/* Buffer pointers are obtained using load operations */
+	addr = BIT(63) | BIT(48) | (0x29ull << 40) | (node << 36) |
+		(aura << 16);
+	buf_phys = *(u64 *)addr;
+
+	if (buf_phys)
+		buf = phys_to_virt(buf_phys);
+
+	return buf;
+}
+EXPORT_SYMBOL(octeon_fpa3_alloc);
+
+/**
+ * octeon_fpa3_free - Add a buffer back to the aura's pool.
+ * @node: Node to free memory to.
+ * @aura: Aura to free memory to.
+ * @buf: Address of buffer to free to the aura's pool.
+ */
+void octeon_fpa3_free(u64 node, int aura, const void *buf)
+{
+	u64 buf_phys, addr;
+
+	buf_phys = virt_to_phys(buf);
+
+	/* Make sure that any previous writes to memory go out before we free
+	 * this buffer. This also serves as a barrier to prevent GCC from
+	 * reordering operations to after the free.
+	 */
+	wmb();
+
+	/* Buffers are added to fpa pools using store operations */
+	addr = BIT(63) | BIT(48) | (0x29ull << 40) | (node << 36) | (aura << 16);
+	*(u64 *)addr = buf_phys;
+}
+EXPORT_SYMBOL(octeon_fpa3_free);
+
+/**
+ * octeon_fpa3_mem_fill - Add buffers to an aura.
+ * @node: Node to get memory from.
+ * @cache: Memory cache to allocate from.
+ * @aura: Aura to add buffers to.
+ * @num_bufs: Number of buffers to add to the aura.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_mem_fill(int node, struct kmem_cache *cache, int aura, int num_bufs)
+{
+	void *mem;
+	int i, rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	for (i = 0; i < num_bufs; i++) {
+		mem = kmem_cache_alloc_node(cache, GFP_KERNEL, node);
+		if (!mem) {
+			pr_err("Failed to allocate memory for aura=%d\n", aura);
+			rc = -ENOMEM;
+			break;
+		}
+		octeon_fpa3_free(node, aura, mem);
+	}
+
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_mem_fill);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cavium, Inc. Octeon III FPA manager.");
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 0411efdb465c..d184592e6515 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -10,6 +10,7 @@
 
 #include <asm/octeon/cvmx.h>
 #include <asm/bitfield.h>
+#include <linux/slab.h>
 
 extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
 						uint64_t alignment,
@@ -364,6 +365,20 @@ int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
 			int req_cnt, bool use_last_avail, int *inst);
 int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt);
 
+#if IS_ENABLED(CONFIG_OCTEON_FPA3)
+int octeon_fpa3_init(int node);
+int octeon_fpa3_pool_init(int node, int pool_num, int *pool, void **pool_stack,
+			  int num_ptrs);
+int octeon_fpa3_aura_init(int node, int pool, int aura_num, int *aura,
+			  int num_bufs, unsigned int limit);
+int octeon_fpa3_mem_fill(int node, struct kmem_cache *cache, int aura,
+			 int num_bufs);
+void octeon_fpa3_free(u64 node, int aura, const void *buf);
+void *octeon_fpa3_alloc(u64 node, int aura);
+void octeon_fpa3_release_pool(int node, int pool);
+void octeon_fpa3_release_aura(int node, int aura);
+#endif
+
 /**
  * Read a 32bit value from the Octeon NPI register space
  *
-- 
2.13.6
