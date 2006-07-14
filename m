Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 17:11:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16568 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133536AbWGNQL1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Jul 2006 17:11:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k6EGBS1N012564;
	Fri, 14 Jul 2006 17:11:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k6EGBS4B012563;
	Fri, 14 Jul 2006 17:11:28 +0100
Date:	Fri, 14 Jul 2006 17:11:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Message-ID: <20060714161128.GB15427@linux-mips.org>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 14, 2006 at 04:53:11PM +0200, Daniel Mack wrote:

> the following patch makes external interrupt sources work again
> on AMD's Au1200 development boards. The unnamed initialization
> of 'external_irq_type' lead to a defective function mapping.
> 
> I resent it because of the missing Signed-off-by: line, sorry.

Good - but this patch is still corrupted so doesn't apply, can you
resend with a non-broken mailer?

  Ralf
