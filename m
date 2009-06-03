Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 14:13:52 +0100 (WEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:48394 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022726AbZFCNNn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 14:13:43 +0100
Received: from gandalf ([74.67.89.75]) by hrndva-omta02.mail.rr.com
          with ESMTP
          id <20090603124708504.NBIH11757@hrndva-omta02.mail.rr.com>;
          Wed, 3 Jun 2009 12:47:08 +0000
Date:	Wed, 3 Jun 2009 08:47:07 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Wang Liming <liming.wang@windriver.com>
cc:	wu zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, Wu Zhangjin <wuzj@lemote.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH v2 2/6] mips dynamic function tracer support
In-Reply-To: <4A26129E.1080008@windriver.com>
Message-ID: <alpine.DEB.2.00.0906030841040.14994@gandalf.stny.rr.com>
References: <cover.1243604390.git.wuzj@lemote.com>  <a00a91f6fc79b7d20b5b2193086e879dcafded46.1243604390.git.wuzj@lemote.com>  <4A22281B.7020908@windriver.com> <b00321320906020915n7ba241eqb3cb0de877af514d@mail.gmail.com> <4A26129E.1080008@windriver.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Wed, 3 Jun 2009, Wang Liming wrote:

> wu zhangjin wrote:
> > hi,
> > 
> > sorry, I'm so late to reply your E-mail, a little busy these days.
> > > 
> > > }
> > > 
> > > ----------arch/mips/kernel/module.c:apply_r_mips_26_rel()-------------------
> > > 
> > > v is kernel _mcount's address, location is the address of the instrution
> > > that should be relocated;
> > > 
> > > To resolve this problem, we may need to do more work, either on gcc or on
> > > the kernel. So I want to hear your test result and if you have solution,
> > > please let me know.
> > > 
> > 
> > yes, current version of mips-specific dynamic ftrace not support modules
> > yet.
> > 
> > there is similar solution implemented in PowerPC(something named
> > trampoline),
> > although I did not look into it, but I'm sure we can implement the
> > mips-specific one
> > via imitating it.
> Good hit. I may have a look on Powerpc implementation.

Note, PowerPC uses a trampoline from modules to kernel core. I think MIPS 
just calls mcount differently. That is, it does a full 32bit address call
(64 bit for 64 bit archs?). Something like:

	lui	v1, _mcount
	addiu	v1, v1, _mcount
	jalr	v1
	addiu	sp, sp, -8

Then a nop would not do. Due to preemption, we can not modify more than 
one line. But you could modify it to:

	b	1f
	addiu	v1, v1, _mcount
	jalr	v1
	addiu	sp, sp, -8
1:

Clobbering v1 should not be an issue since it is already used to store 
_mcount. That is, we still do the addiu v1,v1,_mcount with that branch. 
But v1 should be ignored.

-- Steve
