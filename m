Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 15:06:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59313 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039467AbWH2OGe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 15:06:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7TE71G3031899;
	Tue, 29 Aug 2006 15:07:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7TE70CI031898;
	Tue, 29 Aug 2006 15:07:00 +0100
Date:	Tue, 29 Aug 2006 15:07:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Peter Watkins <treestem@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
Message-ID: <20060829140700.GD29289@linux-mips.org>
References: <20060823160011.GE20395@networkno.de> <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 23, 2006 at 09:23:24AM -0700, Jonathan Day wrote:

> I am extremely interested in big pages (64K, etc), and
> the sooner the better. If there is anything not
> considered OK for immediate inclusion in the Linux
> MIPS git tree, I would love to have a copy anyway.
> Large pages will be necessary for some high-priority
> work I'm doing, although stability at this point seems
> to be an optional extra. (Hence why the patches are
> much more important than whether they're actually
> finished yet.)

We're getting very close to a 2.6.18 release and 64kB pages are still
quite experimental, so I'm putting all the 64kB pagesize related fixes
into the queue branch.  16kB by now has a few users, so I give it
higher priority.

I've been promised hugetlbfs since quite a while but that somehow never
materialized.  Or maybe that's just because the runtime generated TLB
exception handlers killed the patches ;-)

  Ralf
