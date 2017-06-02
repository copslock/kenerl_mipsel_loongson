Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 23:51:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35413 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993940AbdFBVubZ7L3F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 23:50:31 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1AD1D3DB81046;
        Fri,  2 Jun 2017 22:50:20 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 22:50:24
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/7] MIPS: CPS: Select CONFIG_SYS_SUPPORTS_SCHED_SMT for MIPSr6
Date:   Fri, 2 Jun 2017 14:48:52 -0700
Message-ID: <20170602214856.4545-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602214856.4545-1-paul.burton@imgtec.com>
References: <20170602214856.4545-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58158
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

Prior to MIPSr6 multithreading is only supported if CONFIG_MIPS_MT_SMP
is enabled, so CONFIG_MIPS_MT_SMP selects CONFIG_SYS_SUPPORTS_SCHED_SMT.
With MIPSr6 the CONFIG_MIPS_CPS SMP implementation always supports
multithreading, so have it select CONFIG_SYS_SUPPORTS_SCHED_SMT in order
to allow the scheduler to make better informed decisions on
multithreaded MIPSr6 systems (for example those using I6400 or I6500
CPUs).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..a0d439cb0766 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2369,6 +2369,7 @@ config MIPS_CPS
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
+	select SYS_SUPPORTS_SCHED_SMT if CPU_MIPSR6
 	select SYS_SUPPORTS_SMP
 	select WEAK_ORDERING
 	help
-- 
2.13.0
