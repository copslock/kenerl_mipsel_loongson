Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2015 18:06:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29425 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012613AbbKJRGvrYJX1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2015 18:06:51 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 00E803512DE3F;
        Tue, 10 Nov 2015 17:06:42 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 10 Nov
 2015 17:06:45 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 10 Nov 2015 17:06:44 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 10 Nov 2015 17:06:44 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH] MIPS: KVM: Fix CP0_EBASE redefined build warning
Date:   Tue, 10 Nov 2015 17:06:37 +0000
Message-ID: <1447175197-6478-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49883
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

The patch "MIPS: CPS: Early debug using an ns16550-compatible UART" in
linux-next causes a build warning in locore.S by adding an identical
definition of CP0_EBASE in asm/mipsregs.h.

arch/mips/kvm/locore.S:41:0: warning: "CP0_EBASE" redefined
 #define CP0_EBASE           $15,1
 ^
In file included from ./arch/mips/include/asm/msa.h:13:0,
                 from ./arch/mips/include/asm/asmmacro.h:13,
                 from arch/mips/kvm/locore.S:13:
./arch/mips/include/asm/mipsregs.h:62:0: note: this is the location of the previous definition
 #define CP0_EBASE $15, 1
 ^

Remove the definition in locore.S and move a few of the other similar
definitions in asm/mipsregs.h too. CP0_INTCTL, CP0_SRSCTL, & CP0_SRSMAP
are unused so they're just dropped instead. CP0_DDATA_LO is left where
it is as I have patches to eliminate its use in locore.S and it
otherwise is unlikely to need to be used from assembly code.

Fixes: "MIPS: CPS: Early debug using an ns16550-compatible UART"
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
Ralf: Please can you take this patch, as the thing it fixes is in the
mips-for-linux-next branch.
---
 arch/mips/include/asm/mipsregs.h | 3 +++
 arch/mips/kvm/locore.S           | 8 --------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e7c1e28438e0..e43aca183c99 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -50,6 +50,7 @@
 #define CP0_PAGEMASK $5
 #define CP0_WIRED $6
 #define CP0_INFO $7
+#define CP0_HWRENA $7, 0
 #define CP0_BADVADDR $8
 #define CP0_BADINSTR $8, 1
 #define CP0_COUNT $9
@@ -62,6 +63,8 @@
 #define CP0_EBASE $15, 1
 #define CP0_CMGCRBASE $15, 3
 #define CP0_CONFIG $16
+#define CP0_CONFIG3 $16, 3
+#define CP0_CONFIG5 $16, 5
 #define CP0_LLADDR $17
 #define CP0_WATCHLO $18
 #define CP0_WATCHHI $19
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index c567240386a0..7bab3a4e8f7d 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -36,14 +36,6 @@
 #define PT_HOST_USERLOCAL   PT_EPC
 
 #define CP0_DDATA_LO        $28,3
-#define CP0_CONFIG3         $16,3
-#define CP0_CONFIG5         $16,5
-#define CP0_EBASE           $15,1
-
-#define CP0_INTCTL          $12,1
-#define CP0_SRSCTL          $12,2
-#define CP0_SRSMAP          $12,3
-#define CP0_HWRENA          $7,0
 
 /* Resume Flags */
 #define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
-- 
2.4.10
