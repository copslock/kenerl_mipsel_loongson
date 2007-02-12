Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 08:45:40 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.225]:15632 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038442AbXBLIpf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 08:45:35 +0000
Received: by qb-out-0506.google.com with SMTP id e12so536855qba
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2007 00:44:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NuVuowrc3P+Ukzo8i85eqAV2WTVoCRxZgIrNZ04KtF51UYCtAJNOp7Lr0ZLFRSDzF9XtPkG4YDmPXBDeDeP13kVH2M1stzm3QvbXFn5yFcZhUcfXSmO+9c5CU0TS1D45nG2DYTRQbNUEi9ZTf4BGzIf+qcO+QPKu+dihkVpAHMA=
Received: by 10.114.254.1 with SMTP id b1mr5556353wai.1171269873302;
        Mon, 12 Feb 2007 00:44:33 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 12 Feb 2007 00:44:33 -0800 (PST)
Message-ID: <cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
Date:	Mon, 12 Feb 2007 09:44:33 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070211.004020.79071872.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45C8A477.8070906@innova-card.com>
	 <20070211.004020.79071872.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 2/10/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Maybe this would be better?
>
> #ifdef CONFIG_PREEMPT
> FEXPORT(ret_from_irq)
>         LONG_S  s0, TI_REGS($28)
> FEXPORT(ret_from_exception)
> #else
> FEXPORT(ret_from_exception)
>         local_irq_disable                       # preempt stop
>         b       _ret_from_irq
> FEXPORT(ret_from_irq)
>         LONG_S  s0, TI_REGS($28)
> #endif
> FEXPORT(_ret_from_irq)
>

well maybe this one would be more readable:

-- >8 --

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index f10b6a1..b5d27d5 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -21,23 +21,20 @@
 #endif

 #ifndef CONFIG_PREEMPT
-	.macro	preempt_stop
-	local_irq_disable
-	.endm
 #define resume_kernel	restore_all
+#else
+#define _ret_from_irq	ret_from_exception
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
+FEXPORT(ret_from_irq)
+	LONG_S	s0, TI_REGS($28)
 FEXPORT(_ret_from_irq)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER



-- 
               Franck
