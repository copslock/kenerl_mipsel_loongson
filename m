Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2004 16:57:26 +0000 (GMT)
Received: from p508B5C87.dip.t-dialin.net ([IPv6:::ffff:80.139.92.135]:56448
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225329AbUALQ5Z>; Mon, 12 Jan 2004 16:57:25 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0CGvOfB023557;
	Mon, 12 Jan 2004 17:57:24 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0CGvO1D023556;
	Mon, 12 Jan 2004 17:57:24 +0100
Date: Mon, 12 Jan 2004 17:57:24 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to configure the cache size in r4000
Message-ID: <20040112165724.GA16126@linux-mips.org>
References: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 11, 2004 at 12:48:28PM +0000, karthikeyan natarajan wrote:

>     The cache size is modified by setting the IC/DC
> bits in the 'config' register. Seems they are set only
> by the hardware during the processor reset. And also,
> those bits are mentioned as read only bits..
>    Could you please let me know how can we instruct 
> the hardware to do so. Can we do this via s/w?.

You can't.  These bits are hardwired to indicate the cache size which is
8k per primary cache on the R4000.

  Ralf
