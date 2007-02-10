Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 15:41:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:63686 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039014AbXBJPln (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Feb 2007 15:41:43 +0000
Received: from localhost (p3173-ipad210funabasi.chiba.ocn.ne.jp [58.88.122.173])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AC917B89B; Sun, 11 Feb 2007 00:40:20 +0900 (JST)
Date:	Sun, 11 Feb 2007 00:40:20 +0900 (JST)
Message-Id: <20070211.004020.79071872.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45C8A477.8070906@innova-card.com>
References: <45C8A477.8070906@innova-card.com>
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
X-archive-position: 14025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 06 Feb 2007 16:53:27 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> This patch makes these routines a lot more readable whatever
> the value of CONFIG_PREEMPT.
> 
> It also moves one branch instruction from ret_from_irq()
> to ret_from_exception(). Therefore we favour the return
> from irq path which should be more common than the other
> one.

After this patch, entry.S becomes:

FEXPORT(ret_from_exception)
#ifndef CONFIG_PREEMPT
	local_irq_disable			# preempt stop
#endif
	b	_ret_from_irq
FEXPORT(ret_from_irq)
	LONG_S	s0, TI_REGS($28)
FEXPORT(_ret_from_irq)


Apparently your patch add an additional branch in critical path in
CONFIG_PREEMPT=y case.

Maybe this would be better?

#ifdef CONFIG_PREEMPT
FEXPORT(ret_from_irq)
	LONG_S	s0, TI_REGS($28)
FEXPORT(ret_from_exception)
#else
FEXPORT(ret_from_exception)
	local_irq_disable			# preempt stop
	b	_ret_from_irq
FEXPORT(ret_from_irq)
	LONG_S	s0, TI_REGS($28)
#endif
FEXPORT(_ret_from_irq)

---
Atsushi Nemoto
