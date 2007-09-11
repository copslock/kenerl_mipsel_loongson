Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 14:41:18 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:23742 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022315AbXIKNlJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 14:41:09 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C1C7940097;
	Tue, 11 Sep 2007 15:41:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id h9dklSjmrppV; Tue, 11 Sep 2007 15:41:00 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C3CF740071;
	Tue, 11 Sep 2007 15:41:00 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8BDf26h016545;
	Tue, 11 Sep 2007 15:41:04 +0200
Date:	Tue, 11 Sep 2007 14:40:57 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
In-Reply-To: <20070911.001819.126573631.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0709111431240.30365@blysk.ds.pg.gda.pl>
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
 <Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
 <20070911.001819.126573631.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4238/Tue Sep 11 05:38:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 11 Sep 2007, Atsushi Nemoto wrote:

> And how about this patch?  Does this fix the problem on SWARM?
> http://www.linux-mips.org/archives/linux-mips/2007-09/msg00036.html

 Thanks a lot -- it makes things work for my SWARM as expected.  But 
doesn't it break systems where there actually is a PCI-(E)ISA bridge and a 
legacy IDE interface?

  Maciej
