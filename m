Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 16:32:07 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:39418 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992143AbcL0PcAwRlSR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Dec 2016 16:32:00 +0100
Received: from hauke-desktop.lan (p4FD97BB3.dip0.t-ipconnect.de [79.217.123.179])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 77F1210047A;
        Tue, 27 Dec 2016 16:31:59 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     paul.gortmaker@windriver.com, linux-mips@linux-mips.org,
        john@phrozen.org, lkp@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: lantiq: set physical_memsize
Date:   Tue, 27 Dec 2016 16:31:43 +0100
Message-Id: <20161227153143.8601-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

physical_memsize is needed by the vpe loader code and the platform
specific code has to define it. This value will be given to the
firmware loaded with the VPE loader. I am not aware of any standard
interface or better value to provide here.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/prom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 4cbb000e778e..96773bed8a8a 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -26,6 +26,12 @@ DEFINE_SPINLOCK(ebu_lock);
 EXPORT_SYMBOL_GPL(ebu_lock);
 
 /*
+ * This is needed by the VPE loader code, just set it to 0 and assume
+ * that the firmware hardcodes this value to something useful.
+ */
+unsigned long physical_memsize = 0L;
+
+/*
  * this struct is filled by the soc specific detection code and holds
  * information about the specific soc type, revision and name
  */
-- 
2.11.0
