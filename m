Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2017 15:22:48 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45976 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdDANWidqzS- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2017 15:22:38 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzE-00042J-R1; Sat, 01 Apr 2017 14:22:36 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzD-0004eG-TQ; Sat, 01 Apr 2017 14:22:35 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>
Date:   Sat, 01 Apr 2017 14:17:50 +0100
Message-ID: <lsq.1491052670.178507888@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 05/19] MIPS: save/disable MSA in lose_fpu
In-Reply-To: <lsq.1491052670.319419763@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.43-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 33c771ba5c5d067f85a5a6c4b11047219b5b8f4e upstream.

The kernel depends upon MSA never being enabled when the FPU is not, a
condition which is currently violated in a few places (whilst saving
sigcontext, following mips_cpu_save). Catch all the problem cases by
disabling MSA in lose_fpu, after saving context if necessary.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7302/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/fpu.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -21,6 +21,7 @@
 #include <asm/hazards.h>
 #include <asm/processor.h>
 #include <asm/current.h>
+#include <asm/msa.h>
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 #include <asm/mips_mt.h>
@@ -141,13 +142,21 @@ static inline int own_fpu(int restore)
 static inline void lose_fpu(int save)
 {
 	preempt_disable();
-	if (is_fpu_owner()) {
+	if (is_msa_enabled()) {
+		if (save) {
+			save_msa(current);
+			asm volatile("cfc1 %0, $31"
+				: "=r"(current->thread.fpu.fcr31));
+		}
+		disable_msa();
+		clear_thread_flag(TIF_USEDMSA);
+	} else if (is_fpu_owner()) {
 		if (save)
 			_save_fp(current);
-		KSTK_STATUS(current) &= ~ST0_CU1;
-		clear_thread_flag(TIF_USEDFPU);
 		__disable_fpu();
 	}
+	KSTK_STATUS(current) &= ~ST0_CU1;
+	clear_thread_flag(TIF_USEDFPU);
 	preempt_enable();
 }
 
