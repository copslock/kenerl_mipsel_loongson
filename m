Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 13:47:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39560 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038551AbWHUMrP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 13:47:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7LClXg5015720;
	Mon, 21 Aug 2006 13:47:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7LClWFZ015719;
	Mon, 21 Aug 2006 13:47:32 +0100
Date:	Mon, 21 Aug 2006 13:47:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821124731.GA15352@linux-mips.org>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 21, 2006 at 01:45:03PM +0100, Maciej W. Rozycki wrote:

> > @@ -20,7 +20,7 @@ #define cpu_has_ejtag		0
> >  
> >  #define cpu_has_llsc		1
> >  #define cpu_has_vtag_icache	0
> > -#define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
> > +#define cpu_has_dc_aliases	0
> >  #define cpu_has_ic_fills_f_dc	0
> >  
> >  #define cpu_has_dsp		0
> 
>  Hmm, it looks like a bug in QEMU -- we should definitely implement them!

In this case I'd rather suggest to fix reality to match emulation ;-)

  Ralf
