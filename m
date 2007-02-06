Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 15:55:31 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.236]:49953 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038431AbXBFPz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 15:55:26 +0000
Received: by hu-out-0506.google.com with SMTP id 22so985449hug
        for <linux-mips@linux-mips.org>; Tue, 06 Feb 2007 07:54:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=KwHe7wK7c6sSKeF6pB/UVCQzAd6O6p8CC/mmdqOvXHQyeEh6m5TjcQtlaff/u3MwovHLGSJgK3ECWClZqm0Qq/trjYSBdg0peYq4vdSpf8R/hHOLOOfTtl4DoMJ074YxPVSeasuJPGI4V5RIBv18zUk11LrP/om3An4T1WdnsfQ=
Received: by 10.78.172.20 with SMTP id u20mr531657hue.1170777265690;
        Tue, 06 Feb 2007 07:54:25 -0800 (PST)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id q28sm2872148nfc.2007.02.06.07.54.24;
        Tue, 06 Feb 2007 07:54:25 -0800 (PST)
Message-ID: <45C8A477.8070906@innova-card.com>
Date:	Tue, 06 Feb 2007 16:53:27 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] clean up ret_from_{irq,exception}
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch makes these routines a lot more readable whatever
the value of CONFIG_PREEMPT.

It also moves one branch instruction from ret_from_irq()
to ret_from_exception(). Therefore we favour the return
from irq path which should be more common than the other
one.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/entry.S |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index f10b6a1..571029b 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -21,23 +21,18 @@
 #endif
 
 #ifndef CONFIG_PREEMPT
-	.macro	preempt_stop
-	local_irq_disable
-	.endm
 #define resume_kernel	restore_all
 #endif
 
 	.text
 	.align	5
-FEXPORT(ret_from_irq)
-	LONG_S	s0, TI_REGS($28)
-#ifdef CONFIG_PREEMPT
-FEXPORT(ret_from_exception)
-#else
-	b	_ret_from_irq
 FEXPORT(ret_from_exception)
-	preempt_stop
+#ifndef CONFIG_PREEMPT
+	local_irq_disable			# preempt stop
 #endif
+	b	_ret_from_irq
+FEXPORT(ret_from_irq)
+	LONG_S	s0, TI_REGS($28)
 FEXPORT(_ret_from_irq)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
-- 
1.4.4.3.ge6d4
