Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57JO8u07902
	for linux-mips-outgoing; Thu, 7 Jun 2001 12:24:08 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57JO7h07896
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 12:24:07 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4BA5D125BA; Thu,  7 Jun 2001 12:24:06 -0700 (PDT)
Date: Thu, 7 Jun 2001 12:24:05 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Daniel Berlin <dan@cgsoftware.com>
Cc: Stan Shebs <shebs@apple.com>, GDB <gdb@sourceware.cygnus.com>,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: stabs or ecoff for Linux/mips
Message-ID: <20010607122405.A16724@lucon.org>
References: <20010607093149.B13198@lucon.org> <3B1FCAC9.2110A024@apple.com> <873d9cnmad.fsf@cgsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <873d9cnmad.fsf@cgsoftware.com>; from dan@cgsoftware.com on Thu, Jun 07, 2001 at 03:05:14PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 03:05:14PM -0400, Daniel Berlin wrote:
> Stan Shebs <shebs@apple.com> writes:
> 
> > "H . J . Lu" wrote:
> >> 
> >> What is the better debug format for Linux/mips in the terms of gdb
> >> and binutils, stabs or ecoff? I know the future is dwarf2. But I need
> >> something stable now. Since Linux/x86 uses stabs, I lean toward to
> >> stabs. Any comments?
> > 
> > Go with stabs and ELF.  Neither ecoff's base file format nor the debug
> > info were particularly well-documented (I remember some of the bits in
> > GNU being figured out by reverse engineering!), perpetuating it will
> > just make your life more difficult in the long run.  It will also be
> > easier to move to dwarf2 when the opportunity arises.
> 
> mdebugread is also an evil piece of code. 

That matches my own experiences. In case you haven't noticed, I
have checked in patches to switch Linux/mips to stabs in ELF :-).


H.J.
