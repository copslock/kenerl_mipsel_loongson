Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 08:32:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61139 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20022648AbYFZHcs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 08:32:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5Q7VV2t003424;
	Thu, 26 Jun 2008 09:31:56 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5Q7VTv0003416;
	Thu, 26 Jun 2008 09:31:29 +0200
Date:	Thu, 26 Jun 2008 09:31:29 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix IP32 unexpected irq 71
Message-ID: <20080626073129.GE15605@linux-mips.org>
References: <20080623224805.A0A12FB464@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080623224805.A0A12FB464@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 24, 2008 at 12:48:05AM +0200, Thomas Bogendoerfer wrote:

> It's possible that the crime interrupt handler is called without
> pending interrupts (probably a hardware issue). To avoid irritating
> "unexpected irq 71" messages, we now just ignore the spurious crime
> interrupts.

Applied, thanks!

  Ralf
