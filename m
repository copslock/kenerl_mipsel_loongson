Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 11:10:13 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29191 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133406AbWAXLJ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 11:09:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0A6B1F5B01;
	Tue, 24 Jan 2006 12:14:07 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05014-03; Tue, 24 Jan 2006 12:14:06 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B78B6F5AFF;
	Tue, 24 Jan 2006 12:14:06 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0OBE1wk013624;
	Tue, 24 Jan 2006 12:14:01 +0100
Date:	Tue, 24 Jan 2006 11:14:10 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kaj-Michael Lang <milang@tal.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <Pine.LNX.4.61.0601241147170.19397@tori.tal.org>
Message-ID: <Pine.LNX.4.64N.0601241058390.11021@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.61.0601241147170.19397@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1248/Tue Jan 24 11:54:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jan 2006, Kaj-Michael Lang wrote:

> > We're getting the following boot error on a DECstation with R3K CPU.
> > It simply hangs after the "high precision timer" message.  Maciej, do
> 
> It's trying to use a timer source that does not exist on the DECstation you're
> trying to use, most likely. What model is it you have ? I've tracked it down

 Well, I don't think it's possible to calculate frequency of something 
that's inexistent, yet it does...  That's a /240.

> when I got my first (working) DECstation (5000/133) a
> month or so ago. Forgot all about it under the holidays. I think
> I have a patch somewhere to fix it, I'll do some digging.

 The /133 (as all 3MINs) may have an older revision of the I/O ASIC that 
may not have the free-running counter indeed.  It's handled correctly 
regardless, except from missing timestamp precision, obviously.

 What kind of a patch do you need anyway and why isn't it yet in my mail?

  Maciej
