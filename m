Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 14:47:57 +0000 (GMT)
Received: from p508B758A.dip.t-dialin.net ([IPv6:::ffff:80.139.117.138]:22929
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226164AbTAJOr5>; Fri, 10 Jan 2003 14:47:57 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0AEljH10678;
	Fri, 10 Jan 2003 15:47:45 +0100
Date: Fri, 10 Jan 2003 15:47:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org,
	Karsten Merker <karsten@excalibur.cologne.de>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [patch] R4000/R4400 64-bit errata handling
Message-ID: <20030110154745.D7699@linux-mips.org>
References: <Pine.GSO.3.96.1030110150339.23678K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030110150339.23678K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 10, 2003 at 03:32:34PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 10, 2003 at 03:32:34PM +0100, Maciej W. Rozycki wrote:

>  As you might already know there are a few nasty errata in the R4000 and
> the early R4400 that hit 64-bit operation badly.  Here is proposed code to
> detect them.  If an erratum is found in the processor and no workaround is
> applied to a kernel executable, the kernel refuses to run.  In all cases
> the result of the probes is output to the bootstrap log.
> 
>  The code has bits that make use of features of non-standard tools
> (binutils and gcc).  But it doesn't depend on them -- when built with
> standard tools and run on an affected system, a kernel will simply fail,
> and on good systems it will run normally.  Therefore it's safe to apply,
> and if the ultimate implementation in the tools differs, the code may get
> adjusted appropriately later. 
> 
>  I'd like to apply this code as soon as possible as I consider it a
> prerequisite for integrating 64-bit support for the DECstation (to prevent
> people from running unreliable code), so please tell me if there are any
> doubts about it.  Errata descriptions are available at the MIPS site --
> see: 'http://www.mips.com/publications/r400_r5000.html'.  Unfortunately,
> despite several attempts to get a permission to duplicate them within
> Linux sources, I failed to get one.
> 
>  I'd like to express my gratitude to Karsten and Thiemo for testing the
> code with their hardware.  Without their help, I wouldn't be able to
> prepare appropriate tests for errata my hardware doesn't suffer from. 

> +	__save_and_cli(flags);

> +	__restore_flags(flags);

I suggest to replace these with local_irq_save and local_irq_restore.
They're already deprecated for 2.4 and completly gone in 2.5.

Looks ok to me otherwise.

  Ralf
