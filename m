Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 14:48:02 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:48812 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28578867AbYFLNr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 14:47:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5CDlX6x026980;
	Thu, 12 Jun 2008 14:47:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5CDlU3f026961;
	Thu, 12 Jun 2008 14:47:30 +0100
Date:	Thu, 12 Jun 2008 14:47:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Alchemy: register mmc platform device for
	db1200/pb1200 boards.
Message-ID: <20080612134729.GA20015@linux-mips.org>
References: <20080609063521.GA8724@roarinelk.homelinux.net> <20080609063702.GC8724@roarinelk.homelinux.net> <20080612090206.GB21601@linux-mips.org> <20080612101839.GC21601@linux-mips.org> <20080612121828.GA24603@roarinelk.homelinux.net> <20080612122646.GA9493@linux-mips.org> <20080612154248.5c9c5c9d@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080612154248.5c9c5c9d@mjolnir.drzeus.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 03:42:48PM +0200, Pierre Ossman wrote:

> > Pierre, feel free to merge these MIPS bits into your tree.  The whole
> > series should probably go upstream together.
> > 
> 
> How's the dependency issue though? Will this series be bisectable in my
> tree?

If we're only talking about a build, there should be no dependencies
between the Alchemy and the MMC parts of the series.  The Alchemy part
sorts the device registration and that's a separate construction site
from the rest.  Of course with only one applied things won't work
terribly well but that would only be temporarily.

  Ralf
