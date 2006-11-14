Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 13:04:40 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25022 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038654AbWKNNEi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 13:04:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAED53RL029227;
	Tue, 14 Nov 2006 13:05:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAED53Pi029226;
	Tue, 14 Nov 2006 13:05:03 GMT
Date:	Tue, 14 Nov 2006 13:05:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Portmap on the Encore M3
Message-ID: <20061114130503.GB28579@linux-mips.org>
References: <1163443607.6532.9.camel@sandbar.kenati.com> <20061113233802.GA17130@linux-mips.org> <1163469787.6532.26.camel@sandbar.kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163469787.6532.26.camel@sandbar.kenati.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 13, 2006 at 06:03:07PM -0800, Ashlesha Shintre wrote:

> > > > 16.35 BogoMIPS (lpj=8176)
> > 
> > Sounds about right if your CPU clock hapens to be 8MHz so probably not.
> > Chances the counter was missprogrammed.  Or are you running uncached?
> > Uncached will completly devastate performance.
> > 
> 
> For the AU1500 processor, the CPU Clock is derived from the PLL whose
> input is 12MHz.. Upon reading the value of the SYS_CPUPLL register in
> the calibrate_delay function, I found out that the multiplying factor is
> 40, thus, the CPU Clock frequency is 480MHz.. Thus the lpj should be
> approximately 480000 -- right?

From a CPU core like the Alchemy core I would more expect half of that
number, 240000.  That is if HZ is 1000 which I believe it was still
hardwired for kernels of the vintage you're running.

> Also I dont know what you mean by "running uncached"?

CONFIG_MIPS_UNCACHED which disables all processor caches.  Bad idea.

> Thanks a lot, I will check the problem with the serial driver -- i m
> using the 8250.c serial driver..

Use CONFIG_SERIAL_AU1X00.

  Ralf
