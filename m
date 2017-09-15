Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:35:01 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992110AbdIOReCLycOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DCCgCqSqZsJ2AYBVVwKHy8MhFsTp+2MWopGcYdrvCb8=;
 b=UKNgpNdYTiot1Hqv+Xt6nkEOKpZnYGEtG8uF9PQn3T/TGhCaGqCM30sFOB2K7+1zaPAPUTsVtzLU4iNL8IQuxQKsIUqEurOlUZK2aR953XL+NZEpoLwB8MpTVPuE+pYWhLS2X6bSRfUkgmTNWkkIjz7XTX77twoy8Rs4ooDAAgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:52 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 03/11] MIPS: Octeon: Header and file cleaning.
Date:   Fri, 15 Sep 2017 12:30:05 -0500
Message-Id: <1505496613-27879-4-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: dc96e729-1805-4bf8-16c8-08d4fc5fef38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:88w8PqueqGtfd1z1bRoA1ucsvDXGQyiumakjKkBCjjtlLIgysbFVHRBrbQ63VA4wpkZdLiVlOmqVCFI8gjaKE6FGLJule6Jyu2mQIcpxR/fIuyrH9x1Nb4IgroG5quU6idjW6LwHXxKEnbs0WNCcuYfTRVkJC+ylZTeDXORLxuGK6cSMF2sfD5bbT3aFpg6Ipkx302F7N+ftYkNyrr/jbnkzk5eT5uQnmAb4u/kKu9xRu/m5UAFunvnBzrZDX6Um;25:DV07ZLGupbQY9y3s1MacPp8m5iR2iK7PIOjpkOHt3NieuhjM3FKEHcyoUQkr5WluY491wIYqkBbdUz7PMrR2qBizBhg48rSD3AiSx+yRNHCWtbhyyJIkhm1xb/f2lcVh3YUG/mtVpaFKGD+X0ADPefd5zVpJW46DxtDewLcXnMlJXEk0okcBgvtB8EAMVXgEtK3kDjgLP/XXwBZZ22yD72ZPVH97KKZaW1tw3c+4PzcggVWjhD3GoM0XEdQ9r4SL5m8V7hlR3y71TPjFgj9aQdK1tCvGmX16NIqHW/G2WuCbysZU96X/P5tywNM4nNF0wOMJm5mRIw7V75uBhd/y3g==;31:lvik6N5C0BMy0bTRxTnqSoVeDf4oGLk9c1RYa/D8EboftUwLSOZDSFgvh7Ts1Cy2FwBf/+YFrnkNpd/Zt19NO0i9ep08GzSLlpkqbZT2f3AlHakrl5c95OD/43hm7xMkbn8aqlGgBKqtvoE/iORfFYKxIWMhxTHdGdPfoHMLER0f7Orh6wd7Hc+6cAr3+WWTYCDR0QiF3wNtcqTyKIjLb+W4IMp1SGMU0K/vKFMqNPo=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:fXj75RJvpwOSmBGJ2HEQkvT130jhEUoLxFaowLObI/Cy4skWJRsRLHh+SbZoDhmaxcv9hL3e4BBmDhtPPZt1y/L49RUVAbhRD6CKdu14ZbLbUsaeu2BKEhdGX9Yu0kGJNj/9rzyk4YFTJiYUE2Ep7aUdYPMuO4G6rADo1NCfFTia2V0H+n//e9Iv+Wmsfy7L2pd1qiZ0k8ShcBKynWF7nm7DqnBtUQO0X3PzUujoMlIwNuKOPoJeyUxUnnXXj/+b4RWb2Z5Rfr2XqXsxnmWcM9Te0pEoqtskAuLv5Cscv2XJsoo3JveJYcA85CQ7xK5kd/5D9U58HoaB86oPE2CxhqhUbyhuCkk6fAPHxbvHkwF7+ohQXvDikYmNEhKpP6/ZZj7QvWnJD2c9e5I0GTyL127LzB/pn3tftmAyRDD66SBacVfcfug8hn9IY/x8eu2bhw3H+1zm5o0nTH5gp0YT6o8K5Sc/sQSPVy68LLeGuIiK0EaHFYtegHGsGslLmpHa;4:m40rmDOX5T5U5P16KvAIobVjDkCuk6eQy5s7lhLsb+ArkfqJyie6771Cgl4xO9hI/4GPNtFXl1/wmaCSmUUGrbFgyAJlJXz/E5j5ebQau+xiW+t8EfVNfiw6z0PQ4DBVFH6+DSth2SnguYgPVSQNLJ7m8mCzJKi+e9bz+iYOZ39zUT2G/VxhEuAPcmQpez0nks5t89b4o2jj8v8263qcHTwynYbPCOuNjT53MwXEQyVeCusEq9clujuZyxH9m8lQ
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800D1A23D9EDC89512CF956806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:JKmBJiKZYO5Bm4j/aADH5AfAGs7gQxe85S5TRoG?=
 =?us-ascii?Q?jXTJWRoGQ/FQc3MFCdsrjJFIksNQHX1U+8ds3xzH1mRXe3T4+P+4DHYmUtp4?=
 =?us-ascii?Q?OX86NOQb6lIBZC2Sm2aUJjziryuLEHYOkdR+q8YG0R7b/9bY6Xv42z0bboO3?=
 =?us-ascii?Q?qX0BZ8AvuLiKy//Ej38XG1SC99WziWiOq7ZBCLAefQZw3T6GpJyn9lezhJEP?=
 =?us-ascii?Q?flLt9qwLqn+FIDeeqy8rQYoH7tG5rmuDA1mRGAY8W83BR7aGUHFraPpJqLAj?=
 =?us-ascii?Q?EVn/YAKobs3IGZxl8ZDgAgielErbyIthRSVvWETZHYNJr7TtxtVUBjr8axR9?=
 =?us-ascii?Q?x6jCFv1yja18FVcU5Gkc8l+nwke7nDAM1KlgnC2y/d9oLv96dQMaSoN5zto9?=
 =?us-ascii?Q?WC0DnfaCev666A6MPEdT8DFkmW39tQe9K7WYXkYkD7ncXbWKr7h5XPVLozwY?=
 =?us-ascii?Q?UTTJ/4zHbQGQJudMgw+nBrfiNAbA9PiFXll64hQqQqqmGjabZHYWmCFqjQ1D?=
 =?us-ascii?Q?u8s4txnYZ55Kbck7oP9KftC/fBNhPKhpHwALMzay2pq0UclyafwYAs2p+A93?=
 =?us-ascii?Q?374GGvIcWCBb6p0oygQ/5RMbYfgUZv6f/zyByOrgkVT0jegq+37NCaEqjj3k?=
 =?us-ascii?Q?XKdfVD4XLGVmNIIMY8f04/B4XkHR93WyL4IC95lmArSTVt+GiEq7zKFhYXl2?=
 =?us-ascii?Q?pQfhkHjFJThi6V0pFgFBW4dubc6UQj4kMW7op8V5WQ3g4S02uVLzqhVm6eD5?=
 =?us-ascii?Q?P3vdfXT+zEt+jdD6KrJYvEKDxG8RzN/pYpX4MqRIyAT5rFDNPQkadf7cU7+8?=
 =?us-ascii?Q?WLIQ6+RmE5Ld6DmANnBq5it+Q2ZEU/mugVUggN1X0/8H1etAeMlUp/X0TEOC?=
 =?us-ascii?Q?ZH5qtwipjGlfgefdr2AiN+JGhPrntF86+3urYIXlf5Dv9aWRFFzTVzfYef22?=
 =?us-ascii?Q?LVAQpehVlvLXvpfzD1eUFkR28eYf8QEJ6kPZSJzCDZASuyD0KTlhew8KspIS?=
 =?us-ascii?Q?Y52o6LPGZjttRGtLNVS4xiPvO1QFzqF5pjvPVKIaSlIvHsmN7QdsBMmgiQq/?=
 =?us-ascii?Q?5aKK+MBrAxm3S7J6aDn0Z7iQ1zfVVU6jqA0ipLI6E0gdqLhPxapOQ7iZXoU9?=
 =?us-ascii?Q?ElKHtaY6kENlTDLj9iYgje4+kTF4aXWe5Fj7RaTn7cQgTmOD/IkAuJS2UPzH?=
 =?us-ascii?Q?Bdb1ii1rhOJcuUXzUpZ4DntpnF3SOeE890ti7vSleWQCsjq9rc75UwCtpDg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:VIdEy5yfytTp3QuTDUdsOF+5WQMlHjz+KTszTBK4WFXl/kIZVev5MezgMgtzQFVdrTCJsWRoDnFmAtDTtm7sFcGn0sxz1a/z9ybtbWVpQc2MYgE6aNUYKtiUNN1Cl524xjBFl13XlRvbtV1d698WWxcziFegPPdtAxg/kxzFOfi5r0Kx7DweGXcM9YiSdeth/8PJQt6lq1teXpS2lJOWTNEZ6czVHxd3LEstA0ovhqdBA97+smVLrsu2Ymko/TgBFH0XiBiRl2PM7pTRf0J4ZJiQ/AGcz62j/Y4DZf5ioLskBxi0cfau3vZMmk7VeFh94cwt9ykHLSSUSbgKCcHSzQ==;5:/6xZZg3gIKuDhZquBAOZnzbU7gSxJGBAQwm5JE8gyJHo85Ehce7HBDQmkiRsgIccz7ULAToPrDraHOi1LDR1nDB83F0+YQtQX7ic4poxRehiLOKDj64MKnqHBvIB6aRwnB0aCBtf4pX89jYYDwlIDw==;24:D8yCUFUJGvqnMUZPIvfrwjWoeceE2DH1fnzvMMdSWpUeyVHrD+xzj2LbrxnIJEmbYrUrJxtnhj0/TgAPylVNMG2giOp9VUUInK3dO70VHi8=;7:SfIPVgUXT12tWsHnqGbC5woVXNAS6RWxEw6GbO3XWZMKhZZKhedqiXnmyAa804JYx/sL4UKR6qXRNaHNOUWVHCMDkgjyjBLIjUo7Pnbub4p7IRtJw1glOu0+W7PuLB2EaxFa3uFsarzV9er2NKToRuhM/zQvrYJnyh1UKFppn7BdtlQGkidm5ibGsTg+HiLu7hRj2hqyEl4imEVTUtYULW6GkD4LcfCG/4tR8OfipII=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:52.8324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60015
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

In preparation for new hotplug CPU, some housekeeping:

* Clean-up header file dependencies, specifically move inclusion
  of some headers to only the files that need them.
* Remove usage of arch/mips/cavium-octeon/octeon_boot.h
* Clean-ups from checkpatch in arch/mips/cavium-octeon/setup.c
* Add defining of NR_IRQS_LEGACY for completeness.
* Move CVMX_TMP_STR macros from top level to cvmx-asm.h
* Update some copyright dates.
* Add some missing register include files to top level.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    |  2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |  1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |  1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |  1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |  1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |  1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  1 +
 arch/mips/cavium-octeon/octeon-platform.c          |  1 +
 arch/mips/cavium-octeon/octeon_boot.h              | 95 ----------------------
 arch/mips/cavium-octeon/setup.c                    | 10 ++-
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  8 ++
 arch/mips/include/asm/octeon/cvmx-asm.h            |  6 +-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |  4 +-
 arch/mips/include/asm/octeon/cvmx.h                | 10 +--
 16 files changed, 36 insertions(+), 108 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e..22d46fe 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -32,7 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e6..e417037 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -33,6 +33,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-helper-jtag.h>
 
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index d18ed5a..2d84490 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -30,6 +30,7 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5782833..a25275d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -31,6 +31,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index ef16aa0..d9dac21 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -34,6 +34,7 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-spi.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 19d54e0..d692638 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -32,6 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec..1e807f8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -31,6 +31,7 @@
  *
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 676fab5..ec5b013 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -30,6 +30,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-pko.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a..d346ea7 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -30,6 +30,7 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..a605191 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,6 +13,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
deleted file mode 100644
index a6ce7c4..0000000
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * (C) Copyright 2004, 2005 Cavium Networks
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#ifndef __OCTEON_BOOT_H__
-#define __OCTEON_BOOT_H__
-
-#include <linux/types.h>
-
-struct boot_init_vector {
-	/* First stage address - in ram instead of flash */
-	uint64_t code_addr;
-	/* Setup code for application, NOT application entry point */
-	uint32_t app_start_func_addr;
-	/* k0 is used for global data - needs to be passed to other cores */
-	uint32_t k0_val;
-	/* Address of boot info block structure */
-	uint64_t boot_info_addr;
-	uint32_t flags;		/* flags */
-	uint32_t pad;
-};
-
-/* similar to bootloader's linux_app_boot_info but without global data */
-struct linux_app_boot_info {
-#ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t labi_signature;
-	uint32_t start_core0_addr;
-	uint32_t avail_coremask;
-	uint32_t pci_console_active;
-	uint32_t icache_prefetch_disable;
-	uint32_t padding;
-	uint64_t InitTLBStart_addr;
-	uint32_t start_app_addr;
-	uint32_t cur_exception_base;
-	uint32_t no_mark_private_data;
-	uint32_t compact_flash_common_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-	uint32_t led_display_base_addr;
-#else
-	uint32_t start_core0_addr;
-	uint32_t labi_signature;
-
-	uint32_t pci_console_active;
-	uint32_t avail_coremask;
-
-	uint32_t padding;
-	uint32_t icache_prefetch_disable;
-
-	uint64_t InitTLBStart_addr;
-
-	uint32_t cur_exception_base;
-	uint32_t start_app_addr;
-
-	uint32_t compact_flash_common_base_addr;
-	uint32_t no_mark_private_data;
-
-	uint32_t led_display_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-#endif
-};
-
-/* If not to copy a lot of bootloader's structures
-   here is only offset of requested member */
-#define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
-
-/* hardcoded in bootloader */
-#define	 LABI_ADDR_IN_BOOTLOADER			 0x700
-
-#define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
-
-#define LABI_SIGNATURE 0xAABBCC01
-
-/*  from uboot-headers/octeon_mem_map.h */
-#define EXCEPTION_BASE_INCR	(4 * 1024)
-			       /* Increment size for exception base addresses (4k minimum) */
-#define EXCEPTION_BASE_BASE	0
-#define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
-#define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
-
-#endif /* __OCTEON_BOOT_H__ */
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..2085138 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -39,6 +39,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-rst-defs.h>
 
@@ -165,6 +166,7 @@ static int octeon_kexec_prepare(struct kimage *image)
 			int argc = 0, offt;
 			char *str = (char *)image->segment[i].buf;
 			char *ptr = strchr(str, ' ');
+
 			while (ptr && (OCTEON_ARGV_MAX_ARGS > argc)) {
 				*ptr = '\0';
 				if (ptr[1] != ' ') {
@@ -357,6 +359,7 @@ void octeon_write_lcd(const char *s)
 			ioremap_nocache(octeon_bootinfo->led_display_base_addr,
 					8);
 		int i;
+
 		for (i = 0; i < 8; i++, s++) {
 			if (*s)
 				iowrite8(*s, lcd_address + i);
@@ -429,6 +432,7 @@ static void octeon_restart(char *command)
 	/* Disable all watchdogs before soft reset. They don't get cleared */
 #ifdef CONFIG_SMP
 	int cpu;
+
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
@@ -715,11 +719,13 @@ void __init prom_init(void)
 	if (OCTEON_IS_OCTEON2()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else if (OCTEON_IS_OCTEON3()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else {
@@ -927,6 +933,7 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
 		u64 inc = addr - *mem;
+
 		add_memory_region(*mem, inc, BOOT_MEM_RAM);
 		*mem += inc;
 		*size -= inc;
@@ -947,6 +954,7 @@ void __init fw_init_cmdline(void)
 	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
+
 		if (strlen(arcs_cmdline) + strlen(arg) + 1 <
 			   sizeof(arcs_cmdline) - 1) {
 			strcat(arcs_cmdline, " ");
@@ -1202,7 +1210,7 @@ void __init device_tree_init(void)
 	init_octeon_system_type();
 }
 
-static int __initdata disable_octeon_edac_p;
+static int disable_octeon_edac_p __initdata;
 
 static int __init disable_octeon_edac(char *str)
 {
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 64b86b9..7c2bf76 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -11,6 +11,14 @@
 #define NR_IRQS OCTEON_IRQ_LAST
 #define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0
 
+/*
+ * 0    - unused.
+ * 1..8 - MIPS
+ *
+ * For a total of 9
+ */
+#define NR_IRQS_LEGACY 9
+
 enum octeon_irq {
 /* 1 - 8 represent the 8 MIPS standard interrupt sources */
 	OCTEON_IRQ_SW0 = 1,
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index 31eacc2..0c6ae93 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,9 @@
 #ifndef __CVMX_ASM_H__
 #define __CVMX_ASM_H__
 
-#include <asm/octeon/octeon-model.h>
+/* turn the variable name into a string */
+#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
+#define CVMX_TMP_STR2(x) #x
 
 /* other useful stuff */
 #define CVMX_SYNC asm volatile ("sync" : : : "memory")
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index c6c3ee3..ea1381a 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2016 Cavium, Inc.
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,7 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
-#include "cvmx-coremask.h"
+#include <asm/octeon/cvmx-bootinfo.h>
 
 #define OCTEON_SERIAL_LEN 20
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 4c14382..d1d1935 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -54,8 +54,7 @@ enum cvmx_mips_space {
 #endif
 
 #include <asm/octeon/cvmx-asm.h>
-#include <asm/octeon/cvmx-packet.h>
-#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/octeon-model.h>
 
 #include <asm/octeon/cvmx-ciu-defs.h>
 #include <asm/octeon/cvmx-ciu3-defs.h>
@@ -68,8 +67,9 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-pow-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
-#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-bootmem.h>
 #include <asm/octeon/cvmx-l2c.h>
 
@@ -102,10 +102,6 @@ static inline uint32_t cvmx_get_proc_id(void)
 	return id;
 }
 
-/* turn the variable name into a string */
-#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
-#define CVMX_TMP_STR2(x) #x
-
 /**
  * Builds a bit mask given the required size in bits.
  *
-- 
2.1.4
