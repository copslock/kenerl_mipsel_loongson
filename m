Received:  by oss.sgi.com id <S42264AbQGJDqE>;
	Sun, 9 Jul 2000 20:46:04 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:17938 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42185AbQGJDpt>;
	Sun, 9 Jul 2000 20:45:49 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id UAA10775;
	Sun, 9 Jul 2000 20:45:46 -0700
Date:   Sun, 9 Jul 2000 20:45:45 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: current cvs binutils and mipsel-linux kernel
Message-ID: <20000709204545.A10621@chem.unr.edu>
References: <20000710011846.A1275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000710011846.A1275@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jul 10, 2000 at 01:18:46AM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 10, 2000 at 01:18:46AM +0200, Florian Lohoff wrote:

> mipsel-linux-gcc -D__KERNEL__ -I/home/flo/mips/dec/src/linux-2.4.0-test3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -fno-strict-aliasing -c softfp.S -o softfp.o
> softfp.S: Assembler messages:
> softfp.S:225: Error: illegal operands `la'
> softfp.S:225: Error: unrecognized opcode `cvt'
> softfp.S:225: Error: Rest of line ignored. First ignored character is `.'.
> make[1]: *** [softfp.o] Error 1
> make[1]: Leaving directory `/home/flo/mips/dec/src/linux-2.4.0-test3/arch/mips/kernel'
> make: *** [_dir_arch/mips/kernel] Error 2

This is not a binutils problem. It is caused by a behaviour change in
the C preprocessor in gcc 2.96 >= 000703. This has been fixed in the
CVS kernel; there are other changes required to build with such
compilers available in my patch at
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/kernel-patches/kernel-newcpp-000707.diff.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
