Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:16:19 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:65444 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22307178AbYJXRQO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 18:16:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OHG6qx027648;
	Fri, 24 Oct 2008 18:16:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OHG5qQ027646;
	Fri, 24 Oct 2008 18:16:05 +0100
Date:	Fri, 24 Oct 2008 18:16:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mips/pci/fixup-rc32434.c must #include
	<asm/mach-rc32434/irq.h>
Message-ID: <20081024171605.GD25297@linux-mips.org>
References: <20081012130135.GK31153@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081012130135.GK31153@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 12, 2008 at 04:01:35PM +0300, Adrian Bunk wrote:

Thanks, applied.

  Ralf
