Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 16:27:33 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:34182 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28601028AbYGGP1b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jul 2008 16:27:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m67FQU8M006020;
	Mon, 7 Jul 2008 16:26:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m67FQUI8006019;
	Mon, 7 Jul 2008 16:26:30 +0100
Date:	Mon, 7 Jul 2008 16:26:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rbtx4927: misc cleanups
Message-ID: <20080707152629.GA1790@linux-mips.org>
References: <20080416.020045.75183728.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080416.020045.75183728.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 02:00:45AM +0900, Atsushi Nemoto wrote:

> * Merge tx4927_pci.h into tx4927.h
> * Kill (broken) external PCI clock frequency reporting
> * Kill unnecessary wbflush()
> * Kill unnecessary includes
> * Kill debug garbages
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Queued for 2.6.27.  Thanks Atsushi-San!

  Ralf
