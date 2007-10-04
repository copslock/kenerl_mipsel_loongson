Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 13:28:00 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:56202 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022366AbXJDM1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 13:27:52 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C2B27400AA;
	Thu,  4 Oct 2007 14:27:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 3-h0JOB6wWsp; Thu,  4 Oct 2007 14:27:48 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 902C5400A8;
	Thu,  4 Oct 2007 14:27:48 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94CRpoN031582;
	Thu, 4 Oct 2007 14:27:51 +0200
Date:	Thu, 4 Oct 2007 13:27:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4469/Thu Oct  4 08:56:38 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Giuseppe Sacco wrote:

> I managed to create a patch against current 2.6.23-rc9 git tree
> for supporting PCI bridges on SGI ip32 machines.
> This is my first kernel patch, so I am usure about the correct way
> to send a patch. Please let me know if anything is wrong.

 I am glad you have succeeded.  A couple of minor notes below.

> @@ -31,20 +31,21 @@
>  
>  #define chkslot(_bus,_devfn)					\
>  do {							        \
> -	if ((_bus)->number > 0 || PCI_SLOT (_devfn) < 1	\
> -	    || PCI_SLOT (_devfn) > 3)			        \
> +	if ((_bus)->number > 1 ||                               \
> +		((_bus)->number == 0 && (PCI_SLOT (_devfn) < 1  \
> +	    	|| PCI_SLOT (_devfn) > 3)))		        \
>  		return PCIBIOS_DEVICE_NOT_FOUND;		\

 I think you should allow any bus numbers, not only 0 and 1 -- while 
possibly unlikely, you may have a tree of bridges on an option card.  The 
generic code should handle it fine -- you need not care.

> -#define mkaddr(_devfn, _reg) \
> -((((_devfn) & 0xffUL) << 8) | ((_reg) & 0xfcUL))
> +#define mkaddr(_bus, _devfn, _reg) \
> +((((_bus)->number & 0xffUL) << 16) | (((_devfn) & 0xffUL) << 8) | ((_reg) & 0xfcUL))

 Please fit your lines in 80 characters.

> -	mace->pci.config_addr = mkaddr(devfn, reg);
> +	mace->pci.config_addr = mkaddr(bus, devfn, reg);

 It may be more consistent if you pass just "bus->number".  You may neatly 
avoid the line wrap above this way too.

 Have you run your change through `scripts/checkpatch.pl'?

  Maciej
