Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 16:59:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9663 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030569AbYARQ7D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Jan 2008 16:59:03 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0IGx2Rb019321;
	Fri, 18 Jan 2008 16:59:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0IGx1BB019320;
	Fri, 18 Jan 2008 16:59:01 GMT
Date:	Fri, 18 Jan 2008 16:59:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, jeff@garzik.org
Subject: Re: [PATCH] tc35815: Use irq number for tc35815-mac platform
	device id
Message-ID: <20080118165901.GA19235@linux-mips.org>
References: <20080119.011552.41196389.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080119.011552.41196389.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 19, 2008 at 01:15:52AM +0900, Atsushi Nemoto wrote:

> The tc35815-mac platform device used a pci bus number and a devfn to
> identify its target device, but the pci bus number may vary if some
> bus-bridges are found.  Use irq number which is be unique for embedded
> controllers.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Looks ok and seems to be 2.6.24 stuff.

Gotta hash out with Jeff who will merge it.

  Ralf
