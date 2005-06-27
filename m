Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 15:38:20 +0100 (BST)
Received: from p549F652D.dip.t-dialin.net ([IPv6:::ffff:84.159.101.45]:52648
	"EHLO bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225956AbVF0OiB>; Mon, 27 Jun 2005 15:38:01 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5REabSb008816;
	Mon, 27 Jun 2005 15:36:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5REaXPw008815;
	Mon, 27 Jun 2005 16:36:33 +0200
Date:	Mon, 27 Jun 2005 16:36:33 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
Message-ID: <20050627143633.GD28082@linux-mips.org>
References: <20050625131938.GA7669@paradigm.rfc822.org> <20050625160316.GP6953@linux-mips.org> <20050625175048.GA25276@alpha.franken.de> <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506271309500.15406@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 27, 2005 at 01:45:39PM +0100, Maciej W. Rozycki wrote:

>  Anyway these days we apparently ignore the result of the S-cache probe 
> and the sc_present variable.  The only values that determine whether an 
> S-cache is present or not are: cpu_has_dc_aliases, cpu_has_ic_fills_f_dc 
> and cpu_has_subset_pcaches which you need to get right for your 
> configuration -- I guess cpu_has_dc_aliases == 0, cpu_has_ic_fills_f_dc == 
> 1 and cpu_has_subset_pcaches == 0 should be right to fulfil your needs 
> (but it may break elsewhere).  Have I heard: "serious brain damage" from 
> you?  Well, I couldn't agree more...

What matters isn't the presence of a second level cache but the actual
properties.  The old code was relying almost exclusively on the precense
of an S-cache, so had to be very liberal in it's assumption about that
cache's properties.  Performancewise that sucked, badly.

  Ralf
