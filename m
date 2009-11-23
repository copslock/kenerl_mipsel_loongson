Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 18:46:54 +0100 (CET)
Received: from mx3.mail.elte.hu ([157.181.1.138]:44710 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493288AbZKWRqr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 18:46:47 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1NCczs-0006S6-1O
	from <mingo@elte.hu>; Mon, 23 Nov 2009 18:46:45 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 7EF403E22F6; Mon, 23 Nov 2009 18:46:11 +0100 (CET)
Date:	Mon, 23 Nov 2009 18:46:08 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
Message-ID: <20091123174608.GB6717@elte.hu>
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
 <4B0A8A0B.60405@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0A8A0B.60405@ru.mvista.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-2.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Wu Zhangjin wrote:
> 
> >From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> >(This v5 revision incorporates with the feedbacks from Ingo.)
> 
> >This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> >which provides high resolution. and also, one new kernel option
> >(HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> 
> >Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> >Because cnt32_to_63() needs to be called at least once per half period
> >to work properly, Differ from the old version, this v2 revision set up a
> >kernel timer to ensure the requirement of some MIPSs which have short c0
> >count period.
> 
> >Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> >diff --git a/arch/mips/kernel/csrc-r4k-hres.c b/arch/mips/kernel/csrc-r4k-hres.c
> >new file mode 100644
> >index 0000000..2fe8be7
> >--- /dev/null
> >+++ b/arch/mips/kernel/csrc-r4k-hres.c
> 
>    I don't think this is really good name for this file (one might 
> think that this is another implementation of clocksource instead of 
> some sched_clock() code tied to this particular clocksource), and I 
> don't think we indeed needed to separate that thing into a file of its 
> own, i.e. I'm against Ingo's suggestion in this case.

Well this patch is clearly cleaner than the previous ones - we prefer 
not to contaminate .c files with large #ifdef blocks if it can be 
avoided. (and here it can be avoided easily) YMMV.

Thanks,

	Ingo
