Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 22:40:53 +0200 (CEST)
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:16310
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993947AbeDMUkccWOm3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Apr 2018 22:40:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OBgv8K8EbuqMg8ARV6aOHCEFDFcf0trdXS8FhvX8V/M=;
 b=LSPLlhKCE0Bl6PVKCSkzxLHmsFDEdW+RRtXqRx/3qrT7ezIbRQGj6CyzRo2cCJEpqrFVg4+EDXizEnClkly8ncm6u4zuDDIQuqH0/HMeQY0OrBHj3dq7aq4O3kRtSlUN9u3pkB3te+0IuMuBs49LG/Au/yi6Vx/wnbCrocVejcA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:68::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.653.12; Fri, 13
 Apr 2018 20:40:29 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: Octeon: Remove extern declarations.
Date:   Fri, 13 Apr 2018 15:20:18 -0500
Message-Id: <1523650820-18134-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
References: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To DM5PR07MB3612.namprd07.prod.outlook.com
 (2603:10b6:4:68::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3612;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;3:NyWMPAxX3SjkZhkZXLlQvT9tDy//zWzK3MtCK9u7ZzZZw6pX2r+UDCrtI9VobghYHgfkX9ghSD9cfmSpCM9ILd5RYT3gAlk40X25IhYOhl/1XAk3nG+NKNNscpViKdTcKRH62UCLOaQIW1TTWHsyf/oWQqyi4CJ4O8LKvaUIBHRqSaGiFc49M0PhJdCoGD8mxYJJfEQLuwBPVMXY7oXmQ74QvKGemTEujT6p6VmwjQgesZ10RvJDGSUWMDyVe7ga;25:zGyn5+gkV9Y/Khz8VhJ/Ro/i1cFuw5CK4/bas/leeDAJrX/704iUDRcrySeagKw9nvy7bjCRVx8HMXu5WVFX+i4c7gMes+8H6MtJy7eLndgglicu1w04AWwBoOWd6IqgawHlXefQezbtApVTHQWSuOUut03uGiAAv38JmHr4A1iVAyEc9ETChkhmSF6UoIJQXqR/ceL/GB2GzYLPYXGbMUYSP1MeflV8k7NydLlNknx2QRlVyJxCZi+/rF//avENNY4/ZWn0QR3JB7x9+XzfDwFKokdQjB3ArXhAVA5gmWadCV3WKsqddsgifW+rYUElO065pdGYIMioVvk4wdraRA==;31:NcyIJqz5byYmOaVAZRy09GND1HeaFOM5C9fTXcPOyykM4PJ+eKrSF7Bv/Zf2QXrtBFCGKNMpj/SRH2aTsAONEGlY/62+xGtJeKkKVKUTchbbxBTzCBXcxdasEWFq2YyndrvVm2RNdgAo3moSPQOGV/GMabSa3CPWQPd9FxZ7eBs8zVDAS1KZcdPgfEf50ulGWCAkhsSorouOvglZLTA/Gllxwf7MmdSHlbB4FBaau1A=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3612:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;20:UQ505Nv6M6Y4friCebKq2v9//EBy/31ii9t/5e6BvP2bWWCEwm04eunitwv6ddlUPIFemshXP2XCQQyltnaxlN1oiJ5gyXHYvduN/YaBfXCbbJTpFVGhhRjmxnQUngDN5ZZmXTruK/U0Y3520Bgf8XfxWktbKen2DKGRsofjyuY3fHc87F2tPnrmv4XNTVdSKtyFqZqBdJdKNJa6PjnspU6fvMs3hV04Vt3b8dr9lxM6A07SZ0EBm8C5vna/XdEYpS01B3fMWwo/dep/NKjMSXuAaDNHJTe1UG1hV4i7epHrZXZmu0Y94m5TDIdeutmMIZ7sV6lQntRozTd0YKeAMXvjydwlXDtSjr/eAbOHMTOCVJG8gZ2Vd06GXL7oRXrujc46mIofUwLAZ+1NJPy+gqR8ZoZsHTw2IzmB9viGzknxnxRUjNIQEjFaGXUooD3zJjqzcCvpC/nXUdFgT5OIP6bsz2nD2ST+odRKNj4WGwszcjf+C2xEwxIpIAqEZ11p;4:Z1aJiUrkMdzKX0Frr0SCPupNqwO8kIrfuL66zG4pFMZpF6P6wakqRRJ4pANjMVXmcVyFTxnseCMzHXHY3ovxRToCH+lw64CbjJLvBuRXVe9y7qsdB4+CHr0NZr6mLJNiTDbFGMXkRwf+HFnEpq+x2M8GMoEoQ6HK/75TGNLkY080ScDzzB3SuRqYTWI3aJBbQfW43/VGPao/EU7Wjehc0/hWeNApyTXggcoS7eh5LIYjhJUSay7j/f03LxGD5X8NNaWqEyqJCe9OFIv9XCTEOg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3612E8C55E5D9974A15B11A480B30@DM5PR07MB3612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3612;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(486006)(446003)(69596002)(47776003)(16586007)(105586002)(25786009)(6916009)(66066001)(11346002)(956004)(68736007)(2616005)(478600001)(6506007)(48376002)(2906002)(575784001)(476003)(86362001)(51416003)(2351001)(53416004)(2361001)(5660300001)(81156014)(76176011)(6666003)(386003)(305945005)(6512007)(36756003)(52116002)(8936002)(50226002)(26005)(6116002)(8676002)(72206003)(81166006)(3846002)(186003)(316002)(97736004)(7736002)(50466002)(53936002)(106356001)(16526019)(358055004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3612;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3612;23:yps57Hj6bkR9DAGmlaabH5Fb2btUHKKuWIsIObJQc?=
 =?us-ascii?Q?a8qCpQ1fniLUE7z25Zvc9BlmifYPOJZgopEQvNVC9u4jFuH5xss2o1rRsDEb?=
 =?us-ascii?Q?t2/tUMWkT5iknqd3OUEGfejapir6Ryga/mgytvKFwFlvUsnFWwzQI/2RG7mc?=
 =?us-ascii?Q?ByZsGyJQR7eamxkiGmKyBBRl7TUb12sDIlIVSBI3glFleJR35yzpMkSihsoW?=
 =?us-ascii?Q?STM3/M8SqvIU/HZRlPZqwxtnnIQFRNBOJQ17BSv1wSjJXyxvtA9tFEH8/33t?=
 =?us-ascii?Q?yRk1rcUM7KK/Ld/4VN8f4BTgNaeVssEAwqc1w4UKyqDXo9rkBqU9AXuMhnwf?=
 =?us-ascii?Q?ogqGus4CuAdKq0N4lqkH1Lo+CAklaNYSEgXA3/Y+Hz0YE2mVrvyJWK0x+WG6?=
 =?us-ascii?Q?ECh5pfeqG1Bcw5q/E9gOar3oxtgSmXeYC1y5nt1UeqqWBFXh7VSdfuKezBz8?=
 =?us-ascii?Q?XCv/NHZw1VARnTeJlwwnCCvjL1fRpL/BSp9+zRLMVRyX5UVJm8BwIGzMV7by?=
 =?us-ascii?Q?BA8cEkINaLkKoxscu5YsMTp9uCYshrbAYPvVNLAvimpTy6ZAcnzh4DgvCNur?=
 =?us-ascii?Q?6lCG0H1kEbb95SuHxROGuD8My9DuRBun+F6lfKyAGBVtTLWOuX9rvwXl4r01?=
 =?us-ascii?Q?Aopb8TF4m8s9XDPArgjbBF74dUO3ykx1aYdursDUDsWeAsWyqBgsotcvPlXX?=
 =?us-ascii?Q?Gu1OXjEsxefrW3KEkia0Cn5eDEJugdQC9qChILJf0pzZvBKZ+hUqrfGD/lbp?=
 =?us-ascii?Q?sO/dVOhXmLvs4koy1ni3K+GJe39O1StoJJL0E4SCa7U0iPS5Ytf+Qaqiiww+?=
 =?us-ascii?Q?siBt7l9i4nj06oGIt2gcXL3Hh1qcPwVuXY6Tg5ZzcQJyfFEMvf75P3Z5qWNF?=
 =?us-ascii?Q?7F35uKDzaQZ/T7O+zUxiWAYyvveSMX+4whlwbr/KD3m8zuSAnWRD5nkm8sdG?=
 =?us-ascii?Q?d7PZ1zAc5+rxae5Z7ca4FF9FjK/rwVgVNFtKhkiCYDnQ8NRBFG/Ke0RVbrIf?=
 =?us-ascii?Q?IrE/AZYoB4y3Jj1oZ4/mqpjE7nn7ZTJk4qsdeTRUJQdHgAhtP6lFE5118ezK?=
 =?us-ascii?Q?TOpudu/OA0OIKJz1vAYlVg5kp5wHlQW59LTfR80H4lija3IsYhPsV9kM/+US?=
 =?us-ascii?Q?N/fI74kXDHLjpX6wqu02wL0retRaaXgM0I4MRjvDxTOiChMRtLHH9/CNSABp?=
 =?us-ascii?Q?8d7lRt4x34kG0ROBiOPG7rFOnlLq6nBQ5kAh/ANbirfjntWA5B58aedSdmqn?=
 =?us-ascii?Q?cz21+ZEK631u4AnSRTFeD+4FLlabdbqYITOV08U4GSVUaZyQmalo4oqcrgI6?=
 =?us-ascii?Q?AJakvQ/Ond7U1HXiUWMhGc=3D?=
X-Microsoft-Antispam-Message-Info: Qx/hrdE0KPi6aKcuMrOVHvq0XbpM3hMRRGsKiqi49F115powUiDkXo49XMGhuDiVKtbkMibLR3Yn0F5hSPk+xCqWN5WtKZ2oHLSobMad8CK21w5x2Ujtkoh9AqCgwuEMAh+OvkjS3NIxx2U0CFzCuLib2RRLhqBwoVXSPWNhy8V+Bly2ssJltgxxZbKnptxi
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;6:7J+M4JOIAbekG2obofhu9fR1l7cdOC0DrhNwVYneZeyRSgT558qkZ6XJBN3rFnSESzkaF5pUnlDitLm74JuUsvmn8E1qIzuDDv9KS2hlgDMoFsudQQUrr5FGE4CIO5zzgz8w+Dp81YaXVuZkn842zetV+cgfVnj1yqsja9hMZZFmSsdbAKRdWTJhScE+2PHAxc9qMQ4+T3HsJW6/fgaY45Mj+/R6LB7PPafKKFPAtCNZBwwOZnx+fYVXbRWL6g/w9JuBZpZ0InWTvwR8zqFhy0O0Xf7kFbvoePZ9PgzK71aZaOh6+SrvFksht8HvZGBimNmaPTtckLZdcLTreRI70ut9YoLAg7H3HfbJTNOPju0yWk+jdy4L3bHN5jeR9v0WzMragpEocZ/QEz9zotKHNhM/aCHuRlUx+ae7w+gfctx6LdL5TntJCRmI/sJYEuU72bOmf9tzRUgjrymxZ2WpRA==;5:aXUqWK51n0eRYvu76Tb12FcbqhG3GA5xisbBJGsKQcMn1l6y7Jy3a4YkiP947EABl+ROpT8kPdP0MR1/aKI5WcOwzCffi/TPinPkk2tZEe3QNFq/dx/AQFF5IBCp0WalUVB320zfA6zwYuvXSTfmJ9S4hm5pKctEZB0Zw35khzE=;24:gjeE1yjsaPMTRK6iuPvZL1xut3H6GQyLAeLN1KYMY70a0aZ4J3eeWtKn7WwczcxUEyvfNQsLAOl57uarRqQgrq/zPcCp3a29cnWhwBfu4I8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;7:UGTJnw4oob2IClI/l/i0l7ZCzbkcW7mm0xqqRdz0Ix7y3CTdrddLzi0VE5jhQp52RpRDLOBZcOGiG2gN9jEsN3fIewJpw7q4WGS2jsLch25aUqqtBI/YJW8j2xZRpre+hav7L99rRgwmuf6YNCSdsO7QBKm8DwRJ8aMFo4zkAnYxsKkRwrEaBOy99kfGdaGxtFs3ugsVvc3LjFDmpiXaCN43WHzFl90U3YiT0k2Nb74quql33nzYooCARrhDNJh0
X-MS-Office365-Filtering-Correlation-Id: 11eebd6e-7e31-4609-102e-08d5a17ecbff
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 20:40:29.8235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eebd6e-7e31-4609-102e-08d5a17ecbff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63528
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

Get rid of extern declarations in .c functions and included
the necessary header file. Also remove unused UART declares.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c | 3 ---
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c | 5 +----
 arch/mips/cavium-octeon/executive/cvmx-helper-spi.c   | 6 ++----
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  | 5 +----
 arch/mips/cavium-octeon/setup.c                       | 4 ----
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h         | 2 ++
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h         | 2 ++
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h         | 2 ++
 arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h        | 2 ++
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h         | 2 ++
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h         | 2 ++
 arch/mips/include/asm/octeon/octeon.h                 | 9 ++++-----
 12 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index d18ed5a..af180d8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -42,9 +42,6 @@
 #include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-dbg-defs.h>
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_asxx_enable(int block);
-
 /**
  * Probe RGMII ports and determine the number present
  *
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5782833..3506024 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -39,10 +39,7 @@
 
 #include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-pcsx-defs.h>
-
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
-void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+#include <asm/octeon/cvmx-pcsxx-defs.h>
 
 /**
  * Perform initialization required only once for an SGMII port.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index ef16aa0..b8e4efd 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -25,10 +25,6 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_spxx_int_msk_enable(int index);
-void __cvmx_interrupt_stxx_int_msk_enable(int index);
-
 /*
  * Functions for SPI initialization, configuration,
  * and monitoring.
@@ -41,6 +37,8 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
 
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-pko-defs.h>
+#include <asm/octeon/cvmx-spxx-defs.h>
+#include <asm/octeon/cvmx-stxx-defs.h>
 
 /*
  * CVMX_HELPER_SPI_TIMEOUT is used to determine how long the SPI
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 19d54e0..d85371e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -39,12 +39,9 @@
 
 #include <asm/octeon/cvmx-pko-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-pcsx-defs.h>
 #include <asm/octeon/cvmx-pcsxx-defs.h>
 
-void __cvmx_interrupt_gmxx_enable(int interface);
-void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
-void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
-
 int __cvmx_helper_xaui_enumerate(int interface)
 {
 	union cvmx_gmxx_hg2_control gmx_hg2_control;
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..3ef1d47 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1154,11 +1154,7 @@ void __init prom_free_prom_memory(void)
 }
 
 void __init octeon_fill_mac_addresses(void);
-int octeon_prune_device_tree(void);
 
-extern const char __appended_dtb;
-extern const char __dtb_octeon_3xxx_begin;
-extern const char __dtb_octeon_68xx_begin;
 void __init device_tree_init(void)
 {
 	const void *fdt;
diff --git a/arch/mips/include/asm/octeon/cvmx-asxx-defs.h b/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
index a1e21a3..d07f702 100644
--- a/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-asxx-defs.h
@@ -55,6 +55,8 @@
 #define CVMX_ASXX_TX_HI_WATERX(offset, block_id) (CVMX_ADD_IO_SEG(0x00011800B0000080ull) + (((offset) & 3) + ((block_id) & 1) * 0x1000000ull) * 8)
 #define CVMX_ASXX_TX_PRT_EN(block_id) (CVMX_ADD_IO_SEG(0x00011800B0000008ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_asxx_enable(int block);
+
 union cvmx_asxx_gmii_rx_clk_set {
 	uint64_t u64;
 	struct cvmx_asxx_gmii_rx_clk_set_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index e347496..748a05a 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -2070,6 +2070,8 @@ static inline uint64_t CVMX_GMXX_XAUI_EXT_LOOPBACK(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x8000000ull;
 }
 
+void __cvmx_interrupt_gmxx_enable(int interface);
+
 union cvmx_gmxx_bad_reg {
 	uint64_t u64;
 	struct cvmx_gmxx_bad_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h b/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
index a5e8fd8..fdda788 100644
--- a/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pcsx-defs.h
@@ -334,6 +334,8 @@ static inline uint64_t CVMX_PCSX_TX_RXX_POLARITY_REG(unsigned long offset, unsig
 	return CVMX_ADD_IO_SEG(0x00011800B0001048ull) + ((offset) + (block_id) * 0x20000ull) * 1024;
 }
 
+void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
+
 union cvmx_pcsx_anx_adv_reg {
 	uint64_t u64;
 	struct cvmx_pcsx_anx_adv_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h b/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
index b5b45d2..062b8a0 100644
--- a/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pcsxx-defs.h
@@ -268,6 +268,8 @@ static inline uint64_t CVMX_PCSXX_TX_RX_STATES_REG(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x00011800B0000830ull) + (block_id) * 0x1000000ull;
 }
 
+void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
+
 union cvmx_pcsxx_10gbx_status_reg {
 	uint64_t u64;
 	struct cvmx_pcsxx_10gbx_status_reg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-spxx-defs.h b/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
index c7d601d..3c06b0a 100644
--- a/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-spxx-defs.h
@@ -45,6 +45,8 @@
 #define CVMX_SPXX_TPA_SEL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000328ull) + ((block_id) & 1) * 0x8000000ull)
 #define CVMX_SPXX_TRN4_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000360ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_spxx_int_msk_enable(int index);
+
 union cvmx_spxx_bckprs_cnt {
 	uint64_t u64;
 	struct cvmx_spxx_bckprs_cnt_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-stxx-defs.h b/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
index 1463540..fcaa652 100644
--- a/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-stxx-defs.h
@@ -45,6 +45,8 @@
 #define CVMX_STXX_STAT_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180090000638ull) + ((block_id) & 1) * 0x8000000ull)
 #define CVMX_STXX_STAT_PKT_XMT(block_id) (CVMX_ADD_IO_SEG(0x0001180090000640ull) + ((block_id) & 1) * 0x8000000ull)
 
+void __cvmx_interrupt_stxx_int_msk_enable(int index);
+
 union cvmx_stxx_arb_ctl {
 	uint64_t u64;
 	struct cvmx_stxx_arb_ctl_s {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6..6048150 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -279,13 +279,12 @@ union octeon_cvmemctl {
 	} s;
 };
 
-extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
-extern int octeon_get_boot_uart(void);
 
-struct uart_port;
-extern unsigned int octeon_serial_in(struct uart_port *, int);
-extern void octeon_serial_out(struct uart_port *, int, int);
+int octeon_prune_device_tree(void);
+extern const char __appended_dtb;
+extern const char __dtb_octeon_3xxx_begin;
+extern const char __dtb_octeon_68xx_begin;
 
 /**
  * Write a 32bit value to the Octeon NPI register space
-- 
2.1.4
