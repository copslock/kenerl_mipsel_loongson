Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:06:42 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:43024 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465582AbWAWQGN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 16:06:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2AFAEF5A8B;
	Mon, 23 Jan 2006 17:10:18 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32754-02; Mon, 23 Jan 2006 17:10:17 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BC372F599A;
	Mon, 23 Jan 2006 17:10:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0NGA81x029436;
	Mon, 23 Jan 2006 17:10:08 +0100
Date:	Mon, 23 Jan 2006 16:10:21 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	sde@mips.com
Subject: Re: Build errors
In-Reply-To: <1138031829.6572.2.camel@lx-kurts>
Message-ID: <Pine.LNX.4.64N.0601231603330.27141@blysk.ds.pg.gda.pl>
References: <1137793865.15788.26.camel@lx-kurts>  <20060122030341.GB11131@linux-mips.org>
  <43D4F1E0.1050602@mips.com> <1138031829.6572.2.camel@lx-kurts>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1247/Sat Jan 21 11:24:51 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jan 2006, Kurt Schwemmer wrote:

> Great! It builds now, albeit with warnings:
> 
> arch/mips/lib/uncached.c: In function `run_uncached':
> arch/mips/lib/uncached.c:47: warning: comparison is always true due to
> limited range of data type
> 
> Is that normal?

 That's a bogus warning resulting from unability (despite all the casts) 
to tell GCC that expression is really meant and known to be always true.  
I think it's actually been discussed at the GCC list already; if the 
warning doesn't disappear with 4.1 or so, then it's worth filing a bug 
report at gcc.org.

 Otherwise it's safe to be ignored -- the code produced is correct.

  Maciej
