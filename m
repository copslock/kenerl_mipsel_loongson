Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 18:02:43 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3819 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903424Ab2HNQCf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 18:02:35 +0200
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 14 Aug 2012 09:00:34 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 14 Aug 2012 09:02:22 -0700
Received: from jc-linux.netlogicmicro.com (unknown [10.7.2.153]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EF4199F9F5; Tue, 14
 Aug 2012 09:02:20 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: Fix for warning from FPU emulation code
Date:   Tue, 14 Aug 2012 21:33:40 +0530
Message-ID: <1344960220-30068-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20120814133858.GA30856@linux-mips.org>
References: <20120814133858.GA30856@linux-mips.org>
MIME-Version: 1.0
X-WSS-ID: 7C34A9A849819262306-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The default implementation of 'cpu_has_fpu' macro calls
smp_processor_id() which causes this warning to be printed when
preemption is enabled:

[    4.664000] Algorithmics/MIPS FPU Emulator v1.5
[    4.676000] BUG: using smp_processor_id() in preemptible [00000000] code: ini
[    4.700000] caller is fpu_emulator_cop1Handler+0x434/0x27b8

Use 'raw_cpu_has_fpu' macro in cop1_64bit() instead of 'cpu_has_fpu'
to fix this. Fix suggested by Ralf Baechle <ralf@linux-mips.org>

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/math-emu/cp1emu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index a03bf00..663bfb9 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -178,7 +178,7 @@ static int isBranchInstr(mips_instruction * i)
  */
 static inline int cop1_64bit(struct pt_regs *xcp)
 {
-	if (cpu_has_fpu)
+	if (raw_cpu_has_fpu)
 		return xcp->cp0_status & ST0_FR;
 #ifdef CONFIG_64BIT
 	return !test_thread_flag(TIF_32BIT_REGS);
-- 
1.7.9.5
