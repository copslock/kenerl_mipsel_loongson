Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57IDPA32132
	for linux-mips-outgoing; Thu, 7 Jun 2001 11:13:25 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57IDOh32127
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:13:24 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 46A66125BA; Thu,  7 Jun 2001 11:13:24 -0700 (PDT)
Date: Thu, 7 Jun 2001 11:13:24 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Cagney <ac131313@cygnus.com>
Cc: GDB <gdb@sourceware.cygnus.com>, binutils@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Re: stabs or ecoff for Linux/mips
Message-ID: <20010607111324.C15440@lucon.org>
References: <20010607093332.C13198@lucon.org> <3B1FC23D.3020900@cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1FC23D.3020900@cygnus.com>; from ac131313@cygnus.com on Thu, Jun 07, 2001 at 02:04:45PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 02:04:45PM -0400, Andrew Cagney wrote:
> dwarf2
> stabs
> not ecoff (er, isn't ecoff an object format like coff? I guess you mean 
> something like Dwarf1)

Ok. I meant stabs in ecoff vs. stabs in elf.

> 
> As Dan will probably be quick to point out, you'll get better C++ 
> support with dwarf2.
> 
> There is nothing unstable about dwarf2.  GDB's support for it has been 
> around for yonks.

It is more than just gdb. For a complete dwarf2 support, we need gcc
and binutils. I don't think we are there yet, at least not with stable
release.

H.J.
