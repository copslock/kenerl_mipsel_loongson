Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 17:58:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36340 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225410AbTJJQ6n>;
	Fri, 10 Oct 2003 17:58:43 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h9AGwOL17215;
	Fri, 10 Oct 2003 09:58:24 -0700
Date: Fri, 10 Oct 2003 09:58:24 -0700
From: Jun Sun <jsun@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: durai <durai@isofttech.com>, mips <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: unresolved symbol litodp,dptoli,dpmul - floating point operations in kernel
Message-ID: <20031010095824.B4192@mvista.com>
References: <02d001c38f36$ba4a8e00$6b00a8c0@DURAI> <Pine.GSO.4.21.0310101627400.8302-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0310101627400.8302-100000@waterleaf.sonytel.be>; from geert@linux-m68k.org on Fri, Oct 10, 2003 at 04:28:27PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2003 at 04:28:27PM +0200, Geert Uytterhoeven wrote:
> On Fri, 10 Oct 2003, durai wrote:
> > I am using a mips cross compiler (mips-linux-gcc, version 2.95.3) to build my driver
> > I am using some floating point operations in a wireless lan driver for a mips platform in ucLinux, When i load the driver I am getting unresolved symbols
> > 
> > > 
> > > insmod: unresolved symbol dptoli
> > > insmod: unresolved symbol dpmul
> > > insmod: unresolved symbol litodp
> > 
> > And somebody told me that we cannot use floating point operations in kernel code, but i desperately need to use floating point operations. 
> > please tell me how to use floating point operations in kernel code.
> 
> Do not use floating point operations in kernel code.
> Re-implement using fixed point or something like that.
>

If you are really really desparate, something like the following
might work.

void use_fpu(void)
{
	if (is_fpu_owner()) {
		save_fp(current);
		loose_fpu();
		enable_fpu();
	}
	local_irq_save(flags);
	
	/* now use fpu and store the results */

	local_irq_restore(flags);
}

I like to emphsize this is just a hack and I am not even sure if it will work
at all.  If compiler complains you might have to change the
CC flag for that file or use fpu with inline assembly.

Jun
