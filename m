Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 15:36:08 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:30639
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20118093AbYI0OgE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Sep 2008 15:36:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8REZo7V027239;
	Sat, 27 Sep 2008 15:35:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8REZoZf027238;
	Sat, 27 Sep 2008 15:35:50 +0100
Date:	Sat, 27 Sep 2008 15:35:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6 v3] [MIPS] BCM47xx: Add platform specific PCI code
Message-ID: <20080927143549.GA26502@linux-mips.org>
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net> <20080926182342.GA13542@volta.aurel32.net> <20080927140616.GA4774@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080927140616.GA4774@volta.aurel32.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 27, 2008 at 04:06:16PM +0200, Aurelien Jarno wrote:

> Please find below the version 3 of this patch that addresses all he
> comments. This new version moves all the code to pcibios_plat_dev_init()
> from pcibios_map_irq() to support dynamic interrupt routing. This way
> errors can be reported correctly.

This one looks good.  Thanks, applied.

  Ralf
