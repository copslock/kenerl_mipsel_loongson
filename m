Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 16:36:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61148 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573881AbXAWQgr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 16:36:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NGakY2021504;
	Tue, 23 Jan 2007 16:36:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NGakLo021503;
	Tue, 23 Jan 2007 16:36:46 GMT
Date:	Tue, 23 Jan 2007 16:36:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 1/7] signals: reduce {setup,restore}_sigcontext sizes
Message-ID: <20070123163646.GA21380@linux-mips.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com> <11695619031540-git-send-email-fbuihuu@gmail.com> <20070123143814.GE18083@linux-mips.org> <cda58cb80701230826i3cba9164jf20678f9efd1a7ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80701230826i3cba9164jf20678f9efd1a7ba@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 05:26:21PM +0100, Franck Bui-Huu wrote:

> No, I haven't. Since the size code has been reduced by a factor 2, I
> would think that signal code can better fit in instruction cache
> lines. For example, the loop is made up by 11 instructions (I don't
> know why gcc makes it so big though) which fits into 3 cache lines in
> my cases. Where as the old code generated 246 instructions for the
> same job, which should cause many more cache misses.
> 
> Do you have any pointers on benchmarks I could run ?

For stuff like this microbenchmarks like lmbench are best suited.  Lmbench
recently moved to http://sourceforge.net/projects/lmbench.

  Ralf
