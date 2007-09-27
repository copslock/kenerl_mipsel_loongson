Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 12:11:01 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:38864 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027136AbXI0LKx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 12:10:53 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A2DDE400A9;
	Thu, 27 Sep 2007 13:10:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id gWRIGelRZkI2; Thu, 27 Sep 2007 13:10:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DC3F3400F1;
	Thu, 27 Sep 2007 13:10:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8RBAlC1008336;
	Thu, 27 Sep 2007 13:10:48 +0200
Date:	Thu, 27 Sep 2007 12:10:44 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tbm@cyrius.com,
	linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
In-Reply-To: <46FB65C5.2000202@gmail.com>
Message-ID: <Pine.LNX.4.64N.0709271201160.7853@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
 <46FA5FFA.1060704@gmail.com> <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl>
 <20070927.003400.108121785.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl> <46FB65C5.2000202@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4411/Wed Sep 26 23:43:35 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 27 Sep 2007, Franck Bui-Huu wrote:

> Just to be sure I understand both of you correctly, could
> you confirm that in case of '-msym32' switch isn't supported,
> we should _silently_ drop this option ? That's what Atsushi
> was suggesting. But reading what Maciej wrote, it seems that
> we should notify the user...

 Wrong assumption.  I have thought the "-msym32" option was wired straight 
to CONFIG_BUILD_ELF64, which would be reasonable given what the 
configuration option is meant to be doing.  From the code generation's 
point of view the "-msym32" option can be safely dropped silently, but 
that questions the CONFIG_BUILD_ELF64 option itself and I think we have 
agreed, not necessarily enthusiastically, but still, that 
CONFIG_BUILD_ELF64 will be dropped altogether.

  Maciej
