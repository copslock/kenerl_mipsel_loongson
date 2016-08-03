Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 21:04:31 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:49808 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993267AbcHCTEXztfq4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 21:04:23 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u73J4CE8000684
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 3 Aug 2016 12:04:12 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Wed, 3 Aug 2016 12:04:12 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: dont specify STACKPROTECTOR in defconfigs
Date:   Wed, 3 Aug 2016 15:03:59 -0400
Message-ID: <20160803190359.6486-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Only one defconfig has a STACKPROTECTOR value.  And it asks for
the strong variant, which isn't supported by older toolchains.

Due to the nature of MIPS having more platform specific code than say
x86, the allyesconfig and allmodconfig aren't as effective for build
coverage.  So, in addition, I like to use a trivial script to walk all
the defconfigs and build each one.

However I will get false positives on unsupported stackprotector values
with an older toolchain like gcc-4.6.3.  As in this instance I am just
using the compiler as a glorified syntax checker on a machine where I
build a bunch of other arch for the same reason, there is no real
motivation to get a newer toolchain for improved optimization etc.

Since there is only one of them, and there is nothing about these
settings that are board/platform specific, I propose we just eliminate
the existing instance and take the default.

Cc: James Hartley <james.hartley@imgtec.com>
Cc: Ionela Voinescu <ionela.voinescu@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/configs/pistachio_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index 8b7429127a1d..698631327c8c 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -29,7 +29,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_CC_STACKPROTECTOR_STRONG=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-- 
2.8.4
