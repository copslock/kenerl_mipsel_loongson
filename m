Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2017 15:23:15 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45972 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990686AbdDANWieFsI- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Apr 2017 15:22:38 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzE-00042I-Q0; Sat, 01 Apr 2017 14:22:36 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuIzD-0004eB-Sg; Sat, 01 Apr 2017 14:22:35 +0100
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
Message-ID: <lsq.1491052670.80726452@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 04/19] MIPS: preserve scalar FP CSR when switching
 vector context
In-Reply-To: <lsq.1491052670.319419763@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57520
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

commit b83406735a4ae0aff4b614664d6a64a0fd6b9917 upstream.

Switching the vector context implicitly saves & restores the state of
the aliased scalar FP data registers, however the scalar FP control
& status register is distinct from the MSA control & status register.
In order to allow scalar FP to function correctly in programs using
MSA, the scalar CSR needs to be saved & restored along with the MSA
vector context.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7301/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/r4k_switch.S | 4 +++-
 arch/mips/kernel/traps.c      | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -64,8 +64,10 @@
 	/* Check whether we're saving scalar or vector context. */
 	bgtz	a3, 1f
 
-	/* Save 128b MSA vector context. */
+	/* Save 128b MSA vector context + scalar FP control & status. */
+	cfc1	t1, fcr31
 	msa_save_all	a0
+	sw	t1, THREAD_FCR31(a0)
 	b	2f
 
 1:	/* Save 32b/64b scalar FP context. */
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1159,6 +1159,11 @@ static int enable_restore_fp_context(int
 
 	/* We need to restore the vector context. */
 	restore_msa(current);
+
+	/* Restore the scalar FP control & status register */
+	if (!was_fpu_owner)
+		asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+
 	return 0;
 }
 
