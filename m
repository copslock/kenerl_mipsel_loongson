Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2004 15:13:44 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:1014 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226285AbUFCONj>;
	Thu, 3 Jun 2004 15:13:39 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA15470;
	Thu, 3 Jun 2004 23:13:34 +0900 (JST)
Received: 4UMDO00 id i53EDXl16268; Thu, 3 Jun 2004 23:13:34 +0900 (JST)
Received: 4UMRO00 id i53EDX625550; Thu, 3 Jun 2004 23:13:33 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 3 Jun 2004 23:13:31 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fix atomic_sub_if_positive() and atomic64_sub_if_positive()
Message-Id: <20040603231331.46ac0070.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I found the mistake about return value of atomic_sub_if_positive()  and atomic64_sub_if_positive().

Please apply this patch to v2.6 CVS tree.

Yoichi


diff -urN -X dontdiff linux-orig/include/asm-mips/atomic.h linux/include/asm-mips/atomic.h
--- linux-orig/include/asm-mips/atomic.h	Fri May 28 23:44:14 2004
+++ linux/include/asm-mips/atomic.h	Sun May 30 12:06:20 2004
@@ -228,7 +228,7 @@
 static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 {
 	unsigned long flags;
-	int temp, result;
+	int temp;
 
 	spin_lock_irqsave(&atomic_lock, flags);
 	temp = v->counter;
@@ -237,7 +237,7 @@
 		v->counter = temp;
 	spin_unlock_irqrestore(&atomic_lock, flags);
 
-	return result;
+	return temp;
 }
 
 #endif /* CONFIG_CPU_HAS_LLSC */
@@ -511,7 +511,7 @@
 static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 {
 	unsigned long flags;
-	long temp, result;
+	long temp;
 
 	spin_lock_irqsave(&atomic_lock, flags);
 	temp = v->counter;
@@ -520,7 +520,7 @@
 		v->counter = temp;
 	spin_unlock_irqrestore(&atomic_lock, flags);
 
-	return result;
+	return temp;
 }
 
 #endif /* CONFIG_CPU_HAS_LLDSCD */
