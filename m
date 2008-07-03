Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 15:50:41 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:37775 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20130414AbYGCOub (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 15:50:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63EnD95009752;
	Thu, 3 Jul 2008 16:49:38 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63EnBf3009738;
	Thu, 3 Jul 2008 15:49:11 +0100
Date:	Thu, 3 Jul 2008 15:49:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable FAST-20 for onboard scsi
Message-ID: <20080703144911.GA9630@linux-mips.org>
References: <20080702190603.26B63C214C@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080702190603.26B63C214C@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 02, 2008 at 09:06:03PM +0200, Thomas Bogendoerfer wrote:

> Both onboard controller of the O2 support FAST-20 transfer speeds,
> but the bit, which signals that to the aic driver, isn't set. Instead
> of adding detection code to the scsi driver, we just fake the missing
> bit in the PCI config space of the scsi chips.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, queued for 2.6.27.

  Ralf
