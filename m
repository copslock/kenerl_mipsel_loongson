Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 08:36:22 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:60143 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133397AbWEJGgN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 May 2006 08:36:13 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 10 May 2006 15:36:12 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 66EC62045A;
	Wed, 10 May 2006 15:36:05 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 524AD1FFEB;
	Wed, 10 May 2006 15:36:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4A6a44D099735;
	Wed, 10 May 2006 15:36:05 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 10 May 2006 15:36:04 +0900 (JST)
Message-Id: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use generic DWARF_DEBUG
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

When debugging a kernel compiled by gcc 4.1 with gdb 6.4, gdb could
not show filename, linenumber, etc.  It seems fixed if I used generic
DWARF_DEBUG macro.  Although gcc 3.x seems work without this change,
it would be better to use the generic macro unless there were
something MIPS specific.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 14fa00e..73f7aca 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -155,16 +155,9 @@ #endif
      converted to the new style linker.  */
   .stab 0 : { *(.stab) }
   .stabstr 0 : { *(.stabstr) }
-  /* DWARF debug sections.
-     Symbols in the .debug DWARF section are relative to the beginning of the
-     section so we begin .debug at 0.  It's not clear yet what needs to happen
-     for the others.   */
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
+
+  DWARF_DEBUG
+
   /* These must appear regardless of  .  */
   .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
   .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
