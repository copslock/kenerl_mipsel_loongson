Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JHRsT01799
	for linux-mips-outgoing; Fri, 19 Oct 2001 10:27:54 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JHRqD01793
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 10:27:52 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA50547;
	Fri, 19 Oct 2001 10:27:49 -0700 (PDT)
Date: Fri, 19 Oct 2001 10:27:49 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Subject: Re: [Linux-mips-kernel]PATCH
Message-ID: <20011019102749.B36916@idiom.com>
References: <3BC24525.8030201@mvista.com> <20011016115059.A29701@idiom.com> <1003471921.1184.4.camel@adsl.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <1003471921.1184.4.camel@adsl.pacbell.net>; from Pete Popov on Thu, Oct 18, 2001 at 11:12:01PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete,

> I ported the code from arch/ppc/boot, so if you like that scheme, what 
> is it that you don't like about the patch I sent?  The directory
> structure is the same as arch/ppc/boot, and the generic code is the same
> as well.

I see that PPC now has some of the silly utils where $(shell
objdump ...) in the Makefile would be a lot tighter.  Other
superficial but better ways like subdir-$(CONFIG_<board>) are
not used (instead ifdef CONFIG_NEC_PB100 $MAKE -- ugh!).  Not
sure why using CFLAGS/LOADADDR/.. from arch/mips/Makefile is not
done either... dup'ing this is bad.  Use "override CFLAGS" if it
needs to be re-constructed from GCCFLAGS,CPPFLAGS...

Apologies for playing "armchair coder".  I'll try to create Korva
version... but mine does it without benefit of a separate loader
(standalone vrboot style)... which might be a useful standard
build option.

Seems to me this is way more important than vrxx stuff... which
is already done and over... compression/initrd is in its infancy.

Geoff
-- 
Geoffrey Espin espin@idiom.com
