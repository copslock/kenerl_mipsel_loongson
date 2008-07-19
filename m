Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2008 16:20:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:12251 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025642AbYGSPUk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2008 16:20:40 +0100
Received: from localhost (p1004-ipad301funabasi.chiba.ocn.ne.jp [122.17.251.4])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ED8A2B0F8; Sun, 20 Jul 2008 00:20:33 +0900 (JST)
Date:	Sun, 20 Jul 2008 00:22:24 +0900 (JST)
Message-Id: <20080720.002224.108306935.anemo@mba.ocn.ne.jp>
To:	linux-sparse@vger.kernel.org
Cc:	linux-mips@linux-mips.org, sam@ravnborg.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH] sparse: Make pre_buffer dynamically increasable
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
X-archive-position: 19901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I got this error when running sparse on mips kernel with gcc 4.3:

builtin:272:1: warning: Newline in string or character constant

The linux-mips kernel uses '$(CC) -dM -E' to generates arguments for
sparse.  With gcc 4.3, it generates lot of '-D' options and causes
pre_buffer overflow.  The linux-mips kernel can filter unused symbols
out to avoid overflow, but sparse should be fixed anyway.

This patch make pre_buffer dynamically increasable and add extra
checking for overflow instead of silently truncating.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/lib.c b/lib.c
index 0abcc9a..6e8d09b 100644
--- a/lib.c
+++ b/lib.c
@@ -186,7 +186,8 @@ void die(const char *fmt, ...)
 }
 
 static unsigned int pre_buffer_size;
-static char pre_buffer[8192];
+static unsigned int pre_buffer_alloc_size;
+static char *pre_buffer;
 
 int Waddress_space = 1;
 int Wbitwise = 0;
@@ -232,12 +233,20 @@ void add_pre_buffer(const char *fmt, ...)
 	unsigned int size;
 
 	va_start(args, fmt);
+	if (pre_buffer_alloc_size < pre_buffer_size + getpagesize()) {
+		pre_buffer_alloc_size += getpagesize();
+		pre_buffer = realloc(pre_buffer, pre_buffer_alloc_size);
+		if (!pre_buffer)
+			die("Unable to allocate more pre_buffer space");
+	}
 	size = pre_buffer_size;
 	size += vsnprintf(pre_buffer + size,
-		sizeof(pre_buffer) - size,
+		pre_buffer_alloc_size - size,
 		fmt, args);
 	pre_buffer_size = size;
 	va_end(args);
+	if (pre_buffer_size >= pre_buffer_alloc_size - 1)
+		die("pre_buffer overflow");
 }
 
 static char **handle_switch_D(char *arg, char **next)
