Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DIHpU23790
	for linux-mips-outgoing; Fri, 13 Jul 2001 11:17:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DIHnV23787;
	Fri, 13 Jul 2001 11:17:49 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id AF72F125BA; Fri, 13 Jul 2001 11:17:43 -0700 (PDT)
Date: Fri, 13 Jul 2001 11:17:43 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Andreas Jaeger <aj@suse.de>
Cc: Ulrich Drepper <drepper@cygnus.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010713111743.C25902@lucon.org>
References: <20010712182402.A10768@lucon.org> <20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet> <u8u20gem8j.fsf@gromit.moeb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <u8u20gem8j.fsf@gromit.moeb>; from aj@suse.de on Fri, Jul 13, 2001 at 08:07:40PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 08:07:40PM +0200, Andreas Jaeger wrote:
> Ulrich Drepper <drepper@redhat.com> writes:
> 
> > Ralf Baechle <ralf@oss.sgi.com> writes:
> > 
> >> So please, go ahead.
> > 
> > So you say the patch is OK from your POV?
> 
> Just for the record, I also think it's ok - but will not apply it
> since it depends on patches for generic code.

Please ignore my first patch, which is wrong. The second one is ok
which doesn't touch generic code.


H.J.
