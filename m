Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMrVd15591
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:53:31 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMrRe15588;
	Mon, 17 Sep 2001 15:53:27 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1A59C125C6; Mon, 17 Sep 2001 15:53:26 -0700 (PDT)
Date: Mon, 17 Sep 2001 15:53:25 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Richard Henderson <rth@redhat.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Ryan Murray <rmurray@cyberhqz.com>,
   linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917155325.A25017@lucon.org>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917035509.B24278@dea.linux-mips.net> <20010917154001.D30386@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010917154001.D30386@redhat.com>; from rth@redhat.com on Mon, Sep 17, 2001 at 03:40:01PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 03:40:01PM -0700, Richard Henderson wrote:
> On Mon, Sep 17, 2001 at 03:55:09AM +0200, Ralf Baechle wrote:
> > It is.  Yet I wouldn't like to assign a different meaning to -fpic and
> > -fPIC as most makefiles make little difference between these two options,
> > so that would imply quite some overhead.
> 
> There is already such a difference.  Sparc uses 13-bit GOT offsets
> with -fpic and 32-bit offsets with -fPIC.  I'm considering changes
> to Alpha to use a 16/32 split for pic/PIC.

Can you mix object files compiled with -fPIC/-fpic on Sparc/Alpha?


H.J.
