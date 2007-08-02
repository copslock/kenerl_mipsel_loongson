Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 10:44:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:39687 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021917AbXHBJok (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 10:44:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B82F5E1C71;
	Thu,  2 Aug 2007 11:44:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWtiQzC8PzrO; Thu,  2 Aug 2007 11:44:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5F188E1C63;
	Thu,  2 Aug 2007 11:44:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l729ig51000976;
	Thu, 2 Aug 2007 11:44:42 +0200
Date:	Thu, 2 Aug 2007 10:44:40 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <20070802092538.GC22697@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0708021039510.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <20070801163926.038c48db@the-village.bc.nu> <Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl>
 <20070801165812.3bdb269f@the-village.bc.nu> <Pine.LNX.4.64N.0708011657190.20314@blysk.ds.pg.gda.pl>
 <20070801162110.GB14756@linux-mips.org> <Pine.LNX.4.64N.0708011727150.20314@blysk.ds.pg.gda.pl>
 <20070802092538.GC22697@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Aug 2007, Ralf Baechle wrote:

> It's the physical not virtual address and as you say yourself it's a cookie
> so could potencially be some opaque value that isn't a physical address
> at all.  And I wouldn't quite call it crippling that's certainly way
> exagerated.

 Well, once you start hashing your physical addresses into smaller cookies 
you ask for complexity and likely trouble.  But it should be doable -- you 
cannot map more of the physical space at a time than you can address 
virtually.

  Maciej
