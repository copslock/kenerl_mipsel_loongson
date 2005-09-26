Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 13:21:38 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:516 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133525AbVIZMVX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Sep 2005 13:21:23 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8QCLEbP007128;
	Mon, 26 Sep 2005 14:21:14 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8QCLEAk007127;
	Mon, 26 Sep 2005 14:21:14 +0200
Date:	Mon, 26 Sep 2005 14:21:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: DISCONTIGMEM suuport on 32 bits MIPS
Message-ID: <20050926122114.GC3175@linux-mips.org>
References: <cda58cb80509260216591eb96b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80509260216591eb96b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 11:16:27AM +0200, Franck wrote:

> I'm working on a port of 32bit MIPS to a custom board with several
> large holes in the memory map. I would like to know the status of
> discontiguous memory on MIPS. I have noticed that ip27 Kconfig enables
> this feature but I don't see any MIPS generic code that handles it...

IP27 currently the only system that absolutely needs discontiguous
memory in order to work at all.  A few other systems could make use of
discontiguous memory to reduce the waste of memory - the family of
Broadcom SB1 based systems comes to mind.

> Has anybody already done this ? If not then I'll try to work out what
> needed from the corresponding i386 code, but I'd appreciate any
> pointers.

See IP27.  IP27 has one added extra complexity, it's a NUMA system but
you can ignore that.

  Ralf
