Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GDvJR03913
	for linux-mips-outgoing; Mon, 16 Jul 2001 06:57:19 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GDvAV03900;
	Mon, 16 Jul 2001 06:57:10 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A2188125BC; Mon, 16 Jul 2001 06:57:09 -0700 (PDT)
Date: Mon, 16 Jul 2001 06:57:09 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010716065709.A27252@lucon.org>
References: <20010712182402.A10768@lucon.org> <20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet> <20010713111010.A25902@lucon.org> <m38zhps7on.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m38zhps7on.fsf@otr.mynet>; from drepper@redhat.com on Sun, Jul 15, 2001 at 11:35:04PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 15, 2001 at 11:35:04PM -0700, Ulrich Drepper wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > 2001-07-13  H.J. Lu <hjl@gnu.org>
> > 
> > 	* sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Removed.
> > 	(elf_machine_got_rel): Defined only if RTLD_BOOTSTRAP is not
> > 	defined.
> > 	(RESOLVE_GOTSYM): Rewrite to use RESOLVE.
> > 
> > 	* sysdeps/mips/rtld-ldscript.in: Removed.
> > 	* sysdeps/mips/rtld-parms: Likewise.
> > 	* sysdeps/mips/mips64/rtld-parms: Likewise.
> > 	* sysdeps/mips/mipsel/rtld-parms: Likewise.
> 
> Is this the complete patch?  Nothing needed from the other patches?
> 

Yes, it is complete. Tested on Linux/mipsel.


H.J.
