Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:01:13 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:37905 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226123AbULBABI>; Thu, 2 Dec 2004 00:01:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DD948E1C94; Thu,  2 Dec 2004 01:01:00 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18304-06; Thu,  2 Dec 2004 01:01:00 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 60660E1C61; Thu,  2 Dec 2004 01:01:00 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB201Fn4012373;
	Thu, 2 Dec 2004 01:01:18 +0100
Date: Thu, 2 Dec 2004 00:01:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201233940.GA15116@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412012359190.20966@blysk.ds.pg.gda.pl>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
 <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201123336.GA5612@linux-mips.org>
 <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
 <20041201233940.GA15116@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004, Ralf Baechle wrote:

> >  No surprise as the "o" constraint doesn't mean anything particular for
> > MIPS.  All addresses are offsettable -- there is no addressing mode that
> > would preclude it, so "o" is exactly the same as "m".
> 
> This is what the gcc docs say:
[...]
> So it is not the same as "m".

 It is the same *for* MIPS.  Not in general.

  Maciej
