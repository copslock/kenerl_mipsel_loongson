Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OLBKwJ020340
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 14:11:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OLBKlM020338
	for linux-mips-outgoing; Wed, 24 Apr 2002 14:11:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OLBEwJ020335
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 14:11:15 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id OAA68127;
	Wed, 24 Apr 2002 14:11:36 -0700 (PDT)
Date: Wed, 24 Apr 2002 14:11:36 -0700
From: Geoffrey Espin <espin@idiom.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: Updates for RedHat 7.1/mips
Message-ID: <20020424141136.A63873@idiom.com>
References: <20020423155925.A8846@lucon.org> <20020424135339.A24558@idiom.com> <20020424140156.A28438@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020424140156.A28438@lucon.org>; from H . J . Lu on Wed, Apr 24, 2002 at 02:01:56PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 24, 2002 at 02:01:56PM -0700, H . J . Lu wrote:
> That is a kernel bug which has been fixed in the newer kernel. From my
> binutils release note:
> Changes from binutils 2.11.92.0.10:
> 1. Update from binutils 2001 1121.
> 2. Fix a linker symbol version bug for common symbols.
> 3. Update handling relocations against the discarded sections. You may
> need to apply the kernel patch enclosed here to your kernel source. If
> you still see things like
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded
>  section .text.exit'
> in the final kernel link, that means you have compiled a driver into
> the kernel which has a reference to the symbol in a discarded section.
> Kernel 2.4.17 or above should work fine.
> H.J.

Sorry, I should have specified my kernel *IS* recently (Monday)
from linux-mips.sourceforge.net.  And it was previously sync'd
to oss.sgi.com on Sunday, 21Apr02.

    VERSION = 2
    PATCHLEVEL = 4
    SUBLEVEL = 18
    EXTRAVERSION = -mips

Hence my befuddlement.

I'll fix the cc list to l-m-k.

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
