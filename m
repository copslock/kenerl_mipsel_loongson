Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 14:04:07 +0100 (BST)
Received: from [217.169.26.28] ([217.169.26.28]:16010 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20022905AbYGHND4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jul 2008 14:03:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m68D2aai029514;
	Tue, 8 Jul 2008 14:03:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m68D2ZKr029513;
	Tue, 8 Jul 2008 14:02:35 +0100
Date:	Tue, 8 Jul 2008 14:02:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix 32bit kernels on R4k with 128 byte cache line size
Message-ID: <20080708130234.GA29470@linux-mips.org>
References: <20080708124634.4EDFBC3562@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080708124634.4EDFBC3562@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 08, 2008 at 02:46:34PM +0200, Thomas Bogendoerfer wrote:

> The generated copy_page for R4k CPU with a 128 byte cache line size used
> Create Dirty Exclusive cache line operations even if only part of the
> cache line was filled.  This change avoids generating cache operations,
> if only part of the cache line size is copied in one loop. It also
> increases the maxmimum loop size, because the generated code even fits
> into the available space for r4k CPUs with 128 byte cache line size.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks - another important fix in the last minute ...

Applied, will send to Linus tonight.

  Ralf
