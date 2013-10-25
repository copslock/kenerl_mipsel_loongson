Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2013 20:28:13 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1200 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817974Ab3JYS2KqjZ0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Oct 2013 20:28:10 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 25 Oct 2013 11:27:41 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 25 Oct 2013 11:26:59 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 25 Oct 2013 11:26:59 -0700
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 7A2BD246A3; Fri,
 25 Oct 2013 11:26:59 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org,
        Leonid.Yegoshin@imgtec.com, markos.chandras@imgtec.com,
        jim2101024@gmail.com, "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH mips-for-linux-next] MIPS: fix genex.S build for non
 MIPS32r2 class processors
Date:   Fri, 25 Oct 2013 11:26:57 -0700
Message-ID: <1382725617-32561-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
X-WSS-ID: 7E74679C4RS1562600-12-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Commit d712357d ("MIPS: Print correct PC in trace dump after NMI
exception") introduced assembly code which uses the "ehb" instruction,
which is only available in MIPS32r2 class processors and causes such
build errors on MIPS32r1 processors:

  AS      arch/mips/kernel/genex.o
arch/mips/kernel/genex.S: Assembler messages:
arch/mips/kernel/genex.S:386: Error: opcode not supported on this
processor: mips32 (mips32) `ehb'
make[2]: *** [arch/mips/kernel/genex.o] Error 1
make[1]: *** [arch/mips/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....

Use _ehb which properly substitutes to a nop or a real ehb depending on
the processor we are building for.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/genex.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 72853aa..47d7583 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -383,7 +383,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	li	k1, ~(ST0_BEV | ST0_ERL)
 	and     k0, k0, k1
 	mtc0    k0, CP0_STATUS
-	ehb
+	_ehb
 	SAVE_ALL
 	move	a0, sp
 	jal	nmi_exception_handler
-- 
1.8.3.2
