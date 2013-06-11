Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 12:04:01 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:49825 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818712Ab3FKKEA5TKSu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 12:04:00 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: kvm: Kconfig: Drop HAVE_KVM dependency from VIRTUALIZATION
Date:   Tue, 11 Jun 2013 11:02:33 +0100
Message-ID: <1370944953-14171-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_11_11_03_55
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Virtualization does not always need KVM capabilities so drop the
dependency. The KVM symbol already depends on HAVE_KVM.

Fixes the following problem on a randconfig:
warning: (REMOTEPROC && RPMSG) selects VIRTUALIZATION which has unmet direct
dependencies (HAVE_KVM)
warning: (REMOTEPROC && RPMSG) selects VIRTUALIZATION which has unmet
direct dependencies (HAVE_KVM)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/kvm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 2c15590..30e334e 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -5,7 +5,6 @@ source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
-	depends on HAVE_KVM
 	---help---
 	  Say Y here to get to see options for using your Linux host to run
 	  other operating systems inside virtual machines (guests).
-- 
1.8.2.1
