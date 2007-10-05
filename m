Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:10:50 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:59786 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021515AbXJEMKl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:10:41 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 46A5B400CD;
	Fri,  5 Oct 2007 14:10:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id NA7PDFyOvYot; Fri,  5 Oct 2007 14:10:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D0F2740095;
	Fri,  5 Oct 2007 14:10:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l95CAaiF004885;
	Fri, 5 Oct 2007 14:10:36 +0200
Date:	Fri, 5 Oct 2007 13:10:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <20071004165546.GA23610@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710051257230.17849@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
 <20071004130318.GC28928@linux-mips.org> <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
 <20071004165546.GA23610@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4475/Fri Oct  5 10:56:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Ralf Baechle wrote:

> It's documented somewhere in their specs.  Whatever, it ends crashing
> the system so device 31 is hands off.

 OK, found it -- it is the GT-64120A erratum FEr#19 leading to a hang of 
the device; perhaps we should mention it briefly in the source code.

 While the PCI spec says reads from the device #31, function #7 for host 
bridges implementing the recommended special cycle generation mechanism 
have undefined results, this behaviour is certainly "undefined" in a very 
silly way and then, according to the spec, it must not happen for the 
function #0, which is the only one probed by Linux by default for 
single-function devices.

  Maciej
