Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2006 13:38:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:40150 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133598AbWBKNif (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2006 13:38:35 +0000
Received: from localhost (p5152-ipad02funabasi.chiba.ocn.ne.jp [61.207.152.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E273A8F9E; Sat, 11 Feb 2006 22:44:35 +0900 (JST)
Date:	Sat, 11 Feb 2006 22:44:20 +0900 (JST)
Message-Id: <20060211.224420.25910222.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	tbm@cyrius.com, linux-mips@linux-mips.org, anderson@netsweng.com,
	ddaney@avtrex.com, richard@codesourcery.com
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060210013440.GA5436@linux-mips.org>
References: <20060123150507.GA18665@linux-mips.org>
	<87wtg6c43s.fsf@talisman.home>
	<20060210013440.GA5436@linux-mips.org>
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
X-archive-position: 10400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 10 Feb 2006 01:34:40 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> Thanks, makes perfect sense.  I tried various other obscure
ralf> things and your patch was holding up, so I just applied it.

Please add this cast to fix compiler/sparse warnings?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index 7a553e9..252caba 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -284,7 +284,7 @@ do {									\
 	"	.previous					\n"	\
 	: "=r" (__gu_err), "=&r" (__gu_tmp)				\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
-	(val) = __gu_tmp;						\
+	(val) = (__typeof__(val)) __gu_tmp;				\
 }
 
 /*
