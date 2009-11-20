Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 18:26:21 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34054 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494161AbZKTRZl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Nov 2009 18:25:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAKHPMjY011110;
	Fri, 20 Nov 2009 17:25:22 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAKHPHg0011107;
	Fri, 20 Nov 2009 17:25:17 GMT
Date:	Fri, 20 Nov 2009 17:25:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 09/10] tracing: reserve $12(t0) for
	mcount-ra-address of gcc 4.5
Message-ID: <20091120172517.GI6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com> <76ddc2b8164e0e2f239ddd81ef1ef6a241540004.1258719323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ddc2b8164e0e2f239ddd81ef1ef6a241540004.1258719323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 20, 2009 at 08:34:37PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> A new option -mmcount-ra-address for gcc 4.5 have been sent by David
> Daney <ddaney@caviumnetworks.com> in the thread "MIPS: Add option to
> pass return address location to _mcount", which help to record the
> location of the return address(ra) for the function graph tracer of MIPS
> to hijack the return address easier and safer. that option used the
> $12(t0) register by default, so, we reserve it for it, and use t1,t2,t3
> instead of t0,t1,t2.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33 but due to patch 3/3 I won't propagate this series
immediately to linux-next.

Thanks!

  Ralf
