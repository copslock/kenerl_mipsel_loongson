Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56Lhcd11089
	for linux-mips-outgoing; Wed, 6 Jun 2001 14:43:38 -0700
Received: from geoffk.org (desire.geoffk.org [64.2.60.52])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56Lhah11085
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 14:43:37 -0700
Received: (from geoffk@localhost)
	by geoffk.org (8.9.3/8.9.3) id OAA01491;
	Wed, 6 Jun 2001 14:59:19 -0700
Date: Wed, 6 Jun 2001 14:59:19 -0700
Message-Id: <200106062159.OAA01491@geoffk.org>
X-Authentication-Warning: localhost: geoffk set sender to geoffk@geoffk.org using -f
From: Geoff Keating <geoffk@geoffk.org>
To: hjl@lucon.org
CC: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
In-reply-to: <20010606131551.A25655@lucon.org> (hjl@lucon.org)
Subject: Re: mips gas is horribly broken
Reply-to: Geoff Keating <geoffk@redhat.com>
References: <20010606091846.A21652@lucon.org> <200106061932.MAA01399@geoffk.org> <20010606131551.A25655@lucon.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Date: Wed, 6 Jun 2001 13:15:51 -0700
> From: "H . J . Lu" <hjl@lucon.org>
> Cc: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
> Content-Disposition: inline
> User-Agent: Mutt/1.2.5i
> 
> On Wed, Jun 06, 2001 at 12:32:15PM -0700, Geoff Keating wrote:
> > > Date: Wed, 6 Jun 2001 09:18:46 -0700
> > > From: "H . J . Lu" <hjl@lucon.org>
> > > Cc: linux-mips@oss.sgi.com
> > > Content-Disposition: inline
> > > User-Agent: Mutt/1.2.5i
> > > 
> > > Around line 9544 in gas/config/tc-mips.c, there are
> > > 
> > >         if (value != 0 && ! fixP->fx_pcrel)
> > >           {
> > >             /* In this case, the bfd_install_relocation routine will
> > >                incorrectly add the symbol value back in.  We just want
> > >                the addend to appear in the object file.
> > >                FIXME: If this makes VALUE zero, we're toast.  */
> > >             value -= S_GET_VALUE (fixP->fx_addsy);
> > >           }
> > > 
> > > I spent several days trying to figure out why libstdc++ was miscompiled
> > > on Linux/mipsel. That was because value was zero. That is totally
> > > unacceptable for gas to knowingly generate incorrect binaries. At
> > > least, we should do
> > > 
> > >             value -= S_GET_VALUE (fixP->fx_addsy);
> > > 	    assert (value != 0);
> > > 
> > > But I'd like to fix it once for all. Does anyone have any suggestions?
> > 
> > There is no easy fix.  This has been a longstanding problem, but any
> > change to bfd_install_relocation would require modifying every port in
> 
> That is not a good excuse to knowingly generate incorrect binaries.
> 
> > a corresponding way, see for instance the FIXME at line 4816 or so in
> > tc-ppc.c.
> 
> I am willing to spend my time to fix it. Do you have any suggestions
> how to proceed?

First, redesign bfd_install_relocation so that it does the right thing
(there are other cases where the bfd backends have to work around
it).  Then, change all the users to match.  Then, test all the
supported platforms.

It might be worthwhile, before starting this, to look and see what
precisely _are_ the supported platforms.  There are things 
in bfd that probably haven't been used for years.  I guess anything
supported by either GDB or by GCC should still be supported, but there
are some more platforms which are supported only in GAS, typically
because it doesn't make sense to have a compiler for them (small 8-bit
parts, for instance).

-- 
- Geoffrey Keating <geoffk@geoffk.org>
