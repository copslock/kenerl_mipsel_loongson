Received:  by oss.sgi.com id <S42251AbQGIXtX>;
	Sun, 9 Jul 2000 16:49:23 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:3848 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42185AbQGIXsz>;
	Sun, 9 Jul 2000 16:48:55 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 12D0A959; Mon, 10 Jul 2000 01:49:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 900C08F73; Mon, 10 Jul 2000 01:18:46 +0200 (CEST)
Date:   Mon, 10 Jul 2000 01:18:46 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: current cvs binutils and mipsel-linux kernel
Message-ID: <20000710011846.A1275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
it seems there is a problem in the binutils from current cvs ...

mipsel-linux-gcc -D__KERNEL__ -I/home/flo/mips/dec/src/linux-2.4.0-test3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -fno-strict-aliasing -c softfp.S -o softfp.o
softfp.S: Assembler messages:
softfp.S:225: Error: illegal operands `la'
softfp.S:225: Error: unrecognized opcode `cvt'
softfp.S:225: Error: Rest of line ignored. First ignored character is `.'.
make[1]: *** [softfp.o] Error 1
make[1]: Leaving directory `/home/flo/mips/dec/src/linux-2.4.0-test3/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2

(flo@ping)~/mips/dec/src/linux-2.4.0-test3# mipsel-linux-as --version
GNU assembler 2.10.90
Copyright 2000 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `mipsel-linux'.

This is cvs checkout as of 20000708

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
