Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 14:58:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45775 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492827AbZFYM6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jun 2009 14:58:46 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5PCsmB8001642;
	Thu, 25 Jun 2009 13:54:49 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5PCsmGE001638;
	Thu, 25 Jun 2009 13:54:48 +0100
Date:	Thu, 25 Jun 2009 13:54:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make Broadcom SoC naming options consistent
Message-ID: <20090625125448.GA10661@linux-mips.org>
References: <200906251034.32811.florian@openwrt.org> <20090625114258.GA32558@linux-mips.org> <1245930973.30592.63.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1245930973.30592.63.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 25, 2009 at 01:56:13PM +0200, Maxime Bizon wrote:

> > Thanks.  Patch applied nad tree respun against -rc1.  With the AR7
> > stuff finally merged this makes the BCM stuff the longest pending to
> > be merged ...
> 
> I'm considering removing non MIPS stuff (ethernet, usb, pcmcia) from the
> patchset for the moment. Getting ACKs from all subsystems on the same
> merge window is too difficult.
> 
> That way you could merge the CPU support in your tree, and the drivers
> could go via subsystems trees on the next merge window.
> 
> What do you think ?

Agreed.  I think I'll start off by posting the whole series to the list
for everybody's reviewing pleassure then let's sort the whole thing.

  Ralf
