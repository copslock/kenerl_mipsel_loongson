Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 18:03:21 +0100 (BST)
Received: from [81.2.110.250] ([81.2.110.250]:31156 "EHLO the-village.bc.nu")
	by ftp.linux-mips.org with ESMTP id S20021981AbXHARDQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 18:03:16 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l71HAV8L015836;
	Wed, 1 Aug 2007 18:10:31 +0100
Date:	Wed, 1 Aug 2007 18:10:31 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
Message-ID: <20070801181031.390d4f3a@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org>
	<46B07B36.1000501@ru.mvista.com>
	<Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
	<46B086EB.2030101@ru.mvista.com>
	<46B0880B.2000009@ru.mvista.com>
	<Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
	<46B0AA74.7040100@ru.mvista.com>
	<Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
	<46B0B6B4.5090103@ru.mvista.com>
	<Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
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
X-archive-position: 15998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> >    That depends on the drivers used (some IDE drivers access it really often).
> 
>  It is their problem I would say -- there is a design problem either in 
> these drivers or the hardware handled.  The PCI spec is very explicit that 
> the config space is meant to be seldom accessed only.  Device 
> initialization/shutdown and bus error recovery are the normal places.

An awful lot of vendors get it horribly wrong and many end up needing
configuration space access even in IRQ handlers. Dishonourable mentions
to ATI for example ;)
