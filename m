Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33I2Nl12530
	for linux-mips-outgoing; Tue, 3 Apr 2001 11:02:23 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33I2MM12527
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 11:02:22 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id MAA17207;
	Tue, 3 Apr 2001 12:42:59 -0500
Message-ID: <3ACA00A5.8DAAC8CB@cotw.com>
Date: Tue, 03 Apr 2001 11:56:05 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
References: <Pine.GSO.3.96.1010403185241.25523H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
>  I've reviewed the patch briefly and it appears fine in principle.  I'm
> unsure about the target naming.  Since the MIPS ABI (which Linux tries to
> conform to) is defined by SVR4 and IRIX defines incompatible changes, I
> believe the the target SVR4 and Linux uses should be named
> 'elf[32|64]_bigmips' (and 'elf[32|64]_littlemips' for consistency, even
> though SVR4 doesn't really define it) and the IRIX target should be named
> something like 'elf[32|64]_irixbigmips'.
> 
Well, the traditional MIPS targets are BEING used for SVR4....observe:

ld/configure.tgt:286:    mips*-*-sysv4*) targ_emul=elf32btsmip ;;
 gas/conlfigure:2499:    mips-*-sysv4*MP*) fmt=elf em=tmips ;;
   bfd/config.bd:646:    mips*-*-sysv4*) targ_defvec=bfd_elf32_tradbigmips_vec

I think that using 'elf[32|64]_[big|little]mips' for Linux and SVR4 would
be a bad idea and would confuse things. Note that in 'bfd/elf32-mips.c' the
IRIX_COMPAT macro is hinged around checking for a traditional MIPS target
and will proceed to build IRIX flavored binaries if we are not using a
traditional target. The names for IRIX targets ARE currently
'elf[32|64]_[big|little]mips'. Changing binutils so that these targets will
now be for Linux/SVR4 and create ANOTHER target 'elf[32|64]_irixbigmips'
will add more bloat to binutils and be confusing to people. SVR4 already
uses traditional MIPS targets and Linux should as well. My vote is still
to make Linux use the traditional MIPS targets. It will be difficult to
convince me otherwise right now :).

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
