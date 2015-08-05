Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 00:44:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8503 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012613AbbHEWo36TfO8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 00:44:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26267E520F438;
        Wed,  5 Aug 2015 23:44:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 23:44:24 +0100
Received: from localhost (192.168.159.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 5 Aug
 2015 23:44:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] MIPS: CONFIG_MIPS_MT_SMP should depend upon CPU_MIPSR2
Date:   Wed, 5 Aug 2015 15:42:39 -0700
Message-ID: <1438814560-19821-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.103]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48624
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

The MT ASE cannot be used with CPUs that implement older releases of the
MIPS architecture than release 2, and is replaced in release 6. Encode
these constraints in Kconfig to ensure that MT code is only built as
part of kernels targeting an appropriate revision of the architecture.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # 3.16+
---

 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee5f93..ef248cf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2114,7 +2114,7 @@ config CPU_R4K_CACHE_TLB
 
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && CPU_MIPSR2
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-- 
2.5.0
