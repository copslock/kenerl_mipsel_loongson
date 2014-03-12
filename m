Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2014 12:02:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:33308 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaCLLCwwH6ZE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2014 12:02:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 855525A44206E
        for <linux-mips@linux-mips.org>; Wed, 12 Mar 2014 11:02:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 12 Mar 2014 11:02:47 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 12 Mar 2014 11:02:46 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: smp-cps: fix NMI detection
Date:   Wed, 12 Mar 2014 11:02:33 +0000
Message-ID: <1394622153-5275-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The code checking whether the core is running the reset vector due to an
NMI was mistakenly using the value of the t0 register rather than the k0
register which contains cp0_status. This meant that if t0 happened to
have bit 19 set when the core powered up it would mistake the reason as
being an NMI, leading to a failure in onlining the CPU. That seems to
happen rarely enough that I didn't catch this until I started
implementing hotplug & ran a script repeatedly offlining & onlining a
CPU.

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Ideally this would be applied as a fixup for "MIPS: Coherent Processing
System SMP implementation".
---
 arch/mips/kernel/cps-vec.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 95dafcb..40c2abe 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -30,7 +30,7 @@ LEAF(mips_cps_core_entry)
 
 	/* Check whether we're here due to an NMI */
 	mfc0	k0, CP0_STATUS
-	and	k0, t0, ST0_NMI
+	and	k0, k0, ST0_NMI
 	beqz	k0, not_nmi
 	 nop
 
-- 
1.8.5.3
