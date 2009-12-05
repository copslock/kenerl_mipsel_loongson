Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Dec 2009 13:10:26 +0100 (CET)
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:58566 "EHLO
        gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137AbZLEMKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Dec 2009 13:10:23 +0100
Received: from localhost.localdomain (a88-114-227-145.elisa-laajakaista.fi [88.114.227.145])
        by gw03.mail.saunalahti.fi (Postfix) with ESMTP id 6271A2166F6;
        Sat,  5 Dec 2009 14:10:18 +0200 (EET)
From:   Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] Fix MIPSsim build after command-line cleanup
Date:   Sat,  5 Dec 2009 14:09:20 +0200
Message-Id: <1260014960-16415-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20091205104158.GA11800@linux-mips.org>
References: <20091205104158.GA11800@linux-mips.org>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Commit `MIPSsim: Remove unused code' removed the file
arch/mips/mipssim/sim_cmdline.c but did not clean the
reference to the corresponding object file.  This patch
is to fix the build breakage resulted from the above.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/mipssim/Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mipssim/Makefile b/arch/mips/mipssim/Makefile
index 57f43c1..41b9657 100644
--- a/arch/mips/mipssim/Makefile
+++ b/arch/mips/mipssim/Makefile
@@ -17,8 +17,7 @@
 # 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 #
 
-obj-y := sim_platform.o sim_setup.o sim_mem.o sim_time.o sim_int.o \
-	 sim_cmdline.o
+obj-y := sim_platform.o sim_setup.o sim_mem.o sim_time.o sim_int.o
 
 obj-$(CONFIG_EARLY_PRINTK) += sim_console.o
 obj-$(CONFIG_MIPS_MT_SMTC) += sim_smtc.o
-- 
1.6.3.3
