Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 15:20:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51622 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492972AbZI1NUI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Sep 2009 15:20:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8SDLRXe027147;
	Mon, 28 Sep 2009 14:21:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8SDLMDD027129;
	Mon, 28 Sep 2009 14:21:22 +0100
Date:	Mon, 28 Sep 2009 14:21:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-pcmcia@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
Message-ID: <20090928132122.GA26272@linux-mips.org>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net> <20090923123143.GB3131@pengutronix.de> <1253709915.1627.397.camel@sakura.staff.proxad.net> <1253890476.1627.468.camel@sakura.staff.proxad.net> <4ABCF1E7.4010304@ru.mvista.com> <1254142183.1627.488.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254142183.1627.488.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 28, 2009 at 02:49:43PM +0200, Maxime Bizon wrote:

> > a good idea. I'd put the driver in its own separate patch...
> 
> Ralf seems ok with merging as-is, next time I'll split board support and
> driver I guess.

The patch headers patches which are required by the arch and the driver
bits.  To avoid patch ordering issues that could result from splitting
and then most likely submitting the resulting patches via multiple
maintainers it was the easiest to just submit everything in a single
patch.

  Ralf
