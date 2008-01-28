Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 22:53:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16074 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28584944AbYA1WxC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jan 2008 22:53:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0SMr1r2027734;
	Mon, 28 Jan 2008 22:53:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0SMr1EM027727;
	Mon, 28 Jan 2008 22:53:01 GMT
Date:	Mon, 28 Jan 2008 22:53:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Split the micro-assembler from tlbex.c (was: Re: your mail)
Message-ID: <20080128225300.GB20434@linux-mips.org>
References: <20080122000026.GN28842@networkno.de> <20080128175128.GA15115@linux-mips.org> <20080128200538.GB23119@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080128200538.GB23119@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 28, 2008 at 08:05:38PM +0000, Thiemo Seufer wrote:

> Split the micro-assembler from tlbex.c.
> 
> This patch moves the micro-assembler in a separate implementation, as
> it is useful for further run-time optimizations. The only change in
> behaviour is cutting down printk noise at kernel startup time.
> 
> Checkpatch complains about macro parameters which aren't protected by
> parentheses. I believe this is a flaw in checkpatch, the paste operator
> used in those macros won't work with parenthesised parameters.
> 
> Signed-off-by:  Thiemo Seufer <ths@networkno.de>

This one works, thanks.

  Ralf
