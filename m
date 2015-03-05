Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:00:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46541 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008151AbbCEA70vusyG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 01:59:26 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 36588B97F9CD3;
        Thu,  5 Mar 2015 00:59:17 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 5 Mar
 2015 00:59:21 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 4 Mar 2015
 16:59:19 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 04/15] MIPS: Add sched_clock support
Date:   Wed, 4 Mar 2015 16:58:46 -0800
Message-ID: <1425517137-26463-5-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

This will provide sched_clock interface to implement individual
read_sched_clock(). Not for CAVIUM_OCTEON_SOC as it defines its own
sched_clock() directly (not using the sched_clock_register interface).

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 068592a..09405dc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -43,6 +43,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select BUILDTIME_EXTABLE_SORT
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_CMOS_UPDATE
 	select HAVE_MOD_ARCH_SPECIFIC
 	select VIRT_TO_BUS
-- 
1.8.5.3
