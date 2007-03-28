Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 11:33:18 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:20491 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021977AbXC1KdQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 11:33:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5E1CAE1C95;
	Wed, 28 Mar 2007 12:32:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cc8w-QI8+qrg; Wed, 28 Mar 2007 12:32:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D1882E1C72;
	Wed, 28 Mar 2007 12:32:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2SAWiZn024301;
	Wed, 28 Mar 2007 12:32:44 +0200
Date:	Wed, 28 Mar 2007 11:32:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Bunk <bunk@stusta.de>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: [CHAR] Wire up DEC serial drivers in Kconfig
In-Reply-To: <20070328023724.GA31980@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0703281128010.25992@blysk.ds.pg.gda.pl>
References: <20070328023724.GA31980@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2946/Wed Mar 28 11:36:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 28 Mar 2007, Ralf Baechle wrote:

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 I'm not sure it's worth the hassle -- I'm in the middle of moving the 
driver to drivers/serial/, which I should finish soon after I reestablish 
my home network.  Otherwise I'm fine with it.  Has anybody actually 
requested it?

  Maciej
