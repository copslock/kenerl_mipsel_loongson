Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 21:40:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55459 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021668AbXCIVkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 21:40:03 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l29LcBqN017598;
	Fri, 9 Mar 2007 21:38:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l29LcAFi017597;
	Fri, 9 Mar 2007 21:38:10 GMT
Date:	Fri, 9 Mar 2007 21:38:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, macro@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH] Check FCSR for pending interrupts, alternative version
Message-ID: <20070309213810.GA17591@linux-mips.org>
References: <20070310.010348.72708233.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310.010348.72708233.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 10, 2007 at 01:03:48AM +0900, Atsushi Nemoto wrote:

> 
> The commit 6d6671066a311703bca1b91645bb1e04cc983387 is incomplete and
> misses non-r4k CPUs.  This patch reverts the commit and fixes in other
> way.
> 
> * Do FCSR checking in caller of restore_fp_context.
> * Send SIGFPE if the signal handler set any FPU exception bits.

Applied,

  Ralf
