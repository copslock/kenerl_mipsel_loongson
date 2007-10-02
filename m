Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 12:39:46 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:46314 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023881AbXJBLjh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 12:39:37 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id EBEF5400FE;
	Tue,  2 Oct 2007 13:39:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id cziddk+uzHvj; Tue,  2 Oct 2007 13:39:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9E20240040;
	Tue,  2 Oct 2007 13:39:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l92BdZ89024317;
	Tue, 2 Oct 2007 13:39:36 +0200
Date:	Tue, 2 Oct 2007 12:39:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Using PCI bridges on sgi-ip32: CONFIG_PCI_DEBUG
In-Reply-To: <20071002030133.fd5f6315.giuseppe@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.64N.0710021215460.32726@blysk.ds.pg.gda.pl>
References: <1190973427.11251.17.camel@scarafaggio> <1191141276.7160.44.camel@scarafaggio>
 <Pine.LNX.4.64N.0710011559410.27280@blysk.ds.pg.gda.pl>
 <20071002030133.fd5f6315.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4452/Tue Oct  2 07:03:17 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Oct 2007, Giuseppe Sacco wrote:

> PCI: Fixups for bus 0000:00
> PCI: Scanning behind PCI bridge 0000:00:03.0, config ffffff, pass 0
> PCI: Scanning behind PCI bridge 0000:00:03.0, config 000000, pass 1
> PCI: Scanning bus 0000:01
> PCI: Fixups for bus 0000:01
> PCI: Bus scan for 0000:01 returning with max=01
> PCI: Bus scan for 0000:00 returning with max=01

 So it looks like the generic PCI code does scan behind the bridge at 
0000:00:03.0, but nothing is found.  So the first obvious question is: 
"Does your host bridge (or actually code that handles it) correctly 
generate type 1 PCI configuration cycles?"  It looks like 
arch/mips/pci/ops-mace.c is the place to look for possible breakage.

 Well, actually chkslot() there is the obvious answer.  It is probably 
easy to fix, but for somebody with documentation or at least the right 
piece of hardware, so I do not qualify, I am afraid.  Sorry.

 Failing anybody else, you may be able to figure it out yourself -- you 
probably need to stick bus->number into mace->pci.config_addr somewhere.  
Try bits 23:16 as the obvious first guess.

  Maciej
