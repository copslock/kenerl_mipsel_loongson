Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 17:27:41 +0200 (CEST)
Received: from p508B64E2.dip.t-dialin.net ([80.139.100.226]:23693 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123986AbSI0P1k>; Fri, 27 Sep 2002 17:27:40 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8RFRUQ01811;
	Fri, 27 Sep 2002 17:27:30 +0200
Date: Fri, 27 Sep 2002 17:27:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ioremap in MIPS-IDT..?
Message-ID: <20020927172730.F29970@linux-mips.org>
References: <20020927130955.4099.qmail@webmail23.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927130955.4099.qmail@webmail23.rediffmail.com>; from atulsrivastava9@rediffmail.com on Fri, Sep 27, 2002 at 01:09:55PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 27, 2002 at 01:09:55PM -0000, atul srivastava wrote:

> just now i noted that there is no ioremap.c file in
> source tree.

In which case the small green dots on your kernel source tree is the mould.
Time for an upgrade :-)  Kernel's that don't have arch/mips/mm/ioremap.c
can only support ioremap() for physical addresses < 0x20000000.

  Ralf
