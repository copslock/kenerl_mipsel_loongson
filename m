Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:28:28 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:50410
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28579709AbYHRV2S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2008 22:28:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7ILSDib006326;
	Mon, 18 Aug 2008 22:28:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7ILSCS5006324;
	Mon, 18 Aug 2008 22:28:12 +0100
Date:	Mon, 18 Aug 2008 22:28:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Message-ID: <20080818212812.GA28692@linux-mips.org>
References: <E1KUmPs-0005uZ-Du@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1KUmPs-0005uZ-Du@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 17, 2008 at 11:51:48AM -0600, Shane McDonald wrote:
> From: Shane McDonald <mcdonald.shane@gmail.com>
> Date: Sun, 17 Aug 2008 11:51:48 -0600
> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
> 
> The msp71xx_defconfig has never compiled in a kernel release.  This is
> because the file msp_setup.c relies on some definitions from the PMCMSP
> GPIO driver, which has not yet been accepted into the kernel.
> This patch checks for the existence of the PMCMSP GPIO driver;
> if it doesn't exist, no GPIO functions are referenced.
> 
> This patch will continue to work after the GPIO driver has been accepted,
> so no changes will be necessary when that happens.

Has the driver actually been submitted?  In its current form I doubt it'll
be accepted since there is now a generic GPIO framework so there should
be no more new drivers/char/ GPIO drivers.

  Ralf
