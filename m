Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 06:58:59 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:22667
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023143AbYGKF65 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 06:58:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6B5wudq015824;
	Fri, 11 Jul 2008 06:58:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6B5wueR015823;
	Fri, 11 Jul 2008 06:58:56 +0100
Date:	Fri, 11 Jul 2008 06:58:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] reorganize txx9 pci code
Message-ID: <20080711055856.GB9794@linux-mips.org>
References: <20080711.003308.108121397.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080711.003308.108121397.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 11, 2008 at 12:33:08AM +0900, Atsushi Nemoto wrote:

> Split out PCIC dependent code and SoC dependent code from board
> dependent code.  Now TX4927 PCIC code is independent from
> TX4927/TX4938 SoC code.  Also fix some build problems on CONFIG_PCI=n.
> 
> As a bonus, "FPCIB0 Backplane Support" is available for all TX39/TX49
> boards and PCI66 support is available for all TX49 boards.

Also queued for 2.6.27.  Thanks!

  Ralf
