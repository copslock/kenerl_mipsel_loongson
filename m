Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:33:45 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17681 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3465640AbWBBQd1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 16:33:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 88C4BF5A5C;
	Thu,  2 Feb 2006 17:38:34 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10280-04; Thu,  2 Feb 2006 17:38:34 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 26BB0E1C82;
	Thu,  2 Feb 2006 17:38:34 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k12GcPlw009548;
	Thu, 2 Feb 2006 17:38:25 +0100
Date:	Thu, 2 Feb 2006 16:38:37 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
In-Reply-To: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0602021636380.11727@blysk.ds.pg.gda.pl>
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1270/Thu Feb  2 13:47:37 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 3 Feb 2006, Atsushi Nemoto wrote:

> Workaround: mask EXL bit of the result or place a nop before mfc0.
[...]
> @@ -55,8 +56,13 @@ __asm__ (
>  	"	di							\n"
>  #else
>  	"	mfc0	$1,$12						\n"
> +#if TX49XX_MFC0_WAR && defined(MODULE)
> +	"	ori	$1,3						\n"
> +	"	xori	$1,3						\n"
> +#else
>  	"	ori	$1,1						\n"
>  	"	xori	$1,1						\n"
> +#endif
>  	"	.set	noreorder					\n"
>  	"	mtc0	$1,$12						\n"
>  #endif

 Hmm, wouldn't that "nop" alternative be simpler?

  Maciej
