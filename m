Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 13:01:43 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:27623 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030387AbXJKMBe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 13:01:34 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E9A6C400A4;
	Thu, 11 Oct 2007 14:01:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id dR5QVdDMRK70; Thu, 11 Oct 2007 14:01:28 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4DE4240095;
	Thu, 11 Oct 2007 14:01:28 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9BC1U3l009966;
	Thu, 11 Oct 2007 14:01:31 +0200
Date:	Thu, 11 Oct 2007 13:01:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Nigel Stephens <nigel@mips.com>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [SPAM?]  Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <470CC0CE.9080303@mips.com>
Message-ID: <Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
 <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
 <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
 <470CC0CE.9080303@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4529/Thu Oct 11 08:54:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Oct 2007, Nigel Stephens wrote:

> Actually the -march=4ksd option will allow gcc to use of the SmartMIPS lwxs
> (indexed load) instruction, which could save a few instructions here and
> there.

 Good point, but if we decide the lone instruction is worth the hassle, 
then we should use "-msmartmips" on top of the base ISA selection.  
Likewise with "lwx" and "-mdsp".

 Though either way I am not sure these would have to be put in Kconfig or 
Makefile anywhere.  A generic way should be enough for the insistent as 
the potentially useful options may proliferate; we have the CFLAGS_KERNEL 
and CFLAGS_MODULE Makefile variables that would suit for setting upon 
`make' invocation.

  Maciej
