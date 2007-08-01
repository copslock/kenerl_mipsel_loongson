Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 13:54:32 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57093 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021817AbXHAMya (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 13:54:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D154DE1C78;
	Wed,  1 Aug 2007 14:53:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ5wY530dPtM; Wed,  1 Aug 2007 14:53:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 806D2E1C63;
	Wed,  1 Aug 2007 14:53:56 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71Cs36d007343;
	Wed, 1 Aug 2007 14:54:04 +0200
Date:	Wed, 1 Aug 2007 13:53:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B07B36.1000501@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

> > So could somebody Alchemist try to rewrite this to use ioremap() instead?
> 
>    Will ioremap() work for 4 GB range? I guess not.

 Of course it will.  It shall work with whatever physical address space is 
supported by your MMU.  As long as the MMU is handled correctly that is, 
but I guess I may have omitted this clarification as obvious.

  Maciej
