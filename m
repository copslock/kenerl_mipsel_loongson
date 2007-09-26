Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 16:48:03 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:29146 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029464AbXIZPry (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 16:47:54 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4DBF2400ED;
	Wed, 26 Sep 2007 17:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id HuXdSPBdQUV6; Wed, 26 Sep 2007 17:47:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7C63C400A9;
	Wed, 26 Sep 2007 17:47:20 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8QFlOpi026044;
	Wed, 26 Sep 2007 17:47:24 +0200
Date:	Wed, 26 Sep 2007 16:47:18 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, tbm@cyrius.com, linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
In-Reply-To: <20070927.003400.108121785.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
 <46FA5FFA.1060704@gmail.com> <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl>
 <20070927.003400.108121785.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4404/Wed Sep 26 14:53:15 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 27 Sep 2007, Atsushi Nemoto wrote:

> Current linux-queue code adds -msym32 if the load address was CKSEG0,
> so it can not be compiled with gcc 3.x.  I think this patch fixes the
> problem:
> 
> http://www.linux-mips.org/archives/linux-mips/2007-03/msg00404.html

 It looks like it should -- why hasn't it been pushed?

 Everybody please note that officially GCC 3.2 is the oldest version of 
the compiler supported and based on recent activity we do care about it.

  Maciej
