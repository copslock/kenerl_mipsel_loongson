Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PBKqRw001154
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 04:20:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PBKq7U001153
	for linux-mips-outgoing; Thu, 25 Jul 2002 04:20:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PBKjRw001137
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 04:20:46 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA29941;
	Thu, 25 Jul 2002 13:10:06 +0200 (MET DST)
Date: Thu, 25 Jul 2002 13:10:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: RFC: elf_check_arch() rework
In-Reply-To: <3D3EFC14.D8D690F0@mips.com>
Message-ID: <Pine.GSO.3.96.1020725125830.27463H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 24 Jul 2002, Carsten Langgaard wrote:

> We at MIPS are in the process of making an ABI spec for all this, which
> is the intention that should be used by the tool-vendors.  So please
> don't change the ELF header defines. 

 It'd be better the spec matched the real world...

> I don't see that is wrong with checking the ISA level, I rather have an
> error telling me that I can't execute a certain ISA level than
> eventually getting a reserved instruction or something worse like
> something unpredictable. 

 Well, -ENOEXEC in not any more useful than SIGILL -- with the latter you
have at least an idea what happened.  The ISA check is not implemented for
any Linux port, so there no suitable hook in binfmt_*.c files.  You might
propose an implementation if that's particularly important for you. 

> You are obviously right about the elf_check_arch in the 64-bit part of
> the kernel is broken.  It's probably just be copied from the 32-bit part
> without changes, like a lot of the code in the 64-bit kernel is. 

 Possibly, but it still makes me wonder why it wasn't adjusted at the time
binfmt_elf32.c was created...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
