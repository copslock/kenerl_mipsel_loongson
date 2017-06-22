Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 00:17:18 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:50921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992297AbdFVWRJk0IFa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 00:17:09 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dOAO8-0003Ah-Ot; Fri, 23 Jun 2017 00:15:45 +0200
Date:   Fri, 23 Jun 2017 00:16:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Meyer <thomas@m3y3r.de>, Ingo Molnar <mingo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] kernel/extable.c: mark core_kernel_text notrace
In-Reply-To: <20170622181050.220c23a3@gandalf.local.home>
Message-ID: <alpine.DEB.2.20.1706230012150.2221@nanos>
References: <1498028607-6765-1-git-send-email-marcin.nowakowski@imgtec.com> <20170622181050.220c23a3@gandalf.local.home>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Thu, 22 Jun 2017, Steven Rostedt wrote:
> On Wed, 21 Jun 2017 09:03:26 +0200
> Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> >  
> > -int core_kernel_text(unsigned long addr)
> > +int notrace core_kernel_text(unsigned long addr)
> 
> Is mips the only one with this issue. I hate adding notrace to general
> functions if it is only an issue with a single arch.

We have unwinders using that function and btw, ftrace has a similar issue
with core_kernel_data(). Probably not endless recursive, but not pretty
either if you have trace entries from within the tracer itself.

> Can we add a: mips_notrace? where we have:
> 
> #ifdef CONFIG_MIPS
> # define mips_notrace notrace
> #else 
> # define mips_notrace
> #endif

We can, but that will explode into an unholy mess sooner than later. I know
you'd love to come up with the most convoluted macro magic to make that
happen.

Thanks,

	tglx
