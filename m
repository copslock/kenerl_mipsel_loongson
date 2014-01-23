Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 17:47:02 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:55097 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825727AbaAWQq6NVUB6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 17:46:58 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0NGkolF022075
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 23 Jan 2014 08:46:50 -0800 (PST)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.2.347.0; Thu, 23 Jan 2014 08:46:49 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <paul.gortmaker@windriver.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] mips: restore init.h usage to arch/mips/ar7/time.c
Date:   Thu, 23 Jan 2014 11:46:41 -0500
Message-ID: <1390495601-6938-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39088
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

Commit 0046be10e0c502705fc74d91408eba13a73bc201 ("mips: delete
non-required instances of include <linux/init.h>") inadvertently
removed an include that was actually correct.  Restore it.

Note that it gets init.h implicitly anyway, so this is largely a
cosmetic fixup; no build regressions were caused by this.

Cc: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ For now, I'll carry the patch in the init cleanup series:

   http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git

 but feel free to add it or squash it into the mips-next tree
 if the opportunity arises.]

 arch/mips/ar7/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
index 1dc6c3b37f91..22c93213b233 100644
--- a/arch/mips/ar7/time.c
+++ b/arch/mips/ar7/time.c
@@ -18,6 +18,7 @@
  * Setting up the clock on the MIPS boards.
  */
 
+#include <linux/init.h>
 #include <linux/time.h>
 #include <linux/err.h>
 #include <linux/clk.h>
-- 
1.8.5.2
