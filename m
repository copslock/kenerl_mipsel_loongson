Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2014 11:57:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34893 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822090AbaC0K5MQFtaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2014 11:57:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 262D07FB740D5
        for <linux-mips@linux-mips.org>; Thu, 27 Mar 2014 10:57:04 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 27 Mar
 2014 10:57:06 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 27 Mar 2014 10:57:05 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 27 Mar 2014 10:57:05 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/13] MIPS: MT: core_nvpes function to retrieve VPE count
Date:   Thu, 27 Mar 2014 10:57:01 +0000
Message-ID: <1395917821-11105-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395402961-39632-1-git-send-email-paul.burton@imgtec.com>
References: <1395402961-39632-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39590
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

This function simply returns the number of VPEs present in the current
core, or 1 if the core does not implement the MT ASE. In SMP kernels
this will typically equal smp_num_siblings, however it will also be
usable in UP kernels and helps prepare for the possibility of a
heterogenous system where the VPE count is not the same across all
cores.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
This one wasn't present in the original series, but needs to preceed
"MIPS: fix core number detection for MT cores". Or feel free to squash
it into that patch if you prefer. This function can also be used in a
few other places but in the interests of not making your life even more
difficult I'll leave that cleanup for later.
---
 arch/mips/include/asm/mipsmtregs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index 38b7704..6efa79a 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -176,6 +176,17 @@
 
 #ifndef __ASSEMBLY__
 
+static inline unsigned core_nvpes(void)
+{
+	unsigned conf0;
+
+	if (!cpu_has_mipsmt)
+		return 1;
+
+	conf0 = read_c0_mvpconf0();
+	return ((conf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
+}
+
 static inline unsigned int dvpe(void)
 {
 	int res = 0;
-- 
1.8.5.3
