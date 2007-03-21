Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 16:00:28 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:22534 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021490AbXCUQA0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 16:00:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 71BD8E1C9A;
	Wed, 21 Mar 2007 16:59:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCQYIjourYLf; Wed, 21 Mar 2007 16:59:42 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0CC72E1C6E;
	Wed, 21 Mar 2007 16:59:42 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2LFxsiJ031116;
	Wed, 21 Mar 2007 16:59:54 +0100
Date:	Wed, 21 Mar 2007 15:59:49 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Cleanup for plat_irq_dispatch functions
In-Reply-To: <20070319014604.GA5658@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0703211555340.2628@blysk.ds.pg.gda.pl>
References: <20070319001337.GB7744@networkno.de> <20070319014604.GA5658@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2892/Wed Mar 21 11:40:09 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007, Ralf Baechle wrote:

> Now, I think spurious_interrupt should be deleted, it delivers not too
> much useful data and even the reasoning for adding it back in the dark
> ages was fairly weak ...

 It is useful for debugging -- if you get more than a few such events in a 
long time, then you need to debug your driver to make sure the interrupt 
request is removed soon enough for not being redelivered when the handler 
exits.  The problem is hard to notice otherwise.

  Maciej
