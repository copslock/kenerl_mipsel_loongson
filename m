Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 12:09:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55482 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573809AbYAGMJN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 12:09:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07C8r4K025224;
	Mon, 7 Jan 2008 12:08:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07C8qgo025223;
	Mon, 7 Jan 2008 12:08:52 GMT
Date:	Mon, 7 Jan 2008 12:08:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jorgen Lundman <lundman@lundman.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS 4KEc with 2.6.15
Message-ID: <20080107120852.GA24700@linux-mips.org>
References: <478174C1.2090708@lundman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478174C1.2090708@lundman.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 07, 2008 at 09:39:29AM +0900, Jorgen Lundman wrote:

> I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz CPU. 
> It was configured for Sigma's tango2 board, which I know nothing about, so 
> I picked a mips-board by random, "atlas", and found I can produce working 
> kernel module compiles.
>
> However, when I compiled FUSE kernel module, it behaves erratically in a 
> way making the FUSE developer think I may have come across the cache 
> coherency bug in arm and mips, fixed sometime around 2.6.17.
>
> Since I can not change the kernel that is running, I was looking for 
> alternate solutions. FUSE itself has a work around, that calls 
> flush_cache_page(), but I found that mips-board atlas does not have this 
> defined:

While you may not be able to change the kernel running on your board,
you should be building any modules against kernel headers of the exact
kernel running and configured for the platform and CPU you're using.

Mixing and matching different versions and configurations may work but
frequently it will fail silently.

  Ralf
