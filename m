Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 10:17:52 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:41089 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021905AbZEOJRp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 10:17:45 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M4tXz-0002ZX-Bk; Fri, 15 May 2009 10:17:43 +0100
Date:	Fri, 15 May 2009 10:17:43 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] TXx9: Add ACLC support
Message-ID: <20090515091741.GA4449@sirena.org.uk>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp> <20090515090118.GA7706@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090515090118.GA7706@linux-mips.org>
X-Cookie: Could I have a drug overdose?
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, May 15, 2009 at 10:01:19AM +0100, Ralf Baechle wrote:
> On Thu, May 14, 2009 at 11:50:05PM +0900, Atsushi Nemoto wrote:

> > Add platform support for ACLC of TXx9 SoCs.

> Thanks, queued up for 2.6.31 / linux-next.

These will need revision after fixing my review comments for the audio
drivers - the way the platform devices are set up needs to be changed so
that the resources are associated with devices for the CPU rather than
the machine driver that says how a given board is connected up.
