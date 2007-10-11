Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 15:50:42 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:39573 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021774AbXJKOud (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 15:50:33 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 22797400A4;
	Thu, 11 Oct 2007 16:50:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 4IxzO1bWX+Lb; Thu, 11 Oct 2007 16:49:57 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C905640095;
	Thu, 11 Oct 2007 16:49:57 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9BEo10D010141;
	Thu, 11 Oct 2007 16:50:01 +0200
Date:	Thu, 11 Oct 2007 15:49:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <20071011140006.GA2828@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710111548160.16370@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <20071011124410.GA17202@linux-mips.org>
 <Pine.LNX.4.64N.0710111420030.16370@blysk.ds.pg.gda.pl>
 <20071011140006.GA2828@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4529/Thu Oct 11 08:54:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Oct 2007, Ralf Baechle wrote:

> Beofore applying the previously mentioned fixes I spoke to them but they
> were not very inclined to consider the gcc behaviour a bug.

 This may qualify as the lack of a feature indeed.  So I guess the 
ultimate solution is waiting for somebody to get inclined enough to 
implement it. ;-)

  Maciej
