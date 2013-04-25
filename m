Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Apr 2013 18:49:17 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38464 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835355Ab3DYQtLydbQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Apr 2013 18:49:11 +0200
Received: by mail-pa0-f46.google.com with SMTP id ld10so1349847pab.19
        for <multiple recipients>; Thu, 25 Apr 2013 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=cwpi5s7+KDmAghbOjkQjr9Nep2/pSWHg1bV09EbW4Xg=;
        b=AUiSl91hynf/CR8PnHLTeCW3wthlR3bTCe8o9c7wXauHmQAhM7LbvLtVbg/zR59Mxo
         TKMKzpDIgYxlMladNQuuTHUInGhkKZKZB+TEtfegvgiByqX/xptRdanHOoSj+N8etsR8
         Ie5baEzYFgRxg0PYtaVRp6Q9zqssNCqdJF8XYbhfe4Thhq0kI4QyGtQtnxT3LZUEtVZ0
         2YUZABvIc091FYRtIv5YHdOIxjN/fNi6VGKD08tu4Kf5XYlOWOvy8IDD44EUgyDfnBAq
         q3Q4c31gNMhCEH+HhfZ/QFpz2YkAgSsOM7+5A2GIVoA8m1UA8OeetFT1nI1NlSQbVhqx
         v8QA==
X-Received: by 10.68.49.193 with SMTP id w1mr53831857pbn.146.1366908539188;
        Thu, 25 Apr 2013 09:48:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id do4sm8024663pbc.8.2013.04.25.09.48.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 09:48:58 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r3PGmut7027575;
        Thu, 25 Apr 2013 09:48:56 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r3PGmtdJ027574;
        Thu, 25 Apr 2013 09:48:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Remove redundant instructions from arch_spin_lock and arch_spin_trylock.
Date:   Thu, 25 Apr 2013 09:48:53 -0700
Message-Id: <1366908533-27541-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

We were doing:
   SRL  $r,$?,16
   ANDI $r,$r,0xffff

The logical right shift by 16 leaves the upper 16 bits clear, so the
subsequent masking out of those bits is redundant, and can safely be
removed.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/spinlock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 0b1dbd2..78d201f 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -71,7 +71,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	 nop						\n"
 		"	srl	%[my_ticket], %[ticket], 16		\n"
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"2:							\n"
@@ -105,7 +104,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	beqz	%[my_ticket], 1b			\n"
 		"	 srl	%[my_ticket], %[ticket], 16		\n"
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"2:							\n"
@@ -153,7 +151,6 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"							\n"
 		"1:	ll	%[ticket], %[ticket_ptr]		\n"
 		"	srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	andi	%[now_serving], %[ticket], 0xffff	\n"
 		"	bne	%[my_ticket], %[now_serving], 3f	\n"
 		"	 addu	%[ticket], %[ticket], %[inc]		\n"
@@ -178,7 +175,6 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"							\n"
 		"1:	ll	%[ticket], %[ticket_ptr]		\n"
 		"	srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	andi	%[now_serving], %[ticket], 0xffff	\n"
 		"	bne	%[my_ticket], %[now_serving], 3f	\n"
 		"	 addu	%[ticket], %[ticket], %[inc]		\n"
-- 
1.7.11.7
