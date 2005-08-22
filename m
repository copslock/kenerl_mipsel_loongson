Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 10:18:12 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:30739 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225341AbVHVJR4>; Mon, 22 Aug 2005 10:17:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8C62EF59B2; Mon, 22 Aug 2005 11:17:55 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01286-05; Mon, 22 Aug 2005 11:17:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 47469F5949; Mon, 22 Aug 2005 11:17:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j7M9Hvav022393;
	Mon, 22 Aug 2005 11:17:57 +0200
Date:	Mon, 22 Aug 2005 10:18:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050820142723Z8225252-3678+7060@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0508221013180.26914@blysk.ds.pg.gda.pl>
References: <20050820142723Z8225252-3678+7060@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 20 Aug 2005 ralf@linux-mips.org wrote:

> Modified files:
> 	arch/mips/kernel: irq_cpu.c 
> 
> Log message:
> 	MT bulletproofing; MT also uses the software interrupts.

 Well, since they use a different controller structure and different 
functions, the user-visible name should be different too, shouldn't it?  
To be original ;-) -- how about "MIPS-MT"?

  Maciej
