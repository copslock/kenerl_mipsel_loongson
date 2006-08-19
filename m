Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2006 16:31:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:27645 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038480AbWHSPb5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2006 16:31:57 +0100
Received: from localhost (p4121-ipad212funabasi.chiba.ocn.ne.jp [58.91.168.121])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 10730A63B; Sun, 20 Aug 2006 00:31:53 +0900 (JST)
Date:	Sun, 20 Aug 2006 00:33:38 +0900 (JST)
Message-Id: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] qemu does not have dcache aliases
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/mach-qemu/cpu-feature-overrides.h b/include/asm-mips/mach-qemu/cpu-feature-overrides.h
index f4e370e..529445d 100644
--- a/include/asm-mips/mach-qemu/cpu-feature-overrides.h
+++ b/include/asm-mips/mach-qemu/cpu-feature-overrides.h
@@ -20,7 +20,7 @@ #define cpu_has_ejtag		0
 
 #define cpu_has_llsc		1
 #define cpu_has_vtag_icache	0
-#define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
+#define cpu_has_dc_aliases	0
 #define cpu_has_ic_fills_f_dc	0
 
 #define cpu_has_dsp		0
