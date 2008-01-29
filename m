Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2008 10:16:58 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:58818 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023187AbYA2KQs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jan 2008 10:16:48 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9AD6C40091;
	Tue, 29 Jan 2008 11:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id z53NR7GH3uIm; Tue, 29 Jan 2008 11:16:43 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E7BDF40041;
	Tue, 29 Jan 2008 11:16:42 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m0TAGiKX022651;
	Tue, 29 Jan 2008 11:16:44 +0100
Date:	Tue, 29 Jan 2008 10:16:38 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"M. Warner Losh" <imp@bsdimp.com>
cc:	ralf@linux-mips.org, cfriesen@nortel.com, linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
In-Reply-To: <20080128.142610.1159133450.imp@bsdimp.com>
Message-ID: <Pine.LNX.4.64N.0801291009270.32259@blysk.ds.pg.gda.pl>
References: <20080122200751.GA2672@linux-mips.org> <20080128.140245.-108809632.imp@bsdimp.com>
 <20080128211803.GA20434@linux-mips.org> <20080128.142610.1159133450.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5590/Tue Jan 29 00:53:31 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jan 2008, M. Warner Losh wrote:

> : The architecture manual doesn't make a difference between 32-bit and
> : 64-bit for rdhwr.  My reading is the entire 64-bit would have to be
> : transfered.
> 
> Hmmm, the manual I have specifically calls out the difference...

 Concerning implementation-specific registers number 30 and 31 the MIPS64 
architecture manual states that if the register in question is 64-bit and 
64-bit operations are enabled then it is copied as is and otherwise it is 
sign-extended from the bit #31.  Note that the kernel mode implies 64-bit 
operations enabled.

  Maciej
