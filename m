Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 16:26:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:17613 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20036561AbYGHP02 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2008 16:26:28 +0100
Received: from localhost (p2206-ipad301funabasi.chiba.ocn.ne.jp [122.17.252.206])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EB03CAE18; Wed,  9 Jul 2008 00:26:20 +0900 (JST)
Date:	Wed, 09 Jul 2008 00:28:05 +0900 (JST)
Message-Id: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
To:	linux-sparse@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] sparse: Increase pre_buffer[] and check overflow
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
X-archive-position: 19739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I got this error when running sparse on mips kernel with gcc 4.3:

builtin:272:1: warning: Newline in string or character constant

The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
sparse.  With gcc 4.3, it generates lot of '-D' options and causes
pre_buffer overflow.

This patch increase pre_buffer[] size and add extra checking for
overflow instead of silently truncating.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/lib.c b/lib.c
index 0abcc9a..b8b2d57 100644
--- a/lib.c
+++ b/lib.c
@@ -186,7 +186,7 @@ void die(const char *fmt, ...)
 }
 
 static unsigned int pre_buffer_size;
-static char pre_buffer[8192];
+static char pre_buffer[16384];
 
 int Waddress_space = 1;
 int Wbitwise = 0;
@@ -238,6 +238,8 @@ void add_pre_buffer(const char *fmt, ...)
 		fmt, args);
 	pre_buffer_size = size;
 	va_end(args);
+	if (pre_buffer_size >= sizeof(pre_buffer) - 1)
+		die("pre_buffer overflow");
 }
 
 static char **handle_switch_D(char *arg, char **next)
