Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OLIOwJ020569
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 14:18:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OLIOrB020568
	for linux-mips-outgoing; Wed, 24 Apr 2002 14:18:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OLIJwJ020552
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 14:18:19 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020424211841.BEYH29911.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Wed, 24 Apr 2002 21:18:41 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9FB98125C7; Wed, 24 Apr 2002 14:18:40 -0700 (PDT)
Date: Wed, 24 Apr 2002 14:18:40 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: Updates for RedHat 7.1/mips
Message-ID: <20020424141840.A28683@lucon.org>
References: <20020423155925.A8846@lucon.org> <20020424135339.A24558@idiom.com> <20020424140156.A28438@lucon.org> <20020424141136.A63873@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020424141136.A63873@idiom.com>; from espin@idiom.com on Wed, Apr 24, 2002 at 02:11:36PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 24, 2002 at 02:11:36PM -0700, Geoffrey Espin wrote:
> On Wed, Apr 24, 2002 at 02:01:56PM -0700, H . J . Lu wrote:
> > That is a kernel bug which has been fixed in the newer kernel. From my
> > binutils release note:
> > Changes from binutils 2.11.92.0.10:
> > 1. Update from binutils 2001 1121.
> > 2. Fix a linker symbol version bug for common symbols.
> > 3. Update handling relocations against the discarded sections. You may
> > need to apply the kernel patch enclosed here to your kernel source. If
> > you still see things like
> > drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded
> >  section .text.exit'
> > in the final kernel link, that means you have compiled a driver into
> > the kernel which has a reference to the symbol in a discarded section.
> > Kernel 2.4.17 or above should work fine.
> > H.J.
> 
> Sorry, I should have specified my kernel *IS* recently (Monday)
> from linux-mips.sourceforge.net.  And it was previously sync'd
> to oss.sgi.com on Sunday, 21Apr02.
> 

Your kernel still have references to symbols in discarded sections. Please
read linux/include/linux/init.h:

/* Functions marked as __devexit may be discarded at kernel link time, depending
   on config options.  Newer versions of binutils detect references from
   retained sections to discarded sections and flag an error.  Pointers to
   __devexit functions must use __devexit_p(function_name), the wrapper will
   insert either the function_name or NULL, depending on the config options.
 */
#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x 
#else
#define __devexit_p(x) NULL
#endif


H.J.
