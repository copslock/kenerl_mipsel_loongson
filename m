Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JIFLF03454
	for linux-mips-outgoing; Fri, 19 Oct 2001 11:15:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JIFHD03451
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 11:15:17 -0700
Received: from adsl.pacbell.net ([10.2.2.20])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9JIGwB14771;
	Fri, 19 Oct 2001 11:16:58 -0700
Subject: Re: [Linux-mips-kernel]PATCH
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
In-reply-to: <1003471921.1184.4.camel@adsl.pacbell.net>; from Pete Popov on
	Thu, Oct 18, 2001 at 11:12:01PM -0700
X-Mailer: Mutt 0.95.1i
References: <3BC24525.8030201@mvista.com> <20011016115059.A29701@idiom.com>
	<1003471921.1184.4.camel@adsl.pacbell.net>
X-Authentication-warning: oss.sgi.com: mail owned process doing -bs
In-Reply-To: <20011019102749.B36916@idiom.com>
References: <3BC24525.8030201@mvista.com> <20011016115059.A29701@idiom.com>
	<1003471921.1184.4.camel@adsl.pacbell.net> 
	<20011019102749.B36916@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 19 Oct 2001 11:13:49 -0700
Message-Id: <1003515229.1184.27.camel@adsl.pacbell.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-10-19 at 10:27, Geoffrey Espin wrote:
> Pete,
> 
> > I ported the code from arch/ppc/boot, so if you like that scheme, what 
> > is it that you don't like about the patch I sent?  The directory
> > structure is the same as arch/ppc/boot, and the generic code is the same
> > as well.
> 
> I see that PPC now has some of the silly utils where $(shell
> objdump ...) in the Makefile would be a lot tighter.  

Are you talking about the utils in boot/utils?  I suppose you can get
rid of those and put everything in the makefile, but I'm not sure it
would be cleaner.

> Other
> superficial but better ways like subdir-$(CONFIG_<board>) are
> not used (instead ifdef CONFIG_NEC_PB100 $MAKE -- ugh!).  Not
> sure why using CFLAGS/LOADADDR/.. from arch/mips/Makefile is not
> done either... dup'ing this is bad.  

Yes, it is. I tried inheriting LOADADDR from arch/mips/Makefile, but it
didn't work and I didn't want to spend more time on it. I figured we can
clean that up later.

> Use "override CFLAGS" if it
> needs to be re-constructed from GCCFLAGS,CPPFLAGS...
> 
> Apologies for playing "armchair coder".  I'll try to create Korva
> version... but mine does it without benefit of a separate loader
> (standalone vrboot style)... which might be a useful standard
> build option.
> 
> Seems to me this is way more important than vrxx stuff... which
> is already done and over... compression/initrd is in its infancy.

Certainly on embedded mips boards it is. It seems like every other arch
already has compression and initrd support.  What I was shooting for
with that ppc patch is a reasonable start at having compression / kernel
loader support.  

Pete
