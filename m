Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 18:23:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41368 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038915AbXJQRXq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 18:23:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HHNj0s008858;
	Wed, 17 Oct 2007 18:23:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HHNjoP008857;
	Wed, 17 Oct 2007 18:23:45 +0100
Date:	Wed, 17 Oct 2007 18:23:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Probe for usability of cp0 compare interrupt.
Message-ID: <20071017172345.GA7313@linux-mips.org>
References: <S20022491AbXJQLKE/20071017111004Z+82239@ftp.linux-mips.org> <20071018.011033.115643462.anemo@mba.ocn.ne.jp> <20071017164636.GC5491@linux-mips.org> <Pine.LNX.4.64N.0710171756450.28993@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710171756450.28993@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 06:03:35PM +0100, Maciej W. Rozycki wrote:

> > The two things are a know lose end.  There is a bug in some old MIPS
> > processors where reading one of the compare or count registers in exactly
> > the moment when both have identical values in the interrupt getting lost.
> > 
> > Will have to dig up the details on that one again before I can implement
> > a proper workaround ...
> 
>  This is the erratum #53 of the R4000PC/SC processor and it triggers if 
> the Count register is read.  Conveniently, in the errata sheet as 
> distributed, the text is covered by a figure (Figure 1a on page 13), so 
> you can only reach the page with some PostScript magic.  I did it a while 
> ago and now have a separate document available which provides the text of 
> page 13 with the figure removed.  I can provide it if there is interest.

Ah.  I noticed there was something like white writing on white background
matching when I searched the PDF for keywords.  So I guess it would be
nice if somebody could regenerate a PS or PDF file.  I also seem to be
missing information on the later R4400 versions.

  Ralf
