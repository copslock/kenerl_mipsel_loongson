Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 13:02:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30384 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029542AbXIZMCj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 13:02:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8QC2cud026388;
	Wed, 26 Sep 2007 13:02:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8QC2bT1026385;
	Wed, 26 Sep 2007 13:02:37 +0100
Date:	Wed, 26 Sep 2007 13:02:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ricardo Mendoza <ricmm@kanux.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: IP32: serial console broken with current git
Message-ID: <20070926120237.GB24426@linux-mips.org>
References: <20070925182453.GA15749@deprecation.cyrius.com> <46F93692.4050801@kanux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F93692.4050801@kanux.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 25, 2007 at 12:25:54PM -0400, Ricardo Mendoza wrote:

> Martin Michlmayr wrote:
> > With current git (and 2.6.23-rc1), nothing shows up on the serial
> > console on IP32.  Ricardo Mendoza commented on this on IRC:
> > 
> >> I think it was that using iobase member in the plat_serial8250_port
> >> struct was not working, swapping to membase gave console messages
> >> but kind of stopped printing messages at some point (further in than
> >> first line of C tho)
> > 
> > He also sent me a patch to test.  With this patch, I get serial
> > console output - but only until:
> > 
> > | Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> > | serial8250.0: ttyS0 at MMIO 0x0 (irq = 53) is a 16550A
> > | console [ttyS0] enabled
> > 
> > Maybe Ricardo can post his patch for comments and someone can look
> > into the second issue.
> 
> 
> The patch is the following, please ignore the rewrite of the MACE_PORT
> specifications, those are not needed (I don't remember why I did that at
> all).
> 
> As Martin said, the output stops on the 'console [ttyS0] enabled'
> message. I don't know much about the serial code internals but I presume
> something is getting trashed on the console setup.. or perhaps it's just
> something really dumb like a missing call or something. Someone
> enlightened in the issue can perhaps shed a light.

The membase part of it looks right.

  Ralf
