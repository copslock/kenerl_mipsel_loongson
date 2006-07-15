Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2006 05:40:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34441 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133376AbWGOEjw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Jul 2006 05:39:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k6F4dibs003927;
	Sat, 15 Jul 2006 05:39:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k6F4dfCt003926;
	Sat, 15 Jul 2006 05:39:41 +0100
Date:	Sat, 15 Jul 2006 05:39:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Mack <daniel@yoobay.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Message-ID: <20060715043941.GA3587@linux-mips.org>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de> <20060714161128.GB15427@linux-mips.org> <20060715005747.GA21358@ipxXXXXX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715005747.GA21358@ipxXXXXX>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 15, 2006 at 02:57:47AM +0200, Daniel Mack wrote:
> Date:	Sat, 15 Jul 2006 02:57:47 +0200
> From:	Daniel Mack <daniel@yoobay.net>
> To:	Ralf Baechle <ralf@linux-mips.org>
> Cc:	linux-mips@linux-mips.org
> Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, Jul 14, 2006 at 05:11:28PM +0100, Ralf Baechle wrote:
> > > the following patch makes external interrupt sources work again
> > > on AMD's Au1200 development boards. The unnamed initialization
> > > of 'external_irq_type' lead to a defective function mapping.
> > > 
> > > I resent it because of the missing Signed-off-by: line, sorry.
> > 
> > Good - but this patch is still corrupted so doesn't apply, can you
> > resend with a non-broken mailer?
> 
> It hasn't been line-wrapped or corrupted by my mailer, as one can
> see in the mailing list's web archive. 

Same corrupt stuff:

$ wget http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch
--05:36:02--  http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch
           => `irq_chip_pb1200.patch'
Resolving caiaq.org... 212.112.241.133
Connecting to caiaq.org|212.112.241.133|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1,057 (1.0K) [text/plain]

100%[====================================>] 1,057         --.--K/s

05:36:02 (77.54 MB/s) - `irq_chip_pb1200.patch' saved [1057/1057]

$ patch -p1 < irq_chip_pb1200.patch
patching file arch/mips/au1000/pb1200/irqmap.c
patch: **** malformed patch at line 15: static struct irq_chip external_irq_type =

$

  Ralf
