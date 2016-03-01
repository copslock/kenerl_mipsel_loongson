Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:20:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33802 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024626AbcCAWT65XNH- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:19:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0A2B9BA2FF525;
        Tue,  1 Mar 2016 22:19:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:53 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] MIPS: Enable ptrace hw watchpoints on MIPS R6
Date:   Tue, 1 Mar 2016 22:19:37 +0000
Message-ID: <1456870779-21007-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
References: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52391
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

HARDWARE_WATCHPOINTS isn't being enabled for CPU_MIPSR6, even though it
has an identical hardware watchpoint interface to CPU_MIPSR2, which
prevents ptrace watchpoints from being loaded when executing a ptraced
process even though the watchpoints are described in /proc/cpuinfo.

Enable HARDWARE_WATCHPOINTS for CPU_MIPSR6 too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 74a3db92da1b..e9053ab1a847 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2000,7 +2000,7 @@ config MIPS_PGD_C0_CONTEXT
 #
 config HARDWARE_WATCHPOINTS
        bool
-       default y if CPU_MIPSR1 || CPU_MIPSR2
+       default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6
 
 menu "Kernel type"
 
-- 
2.4.10
