Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 13:48:13 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37392 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038415AbWLFNsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 13:48:07 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5DCA6F5943;
	Wed,  6 Dec 2006 14:47:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xaEEcnmOqxhs; Wed,  6 Dec 2006 14:47:56 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id F02A7E1C88;
	Wed,  6 Dec 2006 14:47:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kB6Dm5rl014046;
	Wed, 6 Dec 2006 14:48:05 +0100
Date:	Wed, 6 Dec 2006 13:48:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ingo Molnar <mingo@redhat.com>, anemo@mba.sphere.ne.jp,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
In-Reply-To: <4576C2E9.4060900@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl>
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
 <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
 <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2292/Wed Dec  6 12:00:54 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Dec 2006, Sergei Shtylyov wrote:

> > +static struct irq_chip i8259A_chip = {
> > +	.name		= "XT-PIC",
> > +	.mask		= disable_8259A_irq,
> > +	.unmask		= enable_8259A_irq,
> > +	.mask_ack	= mask_and_ack_8259A,
> >  };
> 
>    I wonder whose idea was to call this device XT-PIC. XT never had dual 8259A
> PICs and so was capable of handling only 8 IRQs. Dual 8259A was first used in
> the AT class machines...

 Ask Ingo, perhaps... ;-)  I think he was perfectly right, though -- this 
is a pair of PC/XT-class PICs.  And with the "IO-APIC-edge" and 
"IO-APIC-level" alternatives back when the concept of IRQ controllers was 
introduced, "XT-PIC" rather than "8259A" sounded quite right.

  Maciej
