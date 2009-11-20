Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 18:23:41 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33948 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494154AbZKTRX2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Nov 2009 18:23:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAKHN4hE011031;
	Fri, 20 Nov 2009 17:23:04 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAKHMrqn011030;
	Fri, 20 Nov 2009 17:22:53 GMT
Date:	Fri, 20 Nov 2009 17:22:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 02/10] tracing: enable
	HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
Message-ID: <20091120172253.GC6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com> <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 20, 2009 at 08:34:30PM +0800, Wu Zhangjin wrote:

> There is an exisiting common ftrace_test_stop_func() in
> kernel/trace/ftrace.c, which is used to check the global variable
> ftrace_trace_stop to determine whether stop the function tracing.
> 
> This patch implepment the MIPS specific one to speedup the procedure.
> 
> Thanks goes to Zhang Le for Cleaning it up.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33 but due to patch 3/3 I won't propagate this series
immediately to linux-next.

Thanks!

  Ralf
