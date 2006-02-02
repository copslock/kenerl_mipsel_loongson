Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:49:50 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:45086 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465645AbWBBQtd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 16:49:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12Gsaun020901;
	Thu, 2 Feb 2006 16:54:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12Gsaqw020900;
	Thu, 2 Feb 2006 16:54:36 GMT
Date:	Thu, 2 Feb 2006 16:54:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: can read/write to mprotect(PROT_NONE) region with 2.6.14 on au1550
Message-ID: <20060202165436.GB17352@linux-mips.org>
References: <ecb4efd10512071351scea736fg8d026e3fa3c54c79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb4efd10512071351scea736fg8d026e3fa3c54c79@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 07, 2005 at 04:51:23PM -0500, Clem Taylor wrote:

> I was trying to use mprotect(PROT_NONE) to help debug a problem, and
> it seems that mprotect() isn't actually doing anything with my 2.6.14
> linux-mips kernel on an au1550. Attached is a simple test program that
> segfaults as expected on x86 (2.6.12), but does not segfault on mips
> (2.6.14). I can both read and write PROT_NONE memory without problem,
> which should result in a segfault. Originally, I was trying to
> mprotect() a mmaped GFP_DMA region which wasn't working and then I
> tried a simpler test that also wasn't working.
> 
> Shouldn't mprotect() work? Could I be missing a config option, or is
> this just broken?

That's a defect in CONFIG_64BIT_PHYS_ADDR which unfortunately is need
on Alchemy SOCs due to the silly address space layout.

  Ralf
