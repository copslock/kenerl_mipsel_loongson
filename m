Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 18:22:05 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48259 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494151AbZKTRV7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Nov 2009 18:21:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAKHKx86010986;
	Fri, 20 Nov 2009 17:21:02 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAKHKehe010970;
	Fri, 20 Nov 2009 17:20:40 GMT
Date:	Fri, 20 Nov 2009 17:20:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH v9 03/10] tracing: add an endian argument to
	scripts/recordmcount.pl
Message-ID: <20091120172039.GA6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com> <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 20, 2009 at 08:34:31PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> MIPS and some other architectures need this argument to handle
> big/little endian respectively.
> 
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>

This one is a bit problematic because you seem to have generated the
patch against linux-next but I'm applying it on the MIPS -queue tree and
some other changes on -next are now resulting in a conflict.  And
Steven Rostedt is going to merge a few more changes which he says will
conflict.

So I put this patch on the queue tree but may not propagate it immediately
to linux-next.

Thanks!

  Ralf
