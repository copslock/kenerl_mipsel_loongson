Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 21:54:49 +0100 (BST)
Received: from p508B65AB.dip.t-dialin.net ([IPv6:::ffff:80.139.101.171]:14748
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225470AbTJMUyq>; Mon, 13 Oct 2003 21:54:46 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9DKsbNK025768;
	Mon, 13 Oct 2003 22:54:37 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9DKsZra025767;
	Mon, 13 Oct 2003 22:54:35 +0200
Date: Mon, 13 Oct 2003 22:54:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	durai <durai@isofttech.com>, mips <linux-mips@linux-mips.org>
Subject: Re: unresolved symbol litodp,dptoli,dpmul - floating point operations in kernel
Message-ID: <20031013205435.GB21100@linux-mips.org>
References: <02d001c38f36$ba4a8e00$6b00a8c0@DURAI> <Pine.GSO.4.21.0310101627400.8302-100000@waterleaf.sonytel.be> <20031010095824.B4192@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010095824.B4192@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2003 at 09:58:24AM -0700, Jun Sun wrote:

> > > > insmod: unresolved symbol dptoli
> > > > insmod: unresolved symbol dpmul
> > > > insmod: unresolved symbol litodp

> If you are really really desparate, something like the following
> might work.
> 
> void use_fpu(void)
> {
> 	if (is_fpu_owner()) {
> 		save_fp(current);
> 		loose_fpu();
> 		enable_fpu();
> 	}
> 	local_irq_save(flags);
> 	
> 	/* now use fpu and store the results */
> 
> 	local_irq_restore(flags);
> }
> 
> I like to emphsize this is just a hack and I am not even sure if it will work
> at all.  If compiler complains you might have to change the
> CC flag for that file or use fpu with inline assembly.

The symbols he was missing are used for software floating point.  Software
floating point in kernel space is perfectly ok since it doesn't use the FPU
so your hack isn't even needed.

  Ralf
