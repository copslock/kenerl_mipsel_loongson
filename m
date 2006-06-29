Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2006 07:51:33 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:38892 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133432AbWF2GvU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Jun 2006 07:51:20 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 80F04165;
	Thu, 29 Jun 2006 08:51:10 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id EB2581BC091;
	Thu, 29 Jun 2006 08:51:11 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 0BCA11A18B8;
	Thu, 29 Jun 2006 08:51:11 +0200 (CEST)
Date:	Thu, 29 Jun 2006 08:51:12 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch rfc] au1xxx spi ported to spi layer
Message-ID: <20060629065112.GG31105@domen.ultra.si>
References: <20060628070750.GE31105@domen.ultra.si> <20060628094847.GA5310@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628094847.GA5310@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 28/06/06 10:48 +0100, Ralf Baechle wrote:
> On Wed, Jun 28, 2006 at 09:07:50AM +0200, Domen Puncer wrote:
> 
> > This is a port of Jordan Crouse's SPI patch to the SPI layer.
> > Board definitions are only for dbau1200, flash should work with
> > in-kernel driver. If someone wants the simple tmp121 driver,
> > i can send it.
> > 
> > Hopefully someone finds this useful.
> > 
> > Signed-off-by: Domen Puncer <domen.puncer@ultra.si>
> 
> As for the arch/mips bits:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!

> 
> About 90% of this patch are SPI specific, so please feed this patch though
> the SPI maintainer:

Well... I wanted some mips/dbau1xxx audience first, to comment it.

> 
> SPI SUBSYSTEM
> P:      David Brownell
> M:      dbrownell@users.sourceforge.net
> L:      spi-devel-general@lists.sourceforge.net
> S:      Maintained
> 
> One thing I noticed at a glance is the use of the sysv compatibility types,
> notably uint.  Please don't use them in new code.

OK. I'll clean this up, and send to SPI guys tomorrow.


	Domen
