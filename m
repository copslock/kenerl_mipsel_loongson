Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA19315 for <linux-archive@neteng.engr.sgi.com>; Thu, 6 Aug 1998 17:34:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA76650
	for linux-list;
	Thu, 6 Aug 1998 17:33:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgitokyo.nsg.sgi.com (sgitokyo.nsg.sgi.com [134.14.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA03739
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Aug 1998 17:33:53 -0700 (PDT)
	mail_from (hakamada@nsg.sgi.com)
Received: from meteor.nsg.sgi.com (meteor.nsg.sgi.com [134.14.162.53])
	by sgitokyo.nsg.sgi.com (8.8.8/3.6W-98051410)
	id JAA24525;
	Fri, 7 Aug 1998 09:33:51 +0900 (JST)
Received: from localhost (localhost [127.0.0.1]) by meteor.nsg.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA67424; Fri, 7 Aug 1998 09:33:47 +0900 (JST)
To: tsbogend@alpha.franken.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Compiling kernel on HardHat
In-Reply-To: Your message of "Thu, 6 Aug 1998 21:25:51 +0200"
	<19980806212551.61171@alpha.franken.de>
References: <19980806212551.61171@alpha.franken.de>
X-Face: >$%-E_%BaR5YR&eW,GS3:]Cxv7ANEn%~'H!9L+1r[D<9qG/,WD4]L%#;`Nqb#^xc_*gG#o7
 j.@E>?09*)XTd}W5}^F*0K^suO|]f{'gAsluG~0(S-BSM96Ev@N9Rmf"{(0=7&ivn9n<-LS,sWB7W/
 H\[
X-Mailer: Mew version 1.92.4 on XEmacs 20.4 (Emerald)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <19980807093347Z.hakamada@nsg.sgi.com>
Date: Fri, 07 Aug 1998 09:33:47 +0900 (JST)
From: Takeshi Hakamada <hakamada@nsg.sgi.com>
X-Dispatcher: imput version 971024
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Thomas,

Thanks for your help. I'll try to remove #include in setup.c and build
kernel tonight.

Cheers,
Takeshi

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Message-ID: <19980806212551.61171@alpha.franken.de>
> On Thu, Aug 06, 1998 at 04:13:25PM +0900, Takeshi Hakamada wrote:
> > I tried to compile kernel on HardHat using RPM kernel(2.1.100) source,
> > I can't build kernel due to following error.
> > In arch/mips/sgi/kernel/setup.c, 
> > 
> > setup.c:18: asm/vector.h: No such file or directory
> 
> that's already fixed in the CVS repository. You just have to remove
> the #include in setup.c.
> 
> > Error message shows that I need to have include/asm/vector.h.
> > How can I get vector.h? Do I have to get latest kernel source from
> > ftp.linux.sgi.com?
> 
> As this should be the only change, you don't need to.
> 
> Thomas.
> 
> -- 
> See, you not only have to be a good coder to create a system like Linux,
> you have to be a sneaky bastard too ;-)
>                    [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
