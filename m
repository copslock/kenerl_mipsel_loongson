Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:52:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31801 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGLwmQXlvs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:52:42 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D77181F20C5A0;
        Mon,  7 Nov 2016 11:52:33 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:52:35 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] MIPS: Ensure bss section ends on a long-aligned address
Date:   Mon, 7 Nov 2016 11:52:19 +0000
Message-ID: <20161107115219.23882-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55705
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

When clearing the .bss section in kernel_entry we do so using LONG_S
instructions, and branch whilst the current write address doesn't equal
the end of the .bss section minus the size of a long integer. The .bss
section always begins at a long-aligned address and we always increment
the write pointer by the size of a long integer - we therefore rely upon
the .bss section ending at a long-aligned address. If this is not the
case then the long-aligned write address can never be equal to the
non-long-aligned end address & we will continue to increment past the
end of the .bss section, attempting to zero the rest of memory.

Despite this requirement that .bss end at a long-aligned address we pass
0 as the end alignment requirement to the BSS_SECTION macro and thus
don't guarantee any particular alignment, allowing us to hit the error
condition described above.

Fix this by instead passing 8 bytes as the end alignment argument to
the BSS_SECTION macro, ensuring that the end of the .bss section is
always at least long-aligned.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>

---

Changes in v2:
- Use 8 rather than LONGSIZE, to avoid including asm/asm.h & breaking LONG().

 arch/mips/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index d5de675..f0a0e6d 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -182,7 +182,7 @@ SECTIONS
 	 * Force .bss to 64K alignment so that .bss..swapper_pg_dir
 	 * gets that alignment.	 .sbss should be empty, so there will be
 	 * no holes after __init_end. */
-	BSS_SECTION(0, 0x10000, 0)
+	BSS_SECTION(0, 0x10000, 8)
 
 	_end = . ;
 
-- 
2.10.2
