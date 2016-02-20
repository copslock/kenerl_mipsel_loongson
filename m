Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2016 02:27:12 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:61726 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013027AbcBTB1ISJehk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2016 02:27:08 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u1K1R1AC007938
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Feb 2016 17:27:01 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (147.11.216.82) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Fri, 19 Feb 2016 17:27:00 -0800
From:   Yang Shi <yang.shi@windriver.com>
To:     <david.daney@cavium.com>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] mips: octeon: mark some functions __init in smp.c
Date:   Fri, 19 Feb 2016 17:04:07 -0800
Message-ID: <1455930247-18490-1-git-send-email-yang.shi@windriver.com>
X-Mailer: git-send-email 2.0.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
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

octeon_smp_setup and octeon_prepare_cpus are just used during initialization
period, so mark them as __init. And, octeon_prepare_cpus is just used in smp.c,
so make it static as well.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/mips/cavium-octeon/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index b7fa9ae..3f03893 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -97,7 +97,7 @@ static void octeon_smp_hotplug_setup(void)
 #endif
 }
 
-static void octeon_smp_setup(void)
+static void __init octeon_smp_setup(void)
 {
 	const int coreid = cvmx_get_core_num();
 	int cpus;
@@ -196,7 +196,7 @@ static void octeon_init_secondary(void)
  * Callout to firmware before smp_init
  *
  */
-void octeon_prepare_cpus(unsigned int max_cpus)
+static void __init octeon_prepare_cpus(unsigned int max_cpus)
 {
 	/*
 	 * Only the low order mailbox bits are used for IPIs, leave
-- 
2.0.2
