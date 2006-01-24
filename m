Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 12:35:27 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1292 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAXMfK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 12:35:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E6AE9F5B0B;
	Tue, 24 Jan 2006 13:39:22 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24114-01; Tue, 24 Jan 2006 13:39:22 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8F43DF5B0A;
	Tue, 24 Jan 2006 13:39:22 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0OCdGcQ001434;
	Tue, 24 Jan 2006 13:39:16 +0100
Date:	Tue, 24 Jan 2006 12:39:26 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060124122700.GA8527@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1248/Tue Jan 24 11:54:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jan 2006, Martin Michlmayr wrote:

> We had the following settings: console=s and osconsole=3
> The terminal emulation program should've been configured properly
> too.

 Well, the console device was not specified at the Linux's command line 
and the kernel currently does not query REX variables to infer which 
device to use.  Please retry with "console=ttyS2"; you may specify line 
parameters as required, too.  That may be compiled in if you run out of 
the BBU RAM space (which only allows up to 37 characters for kernel 
arguments).

 The output you got was produced with the early console which uses REX 
primitives.

  Maciej
