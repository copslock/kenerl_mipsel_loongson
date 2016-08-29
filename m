Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2016 11:30:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46630 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992028AbcH2JajK9HPp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Aug 2016 11:30:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 293147625EE8C;
        Mon, 29 Aug 2016 10:30:21 +0100 (IST)
Received: from WR-NOWAKOWSKI.wr.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 29 Aug 2016 10:30:22 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/2] MIPS: set NR_syscall_tables appropriately
Date:   Mon, 29 Aug 2016 11:30:07 +0200
Message-ID: <1472463007-6469-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54831
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

Depending on the kernel configuration, up to 3 syscall tables can be
used in parallel - so set the number properly to ensure syscall tracing
is set up properly.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/unistd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index e558130..71162f3d 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -22,6 +22,10 @@
 #define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
 #endif
 
+#define NR_syscall_tables (1 + \
+	IS_ENABLED(CONFIG_MIPS32_O32) + \
+	IS_ENABLED(CONFIG_MIPS32_N32))
+
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_OLD_READDIR
-- 
2.7.4
