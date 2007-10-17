Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 18:04:23 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:54737 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037573AbXJQREO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 18:04:14 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0E6FF400A5;
	Wed, 17 Oct 2007 19:03:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jOxjaETMIUdr; Wed, 17 Oct 2007 19:03:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7F46B400A4;
	Wed, 17 Oct 2007 19:03:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9HH3fnL013685;
	Wed, 17 Oct 2007 19:03:41 +0200
Date:	Wed, 17 Oct 2007 18:03:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Probe for usability of cp0 compare interrupt.
In-Reply-To: <20071017164636.GC5491@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710171756450.28993@blysk.ds.pg.gda.pl>
References: <S20022491AbXJQLKE/20071017111004Z+82239@ftp.linux-mips.org>
 <20071018.011033.115643462.anemo@mba.ocn.ne.jp> <20071017164636.GC5491@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4542/Tue Oct 16 22:31:56 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 17 Oct 2007, Ralf Baechle wrote:

> The two things are a know lose end.  There is a bug in some old MIPS
> processors where reading one of the compare or count registers in exactly
> the moment when both have identical values in the interrupt getting lost.
> 
> Will have to dig up the details on that one again before I can implement
> a proper workaround ...

 This is the erratum #53 of the R4000PC/SC processor and it triggers if 
the Count register is read.  Conveniently, in the errata sheet as 
distributed, the text is covered by a figure (Figure 1a on page 13), so 
you can only reach the page with some PostScript magic.  I did it a while 
ago and now have a separate document available which provides the text of 
page 13 with the figure removed.  I can provide it if there is interest.

  Maciej
