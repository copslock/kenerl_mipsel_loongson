Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 11:01:22 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:41688
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28573881AbYHSKBQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 11:01:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7JA1BWs029667;
	Tue, 19 Aug 2008 11:01:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7JA1Ama029666;
	Tue, 19 Aug 2008 11:01:10 +0100
Date:	Tue, 19 Aug 2008 11:01:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Patrick Glass <patrickglass@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: PMC MSP71XX gpio drivers
Message-ID: <20080819100110.GC28692@linux-mips.org>
References: <20080818214130.10283.80918.stgit@bby1swd01.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080818214130.10283.80918.stgit@bby1swd01.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 18, 2008 at 02:41:30PM -0700, Patrick Glass wrote:

> This new gpio driver for PMC-Sierra's MSP71xx SoC allows
> standard api calls for access to the general and extended
> gpio's.
> 
> Signed-off-by: Patrick Glass <patrickglass@gmail.com>

Patrick,

I've put your patch into the queue for 2.6.28 since by itself it doesn't
cure the MSP platform yet.  If the further patches would fix the platform
I'd push them to Linus for 2.6.27.

  Ralf
