Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 16:07:28 +0000 (GMT)
Received: from p508B60ED.dip.t-dialin.net ([IPv6:::ffff:80.139.96.237]:25259
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbTKZPx4>; Wed, 26 Nov 2003 15:53:56 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAQFrsA0010941;
	Wed, 26 Nov 2003 16:53:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAQFrk6M010929;
	Wed, 26 Nov 2003 16:53:46 +0100
Date: Wed, 26 Nov 2003 16:53:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49Lx support
Message-ID: <20031126155345.GA10842@linux-mips.org>
References: <20031126.150719.104026850.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126.150719.104026850.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 26, 2003 at 03:07:19PM +0900, Atsushi Nemoto wrote:

> Some TX49 do not have FPU.  We can tell such CPUs by bit3 of PrID.
> Here is a patch for 2.4 tree.  The first hunk can also be used for 2.6
> tree.  Please apply.  Thank you.

In general I'd like to ask people to send patches for 2.4 and 2.6 in
separate email.

I applied your patch with a little change for clarity; I also
restructured the 64-bit cpu-probe.c the same way as it's 32-bit
counterpart to keep the two files more similar.

  Ralf
