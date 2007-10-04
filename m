Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 11:30:29 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:38345 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024745AbXJDKaU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 11:30:20 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B0B4E400A8;
	Thu,  4 Oct 2007 12:30:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id STB2gi5AeZY3; Thu,  4 Oct 2007 12:30:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 92759400C8;
	Thu,  4 Oct 2007 12:30:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94AUJjf007694;
	Thu, 4 Oct 2007 12:30:19 +0200
Date:	Thu, 4 Oct 2007 11:30:15 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thiemo Seufer <ths@networkno.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <47049734.6050802@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710041120250.10573@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4469/Thu Oct  4 08:56:38 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Franck Bui-Huu wrote:

> Not really, I would say it's just an idea to remove tlbex.c from the
> kernel code and to make it a tool called during compile time to
> generate a handler skeleton which would be finalized by the kernel.

 Thanks for volunteering.  When you finally come up with an implementation 
of a solution that is much better than the current one I am absolutely 
sure it will be accepted eagerly.

  Maciej
