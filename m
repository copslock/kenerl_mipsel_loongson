Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 14:21:17 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2821 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20025518AbXEaNVQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 14:21:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 00D76E1D01;
	Thu, 31 May 2007 15:21:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayk0b+dhr7yq; Thu, 31 May 2007 15:21:04 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7C4CEE1CD1;
	Thu, 31 May 2007 15:21:04 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l4VDLFO1017417;
	Thu, 31 May 2007 15:21:15 +0200
Date:	Thu, 31 May 2007 14:21:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] No I/O ports on the DECstation
In-Reply-To: <20070531121521.GE28936@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0705311359250.7856@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0705291505370.14456@blysk.ds.pg.gda.pl>
 <20070531121521.GE28936@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3334/Thu May 31 10:54:25 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 31 May 2007, Ralf Baechle wrote:

> >  There are no I/O ports on the DECstation whatsoever in any configuration 
> > as neither the CPU nor the peripheral buses used have a concept of such.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
> Stale patch?

 Not at all, it would seem.  It applies just fine and is still required as 
of 2.6.22-rc3.  These CONFIG_HAS_IOMEM and CONFIG_HAS_IOPORT options are 
pretty recent anyway -- there is little chance for anything about them to 
get stale yet.

  Maciej
