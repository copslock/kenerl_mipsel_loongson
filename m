Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 15:13:54 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:9365 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022213AbXIMONp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 15:13:45 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4B92C400CC;
	Thu, 13 Sep 2007 16:13:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id zAjQMkotT9QZ; Thu, 13 Sep 2007 16:13:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 078A8400EC;
	Thu, 13 Sep 2007 16:13:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8DEDBWG023954;
	Thu, 13 Sep 2007 16:13:12 +0200
Date:	Thu, 13 Sep 2007 15:13:06 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jeff Garzik <jgarzik@pobox.com>
cc:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
In-Reply-To: <46E8B56E.7060705@pobox.com>
Message-ID: <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
 <46E8B56E.7060705@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4264/Thu Sep 13 08:06:05 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 12 Sep 2007, Jeff Garzik wrote:

> > Remove typedefs, volatiles and convert kmalloc()/memset() pairs to
> > kcalloc().  Also reformat the surrounding clutter.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > ---
> 
> ACK, but patch does not apply cleanly to netdev-2.6.git#upstream (nor -mm)

 Hmm, works fine with linux-2.6.git#master.  I do not recall any recent 
activity with this driver -- I wonder what the difference is.  Let me 
see...

  Maciej
