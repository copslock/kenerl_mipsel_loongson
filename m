Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 17:00:29 +0100 (BST)
Received: from p508B5F50.dip.t-dialin.net ([IPv6:::ffff:80.139.95.80]:41371
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225474AbTI3QAZ>; Tue, 30 Sep 2003 17:00:25 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8UG0NNK009848;
	Tue, 30 Sep 2003 18:00:23 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8UG0NUI009847;
	Tue, 30 Sep 2003 18:00:23 +0200
Date: Tue, 30 Sep 2003 18:00:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
Cc: linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
Message-ID: <20030930160023.GB4231@linux-mips.org>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 29, 2003 at 07:31:57AM -1000, Finney, Steve wrote:

> What would be the downside to enabling 64 bit operations in user space
> on a 32 bit kernel (setting the PX bit in the status register?). The
> particular issue is that I want to access 64 bit-memory mapped registers,
> and I really need to do it as an atomic operation. I tried borrowing
> sibyte/64bit.h from the kernel, but I get an illegal instruction on the
> double ops.

Common design bug in hardware, imho ...

> Also, assuming this isn't a horrible idea, is there any obvious single
> place where "default" values in the CP0 status register get set?

There isn't.

What you want really is a 64-bit kernel.  On a 64-bit kernel even for
processes running in 32-bit address spaces (o32, N32) the processor
will run with the UX bit enabled.  o32 userspace still lives in the
assumption that registers are 32-bit so only those bits will be restored
in function calls etc.  N32 (where userspace isn't ready for prime time
yet) does guarantee that.  And N64 (userspace similarly not ready for
prime time) obviously is fully 64-bit everything.

  Ralf
