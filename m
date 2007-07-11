Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:05:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56723 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021642AbXGKQFR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 17:05:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6BFoMs3026762;
	Wed, 11 Jul 2007 16:50:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6BFoLsR026761;
	Wed, 11 Jul 2007 16:50:21 +0100
Date:	Wed, 11 Jul 2007 16:50:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org, sibyte-users@bitmover.com,
	Mark Mason <mason@broadcom.com>
Subject: Re: [PATCH][CFT] Move SB1250 DUART support to the serial subsystem
Message-ID: <20070711155021.GA26548@linux-mips.org>
References: <Pine.LNX.4.64N.0707111206200.26459@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707111206200.26459@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 12:36:32PM +0100, Maciej W. Rozycki wrote:

How far do you trust this driver?  Unless the answer is "not as far as
I can throw a hardcopy of the code on marble" I suggest you feed this
driver upstream ASAP such that Sibyte can finally become usable from
kernel.org.  I don't mind keeping this old driver in the lmo git tree
for another while.

  Ralf
