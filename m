Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2006 10:48:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:54145 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133470AbWF1Jsu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2006 10:48:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5S9mm6f009027;
	Wed, 28 Jun 2006 10:48:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5S9mlOu009026;
	Wed, 28 Jun 2006 10:48:47 +0100
Date:	Wed, 28 Jun 2006 10:48:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch rfc] au1xxx spi ported to spi layer
Message-ID: <20060628094847.GA5310@linux-mips.org>
References: <20060628070750.GE31105@domen.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628070750.GE31105@domen.ultra.si>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 28, 2006 at 09:07:50AM +0200, Domen Puncer wrote:

> This is a port of Jordan Crouse's SPI patch to the SPI layer.
> Board definitions are only for dbau1200, flash should work with
> in-kernel driver. If someone wants the simple tmp121 driver,
> i can send it.
> 
> Hopefully someone finds this useful.
> 
> Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

As for the arch/mips bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

About 90% of this patch are SPI specific, so please feed this patch though
the SPI maintainer:

SPI SUBSYSTEM
P:      David Brownell
M:      dbrownell@users.sourceforge.net
L:      spi-devel-general@lists.sourceforge.net
S:      Maintained

One thing I noticed at a glance is the use of the sysv compatibility types,
notably uint.  Please don't use them in new code.

  Ralf
