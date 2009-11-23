Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 11:37:18 +0100 (CET)
Received: from mx2.mail.elte.hu ([157.181.151.9]:47591 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492521AbZKWKhL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 11:37:11 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1NCWHt-0008Qw-Bc
	from <mingo@elte.hu>; Mon, 23 Nov 2009 11:36:58 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2BAF43E22E1; Mon, 23 Nov 2009 11:36:48 +0100 (CET)
Date:	Mon, 23 Nov 2009 11:36:50 +0100
From:	Ingo Molnar <mingo@elte.hu>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
Message-ID: <20091123103650.GA30666@elte.hu>
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.2.5
	_SUMMARY_
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> (This v5 revision incorporates with the feedbacks from Ingo.)
> 
> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> which provides high resolution. and also, one new kernel option
> (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> 
> Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> Because cnt32_to_63() needs to be called at least once per half period
> to work properly, Differ from the old version, this v2 revision set up a
> kernel timer to ensure the requirement of some MIPSs which have short c0
> count period.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig                |   18 ++++++++++++
>  arch/mips/include/asm/time.h     |   15 ++++++++++
>  arch/mips/kernel/Makefile        |    1 +
>  arch/mips/kernel/csrc-r4k-hres.c |   54 ++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/csrc-r4k.c      |    2 +
>  5 files changed, 90 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/kernel/csrc-r4k-hres.c

Looks good!

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
