Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 10:17:41 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:9186
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28574097AbYHSJRe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 10:17:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7J9HVRS027388;
	Tue, 19 Aug 2008 10:17:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7J9HTft027385;
	Tue, 19 Aug 2008 10:17:29 +0100
Date:	Tue, 19 Aug 2008 10:17:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Patrick Glass <Patrick_Glass@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Message-ID: <20080819091729.GA27342@linux-mips.org>
References: <E1KUmPs-0005uZ-Du@localhost> <20080818212812.GA28692@linux-mips.org> <16B817FC3FB4A540BD8003EA6004CE7101A9FDD8@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16B817FC3FB4A540BD8003EA6004CE7101A9FDD8@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 18, 2008 at 04:11:13PM -0700, Patrick Glass wrote:

> Hi,
> I have attempted to submit a new patch for msp71xx which enables gpio
> access through the new gpio framework. Hopefully it should propogate
> throught the list soon... if I have not messed up (It's my first patch
> for linux-mips). Also we have a newer msp_setup that removes the gpio
> calls altogether. I will cleanup our msp_setup.c file and create a new
> patch that can replace this patch if that's ok with you.

Of course.

  Ralf
