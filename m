Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 11:12:32 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:22999 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022388AbYCSLM2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Mar 2008 11:12:28 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0071F40075;
	Wed, 19 Mar 2008 12:12:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id x9u4abw7sIFN; Wed, 19 Mar 2008 12:12:23 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9EBD140072;
	Wed, 19 Mar 2008 12:12:23 +0100 (CET)
Received: by piorun.ds.pg.gda.pl (Postfix, from userid 2160)
	id 9119216405; Wed, 19 Mar 2008 12:12:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by piorun.ds.pg.gda.pl (Postfix) with ESMTP id 8D9D816404;
	Wed, 19 Mar 2008 11:12:23 +0000 (GMT)
Date:	Wed, 19 Mar 2008 11:12:23 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
X-X-Sender: macro@piorun
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] BCM1480: Init pci controller io_map_base
In-Reply-To: <20080310162825.GE31420@linux-mips.org>
Message-ID: <alpine.SOC.1.00.0803191111570.17546@piorun>
References: <20080308185155.BA791E31BE@solo.franken.de> <20080310162825.GE31420@linux-mips.org>
User-Agent: Alpine 1.00 (SOC 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Mar 2008, Ralf Baechle wrote:

> Thanks, applied.  But this patch only solves the problem for the BCM1480's
> native PCI bus.  Support for PCI behind HT still needs to be fixed and I'm
> not quite sure where the ports of such devices and busses are getting
> mapped to.

 Hmm, A_BCM1480_PHYS_HT_IO_MATCH_BYTES?

  Maciej
