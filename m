Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56KFqx26497
	for linux-mips-outgoing; Wed, 6 Jun 2001 13:15:52 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56KFqh26494
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 13:15:52 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B9103125BA; Wed,  6 Jun 2001 13:15:51 -0700 (PDT)
Date: Wed, 6 Jun 2001 13:15:51 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Geoff Keating <geoffk@redhat.com>
Cc: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: mips gas is horribly broken
Message-ID: <20010606131551.A25655@lucon.org>
References: <20010606091846.A21652@lucon.org> <200106061932.MAA01399@geoffk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106061932.MAA01399@geoffk.org>; from geoffk@geoffk.org on Wed, Jun 06, 2001 at 12:32:15PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 06, 2001 at 12:32:15PM -0700, Geoff Keating wrote:
> > Date: Wed, 6 Jun 2001 09:18:46 -0700
> > From: "H . J . Lu" <hjl@lucon.org>
> > Cc: linux-mips@oss.sgi.com
> > Content-Disposition: inline
> > User-Agent: Mutt/1.2.5i
> > 
> > Around line 9544 in gas/config/tc-mips.c, there are
> > 
> >         if (value != 0 && ! fixP->fx_pcrel)
> >           {
> >             /* In this case, the bfd_install_relocation routine will
> >                incorrectly add the symbol value back in.  We just want
> >                the addend to appear in the object file.
> >                FIXME: If this makes VALUE zero, we're toast.  */
> >             value -= S_GET_VALUE (fixP->fx_addsy);
> >           }
> > 
> > I spent several days trying to figure out why libstdc++ was miscompiled
> > on Linux/mipsel. That was because value was zero. That is totally
> > unacceptable for gas to knowingly generate incorrect binaries. At
> > least, we should do
> > 
> >             value -= S_GET_VALUE (fixP->fx_addsy);
> > 	    assert (value != 0);
> > 
> > But I'd like to fix it once for all. Does anyone have any suggestions?
> 
> There is no easy fix.  This has been a longstanding problem, but any
> change to bfd_install_relocation would require modifying every port in

That is not a good excuse to knowingly generate incorrect binaries.

> a corresponding way, see for instance the FIXME at line 4816 or so in
> tc-ppc.c.

I am willing to spend my time to fix it. Do you have any suggestions
how to proceed?


H.J.
