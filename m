Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2009 16:36:24 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51897 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493024AbZHROgR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Aug 2009 16:36:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7IEb79e002354;
	Tue, 18 Aug 2009 15:37:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7IEb7Sh002352;
	Tue, 18 Aug 2009 15:37:07 +0100
Date:	Tue, 18 Aug 2009 15:37:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: More updates to bcm63xx
Message-ID: <20090818143707.GA2327@linux-mips.org>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr> <20090818122427.GA21399@linux-mips.org> <1250605887.23717.188.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1250605887.23717.188.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 18, 2009 at 04:31:27PM +0200, Maxime Bizon wrote:

> > I folded all 8 patches into the existing patches for the linux-bcm63xx
> > tree
> 
> The bcm63xx tree seems wrong.
> 
> The patch from Florian that adds support for 6338 & 6345 is merged with
> commit BCM63XX: Add integrated ethernet mac support.
> 
> The final patch that adds the board code is gone.

I'm just folding some of the patches together.  I'm aware something went
wrong with the ethernet support and I'm sorting that out now.

  Ralf
