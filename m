Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 17:09:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:55283 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038981AbWIZQI7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 17:08:59 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F21BA84F0; Wed, 27 Sep 2006 01:08:53 +0900 (JST)
Date:	Wed, 27 Sep 2006 01:11:02 +0900 (JST)
Message-Id: <20060927.011102.122254428.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable
 LOCKDEP_SUPPORT
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45194E14.10203@innova-card.com>
References: <20060926.234401.08077257.anemo@mba.ocn.ne.jp>
	<45194E14.10203@innova-card.com>
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
X-archive-position: 12685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Sep 2006 17:58:12 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > +static inline void
> > +save_raw_context_stack(struct stack_trace *trace, unsigned int skip,
> > +		       unsigned long reg29)
> > +{
> [snip]
> > +
> > +static inline struct pt_regs *
> > +save_context_stack(struct stack_trace *trace, unsigned int skip,
> > +		   struct task_struct *task, struct pt_regs *regs)
> > +{
> > +	unsigned long sp = regs->regs[29];
> 
> Any reasons why marking these 2 functions as inlined ? IMHO gcc is now
> good enough for this decision.

Indeed.  I just made them inlined because I used i386's stacktrace.c
as a template :-)

---
Atsushi Nemoto
