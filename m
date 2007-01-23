Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:38:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16784 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579118AbXAWOiQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:38:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NEcE4D018944;
	Tue, 23 Jan 2007 14:38:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NEcE4W018943;
	Tue, 23 Jan 2007 14:38:14 GMT
Date:	Tue, 23 Jan 2007 14:38:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 1/7] signals: reduce {setup,restore}_sigcontext sizes
Message-ID: <20070123143814.GE18083@linux-mips.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com> <11695619031540-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11695619031540-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 03:18:17PM +0100, Franck Bui-Huu wrote:

> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This trivial change reduces considerably code size of these
> 2 functions callers. For instance, here is the figures for
> arch/kernel/signal.o objects:
> 
>    text    data     bss     dec     hex filename
>   11972       0       0   11972    2ec4 arch/mips/kernel/signal.o~old
>    5380       0       0    5380    1504 arch/mips/kernel/signal.o~new

Have you ran any benchmarks on this?  Unrolling the loops used to make
a noticable difference.

  Ralf
