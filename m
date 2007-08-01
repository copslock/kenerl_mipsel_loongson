Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 16:32:17 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39556 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021883AbXHAPcM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 16:32:12 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l71FdQX4015584;
	Wed, 1 Aug 2007 16:39:27 +0100
Date:	Wed, 1 Aug 2007 16:39:26 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
Message-ID: <20070801163926.038c48db@the-village.bc.nu>
In-Reply-To: <46B086EB.2030101@ru.mvista.com>
References: <20070801115231.GA20323@linux-mips.org>
	<46B07B36.1000501@ru.mvista.com>
	<Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
	<46B086EB.2030101@ru.mvista.com>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.13; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 01 Aug 2007 17:13:15 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Maciej W. Rozycki wrote:
> 
> >>>So could somebody Alchemist try to rewrite this to use ioremap() instead?
> 
> >>   Will ioremap() work for 4 GB range? I guess not.
> 
> >  Of course it will.  It shall work with whatever physical address space is 
> > supported by your MMU.  As long as the MMU is handled correctly that is, 
> > but I guess I may have omitted this clarification as obvious.
> 
>     Even on a CPU with 36-bit physical address? ;-)

Nope. This is one problem for example with ioremap on a Pentium Pro.
