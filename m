Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 10:14:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13116 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIBINzybcfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 10:13:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 48B6CF022C2D2;
        Fri,  2 Sep 2016 09:13:37 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 09:13:39 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] MIPS: select HAVE_REGS_AND_STACK_ACCESS_API
Date:   Fri, 2 Sep 2016 10:13:21 +0200
Message-ID: <1472804001-1060-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

All the required methods for HAVE_REGS_AND_STACK_ACCESS_API symbol have
been available in the MIPS tree since commit
40e084a506eb ('MIPS: Add uprobes support.'), but the required config symbol
had not been selected

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2638856..212ff92 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -65,6 +65,7 @@ config MIPS
 	select ARCH_CLOCKSOURCE_DATA
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_EXIT_THREAD
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 menu "Machine selection"
 
-- 
2.7.4
