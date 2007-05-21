Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 16:32:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32742 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024318AbXEUPcs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 16:32:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4LFWY8P007103;
	Mon, 21 May 2007 17:32:34 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4LFWYct007102;
	Mon, 21 May 2007 16:32:34 +0100
Date:	Mon, 21 May 2007 16:32:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix KMODE for the R3000
Message-ID: <20070521153234.GD5943@linux-mips.org>
References: <Pine.LNX.4.64N.0705211331001.8263@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705211331001.8263@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 21, 2007 at 01:47:22PM +0100, Maciej W. Rozycki wrote:

>  This must be the oldest bug that we have got.  Leaving interrupts "as 
> they are" for the R3000 obviously means copying IEp to IEc.  Since we have 
> got STATMASK now, I took this opportunity to mask the status register 
> "correctly" for the R3000 now too.  Oh, and the R3000 hardly ever is 
> 64-bit.

Applied.

  Ralf
