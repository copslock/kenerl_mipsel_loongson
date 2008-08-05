Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 15:45:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51411 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021374AbYHEOpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 15:45:21 +0100
Received: from localhost (p2220-ipad303funabasi.chiba.ocn.ne.jp [123.217.148.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A2E70A9FF; Tue,  5 Aug 2008 23:45:13 +0900 (JST)
Date:	Tue, 05 Aug 2008 23:45:14 +0900 (JST)
Message-Id: <20080805.234514.39153536.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] vmlinux.lds.S: handle .text.* 
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The -ffunction-sections puts each text in .text.function_name section.
Without this patch, most functions are placed outside _text..._etext
area and it breaks show_stacktrace(), etc.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index b5470ce..afb119f 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -36,6 +36,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		*(.text.*)
 		*(.fixup)
 		*(.gnu.warning)
 	} :text = 0
