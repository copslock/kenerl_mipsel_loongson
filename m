Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:57:47 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:45711 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022619AbXJYO5i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:57:38 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5FF4B400D4;
	Thu, 25 Oct 2007 16:57:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id TiNZhS5GxMOv; Thu, 25 Oct 2007 16:57:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1AE224007F;
	Thu, 25 Oct 2007 16:57:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9PEv6cE027680;
	Thu, 25 Oct 2007 16:57:06 +0200
Date:	Thu, 25 Oct 2007 15:57:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Jan Nikitenko <jan.nikitenko@gmail.com>, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
In-Reply-To: <20071025140940.GC23398@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710251548080.24086@blysk.ds.pg.gda.pl>
References: <4720A11E.5060101@gmail.com> <20071025140940.GC23398@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4594/Thu Oct 25 14:45:14 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Oct 2007, Ralf Baechle wrote:

> That said, irq 0 is imho totally valid (take the good old PIT timer
> interrupt of the PC as the classic example) and treating it as an invalid 
> interrupt number is broken.

 I would rather -1 stood for the invalid IRQ number -- unlike with 0 
chances are nobody will need 4G of interrupt lines or vectors (as 
applicable) in a single system.  We sort of escape the problem with the 
MIPS processors because the IP0 bit of the Cause register is a software 
interrupt that is not used by devices, but still some platforms bypass the 
built-in interrupt "controller" as only a single source is used in the 
Cause register and want to start the numbering of lines in the external 
controller from 0.

  Maciej
