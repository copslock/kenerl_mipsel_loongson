Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 13:52:14 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.230]:25423 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039260AbXBMNwI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 13:52:08 +0000
Received: by hu-out-0506.google.com with SMTP id 22so1106330hug
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 05:51:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rGxGpOtKYzbM2C83dHBMMfsrFxCXjI1eggUa04Wola49EeEkUA3JFE5WF3IU/R1P+UZYHYu7a0kbO6Y5qBuzIGwVBc/TpRcWbFjjtzEtTByur7DBc7E5a81xARgStHhsTFg27WejYfv+cefQnxZXq61fztMMZ6q0ok7EFTssCro=
Received: by 10.82.114.3 with SMTP id m3mr10970511buc.1171374668401;
        Tue, 13 Feb 2007 05:51:08 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm2768771nfc.2007.02.13.05.51.06;
        Tue, 13 Feb 2007 05:51:07 -0800 (PST)
Message-ID: <45D1C21A.9070801@innova-card.com>
Date:	Tue, 13 Feb 2007 14:50:18 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH] fix irq handling of DECstations
References: <20070212.234826.59032634.anemo@mba.ocn.ne.jp> <20070213022548.GB25323@linux-mips.org>
In-Reply-To: <20070213022548.GB25323@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Feb 12, 2007 at 11:48:26PM +0900, Atsushi Nemoto wrote:
> 
>> It looks 2.6.19 or 2.6.20 does not work on DECStations.
> 
> Applied.  Thanks,
> 

Hi Ralf,

Since you applied Atsushi's patch, can you consider the following
one ?

thanks
		Franck

-- >8 --

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch makes these routines a lot more readable whatever
the value of CONFIG_PREEMPT.

When CONFIG_PREEMPT is not set, it also moves one branch
instruction from ret_from_irq() to ret_from_exception().
Therefore we favour the return from irq case which should be
more common than the other one.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/entry.S |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index f10b6a1..c7429b2 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -21,24 +21,21 @@
 #endif
 
 #ifndef CONFIG_PREEMPT
-	.macro	preempt_stop
-	local_irq_disable
-	.endm
 #define resume_kernel	restore_all
+#else
+#define __ret_from_irq	ret_from_exception
 #endif
 
 	.text
 	.align	5
-FEXPORT(ret_from_irq)
-	LONG_S	s0, TI_REGS($28)
-#ifdef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPT
 FEXPORT(ret_from_exception)
-#else
+	local_irq_disable			# preempt stop
 	b	_ret_from_irq
-FEXPORT(ret_from_exception)
-	preempt_stop
 #endif
-FEXPORT(_ret_from_irq)
+FEXPORT(ret_from_irq)
+	LONG_S	s0, TI_REGS($28)
+FEXPORT(__ret_from_irq)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
-- 
1.4.4.3.ge6d4
