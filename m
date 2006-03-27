Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 16:08:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:36303 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133525AbWC0PI0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2006 16:08:26 +0100
Received: from localhost (p5107-ipad27funabasi.chiba.ocn.ne.jp [220.107.196.107])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8FAADA3A9; Tue, 28 Mar 2006 00:18:41 +0900 (JST)
Date:	Tue, 28 Mar 2006 00:18:54 +0900 (JST)
Message-Id: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org, akpm@osdl.org
Subject: [PATCH] Fix sed regexp to generate asm-offset.h
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
X-archive-position: 10952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Changes to Makefile.kbuild ("kbuild: add -fverbose-asm to i386
Makefile") breaks asm-offset.h file on MIPS.  Other archs possibly
suffer this change too but I'm not sure.

Here is a fix just for MIPS.  

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/Kbuild b/Kbuild
index 95d6a00..2d4f95e 100644
--- a/Kbuild
+++ b/Kbuild
@@ -18,7 +18,7 @@ define sed-y
 	"/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"
 endef
 # Override default regexp for specific architectures
-sed-$(CONFIG_MIPS) := "/^@@@/s///p"
+sed-$(CONFIG_MIPS) := "/^@@@/{s/^@@@//; s/ \#.*\$$//; p;}"
 
 quiet_cmd_offsets = GEN     $@
 define cmd_offsets
