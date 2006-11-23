Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 16:15:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49625 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038834AbWKWQPD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2006 16:15:03 +0000
Received: from localhost (p2128-ipad34funabasi.chiba.ocn.ne.jp [124.85.59.128])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 737ECA56B; Fri, 24 Nov 2006 01:14:58 +0900 (JST)
Date:	Fri, 24 Nov 2006 01:17:40 +0900 (JST)
Message-Id: <20061124.011740.108740210.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic_handle_irq, handle_level_irq,
 handle_percpu_irq
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4565C16E.3090803@ru.mvista.com>
References: <45631BD2.4090509@ru.mvista.com>
	<20061122120552.GA27782@linux-mips.org>
	<4565C16E.3090803@ru.mvista.com>
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
X-archive-position: 13249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 23 Nov 2006 18:42:38 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>   BTW, isn't IRQ7 per-CPU?
> 
> > Yes and no.  On many CPUs IRQ 7 can be configured at reset time as either
> > the count / compare interrupt or a CPU interrupt just like the others.
> > It always used to be a normal CPU interrupt for R2000 class CPUs.
> 
>     Nevertheless, IRQ7 having percpu flow when it's known to be from 
> count/compare would make the timer stuff faster, I assume...

It would be faster indeed, but note that handle_percpu_irq() depends
on CONFIG_SMP for now.

---
Atsushi Nemoto
