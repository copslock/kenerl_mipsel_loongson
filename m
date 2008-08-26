Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 22:22:57 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:10684
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20038979AbYHZVWy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 22:22:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7QLMr9l014206;
	Tue, 26 Aug 2008 22:22:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7QLMq18014204;
	Tue, 26 Aug 2008 22:22:52 +0100
Date:	Tue, 26 Aug 2008 22:22:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add missing local_flush_icache_range initialization
	for TX39
Message-ID: <20080826212252.GA13647@linux-mips.org>
References: <20080826.223041.51865296.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080826.223041.51865296.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 26, 2008 at 10:30:41PM +0900, Atsushi Nemoto wrote:

> The commmit 59e39ecd933ba49eb6efe84cbfa5597a6c9ef18a ("Fix WARNING: at
> kernel/smp.c:290") introduced local_flush_icache_range but lacks
> initialization for some TX39 case.

Applied.  Thanks Atsushi-San!

  Ralf
