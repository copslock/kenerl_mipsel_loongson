Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 17:32:14 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:5148 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S28574667AbXK0RcF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2007 17:32:05 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 27 Nov 2007 09:31:57 -0800
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 27 Nov 2007 09:31:57 -0800
Date:	Tue, 27 Nov 2007 09:31:57 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix warning when using PHYS_TO_XKSEG_xx()
Message-ID: <20071127093157.137e231f@ripper.onstor.net>
In-Reply-To: <20071127085900.GB6733@alpha.franken.de>
References: <20071126223948.C7CB3C2B26@solo.franken.de>
	<20071126150601.2cd8efc0@ripper.onstor.net>
	<20071127085900.GB6733@alpha.franken.de>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2007 17:31:57.0107 (UTC) FILETIME=[68BBB830:01C8311B]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Tue, 27 Nov 2007 09:59:00 +0100 tsbogend@alpha.franken.de (Thomas
Bogendoerfer) wrote:

> On Mon, Nov 26, 2007 at 03:06:01PM -0800, Andrew Sharp wrote:
> > This is the basically the patch I submitted 10/31 and I believe is
> > queued for 2.6.25 ...
> 
> oops, I didn't notice that. If it's in, I could check off that patch
> from my list.

I tried to check, but apparently I don't pull the queue branch
anymore.  I don't remember why.

Cheers,

a
