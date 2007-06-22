Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 15:07:01 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1799 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022321AbXFVOG6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Jun 2007 15:06:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 63435E1C6E;
	Fri, 22 Jun 2007 16:06:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGauBIihJovW; Fri, 22 Jun 2007 16:06:18 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id F3327E1C63;
	Fri, 22 Jun 2007 16:06:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5ME6SMP019482;
	Fri, 22 Jun 2007 16:06:28 +0200
Date:	Fri, 22 Jun 2007 15:06:24 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	sknauert@wesleyan.edu
cc:	linux-mips@linux-mips.org
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
In-Reply-To: <53391.129.133.92.31.1182519298.squirrel@webmail.wesleyan.edu>
Message-ID: <Pine.LNX.4.64N.0706221456140.30780@blysk.ds.pg.gda.pl>
References: <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu> 
   <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>   
 <Pine.LNX.4.64N.0706191246060.15474@blysk.ds.pg.gda.pl>   
 <20070620.012206.30438292.anemo@mba.ocn.ne.jp>
 <53391.129.133.92.31.1182519298.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3493/Fri Jun 22 11:18:44 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 22 Jun 2007, sknauert@wesleyan.edu wrote:

> > Oh I thought ioperm() or iopl() on archs other then x86 are all dummy
> > routines, but apparently that was wrong.  Now I have looked some
> > ioperm.c in glibc and am very suprised by so many hard-coded
> > boardname/addresses ;)
> >
> 
> This seems like a mistake, shouldn't the hardware specific chunks be in
> the kernel?

 No particular need for this -- libc is a part of the operating system 
API.  Anything below this API is up to the system implementation and the 
more bits moved to the userland the better.

  Maciej
