Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HN6XY16003
	for linux-mips-outgoing; Mon, 17 Sep 2001 16:06:33 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HN6Te16000;
	Mon, 17 Sep 2001 16:06:29 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 08467125C6; Mon, 17 Sep 2001 16:06:29 -0700 (PDT)
Date: Mon, 17 Sep 2001 16:06:28 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Richard Henderson <rth@redhat.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Ryan Murray <rmurray@cyberhqz.com>,
   linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010917160628.B25204@lucon.org>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com> <20010916155003.B1446@lucon.org> <20010917035509.B24278@dea.linux-mips.net> <20010917154001.D30386@redhat.com> <20010917155325.A25017@lucon.org> <20010917155616.H30386@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010917155616.H30386@redhat.com>; from rth@redhat.com on Mon, Sep 17, 2001 at 03:56:16PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 03:56:16PM -0700, Richard Henderson wrote:
> On Mon, Sep 17, 2001 at 03:53:25PM -0700, H . J . Lu wrote:
> > Can you mix object files compiled with -fPIC/-fpic on Sparc/Alpha?
> 
> Yes, but of course the total GOT/small data area is constrained
> by the size allowed by -fpic.

It doesn't help much if you do need -fPIC on some Qt code. Since I
don't use Qt on mips, I will let others work on it.


H.J.
