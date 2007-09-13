Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 16:14:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9194 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022297AbXIMPOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 16:14:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DFErj3007911;
	Thu, 13 Sep 2007 16:14:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DFEqXU007910;
	Thu, 13 Sep 2007 16:14:52 +0100
Date:	Thu, 13 Sep 2007 16:14:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
Message-ID: <20070913151452.GB29665@linux-mips.org>
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl> <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 03:13:06PM +0100, Maciej W. Rozycki wrote:

>  Hmm, works fine with linux-2.6.git#master.  I do not recall any recent 
> activity with this driver -- I wonder what the difference is.  Let me 
> see...

Hmm...  HEAD du jour has no differences for the sb1250-mac between lmo
and kernel.org.

  Ralf
