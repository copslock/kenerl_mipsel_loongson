Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14Muta18698
	for linux-mips-outgoing; Mon, 4 Feb 2002 14:56:55 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14MumA18693;
	Mon, 4 Feb 2002 14:56:48 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g14MshB25272;
	Mon, 4 Feb 2002 14:54:43 -0800
Message-ID: <3C5F11AB.957DDA6C@mvista.com>
Date: Mon, 04 Feb 2002 14:56:43 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: gcc 3.x, -ansi and "static inline"
References: <20020201115206.A18085@mvista.com> <20020203180151.A5371@dea.linux-mips.net> <3C5EE0D0.F2CC94CE@mvista.com> <20020204232108.A7266@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Mon, Feb 04, 2002 at 11:28:16AM -0800, Jun Sun wrote:
> 
> > > On Fri, Feb 01, 2002 at 11:52:06AM -0800, Jun Sun wrote:
> > >
> > > > BTW, the inclusion of "mipsregs.h" file in bitops.h seems unnecessary
> > > > and caused a bunch of similar errors.
> > >
> > > Indeed, it was pointless and I therefore removed it.
> >
> > What about ffz()?  We can do:
> 
> Including kernel header files into user code is the actual bug

In theory, yes.  In practice, kernel head is all a big mesh where we don't
have a clear division as which part can go to userland and which part can't.

The inline function makes mesh even meshier.

> but if
> you think fixing that isn't an option I can certainly so a
> s/inline/__inline__/
> 

I think this is the case.  See the inclusion chain below.  BTW, the app is
libcap.

In file included from
/opt/hardhat/devkit/mips/sb1_fp_be/target/usr/include/linux/fs.h:26,
                 from
/opt/hardhat/devkit/mips/sb1_fp_be/target/usr/include/linux/capability.h:17,
                 from
/var/tmp/BUILD/libcap-1.10.orig/libcap/include/sys/capability.h:24,
                 from libcap.h:19,
                 from cap_alloc.c:12:
/opt/hardhat/devkit/mips/sb1_fp_be/target/usr/include/asm/bitops.h:678: syntax
error before "unsigned"


Jun
