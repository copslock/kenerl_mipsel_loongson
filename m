Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GMoA920370
	for linux-mips-outgoing; Sun, 16 Sep 2001 15:50:10 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GMo7e20367
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 15:50:07 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id BCA05125C6; Sun, 16 Sep 2001 15:50:05 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 8691AEBA4; Sun, 16 Sep 2001 15:50:03 -0700 (PDT)
Date: Sun, 16 Sep 2001 15:50:03 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ryan Murray <rmurray@cyberhqz.com>
Cc: linux-mips@oss.sgi.com, binutils@sourceware.cygnus.com, gcc@gcc.gnu.org
Subject: Re: linker problem: relocation truncated to fit
Message-ID: <20010916155003.B1446@lucon.org>
References: <20010916091654.C1812@lucon.org> <Pine.BSO.4.33.0109161323280.14503-100000@oddbox.cn> <20010917000719.B25531@false.linpro.no> <20010916153857.H22750@cyberhqz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916153857.H22750@cyberhqz.com>; from rmurray@cyberhqz.com on Sun, Sep 16, 2001 at 03:38:57PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Sep 16, 2001 at 03:38:57PM -0700, Ryan Murray wrote:
> On Mon, Sep 17, 2001 at 12:07:19AM +0200, Petter Reinholdtsen wrote:
> > [Wilbern Cobb]
> > > This is a `feature' of the MIPS toolchain. Global and static items <= n
> > > bytes are placed into the small data or small bss sections instead of
> > > the normal data or bss sections as an optimization. Excess items would
> > > cause these linker errors.
> > > 
> > > Pass the compiler the -Gn flag (default is 8 bytes), ie. -G4 should work
> > > for most purposes.
> > 
> > I tried -G4, -G2 and -G1 without any luck.  Even with -G1 there are still
> 
> I don't think -G is the problem here.  The problem is that the GOT
> needs to be bigger than a 16 bit value.  The only way to do this is to
> recompile everything that is going to be linked in statically
> (libc_noshared.a and libgcc.a included) with -Wa,-xgot This problem
> currently affects openh323 and mozilla, among other things.
> 

I don't think mips is the only platform which has this problem. Do
Alpha, PowerPC and Sparc have similar problems like that? What are
the solutions for them?

BTW, it sounds like the -fpic vs. -fPIC issue. 


H.J.
