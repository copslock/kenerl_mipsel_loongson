Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 08:11:31 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:51590
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023615AbYG2HLX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 08:11:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6T732n1003157;
	Tue, 29 Jul 2008 08:03:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6T730De003155;
	Tue, 29 Jul 2008 08:03:00 +0100
Date:	Tue, 29 Jul 2008 08:03:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Phil Sutter <n0-1@freewrt.org>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] mips/rb532/: flags are unsigned long
Message-ID: <20080729070300.GB1876@linux-mips.org>
References: <20080729064634.GJ7713@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080729064634.GJ7713@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 29, 2008 at 09:46:34AM +0300, Adrian Bunk wrote:

> A recent generic change now catches such bugs:

Thanks, applied.

  Ralf
