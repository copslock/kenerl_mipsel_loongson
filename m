Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 15:03:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:35269 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025147AbYG1ODV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 15:03:21 +0100
Received: from localhost (p3065-ipad303funabasi.chiba.ocn.ne.jp [123.217.149.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DCAC5AA6F; Mon, 28 Jul 2008 23:03:15 +0900 (JST)
Date:	Mon, 28 Jul 2008 23:05:12 +0900 (JST)
Message-Id: <20080728.230512.132304415.anemo@mba.ocn.ne.jp>
To:	jason.wessel@windriver.com
Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080725.235233.130241768.anemo@mba.ocn.ne.jp>
References: <20080725.012748.108121457.anemo@mba.ocn.ne.jp>
	<488941C5.9060908@windriver.com>
	<20080725.235233.130241768.anemo@mba.ocn.ne.jp>
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
X-archive-position: 19990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 25 Jul 2008 23:52:33 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > It seem ok to me to try it.  Here is version 3 of the patch, which I was going to send to Ralf.
> 
> Thanks, it works for me with serial_txx9 kgdboc module.

BTW, is FRAME_POINTER mandatory for kgdb?  I agree that FRAME_POINTER
(ie. -fno-omit-frame-pointer -fno-optimize-sibling-calls) helps source
level debugging, but I think transparency is more important.

Now kgdboc can be loaded/activated at run-time, so I want to enable
CONFIG_KGDB usually.  But CONFIG_FRAME_POINTER introduces runtime
overhead on overall kernel, which is too bad (at least on MIPS).

Also, selecting FRAME_POINTER (which is not selectable on MIPS)
unconditionally looks somewhat inconsistent.

So ... Is this patch reasonable?


Subject: kgdb: Do not select FRAME_POINTER on MIPS

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index a5d4b1d..cc61bf0 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -7,7 +7,7 @@ config HAVE_ARCH_KGDB
 
 menuconfig KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	select FRAME_POINTER
+	select FRAME_POINTER if !MIPS
 	depends on HAVE_ARCH_KGDB
 	depends on DEBUG_KERNEL && EXPERIMENTAL
 	help
