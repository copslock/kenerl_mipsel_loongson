Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 18:25:55 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34042 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1494156AbZKTRZY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Nov 2009 18:25:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAKHP2WS011091;
	Fri, 20 Nov 2009 17:25:02 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAKHOv8L011090;
	Fri, 20 Nov 2009 17:24:57 GMT
Date:	Fri, 20 Nov 2009 17:24:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	rostedt@goodmis.org, Nicholas Mc Guire <der.herr@hofr.at>,
	zhangfx@lemote.com, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 08/10] tracing: make ftrace for MIPS work without
	-fno-omit-frame-pointer
Message-ID: <20091120172457.GH6869@linux-mips.org>
References: <cover.1258719323.git.wuzhangjin@gmail.com> <16e57c64d806acc5fc3440370aa0ff97a5db7dc3.1258719323.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e57c64d806acc5fc3440370aa0ff97a5db7dc3.1258719323.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 20, 2009 at 08:34:36PM +0800, Wu Zhangjin wrote:

> When remove the -fno-omit-frame-pointer, gcc will not save the frame
> pointer for us, we need to save one ourselves.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33 but due to patch 3/3 I won't propagate this series
immediately to linux-next.

Thanks!

  Ralf
