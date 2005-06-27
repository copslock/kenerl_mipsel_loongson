Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 13:05:15 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:65298 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225951AbVF0ME6>; Mon, 27 Jun 2005 13:04:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 485E6E1C95; Mon, 27 Jun 2005 14:04:14 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18474-10; Mon, 27 Jun 2005 14:04:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EC0BFE1C7C; Mon, 27 Jun 2005 14:04:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5RC4Arh014265;
	Mon, 27 Jun 2005 14:04:10 +0200
Date:	Mon, 27 Jun 2005 13:04:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dominic Sweetman <dom@mips.com>, madprops@gmx.net,
	linux-mips@linux-mips.org
Subject: Re: tlb magic
In-Reply-To: <20050625144154.GO6953@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0506271302210.15406@blysk.ds.pg.gda.pl>
References: <17069.62407.584863.185198@mips.com> <18788.1118764826@www21.gmx.net>
 <17084.61658.662352.432937@mips.com> <20050625144154.GO6953@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/958/Mon Jun 27 00:22:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 25 Jun 2005, Ralf Baechle wrote:

> The most useful useful trick of all will be increasing the pagesize to
> grow beyond the small pagesize of 4k - for expected significant
> performance benefits because the the TLB reach will increase but also
> virtual aliases will go away on about anything but R4000SC returning us
> to the promised lands of simplicity of cache managment :-)

 But that we have already done, haven't we? ;-)

  Maciej
