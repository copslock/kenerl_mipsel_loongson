Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 10:47:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3396 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842530AbaGVIa1p4HqP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 10:30:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ACC529550CDAE
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 09:29:59 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 22 Jul
 2014 09:30:01 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 09:30:01 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.158) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 09:30:00 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: Select SMP symbols for CMP
Date:   Tue, 22 Jul 2014 09:29:34 +0100
Message-ID: <1406017774-2187-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41422
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

CMP is an SMP implementation, and as a result of which, it needs
to select the SYS_SUPPORTS_SMP and SMP symbols. This fixes the
following build problem when CMP is enabled but SMP is not.

In file included from arch/mips/kernel/smp-cmp.c:34:0:
./arch/mips/include/asm/smp.h:26:0: error: "raw_smp_processor_id" redefined
[-Werror]
 #define raw_smp_processor_id() (current_thread_info()->cpu)
[...]
In file included from arch/mips/kernel/smp-cmp.c:34:0:
./arch/mips/include/asm/smp.h:59:20: error: redefinition of
'smp_send_reschedule'
[...]
./arch/mips/include/asm/smp.h: In function 'smp_send_reschedule':
./arch/mips/include/asm/smp.h:63:8: error: dereferencing pointer to incomplete
type

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4e238e6e661c..9e3b67c65a32 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2026,7 +2026,9 @@ config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP
 	select MIPS_GIC_IPI
+	select SMP
 	select SYNC_R4K
+	select SYS_SUPPORTS_SMP
 	select WEAK_ORDERING
 	default n
 	help
-- 
2.0.2
