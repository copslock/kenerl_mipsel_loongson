Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:42:56 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10253 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225208AbUKXWmt>; Wed, 24 Nov 2004 22:42:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4C845E1C89; Wed, 24 Nov 2004 23:42:42 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19804-07; Wed, 24 Nov 2004 23:42:42 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E08C1E1C84; Wed, 24 Nov 2004 23:42:41 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAOMgwYJ024888;
	Wed, 24 Nov 2004 23:42:59 +0100
Date: Wed, 24 Nov 2004 22:42:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Kapoor, Pankaj" <pkapoor@ti.com>, linux-mips@linux-mips.org
Subject: Re: Cache Question
In-Reply-To: <20041124223211.GB22439@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411242241130.843@blysk.ds.pg.gda.pl>
References: <C4D23DECD6CD714BBFB38B0AE8D25A3A24FF66@dlee2k03.ent.ti.com>
 <20041124223211.GB22439@linux-mips.org>
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
X-archive-position: 6449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2004, Ralf Baechle wrote:

> That interrupt disabling in some cache flushes dates back further than
> CVS history.  Seems once uppon a time there was some CPU which didn't
> like cache flushes with interrupts enabled.  This is rather bad for
> latencies so unless somebody else on this list recalls a good reason
> I'd like to remove this.

 Some R4600 (v1.1?) errata workaround?  Or was it elsewhere?

  Maciej
