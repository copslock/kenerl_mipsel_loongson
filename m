Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 14:11:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59859 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039873AbWJJNLq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 14:11:46 +0100
Received: from localhost (p3213-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 33AF9B718; Tue, 10 Oct 2006 22:11:40 +0900 (JST)
Date:	Tue, 10 Oct 2006 22:13:55 +0900 (JST)
Message-Id: <20061010.221355.119270972.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Do not use -msym32 option for modules.
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
X-archive-position: 12862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On 64-bit kernel, modules are loaded into XKSEG for now.  While XKSEG
address is not a sign-extended 32-bit address, we can not use -msym32
option.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2124350..6691086 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -63,7 +63,9 @@ cflags-y		+= -mabi=64
 ifdef CONFIG_BUILD_ELF64
 cflags-y		+= $(call cc-option,-mno-explicit-relocs)
 else
-cflags-y		+= $(call cc-option,-msym32)
+# -msym32 can not be used for modules since they are loaded into XKSEG
+CFLAGS_MODULE		+= $(call cc-option,-mno-explicit-relocs)
+CFLAGS_KERNEL		+= $(call cc-option,-msym32)
 endif
 endif
 
