Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:11:12 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:13184 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1493091AbZKWNLE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 14:11:04 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 00C8C3ECC; Mon, 23 Nov 2009 05:10:52 -0800 (PST)
Message-ID: <4B0A8A0B.60405@ru.mvista.com>
Date:	Mon, 23 Nov 2009 16:11:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
In-Reply-To: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>

> (This v5 revision incorporates with the feedbacks from Ingo.)

> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> which provides high resolution. and also, one new kernel option
> (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().

> Without it, the Ftrace for MIPS will give useless timestamp information.

> Because cnt32_to_63() needs to be called at least once per half period
> to work properly, Differ from the old version, this v2 revision set up a
> kernel timer to ensure the requirement of some MIPSs which have short c0
> count period.

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

> diff --git a/arch/mips/kernel/csrc-r4k-hres.c b/arch/mips/kernel/csrc-r4k-hres.c
> new file mode 100644
> index 0000000..2fe8be7
> --- /dev/null
> +++ b/arch/mips/kernel/csrc-r4k-hres.c

    I don't think this is really good name for this file (one might think 
that this is another implementation of clocksource instead of some 
sched_clock() code tied to this particular clocksource), and I don't think 
we indeed needed to separate that thing into a file of its own, i.e. I'm 
against Ingo's suggestion in this case.

WBR, Sergei
