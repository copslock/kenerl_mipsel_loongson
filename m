Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 15:33:52 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45257 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038817AbWLCPdr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 15:33:47 +0000
Received: from localhost (p6165-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7ED55C0D1; Mon,  4 Dec 2006 00:33:42 +0900 (JST)
Date:	Mon, 04 Dec 2006 00:33:42 +0900 (JST)
Message-Id: <20061204.003342.75185311.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix 64-bit build
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
X-archive-position: 13328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

commit d89d8e0637a5e4e0a12e90c4bc934d0d4c335239 break 64-bit build.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
index 7978d8e..3657670 100644
--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -375,7 +375,7 @@ #define atomic_add_negative(i,v) (atomic
 
 #ifdef CONFIG_64BIT
 
-typedef struct { volatile __s64 counter; } atomic64_t;
+typedef struct { volatile long counter; } atomic64_t;
 
 #define ATOMIC64_INIT(i)    { (i) }
 
