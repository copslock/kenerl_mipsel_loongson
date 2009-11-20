Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 18:25:31 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34024 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494160AbZKTRZJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Nov 2009 18:25:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAKHOhcX011084;
	Fri, 20 Nov 2009 17:24:43 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAKHOcUh011083;
	Fri, 20 Nov 2009 17:24:38 GMT
Date:	Fri, 20 Nov 2009 17:24:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 07/10] tracing: add dynamic function graph tracer
	for MIPS
Message-ID: <20091120172438.GG6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com> <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08257b0ef370f6e04ff9719bf7499bae28c70f4.1258719323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 20, 2009 at 08:34:35PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch make function graph tracer work with dynamic function tracer.
> 
> To share the source code of dynamic function tracer(MCOUNT_SAVE_REGS),
> and avoid restoring the whole saved registers, we need to restore the ra
> register from the stack.
> 
> (NOTE: This not work with 32bit! need to ensure why!)
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33 but due to patch 3/3 I won't propagate this series
immediately to linux-next.

Thanks!

  Ralf
