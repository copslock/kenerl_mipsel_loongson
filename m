Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8KMY5e05133
	for linux-mips-outgoing; Thu, 20 Sep 2001 15:34:05 -0700
Received: from geoffk.org (dialin-sv-00.cygnus.com [205.180.231.50])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8KMY1e05130
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 15:34:02 -0700
Received: (from geoffk@localhost)
	by geoffk.org (8.9.3/8.9.3) id PAA02201;
	Thu, 20 Sep 2001 15:52:30 -0700
Date: Thu, 20 Sep 2001 15:52:30 -0700
Message-Id: <200109202252.PAA02201@geoffk.org>
X-Authentication-Warning: localhost.cygnus.com: geoffk set sender to geoffk@geoffk.org using -f
From: Geoff Keating <geoffk@geoffk.org>
To: rth@redhat.com
CC: hjl@lucon.org, rmurray@cyberhqz.com, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
In-reply-to: <20010917154754.E30386@redhat.com> (message from Richard
	Henderson on Mon, 17 Sep 2001 15:47:54 -0700)
Subject: Re: linker problem: relocation truncated to fit
Reply-to: Geoff Keating <geoffk@redhat.com>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917154754.E30386@redhat.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Date: Mon, 17 Sep 2001 15:47:54 -0700
> From: Richard Henderson <rth@redhat.com>
> Cc: Ryan Murray <rmurray@cyberhqz.com>, linux-mips@oss.sgi.com,
>         binutils@sourceware.cygnus.com, gcc@gcc.gnu.org

> On Sun, Sep 16, 2001 at 03:50:03PM -0700, H . J . Lu wrote:
> > I don't think mips is the only platform which has this problem. Do
> > Alpha, PowerPC and Sparc have similar problems like that? What are
> > the solutions for them?
> 
> Alpha has a complicated scheme by which every input object file may
> be assigned to a different GOT, each of which is limited to 64k.  The
> other reason this works is that variables assigned to .sdata/.sbss 
> are _not_ treated differently wrt code generation.  Instead, this is
> optimized via linker relaxation.
> 
> IA-64 will overflow its small data area at 22 bits.
> 
> PowerPC and Sparc do not use .sdata/.sbss.

Actually, powerpc could use .sdata/.sbss for shared libraries, but it
never got implemented, and it would have the disadvantage that such
code can't be linked into non-shared objects.

It would be a significant speed/space win for certain objects, most
notably libm.

-- 
- Geoffrey Keating <geoffk@geoffk.org>
