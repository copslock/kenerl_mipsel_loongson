Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 19:14:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42462 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040277AbXJQSOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 19:14:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HIEePF018099;
	Wed, 17 Oct 2007 19:14:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HIEdBk018084;
	Wed, 17 Oct 2007 19:14:39 +0100
Date:	Wed, 17 Oct 2007 19:14:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Probe for usability of cp0 compare interrupt.
Message-ID: <20071017181439.GC11079@linux-mips.org>
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
X-archive-position: 17106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 17, 2007 at 06:03:35PM +0100, Maciej W. Rozycki wrote:

>  This is the erratum #53 of the R4000PC/SC processor and it triggers if 
> the Count register is read.  Conveniently, in the errata sheet as 
> distributed, the text is covered by a figure (Figure 1a on page 13), so 
> you can only reach the page with some PostScript magic.  I did it a while 
> ago and now have a separate document available which provides the text of 
> page 13 with the figure removed.  I can provide it if there is interest.

So it's the same text as for later errata.  Pretty much what I've been
expecting.

  Ralf
