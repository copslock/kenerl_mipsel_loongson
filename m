Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 01:59:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36347 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008146AbbCEA7SxhuiN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 01:59:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 901D6CD91957;
        Thu,  5 Mar 2015 00:59:09 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 5 Mar
 2015 00:59:13 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 4 Mar 2015
 16:59:10 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 01/15] MIPS: Add SCHED_HRTICK support
Date:   Wed, 4 Mar 2015 16:58:43 -0800
Message-ID: <1425517137-26463-2-git-send-email-dengcheng.zhu@imgtec.com>
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
X-archive-position: 46167
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

We have HIGH_RES_TIMERS to support SCHED_HRTICK. But SCHED_HRTICK is in
kernel/Kconfig.hz where HZ values unsuitable for MIPS are defined. So we
simply add this config in arch/mips/Kconfig as opposed to including the
whole kernel/Kconfig.hz.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 294f82e..17f23ed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2500,6 +2500,9 @@ config HZ
 	default 1000 if HZ_1000
 	default 1024 if HZ_1024
 
+config SCHED_HRTICK
+	def_bool HIGH_RES_TIMERS
+
 source "kernel/Kconfig.preempt"
 
 config KEXEC
-- 
1.8.5.3
