Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 16:33:29 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54625 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023665AbZERPdV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 16:33:21 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M64q6-0007TY-GB; Mon, 18 May 2009 16:33:18 +0100
Date:	Mon, 18 May 2009 16:33:18 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
	(v2)
Message-ID: <20090518153317.GA27195@sirena.org.uk>
References: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp> <20090518142305.GE1629@sirena.org.uk> <20090519.002542.39155238.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090519.002542.39155238.anemo@mba.ocn.ne.jp>
X-Cookie: Am I in GRADUATE SCHOOL yet?
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Tue, May 19, 2009 at 12:25:42AM +0900, Atsushi Nemoto wrote:

> Thank you for elaboration.  Then, this untested patch (on top of the
> last patch) is what you mean?  If yes, I will split this into arch
> part and driver part, and then update both patches.

Partly - I'd also expect to see the resources moved around in the
architecture code so that they are on the platform devices that are
being used to probe the DAIs (unless that's what the architecture side
of your patch was doing, patch wasn't quite giving me enough context to
be 100% clear).

You could also roll the resource requesting and unrequesting into the
probe functions for the DAI & DMA platform devices, though that is not
essential.
