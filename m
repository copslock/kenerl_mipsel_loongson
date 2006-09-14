Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2006 18:27:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:462 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038903AbWINR12 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Sep 2006 18:27:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8EHS6Aj002194;
	Thu, 14 Sep 2006 18:28:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8EHS53t002193;
	Thu, 14 Sep 2006 18:28:05 +0100
Date:	Thu, 14 Sep 2006 18:28:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
Message-ID: <20060914172805.GA1756@linux-mips.org>
References: <20060708.011245.82794581.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl> <20060709.011259.92587435.anemo@mba.ocn.ne.jp> <20060710.234010.07457279.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710.234010.07457279.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 10, 2006 at 11:40:10PM +0900, Atsushi Nemoto wrote:

> Add special short path for emulationg RDHWR which is used to support
> TLS.  The handle_tlbl synthesizer takes a care for
> cpu_has_vtag_icache.

I'm just wondering if we actually need such optimizations.  Have you ran
any application benchmarks?

  Ralf
