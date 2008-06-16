Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:37:31 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:2696 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20039034AbYFPOh2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 15:37:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5GEb2Fu029546;
	Mon, 16 Jun 2008 15:37:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5GEb0w5029539;
	Mon, 16 Jun 2008 15:37:00 +0100
Date:	Mon, 16 Jun 2008 15:37:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] malta_mtd.c: add MODULE_LICENSE
Message-ID: <20080616143700.GA28471@linux-mips.org>
References: <20080615161321.GB7865@cs181133002.pp.htv.fi> <20080616133049.GA24056@linux-mips.org> <48567A12.3050206@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48567A12.3050206@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 16, 2008 at 05:34:58PM +0300, Dmitri Vorobiev wrote:

> Every time I come across this file I wonder whether this needs to be
> modularized at all. Isn't you chainsaw itching for this as well? :)

The reason why it was implemented as a module was that due to a MTD
"feature" the code wouldn't compile in 2.6.20 and earlier.  So yes, I
chainsawed it into the right shape, patch is on the way to Linus.

  Ralf
