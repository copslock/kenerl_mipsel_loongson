Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2004 04:14:38 +0100 (BST)
Received: from pD9562DA8.dip.t-dialin.net ([IPv6:::ffff:217.86.45.168]:33393
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224772AbUJ0DOd>; Wed, 27 Oct 2004 04:14:33 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9R3EVB8021447;
	Wed, 27 Oct 2004 05:14:31 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9R3EUJQ021446;
	Wed, 27 Oct 2004 05:14:30 +0200
Date: Wed, 27 Oct 2004 05:14:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: colin <colin@realtek.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: Which MIPS kernel is good to start up? linux-mips.org or Montavista?
Message-ID: <20041027031430.GC14668@linux-mips.org>
References: <007801c4bb2a$9e7ded90$8b1a13ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007801c4bb2a$9e7ded90$8b1a13ac@realtek.com.tw>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2004 at 03:08:34PM +0800, colin wrote:

> Hi all,
> We want to begin to put Linux to our new board with 4KEc CPU.
> Is it better to start porting from Montavista's Kernel, or from the one of
> linux-mips.org?
> I phoned the sales of Montavista and he told me the difference of these 2
> kernels are little, but their kernels have been tested a lot for stability.

A kernel isn't everything you'd get from Montavista; the comparison of
a site that's primarily geared towards development and a company that
is selling is probably not appropriate ...

> Naturally, we would like to choose the kernel version above 2.6.

The time where choosing 2.4 for new project still did make sense is over.

  Ralf
