Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34BZAu12543
	for linux-mips-outgoing; Wed, 4 Apr 2001 04:35:10 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34BZ7M12539
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 04:35:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA12970;
	Wed, 4 Apr 2001 13:35:10 +0200 (MET DST)
Date: Wed, 4 Apr 2001 13:35:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
In-Reply-To: <3ACA00A5.8DAAC8CB@cotw.com>
Message-ID: <Pine.GSO.3.96.1010404132233.6521A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 3 Apr 2001, Steven J. Hill wrote:

> Well, the traditional MIPS targets are BEING used for SVR4....observe:
> 
> ld/configure.tgt:286:    mips*-*-sysv4*) targ_emul=elf32btsmip ;;
>  gas/conlfigure:2499:    mips-*-sysv4*MP*) fmt=elf em=tmips ;;
>    bfd/config.bd:646:    mips*-*-sysv4*) targ_defvec=bfd_elf32_tradbigmips_vec

 Yep, I know.

> I think that using 'elf[32|64]_[big|little]mips' for Linux and SVR4 would
> be a bad idea and would confuse things. Note that in 'bfd/elf32-mips.c' the
> IRIX_COMPAT macro is hinged around checking for a traditional MIPS target
> and will proceed to build IRIX flavored binaries if we are not using a
> traditional target. The names for IRIX targets ARE currently
> 'elf[32|64]_[big|little]mips'. Changing binutils so that these targets will
> now be for Linux/SVR4 and create ANOTHER target 'elf[32|64]_irixbigmips'
> will add more bloat to binutils and be confusing to people. SVR4 already
> uses traditional MIPS targets and Linux should as well. My vote is still
> to make Linux use the traditional MIPS targets. It will be difficult to
> convince me otherwise right now :).

 Note that 'elf32_tradbigmips' is quite a recent invention.  I was
thinking of making SVR4 use 'elf32_bigmips', as well, as this is *THE*
MIPS ELF target and others are variations.  Getting it otherwise seems
backwards.  It's a minor purity issue anyway, so even though I like my
idea better I don't absolutely insist on it. 

 Thanks for getting the work off from me, BTW.  I was going to make the
fix for quite some time now, but given my recent time constraints I
couldn't assure any reasonable deadline for it. :-(

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
