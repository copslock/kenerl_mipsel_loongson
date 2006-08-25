Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 01:28:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35235 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038617AbWHYA16 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 01:27:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7P0SCjl001711;
	Fri, 25 Aug 2006 01:28:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7P0SBUT001710;
	Fri, 25 Aug 2006 01:28:11 +0100
Date:	Fri, 25 Aug 2006 01:28:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Peter Watkins <treestem@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
Message-ID: <20060825002811.GA31044@linux-mips.org>
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
X-archive-position: 12431
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

64K pages are not the universal solution to world hunger.  They're a
tradeoff and usually one that is considered apropriate for full blown
supercomputers.  On smaller systems the memory overhead is likely to be
prohibitive.  The memory overhead problem is being worked on but it's
likely to be quite some time before this is finished and integrated.

Do we want to get them to work?  Of course, Linux/MIPS supports some
extremly large systems.  But aside of those 64K pagesize is rarely useful.

  Ralf
