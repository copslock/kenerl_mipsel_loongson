Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2006 01:58:00 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:27143 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133422AbWGOA5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Jul 2006 01:57:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 11DF47F4028;
	Sat, 15 Jul 2006 02:57:48 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19862-06; Sat, 15 Jul 2006 02:57:47 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id BE49D7F4024; Sat, 15 Jul 2006 02:57:47 +0200 (CEST)
Date:	Sat, 15 Jul 2006 02:57:47 +0200
From:	Daniel Mack <daniel@yoobay.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Message-ID: <20060715005747.GA21358@ipxXXXXX>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de> <20060714161128.GB15427@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714161128.GB15427@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <daniel@yoobay.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@yoobay.net
Precedence: bulk
X-list: linux-mips

On Fri, Jul 14, 2006 at 05:11:28PM +0100, Ralf Baechle wrote:
> > the following patch makes external interrupt sources work again
> > on AMD's Au1200 development boards. The unnamed initialization
> > of 'external_irq_type' lead to a defective function mapping.
> > 
> > I resent it because of the missing Signed-off-by: line, sorry.
> 
> Good - but this patch is still corrupted so doesn't apply, can you
> resend with a non-broken mailer?

It hasn't been line-wrapped or corrupted by my mailer, as one can
see in the mailing list's web archive. 
Anyway, I put it online as a plain text file so anybody should be
able to use it properly:

	http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch

Daniel
