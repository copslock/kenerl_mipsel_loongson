Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 12:04:09 +0000 (GMT)
Received: from p508B6A65.dip.t-dialin.net ([IPv6:::ffff:80.139.106.101]:25636
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225249AbUL0MEF>; Mon, 27 Dec 2004 12:04:05 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBRC3ruo025534;
	Mon, 27 Dec 2004 13:03:53 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBRC3iiL025533;
	Mon, 27 Dec 2004 13:03:44 +0100
Date: Mon, 27 Dec 2004 13:03:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: please export probe_irq_mask
Message-ID: <20041227120344.GA25442@linux-mips.org>
References: <20041227.144804.30188040.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227.144804.30188040.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 27, 2004 at 02:48:04PM +0900, Atsushi Nemoto wrote:

> Now probe_irq_mask is in kernel/irq/autoprobe.c, but it is not
> exported.  Please export it as past.
> 
> Here is a patch (or kernel/irq/autoprobe.c should be fixed?)

I think so but for the time being each arch is exporting the thing itself.

You're using probe_irq_mask for ISA, I assume?

  Ralf
