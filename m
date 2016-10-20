Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 22:30:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9341 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993038AbcJTU2vOjdTK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 22:28:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A89AD71BA7D1D;
        Thu, 20 Oct 2016 21:28:40 +0100 (IST)
Received: from localhost (10.100.200.119) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 20 Oct
 2016 21:28:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 6/6] MIPS: Use thin archives & dead code elimination
Date:   Thu, 20 Oct 2016 21:27:05 +0100
Message-ID: <20161020202705.3783-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161020202705.3783-1-paul.burton@imgtec.com>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.119]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55535
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

Enable CONFIG_THIN_ARCHIVES & CONFIG_LD_DEAD_CODE_DATA_ELIMINATION for
MIPS, ensuring that we keep the data bus exception table & the machine
list which would be discarded without marking them with KEEP.

This shrinks a typical generic kernel build with drivers enabled for
Boston, Ci40 & SEAD-3 by around 5%, or ~450kb. As reported by
bloat-o-meter:

  add/remove: 0/3028 grow/shrink: 1/14 up/down: 18/-457362 (-457344)
  ...
  Total: Before=9001030, After=8543686, chg -5.08%

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

---

 arch/mips/Kconfig              | 2 ++
 arch/mips/kernel/vmlinux.lds.S | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..8557667 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -66,6 +66,8 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select THIN_ARCHIVES
+	select LD_DEAD_CODE_DATA_ELIMINATION
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index d1f5401..a43ba2a 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -72,7 +72,7 @@ SECTIONS
 	/* Exception table for data bus errors */
 	__dbe_table : {
 		__start___dbe_table = .;
-		*(__dbe_table)
+		KEEP(*(__dbe_table))
 		__stop___dbe_table = .;
 	}
 
@@ -122,7 +122,7 @@ SECTIONS
 	. = ALIGN(4);
 	.mips.machines.init : AT(ADDR(.mips.machines.init) - LOAD_OFFSET) {
 		__mips_machines_start = .;
-		*(.mips.machines.init)
+		KEEP(*(.mips.machines.init))
 		__mips_machines_end = .;
 	}
 
-- 
2.10.0
