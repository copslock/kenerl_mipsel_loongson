Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:35:27 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992181AbdIOReCkSHTM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yiJ4Qa87uKUD6+7bY40su02qZjH+Cyy3e553/nG6+ZQ=;
 b=RbFl5WWI3hvoH0w1LUJ5DREEh1kD9B1eOMe+TeIWzoUd2N0tuueDwOAULb3tjYC+/4ohOtCG1E6VDeY6Vmz2QxeeK8SGynMlU57CQcJUWoT+WGuzf3YnsXXhHfAVlECF7v4JVFapOVS4hWwS0GKFcVH0J46rWJNfSR07e8P9IDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:53 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 04/11] MIPS: Octeon: Add support for accessing the boot vector.
Date:   Fri, 15 Sep 2017 12:30:06 -0500
Message-Id: <1505496613-27879-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f8b053-aa40-47e2-245b-08d4fc5fefc7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:LuyC/UyQXRB/8LlIDisQ1hP6fploiO/MtXPAv0xoekPt0/qc+o4/yE3EHNBNTBmeGVwiAn7td2kPdPgj2EfeexX6gEvzQU8XfRJ3aNzrZXGk1R5ddjP0bFr7E9oOySf/6rDL5m2xl6F8zYxtJl+7Z/8NQlBDcU9hQ4vavIJphX8/DPSjVpv7TGaD9GS/mJdTGGaVTMlB0Y1qdNSL0gHaIJfiDv8gEuExQtGtAqro7rqplJzREgkhMG1LsUK3CKYY;25:CjqJTyFaG7lSQz9rKyqTfPO4lBd2ng+IDQyxdDzmo2PD5sF7w+3OwlE6L9xgXCB0G7tJN96jKy52pM+bX9FHQZeOZcYISNYEEV2SASKPDG1mU8dVJeLpqoBcbJ6U45uhx5b08GRK7hnhgWpiEvMT/675Ab/C21k8btFTiDYHoWT6sP4DbXUNm+P6IZ0soTO67d6rU01fZ2fQuQOPekPEZajGOwhRh56TYH2SVBN9b415HRBR7xNX94vVzNOsw52CXeymI1flgI/klcEWmDMUYBi9WQQ7+tMzrPQ3q1wruZQUqz0XraWf/plAN6+RywAcD2kW5poEvrowVCVdma2woA==;31:HIfMC5FAuV/Z//RMy+Qm6fFXovu9PrsGOkteseGVw5BxawLVPOv9Y8HROPVl424lLdEw0LKqIjYv9Y1B9r9dvAqo2LkZmTbk6Fjo7eD2vfJYzsCrByLW03ZAAzUQf6TQRPHkZ5QC32M4XrWCGNKW08lEqrS8Ubcpv5Wl5xDfzPiuW24Mg89F0v6EowOfEw0GFnWYTO9bAaeU7y9sfS/VRKtDS1p9njqgB32UC2THIYw=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:rL1Mz85VjcCYddnfMXFD0zuQvhbCJTOLaOLMK65g0I4a/dQp1Mu6ktcKMtzFwlHg0h3M/fxWYtqoSHPOQq00X2k27XLRY73/7iyifH9P55VwMr+8QRYxTENzrpXGvX8kJcXqvgjxfUINQ51ge79i6k6PNHGvRMkQ/sZjjUWxZdQ36c/5W0PZuLbgl9jzTuA/W1+ilzgIz5XNDqsLRpOHUVpuM2keKtndboFS6Yi8ri+f+J29pqb5v9MOl4poO3NXZosC6ByZOuFBQYTsUzE7JT8gF6Rq6gk+Qz+n/xIrGaV/jLivhtlCLJFhV2FObLfatzp5mT/Iw9Dg9VqQZZhcTqYY7ZdAmvtXi5LS0dPkzWrCfd5ri2vtqwFV5HTFWRBfJUxj9UlBggheax6Og5PLHoRM9tPaqB3tBAsqrPXXkVcM4AYOc6EgOBBMmfH92B9141ZoXgBHRvbzuzfYIXk8xGZaJHvJg6ixaHi/+exwixR7AVEr5FNRr1I9D7D56yKL;4:LgmdD+qKpK97DFmQlW84DeDKL5+UE78RI0fkt9HZRbW6i4M3jgbymCzM8YqSkcXjtOA1EnWKaWP28kkjKy5Lncklzj+LKR6mymrkW4pFBsg7BEKvcj6beYrFeC6+LesPcYzD3zmBC3Kca5/39/GSyH1Jrkzmq+dIh9C21XgBpLa7fmittF9TtGUxMQwqDvQe9ZsoXjWUFYyvzAMTP5reb4gA7xXG+sy2tdopnt3rbb1Kq7J4uZ3myNQ+5jyabUNizSYhvQPsJMY37xDukU+UEvq7fQ4+wcQNqsgzZEuAO0OMrfech8xVBW4Ot2Fj29x8HB2jaVNw+JbOYn151lbsmQ==
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(131327999870524);
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800378C88EA59F6ADAF9698806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:GzG1/KhF0GeFumrg0KjbY11DxEz7IGlzrC40Vlb?=
 =?us-ascii?Q?mNnKx6eM1nGy6Wedjg7yqcId27RkVvNXwbmfhuMaNFfqTuyfhqd/+y2zvlYl?=
 =?us-ascii?Q?D0glXk3QVbc4BP11NkSE/AE7G39TymXYaBmJh+sQ6xXzbZHs87dT/M97g6nd?=
 =?us-ascii?Q?XnP69vaPXYwSlNsWXzRxa3gFmYnsW/UQ8D4mElWj5O0eDG4/i0qQniFMp+x7?=
 =?us-ascii?Q?NFM9OKQmOdXXVn8QVND0WjSIU4EhJwXoisFP8UqpE+5XJzRvuFFbj8NDctzS?=
 =?us-ascii?Q?YP9XsPvw7j8Y2spedxm2y7He2/MqxeaeR2ZHQnOHfkW8wj++fwI0Jsz+7P5m?=
 =?us-ascii?Q?ODE+WGfSCFyOxnqKcmQGB/chTGwc5LJu+I/2Gk8L2bCgMPWKVwKxEJYKRfcU?=
 =?us-ascii?Q?I0IbaynVn4L250HegnbNCrDAnWWSbR/yAObKwqqzeg3+co7HLlxfpY3OBucI?=
 =?us-ascii?Q?JBpI4rCeIjg+9odyE4GCO3BLwr9aP351Imo2bvK5r+tyxCYt1XK/zFtdr+ax?=
 =?us-ascii?Q?3KjCif0K5YLZEP/pVRHaTcR2wVvZ54WuHAfFMVrAbDcZSDo6T9a4ly7HsmG4?=
 =?us-ascii?Q?s/yFvFzyVE0VRepiUeOP9BEXHfSE0O1DGU8pN3WBugQaVbDh+2w0Le58xwj3?=
 =?us-ascii?Q?7rPlTWWx6JD5EwdSJ9eqGestUsA7okkrz74A9MjxbB9G+cDb8FfsY+LmbMxS?=
 =?us-ascii?Q?S/89AaeZ+z9dnWY5Gl7+qaj8mXvn7bgpEPGR96IJvg31xL5IGEhJWW5qHyBE?=
 =?us-ascii?Q?h8VYNwB+AG42eWaW5ET57rO3/WU2zy6hrZ2QQImG1708Cjgd0rsuiEI6FBA2?=
 =?us-ascii?Q?p4iDgINQ/lGCloy2lLomg9m9tz+biud2kHtsW4WBmh/Pp3gyasoMcdbDwmYH?=
 =?us-ascii?Q?RXz3/dtm5Ojvi2wyonBCDPrFs4fxzZhyQqNVE4yGv5cB+IAYBKni1hsMGHtm?=
 =?us-ascii?Q?iE71uVaSCSNrKXF3fxMyNOex9wDJE031ZP9nU+UC9rUshdw9ZW9M3SRLNqmd?=
 =?us-ascii?Q?opeV9CqPw7LVdH3FT+HB3IOIrF3gim8cq1IE1uPW2o0xQKgdKb3YQu97sjqx?=
 =?us-ascii?Q?nqBpXSGkNFUR8qhoDo7jU8WddGDZkEVgAh1Uci5HjawJo9hweuhP0QL5g0eu?=
 =?us-ascii?Q?sFw5x0aMl1iY34QKyPSyJ1wvYZR9sjGQfrPPqjSLX9FyvcFkQU6955bM2tpM?=
 =?us-ascii?Q?H/Q7URpCQrziG3WbYzmbIlC2S1DUSh5Nv+peNXELClOul7qqO3YNzv1JjKw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:D4XlyqJylKSwdpRik4bn6YFwGVCwqGRNyLE5ILTixQ2/MW+xk3C4XQAnDgz2JhythpghW7VOTsIrSKqhYFzvf3NJyG1X+msGBmQlFIvJH9dCzneSrqpD2ZwLWso+Y2JuKlUS6fOX1RDG0s3Z5K9GtOANpZSj6aPHFnYos1zK9ZBx/tnCkGTW2xNUfp+ahZjWYNh++Y4i48iQF+Nq8FQg39fpgFPaJ3wSntmyl8b8TptGZYS4YDHIozRyQ+HnD/gyc9TKrY7tugeWS5dSh1Dt8uJmOR2oxft5p9TLoIiodfmLRk7iBSvRUtko8rSiKSlxL5h1lJtbLrBUV5dUUpHrzw==;5:OX4mmecrwamUZiT54bgwy0cHkM5J+XrtQpGPDroIFq+NU9YgeF4FT/bgjwQqa6wrACnZRWJQ6Zmm68C8iQnu3He2AIZOHM8gBnZr0EB7rLOnymhtxVjFS3E8ab0+9tw/WIAmGi3U57ERkMG03YEcYA==;24:+2Jat5IzHE98Hz1EZh0W6BdXYBkriqnAEj1QTK74E/UYqJ7sGbRK9SiK/SPJx+fhAl3j9g+EizQn2fZQCIJ0cLlrt6fwWqNe9RWZQKCLrGw=;7:TmnuDL0t5L/FjdmeR91LCsgMDqasr4H5obpVONHFTP58LrXxD3EjEULb4W81I5dCALEnr++7+BTdRVf6xpLnUk1QNDTIInoniwmFuAPkWgj9XjlKWXUxRXevo++JyIufD5Puc7w5YjAQyZqSdz6t5zLfOQVfmd2Gyhb2tb+ICeirkBTralQOuAsECoQzjEsuvjn9Y3SPYVe8eYJ7YaCagjDz9sHxKRh6fsVNLREz6Ww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:53.4418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60016
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

Used by the Octeon hotplug CPU and watchdog driver code to get
the address of the firmware boot vector.

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
index 8d54d77..94d97ebf 100644
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
