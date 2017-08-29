Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:43:29 +0200 (CEST)
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:30302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995040AbdH2PnNHIkL1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aRFyHZEzxgl9DDJvCwLNn3XixqlDRLWIqeBlhnu220E=;
 b=Ug8ajsaTr6CsIr+C429j268T9nYCKMdDpmt9Gl4dYc9dTTyX9e/4fGRHwvAY3qcowqDfly/ChGrn5ufsrDnbhSZanx3J5Oxgr2a/dBqRP9f1RYanHHjBHCaW4sWdpWiGsMDKMb830iQumVWYNbXAsWPl4xRgyLP1fh4i/KjbPyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:54 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 1/8] MIPS: Octeon: Add support for accessing the boot vector.
Date:   Tue, 29 Aug 2017 10:40:31 -0500
Message-Id: <1504021238-3184-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b547e2e9-1cf2-4ec1-c1b1-08d4eef49dde
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:PVKhKjytCTDXcCRqy73YRDxlc2LNCeYzF/Ut82tW16P+23Hncj8nrXA3aCsT0VUHTT0okgNfJO/OYUPHEWZ/MCpk1w/Ke/ZnvE++AeGbCUc1cMW14HvmZFR2UvxDcr7kP449c4/GyajquInUkuGobk+X3Jaoo1oemVFY58lv8cDsUxZnok/tFW27ep9NZ4Z3rvlujFAMrf/KhJyhVn60EhPxGIeR1MR1M+tuY4s5tBGqe5ooGYL4lQ/dvhKKZjKV;25:JwT7KwIFaImLD8hIskaHkop2inUyknVih8Ab5KpXxx2UIfUzNJgIZB2xkVPd6lqg1G5e5NRJg1ZM3Rtk2NLhYtMM5moAUeylcsowToz76YZnMZX2wrDr0Rq1KGvJEwrdcvAnAXHwupaMuiugRYD2H+JTG2cIaCXMyZBX8/ehvH2H353NhkDZgnocRWvMX7GgfKGHyf3kOo+caSSIRVZxJxTP3c/YHickmq7uYEPX4IqnHks7la8+QxVdCckYVh6zb1ysV47DMsE2OfBFUOKtpE9Qa2v5yFUEafV9svnon/qHEOMfFIsUIQPXa7kLGUFl+pk72YgIprnQj1+9THVMsw==;31:E08pmmya85sn0Q38fZo+RlwqSOolQwuO3zbVWRdWjOriINnROFxPphPwMzRH87Na2hBl5seyJqxTY8/WmWiqG5DYAiJnb7I0IoeWoLm8R1REAMjbJ0BOizxcmjSpFOzeW4AZ+ueGl59uZ00Ue/+6OlUqqrF+QpXWNzNFRWZRv3xxXADeqXKJWNDRFM2B+UmO2ghJk4bGBWR+UOhiLWKDyFgCegkxM43emDxkC/Od/iU=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:WKXovi5bxXMFRWDQIESN8XhEUNKpu+Fr7004Qgh/Ybc3ntQ79OPZHiORxZ1KqOYzpEst68imVDCoNTGx3eJBqA8QQ2TtV9lu/B6CSXEkNRDW1TqmVmOZAuuVfzisWnBGtsZAh4DnyBvlo99XtjvLZtMVLltDAUAzJStgi7lpv4GKC9Dxm0UBOcCxIvz9iiTX0VqYOHSFhav10oncguR2YH6QOwaQY1horWi+6OvJUM9qfFV2SJwa5D5KThE5F7Lj5P+lrmii7W/od5GohQtRPQmjTmQ91fvpbDmbXxXaI8Y0PGVmmNJFn+XsyurCjrykg0TaTt8DGD1UBcvyJ6reZicP1dzniXJBh9CqmRQ+9LYfwRgMS5314430/nkBuFR6MjtL1tHcO/ldCpc4RXccwqdqWF4PCvLTuCrTXLdvwnxjXQdSu6llFLh8kUiArwgs1cNtEaGXiP5diEnz0bIzV/uKGu9RVXFjzsp94Hg4IHpGfp0clW8sJrl8bDzjL68u;4:4sT1PFbiPr2k0w/YOo087qKGze6lDc3Qjh3NFz/7r/Y+5kyhYUPgG20YMPNProXF5cDntzoh4B3rP68M/vhWBG7xXtOJoiEw+TWOxRLxqu9Qnc844nUzsNIsdY9BGRNDxCe27BIoKO2sgPbMa04o+XRM/FXjTlJILg7w3kDZ1BCwi758GDdYsBK9j14nbBMEH76nMKXsqBL+8ZPrNgRdxmjsTj+gNL4A6ifBKx9E28pTQyloHhI3u/q2/euUKyMe9kWqgeH5jilqYWRjx/4Kl+vCVs/Bpa/kAOZZHNcY+qQtgZ7VkLsTHKuKHFMiPXdN0mY0ysEJ5FY1vc6iaUS4Og==
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(131327999870524);
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803421F1C40E940848ABA65809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(979002)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(575784001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:UIN4sPxbnc2DFxffK12vDu/ndBEnOhhrd2N40rt?=
 =?us-ascii?Q?Gn74VkxZK96M91ylqaogiPownG/kYjXLq5Xssv0gyvXgTd9zp8qLUIKvGGl3?=
 =?us-ascii?Q?wvW15vFgZsxAWT8Oi+jfXrNpWk4xr7ROZ2y6CWESS6/S+ZkYQ+ssQTtTkWNj?=
 =?us-ascii?Q?dpvLirKhY4vlZLhz5reEdoenVgJ5uUHuQAYmzS5MQ/BgYW56qnuLA3Ua9MWr?=
 =?us-ascii?Q?EF+o7kEnqomWqUZ7Iuf16V2mgMIppMisOA1UQVF1qb/6a7aeqAhA9/o158Nq?=
 =?us-ascii?Q?K03gxWWzmSDMPKHntQGHlNgDaktRL3bNBmirdu+6eL8O3aHl15e2iGrHDwEn?=
 =?us-ascii?Q?HAu9yN1GtM400bHIQDUtCI5AXjTi1764ctpHf5I4ll7cX6khY3ldnPsSvwP+?=
 =?us-ascii?Q?x+IYOj9RAczxhv1ooyarwrK0YMvxa+TeqLf2bI8aH4JxVw7QmKGJNHP2n7ud?=
 =?us-ascii?Q?7MVR+onrbLfV30Drh/EhpDZxQJ7tDpXjGnBEkHd5qcS+3FdwywyD58SvRgx2?=
 =?us-ascii?Q?VqSWPhTcQMqcK03ROn6q1Au708QGONR8xEPzirU56xeygEm6SFzmH0B28YX2?=
 =?us-ascii?Q?DiBKvvyNm79SS0QZokU28lU/aCQ++LBuls2ZaRBMYACqPi1yVyfHXWFGu1oy?=
 =?us-ascii?Q?ON49eztUg7i1jlHg62gDSKjPTPGOpiHdPyxdyNvEGk2bgV7NW6bSGrENxNql?=
 =?us-ascii?Q?xFIEDMzx5XqyMXeA7B+gCySpSaC2pyUlke84cQJ+aJfiqglnWk8dIXPDxd2V?=
 =?us-ascii?Q?c9Ex+UJ/T9flQRvxvtJBpZzTbGkehSlg74FveHHb6Abuq9xoj+1AnDKWW31T?=
 =?us-ascii?Q?ft6h3aTfK2imODCCGQRMyDKN/S1pzNSTVi2V/3JmS0Y+k/10K/me+tnN0GjJ?=
 =?us-ascii?Q?JixzluPJnPWd2Qqrv4xTRluLLOMO69usIkiN0giQO+kZVm9YuWwT+aDa9xWR?=
 =?us-ascii?Q?rxiiX+D7LilI4LviSSSvwPMVXn/mxsmfTE92oGyFedAbtg0AevpMDu60pOEV?=
 =?us-ascii?Q?qQm8S4Q7UqHj31T22jYCpKm7UyM2YkTgCV60cWlGsoWWYRdG2UN831W3Edmk?=
 =?us-ascii?Q?u/H01lP3MWyNGRxsM744K97mWrVtrGP/smIzEw6lEABUfZr//IcEDf8/qXxy?=
 =?us-ascii?Q?BIpR8tpDjehb/f5ddMZvjN/9xgZtwM+gWxWGdeQb00/bMX1pmMcBXaudDDs3?=
 =?us-ascii?Q?FnZ4AnOSU1zmOilEI7pBjZxn29i9E0VIoNhklMWu/RglQ5Iz6lkEusX0YHQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:/yZ5/0eI4ijSwuU6QgVPydcLtfuzYMe/lfXC1sDy200wsWoVdHEyLsUBX7/kwYPsrbDfOhFDE6DZV7dH+uIpo4j3equDzi+eK+gF/aTpYB07ZMCm72T5AeBupwuTUNps5CyCwQcKPVvAppoURjmgsgZjLlPT1xdRSQmHukVQOVJTimpMCiUPa8EASQ+Os//++YeKbs9sJ4xM3zvQGKmzheX0VBXbVvcI2edtrSSeMb6sb6LKFJ7OJg4VIQf+IovRP2BpjgqPN2k9xgm7JfZVG6cRYyQASAhGi1F6+vtRq7fUPyd4CVYl8J1JXJ9qqFa7ErY0zbnn/A7/If/x7vO7zg==;5:GvBw9y9icCwPt0uhD1GVbJekiiEXZCSh7p9Ntewtb17bfRiW25R8AYl40mHSfPOKqhbIHCbxu15YqHaMJB/fTl6IdZe+kzfQLyqSywDR9Q0uPtbv/cv9GnFhRlG5pNKpz/l3rCcWa3rsxh+JIUIA0w==;24:ZyiYqjzN54egzBUJJ42DPZtV/gBK0zFelzO03soiIS+HSTMt3j1FmZwOknCBy9FPSdLKm03raoSCRtkK3w/4SMImnQP4cCaPRD66Rn55y38=;7:sczDDlv8b63bn/SndhHAGRloxB2cLAbiY3M+KDjzZF0Du96A9CNfUe0H3V4O8YYbk8DhKx8lBMjZdXVSRFBLdb3MUyFhGFTt6vTrdh3FWjfc5tTFDmCCWJ8LlcWm2YJ64hBiWDiuigMUFZbOmU/RzLgrvBQXwzFeWnirDnf8MfESwXM2G7460KPQZF5mx6lCaxMMTvav0c++hdzgk2Kf0BF0ZkLhkRko1kqf13kRPOE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:54.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59868
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

Used by the Octeon watchdog driver to get the address of the
firmware boot vector.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     | 167 +++++++++++++++++++++
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  85 +++++++++++
 arch/mips/include/asm/octeon/cvmx-boot-vector.h    |  53 +++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  28 ++++
 5 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-boot-vector.h

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index b6d6e84..50b4278 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -16,4 +16,4 @@ obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
 	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
 	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
 
-obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
+obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o cvmx-boot-vector.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
new file mode 100644
index 0000000..b7019d2
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-boot-vector.c
@@ -0,0 +1,167 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2017 Cavium, Inc.
+ */
+
+
+/*
+  We install this program at the bootvector:
+------------------------------------
+	.set noreorder
+	.set nomacro
+	.set noat
+reset_vector:
+	dmtc0	$k0, $31, 0	# Save $k0 to DESAVE
+	dmtc0	$k1, $31, 3	# Save $k1 to KScratch2
+
+	mfc0	$k0, $12, 0	# Status
+	mfc0	$k1, $15, 1	# Ebase
+
+	ori	$k0, 0x84	# Enable 64-bit addressing, set
+				# ERL (should already be set)
+	andi	$k1, 0x3ff	# mask out core ID
+
+	mtc0	$k0, $12, 0	# Status
+	sll	$k1, 5
+
+	lui	$k0, 0xbfc0
+	cache	17, 0($0)	# Core-14345, clear L1 Dcache virtual
+				# tags if the core hit an NMI
+
+	ld	$k0, 0x78($k0)	# k0 <- (bfc00078) pointer to the reset vector
+	synci	0($0)		# Invalidate ICache to get coherent
+				# view of target code.
+
+	daddu	$k0, $k0, $k1
+	nop
+
+	ld	$k0, 0($k0)	# k0 <- core specific target address
+	dmfc0	$k1, $31, 3	# Restore $k1 from KScratch2
+
+	beqz	$k0, wait_loop	# Spin in wait loop
+	nop
+
+	jr	$k0
+	nop
+
+	nop			# NOPs needed here to fill delay slots
+	nop			# on endian reversal of previous instructions
+
+wait_loop:
+	wait
+	nop
+
+	b	wait_loop
+	nop
+
+	nop
+	nop
+------------------------------------
+
+0000000000000000 <reset_vector>:
+   0:	40baf800	dmtc0	k0,c0_desave
+   4:	40bbf803	dmtc0	k1,c0_kscratch2
+
+   8:	401a6000	mfc0	k0,c0_status
+   c:	401b7801	mfc0	k1,c0_ebase
+
+  10:	375a0084	ori	k0,k0,0x84
+  14:	337b03ff	andi	k1,k1,0x3ff
+
+  18:	409a6000	mtc0	k0,c0_status
+  1c:	001bd940	sll	k1,k1,0x5
+
+  20:	3c1abfc0	lui	k0,0xbfc0
+  24:	bc110000	cache	0x11,0(zero)
+
+  28:	df5a0078	ld	k0,120(k0)
+  2c:	041f0000	synci	0(zero)
+
+  30:	035bd02d	daddu	k0,k0,k1
+  34:	00000000	nop
+
+  38:	df5a0000	ld	k0,0(k0)
+  3c:	403bf803	dmfc0	k1,c0_kscratch2
+
+  40:	13400005	beqz	k0,58 <wait_loop>
+  44:	00000000	nop
+
+  48:	03400008	jr	k0
+  4c:	00000000	nop
+
+  50:	00000000	nop
+  54:	00000000	nop
+
+0000000000000058 <wait_loop>:
+  58:	42000020	wait
+  5c:	00000000	nop
+
+  60:	1000fffd	b	58 <wait_loop>
+  64:	00000000	nop
+
+  68:	00000000	nop
+  6c:	00000000	nop
+
+ */
+
+#include <asm/octeon/cvmx-boot-vector.h>
+
+static unsigned long long _cvmx_bootvector_data[16] = {
+	0x40baf80040bbf803ull,  /* patch low order 8-bits if no KScratch*/
+	0x401a6000401b7801ull,
+	0x375a0084337b03ffull,
+	0x409a6000001bd940ull,
+	0x3c1abfc0bc110000ull,
+	0xdf5a0078041f0000ull,
+	0x035bd02d00000000ull,
+	0xdf5a0000403bf803ull,  /* patch low order 8-bits if no KScratch*/
+	0x1340000500000000ull,
+	0x0340000800000000ull,
+	0x0000000000000000ull,
+	0x4200002000000000ull,
+	0x1000fffd00000000ull,
+	0x0000000000000000ull,
+	OCTEON_BOOT_MOVEABLE_MAGIC1,
+	0 /* To be filled in with address of vector block*/
+};
+
+/* 2^10 CPUs */
+#define VECTOR_TABLE_SIZE (1024 * sizeof(struct cvmx_boot_vector_element))
+
+static void cvmx_boot_vector_init(void *mem)
+{
+	uint64_t kseg0_mem;
+	int i;
+
+	memset(mem, 0, VECTOR_TABLE_SIZE);
+	kseg0_mem = cvmx_ptr_to_phys(mem) | 0x8000000000000000ull;
+
+	for (i = 0; i < 15; i++) {
+		uint64_t v = _cvmx_bootvector_data[i];
+
+		if (OCTEON_IS_OCTEON1PLUS() && (i == 0 || i == 7))
+			v &= 0xffffffff00000000ull; /* KScratch not availble. */
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, v);
+	}
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, 15 * 8);
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, kseg0_mem);
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
+}
+
+/**
+ * Get a pointer to the per-core table of reset vector pointers
+ *
+ */
+struct cvmx_boot_vector_element *cvmx_boot_vector_get(void)
+{
+	struct cvmx_boot_vector_element *ret;
+
+	ret = cvmx_bootmem_alloc_named_range_once(VECTOR_TABLE_SIZE, 0,
+		(1ull << 32) - 1, 8, "__boot_vector1__", cvmx_boot_vector_init);
+	return ret;
+}
+EXPORT_SYMBOL(cvmx_boot_vector_get);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 8d54d77..94d97eb 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -44,6 +44,55 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 
 /* See header file for descriptions of functions */
 
+/**
+ * This macro returns the size of a member of a structure.
+ * Logically it is the same as "sizeof(s::field)" in C++, but
+ * C lacks the "::" operator.
+ */
+#define SIZEOF_FIELD(s, field) sizeof(((s *)NULL)->field)
+
+/**
+ * This macro returns a member of the
+ * cvmx_bootmem_named_block_desc_t structure. These members can't
+ * be directly addressed as they might be in memory not directly
+ * reachable. In the case where bootmem is compiled with
+ * LINUX_HOST, the structure itself might be located on a remote
+ * Octeon. The argument "field" is the member name of the
+ * cvmx_bootmem_named_block_desc_t to read. Regardless of the type
+ * of the field, the return type is always a uint64_t. The "addr"
+ * parameter is the physical address of the structure.
+ */
+#define CVMX_BOOTMEM_NAMED_GET_FIELD(addr, field)			\
+	__cvmx_bootmem_desc_get(addr,					\
+		offsetof(struct cvmx_bootmem_named_block_desc, field),	\
+		SIZEOF_FIELD(struct cvmx_bootmem_named_block_desc, field))
+
+/**
+ * This function is the implementation of the get macros defined
+ * for individual structure members. The argument are generated
+ * by the macros inorder to read only the needed memory.
+ *
+ * @param base   64bit physical address of the complete structure
+ * @param offset Offset from the beginning of the structure to the member being
+ *               accessed.
+ * @param size   Size of the structure member.
+ *
+ * @return Value of the structure member promoted into a uint64_t.
+ */
+static inline uint64_t __cvmx_bootmem_desc_get(uint64_t base, int offset,
+					       int size)
+{
+	base = (1ull << 63) | (base + offset);
+	switch (size) {
+	case 4:
+		return cvmx_read64_uint32(base);
+	case 8:
+		return cvmx_read64_uint64(base);
+	default:
+		return 0;
+	}
+}
+
 /*
  * Wrapper functions are provided for reading/writing the size and
  * next block values as these may not be directly addressible (in 32
@@ -98,6 +147,42 @@ void *cvmx_bootmem_alloc(uint64_t size, uint64_t alignment)
 	return cvmx_bootmem_alloc_range(size, alignment, 0, 0);
 }
 
+void *cvmx_bootmem_alloc_named_range_once(uint64_t size, uint64_t min_addr,
+					  uint64_t max_addr, uint64_t align,
+					  char *name,
+					  void (*init) (void *))
+{
+	int64_t addr;
+	void *ptr;
+	uint64_t named_block_desc_addr;
+
+	named_block_desc_addr = (uint64_t)
+		cvmx_bootmem_phy_named_block_find(name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (named_block_desc_addr) {
+		addr = CVMX_BOOTMEM_NAMED_GET_FIELD(named_block_desc_addr,
+						    base_addr);
+		return cvmx_phys_to_ptr(addr);
+	}
+
+	addr = cvmx_bootmem_phy_named_block_alloc(size, min_addr, max_addr,
+						  align, name,
+						  (uint32_t)CVMX_BOOTMEM_FLAG_NO_LOCKING);
+
+	if (addr < 0)
+		return NULL;
+	ptr = cvmx_phys_to_ptr(addr);
+
+	if (init)
+		init(ptr);
+	else
+		memset(ptr, 0, size);
+
+	return ptr;
+}
+EXPORT_SYMBOL(cvmx_bootmem_alloc_named_range_once);
+
 void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 				     uint64_t max_addr, uint64_t align,
 				     char *name)
diff --git a/arch/mips/include/asm/octeon/cvmx-boot-vector.h b/arch/mips/include/asm/octeon/cvmx-boot-vector.h
new file mode 100644
index 0000000..8db0824
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-boot-vector.h
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003-2017 Cavium, Inc.
+ */
+
+#ifndef __CVMX_BOOT_VECTOR_H__
+#define __CVMX_BOOT_VECTOR_H__
+
+#include <asm/octeon/octeon.h>
+
+/*
+ * The boot vector table is made up of an array of 1024 elements of
+ * struct cvmx_boot_vector_element.  There is one entry for each
+ * possible MIPS CPUNum, indexed by the CPUNum.
+ *
+ * Once cvmx_boot_vector_get() returns a non-NULL value (indicating
+ * success), NMI to a core will cause execution to transfer to the
+ * target_ptr location for that core's entry in the vector table.
+ *
+ * The struct cvmx_boot_vector_element fields app0, app1, and app2 can
+ * be used by the application that has set the target_ptr in any
+ * application specific manner, they are not touched by the vectoring
+ * code.
+ *
+ * The boot vector code clobbers the CP0_DESAVE register, and on
+ * OCTEON II and later CPUs also clobbers CP0_KScratch2.  All GP
+ * registers are preserved, except on pre-OCTEON II CPUs, where k1 is
+ * clobbered.
+ *
+ */
+
+
+/*
+ * Applications install the boot bus code in cvmx-boot-vector.c, which
+ * uses this magic:
+ */
+#define OCTEON_BOOT_MOVEABLE_MAGIC1 0xdb00110ad358eacdull
+
+struct cvmx_boot_vector_element {
+	/* kseg0 or xkphys address of target code. */
+	uint64_t target_ptr;
+	/* Three application specific arguments. */
+	uint64_t app0;
+	uint64_t app1;
+	uint64_t app2;
+};
+
+struct cvmx_boot_vector_element *cvmx_boot_vector_get(void);
+
+#endif /* __CVMX_BOOT_VECTOR_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 3745625..72d2e40 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -255,6 +255,34 @@ extern void *cvmx_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
 					    uint64_t max_addr, uint64_t align,
 					    char *name);
 
+/**
+ * Allocate if needed a block of memory from a specific range of the
+ * free list that was passed to the application by the bootloader, and
+ * assign it a name in the global named block table.  (part of the
+ * cvmx_bootmem_descriptor_t structure) Named blocks can later be
+ * freed.  If the requested name block is already allocated, return
+ * the pointer to block of memory.  If request cannot be satisfied
+ * within the address range specified, NULL is returned
+ *
+ * @param size   Size in bytes of block to allocate
+ * @param min_addr  minimum address of range
+ * @param max_addr  maximum address of range
+ * @param align  Alignment of memory to be allocated. (must be a power of 2)
+ * @param name   name of block - must be less than CVMX_BOOTMEM_NAME_LEN bytes
+ * @param init   Initialization function
+ *
+ * The initialization function is optional, if omitted the named block
+ * is initialized to all zeros when it is created, i.e. once.
+ *
+ * @return pointer to block of memory, NULL on error
+ */
+void *cvmx_bootmem_alloc_named_range_once(uint64_t size,
+					  uint64_t min_addr,
+					  uint64_t max_addr,
+					  uint64_t align,
+					  char *name,
+					  void (*init) (void *));
+
 extern int cvmx_bootmem_free_named(char *name);
 
 /**
-- 
2.1.4
