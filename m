Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2007 18:17:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8390 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022576AbXIQRRw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Sep 2007 18:17:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8HHHn46007489;
	Mon, 17 Sep 2007 18:17:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8HHHmIO007488;
	Mon, 17 Sep 2007 18:17:48 +0100
Date:	Mon, 17 Sep 2007 18:17:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] lk201: Remove obsolete driver
Message-ID: <20070917171748.GA7461@linux-mips.org>
References: <Pine.LNX.4.64N.0709171712530.17606@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709171712530.17606@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 17, 2007 at 05:32:43PM +0100, Maciej W. Rozycki wrote:

>  Remove the old-fashioned lk201 driver under drivers/tc/ that used to be 
> used by the old dz.c and zs.c drivers, which is now orphan code referred 
> to from nowhere and does not build anymore.  A modern replacement is 
> available as drivers/input/keyboard/lkkbd.c.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>
