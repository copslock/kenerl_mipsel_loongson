Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jul 2013 13:27:03 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:30016 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822508Ab3GLL1BC4Crz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Jul 2013 13:27:01 +0200
Message-ID: <51DFE7D3.3090002@imgtec.com>
Date:   Fri, 12 Jul 2013 12:26:11 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>, kvm <kvm@vger.kernel.org>
Subject: [PATCH] MIPS: mark KVM_GUEST (T&E KVM) as BROKEN_ON_SMP
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_07_12_12_26_54
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37287
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

Make KVM_GUEST depend on BROKEN_ON_SMP so that it cannot be enabled with
SMP.

SMP kernels use ll/sc instructions for an atomic section in the tlb fill
handler, with a tlbp instruction contained in the middle. This cannot be
emulated with trap & emulate KVM because the tlbp instruction traps and
the eret to return to the guest code clears the LLbit which makes the sc
instruction always fail.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..6a6a096 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1736,6 +1736,7 @@ endchoice
 
 config KVM_GUEST
 	bool "KVM Guest Kernel"
+	depends on BROKEN_ON_SMP
 	help
 	  Select this option if building a guest kernel for KVM (Trap & Emulate) mode
 
-- 
1.8.1.2
