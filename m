Received:  by oss.sgi.com id <S42199AbQGJUal>;
	Mon, 10 Jul 2000 13:30:41 -0700
Received: from u-113.karlsruhe.ipdial.viaginterkom.de ([62.180.18.113]:46598
        "EHLO u-113.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42185AbQGJUa0>; Mon, 10 Jul 2000 13:30:26 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S640084AbQGJR3T>;
        Mon, 10 Jul 2000 19:29:19 +0200
Date:   Mon, 10 Jul 2000 19:29:18 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: current cvs binutils and mipsel-linux kernel
Message-ID: <20000710192918.A5900@bacchus.dhis.org>
References: <20000710011846.A1275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000710011846.A1275@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Jul 10, 2000 at 01:18:46AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 10, 2000 at 01:18:46AM +0200, Florian Lohoff wrote:

> it seems there is a problem in the binutils from current cvs ...
> 
> mipsel-linux-gcc -D__KERNEL__ -I/home/flo/mips/dec/src/linux-2.4.0-test3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -fno-strict-aliasing -c softfp.S -o softfp.o
> softfp.S: Assembler messages:
> softfp.S:225: Error: illegal operands `la'
> softfp.S:225: Error: unrecognized opcode `cvt'
> softfp.S:225: Error: Rest of line ignored. First ignored character is `.'.
> make[1]: *** [softfp.o] Error 1
> make[1]: Leaving directory `/home/flo/mips/dec/src/linux-2.4.0-test3/arch/mips/kernel'
> make: *** [_dir_arch/mips/kernel] Error 2

You're probably also using a very recent gcc.  Recent gcc had preprocessor
changes to make it more stricly comply to ISO.  This breaks a number of
files in the Linux kernel which for readability have extra space around
the ## C preprocessor paste.  I've already commited the necessary fixes
for softfp.S which is the only affected MIPS file to CVS.  There is still
a large number of other files which aren't ISO C89 compliant.   Keith
Wesolowski has made a patch for those which I'll send to Linus.

  Ralf
