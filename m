Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:40:03 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:24081 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225208AbUKXWj6>; Wed, 24 Nov 2004 22:39:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 27EF0E1C7A; Wed, 24 Nov 2004 23:39:51 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05954-09; Wed, 24 Nov 2004 23:39:51 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B5E11E1C79; Wed, 24 Nov 2004 23:39:50 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAOMe8qo024599;
	Wed, 24 Nov 2004 23:40:08 +0100
Date: Wed, 24 Nov 2004 22:39:56 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <20041124221240.GA24500@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411242237540.843@blysk.ds.pg.gda.pl>
References: <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
 <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com>
 <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com>
 <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
 <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de>
 <20041124094423.GB21039@linux-mips.org> <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58L.0411242138560.843@blysk.ds.pg.gda.pl> <20041124221240.GA24500@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2004, Ralf Baechle wrote:

> >  Note, these panic()s really beg for early printk() support -- but doesn't
> > everyone have it already? ;-)
> 
> It's so easy to implement with serial console.  Best thing since sliced
> bread :-)

 Yep, and some systems have an appropriate console output callback in the 
firmware making it trivial.

  Maciej
