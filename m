Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 00:11:07 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:18702 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992214AbcJFWLAg64qo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 00:11:00 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E52FADF74DA82;
        Thu,  6 Oct 2016 23:10:48 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Oct 2016
 23:10:52 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 6 Oct 2016 23:10:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Fix -mabi=64 build of vdso.lds
Date:   Thu, 6 Oct 2016 23:10:41 +0100
Message-ID: <a226de28606d340f3e4cf0d6f6f4b4d12e766a69.1475791723.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The native ABI vDSO linker script vdso.lds is built by preprocessing
vdso.lds.S, with the native -mabi flag passed in to get the correct ABI
definitions. Unfortunately however certain toolchains choke on -mabi=64
without a corresponding compatible -march flag, for example:

cc1: error: ‘-march=mips32r2’ is not compatible with the selected ABI
scripts/Makefile.build:338: recipe for target 'arch/mips/vdso/vdso.lds' failed

Fix this by including ccflags-vdso in the KBUILD_CPPFLAGS for vdso.lds,
which includes the appropriate -march flag.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.4.x-
---
 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 3b4538ec0102..de9e8836d248 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -82,7 +82,7 @@ obj-vdso := $(obj-vdso-y:%.o=$(obj)/%.o)
 $(obj-vdso): KBUILD_CFLAGS := $(cflags-vdso) $(native-abi)
 $(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
 
-$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(native-abi)
+$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
 $(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
-- 
git-series 0.8.10
