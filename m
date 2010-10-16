Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 23:47:08 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:52888 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491843Ab0JPVo0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 23:44:26 +0200
Received: (qmail 13989 invoked from network); 16 Oct 2010 21:44:22 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Oct 2010 21:44:22 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Oct 2010 14:44:22 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH resend 9/9] MIPS: Allow UserLocal on MIPS_R1 processors
Date:   Sat, 16 Oct 2010 14:22:38 -0700
Message-Id: <b2df70b56f2e1a88f20b32974b4a631d@localhost>
In-Reply-To: <17ebecce124618ddf83ec6fe8e526f93@localhost>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Some MIPS32R1 processors implement UserLocal (RDHWR $29) to accelerate
programs that make extensive use of thread-local storage.  Therefore,
setting up the HWRENA register should not depend on cpu_has_mips_r2.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/traps.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 03ec001..ec6cbd2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1469,6 +1469,7 @@ void __cpuinit per_cpu_trap_init(void)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int status_set = ST0_CU0;
+	unsigned int hwrena = cpu_hwrena_impl_bits;
 #ifdef CONFIG_MIPS_MT_SMTC
 	int secondaryTC = 0;
 	int bootTC = (cpu == 0);
@@ -1501,14 +1502,14 @@ void __cpuinit per_cpu_trap_init(void)
 	change_c0_status(ST0_CU|ST0_MX|ST0_RE|ST0_FR|ST0_BEV|ST0_TS|ST0_KX|ST0_SX|ST0_UX,
 			 status_set);
 
-	if (cpu_has_mips_r2) {
-		unsigned int enable = 0x0000000f | cpu_hwrena_impl_bits;
+	if (cpu_has_mips_r2)
+		hwrena |= 0x0000000f;
 
-		if (!noulri && cpu_has_userlocal)
-			enable |= (1 << 29);
+	if (!noulri && cpu_has_userlocal)
+		hwrena |= (1 << 29);
 
-		write_c0_hwrena(enable);
-	}
+	if (hwrena)
+		write_c0_hwrena(hwrena);
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	if (!secondaryTC) {
-- 
1.7.0.4
