Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 11:25:50 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2434 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573944AbXJ2LZY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 11:25:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9SNvVlw027634
	for <linux-mips@linux-mips.org>; Sun, 28 Oct 2007 23:57:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9SNvU6Q027633;
	Sun, 28 Oct 2007 23:57:30 GMT
Date:	Sun, 28 Oct 2007 23:57:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make c0_compare_int_usable faster
Message-ID: <20071028235730.GB17038@linux-mips.org>
References: <20071023.011416.61947729.anemo@mba.ocn.ne.jp> <20071022210400.GB20038@linux-mips.org> <20071023.215542.59032245.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023.215542.59032245.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 09:55:42PM +0900, Atsushi Nemoto wrote:

> On Mon, 22 Oct 2007 22:04:00 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > Use delta value based on its speed for faster probing.
> > 
> > Still the same issue, it breaks with Qemu.  You probably don't see this
> > if you're testing on a desktop where the TSC is used for timing but on
> > a laptop it breaks big time.  I need to increase the shift value to at
> > least like 15 to get it to work more or less reliably with Qemu, so a
> > somewhat different approach is needed.
> 
> OK, Here is the different approach.

Looks like it's going to work.  Applied.

Thanks,

  Ralf
