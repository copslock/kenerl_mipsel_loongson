Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 08:59:20 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:32930 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022736AbXK0I7L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2007 08:59:11 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IwwHe-00074p-01; Tue, 27 Nov 2007 09:59:10 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id BA4A4C2B2B; Tue, 27 Nov 2007 09:59:00 +0100 (CET)
Date:	Tue, 27 Nov 2007 09:59:00 +0100
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix warning when using PHYS_TO_XKSEG_xx()
Message-ID: <20071127085900.GB6733@alpha.franken.de>
References: <20071126223948.C7CB3C2B26@solo.franken.de> <20071126150601.2cd8efc0@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126150601.2cd8efc0@ripper.onstor.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 03:06:01PM -0800, Andrew Sharp wrote:
> This is the basically the patch I submitted 10/31 and I believe is
> queued for 2.6.25 ...

oops, I didn't notice that. If it's in, I could check off that patch
from my list.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
