Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 18:08:51 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:6307 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023100AbXJYRIn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 18:08:43 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 207CA400B9;
	Thu, 25 Oct 2007 19:08:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id jPFZ0-nNZRFA; Thu, 25 Oct 2007 19:08:06 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 96094400CA;
	Thu, 25 Oct 2007 19:08:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9PH8A0E027587;
	Thu, 25 Oct 2007 19:08:10 +0200
Date:	Thu, 25 Oct 2007 18:08:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
In-Reply-To: <20071025155912.GD3994@networkno.de>
Message-ID: <Pine.LNX.4.64N.0710251707170.24086@blysk.ds.pg.gda.pl>
References: <20071025155912.GD3994@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4594/Thu Oct 25 14:45:14 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Oct 2007, Thiemo Seufer wrote:

> currently the kernel panics when it boots on an unknown CPU model
> (with an unknown PRID). Based on the assumption that the majority
> of newly supported CPU will conform to Release 2 standard, I wrote
> the appended patch which handles unknown CPUs as R2. It isn't
> completely bulletproof, as (yet unsupported) non-R1/R2 CPUs may
> use the AT config bits for different purposes. I still think this
> is good enough a test.

 Good idea in general, but do we have to rely on the undefined?  How 
about this:

> +		/* Panic if this isn't a Release 2 CPU. */
> +		if (!((read_c0_config() & MIPS_CONF_AT) >> 13)) {

	if (!(current_cpu_data.isa_level &
	      (MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M32R2))) {

instead for example?

  Maciej
