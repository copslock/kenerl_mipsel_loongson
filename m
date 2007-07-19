Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:57:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34178 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022601AbXGSM5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:57:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6JCvBIx023339;
	Thu, 19 Jul 2007 13:57:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6JCvB0b023338;
	Thu, 19 Jul 2007 13:57:11 +0100
Date:	Thu, 19 Jul 2007 13:57:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org, sibyte-users@bitmover.com
Subject: Re: [PATCH] drivers/char/sb1250_duart.c: Remove the old driver
Message-ID: <20070719125711.GB20370@linux-mips.org>
References: <Pine.LNX.4.64N.0707191343530.1861@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707191343530.1861@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 19, 2007 at 01:50:07PM +0100, Maciej W. Rozycki wrote:

>  Now that the SB1250 DUART is supported with a serial/ driver the old one 
> may be removed.

Nuked.  Thanks,

  Ralf
