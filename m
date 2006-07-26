Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 07:59:04 +0100 (BST)
Received: from www.osadl.org ([213.239.205.134]:38376 "EHLO mail.tglx.de")
	by ftp.linux-mips.org with ESMTP id S8133516AbWGZG6p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 07:58:45 +0100
Received: from hermes.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 8BA9665C003;
	Wed, 26 Jul 2006 08:58:44 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by hermes.tec.linutronix.de (Postfix) with ESMTP id EDA9668034;
	Wed, 26 Jul 2006 08:58:42 +0200 (CEST)
Subject: Re: [PATCH] PNX8550 NAND flash driver
From:	Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To:	Jurgen <jurgen.parmentier@telenet.be>
Cc:	linux-mtd@lists.infradead.org,
	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
	Todd Poynor <tpoynor@mvista.com>, linux-mips@linux-mips.org
In-Reply-To: <44C66437.9030402@telenet.be>
References: <43A2F819.1040106@ru.mvista.com> <43C69EC2.2070601@mvista.com>
	 <43F1D439.60205@ru.mvista.com> <1152525196.30929.11.camel@localhost>
	 <44C66437.9030402@telenet.be>
Content-Type: text/plain
Date:	Wed, 26 Jul 2006 09:02:53 +0200
Message-Id: <1153897373.26845.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Tue, 2006-07-25 at 20:34 +0200, Jurgen wrote:
> Root cause of the problem lies within the early implementation of the 
> low-level NAND commands. There was a severe risk that the PCI accesses 
> were stalled because of a Read Status command for the NAND Flash. This 
> Read Status was launched immediately after program/erase command. The 
> hardware itself will wait for the Ready/Busy to be high and only then 
> launch the Read Status command. This behavior caused timeout on the 
> internal bus because PCI was unable to use the pins during this wait.

The hardware design is broken. Status Read can be requested while R/B is
low. See NAND datasheets.

> If this problem was coinciding with an ISR that tried to perform a PCI 
> status register, then this PCI access could possibly timeout (because 
> the PCI pins were already claimed for the XIO access that is depending 
> on the RBY signal).
> 
> Since the problem only showed during the PCI device ISR, the 
> quick'n'dirty hack was to disable interrupts during XIO accesses.
> 
> A better fix that should be available somewhere, is to improve the 
> low-level NAND driver that will first check the status of the Ready/Busy 
> line and only THEN launch the Read NAND Status command...

Thats not an improvement. Thats a hack for your broken hardware. You'd
burden the R/B check on every sane hardware out there.

You can add the R/B check to the chip->cmd_ctrl() function of your board
driver.

	tglx
