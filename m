Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 18:59:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53900 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022378AbXIJR7M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Sep 2007 18:59:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8AHxC6d009601;
	Mon, 10 Sep 2007 18:59:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8AGw80V007580;
	Mon, 10 Sep 2007 17:58:08 +0100
Date:	Mon, 10 Sep 2007 17:58:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
Message-ID: <20070910165808.GA7501@linux-mips.org>
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 10, 2007 at 01:20:38PM +0100, Maciej W. Rozycki wrote:

>  Remove typedefs, volatiles and convert kmalloc()/memset() pairs to
> kcalloc().  Also reformat the surrounding clutter.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  Per your request, Andrew, a while ago.  It builds, runs, passes 
> checkpatch.pl and sparse.  No semantic changes.

One step closer to sanity for this driver.  So it's got my ACK.

  Ralf
