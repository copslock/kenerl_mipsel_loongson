Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 15:32:25 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40452 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021900AbXC0OcX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 15:32:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 38467E1E6B;
	Tue, 27 Mar 2007 16:31:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XnZpubzue9jV; Tue, 27 Mar 2007 16:31:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B941CE1DDB;
	Tue, 27 Mar 2007 16:31:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2REVnXZ025968;
	Tue, 27 Mar 2007 16:31:49 +0200
Date:	Tue, 27 Mar 2007 15:31:44 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Early printk recent changes.
In-Reply-To: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0703271526000.5547@blysk.ds.pg.gda.pl>
References: <cda58cb80703270716s6c95c66cgd03482a4852a69eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2939/Tue Mar 27 15:30:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

> I'm wondering how arch/mips/kernel/early_printk.c is supposed to be used.
> 
> I've already an early console that needs some setup before registering
> it. In the current context I can't do that anymore. Of course I can do
> it once in prom_putchar() but quite frankly I do not see the real
> point to make this common for all platforms.
> 
> Moreover I used to call setup_early_printk() sooner in my prom setup code.

 I suppose you do not have to use it.  I cannot be satisfied with the 
implementation for the use by the DECstation either, so I am going to 
revive the old code as soon as I upgrade my setup. ;-)  Feel free to use 
the old version of arch/mips/dec/prom/console.c as a template.

 Don't fix what isn't broken...

  Maciej
