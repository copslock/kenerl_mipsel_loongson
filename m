Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 15:01:12 +0000 (GMT)
Received: from moutng.kundenserver.de ([212.227.126.187]:26075 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S8133576AbWAFPAy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 15:00:54 +0000
Received: from [85.212.192.127] (helo=[10.0.0.4])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis),
	id 0ML25U-1Eut7t1QiI-0008Br; Fri, 06 Jan 2006 16:03:33 +0100
Message-ID: <43BE878D.6080105@linuxdevelopment.de>
Date:	Fri, 06 Jan 2006 16:06:53 +0100
From:	Robert Woerle <robert@linuxdevelopment.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: diet-X11 fails /include/bits/types.h
References: <43BD9D93.40005@linuxdevelopment.de>
In-Reply-To: <43BD9D93.40005@linuxdevelopment.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:3a738c603c23670681f156cc7e748d26
Return-Path: <robert@linuxdevelopment.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert@linuxdevelopment.de
Precedence: bulk
X-list: linux-mips

Ok check that types.h and to me it looks that nothing in my toolchain
provides WORDSIZE
so i used the WORDSIZE=32 values and filled them in the 3rd else statement .
now all compiles fine


Robert Woerle schrieb:
>Hi
>
>i am new to mips and i am compiling a familiar gpe image for mips based
>systems .
>Now diet-X11 and X11 are breaking to compile on the below error.
>I googled  and found various occasions of this /include/bits/types.h
>causing problems
>
>i guess that has something todo with combination on compiler and glibc
>seems also glibc-2.3.5 fails on that
>
>i am using for that build
>glibc-2.3.3
>gcc-cross-3.3.4
>
>make[2]: Entering directory
>`/home/bob/Handhelds/oe/stuff/mips-build/tmp/work/diet-x11-6.2.1cvs20050226-r5/X11/src/util'
>| if gcc -DHAVE_CONFIG_H -I.
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/work/diet-x11-6.2.1cvs20050226-r5/X11/src/util
>-I../../src  
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include
>-Wall -Wpointer-arith -Wstrict-prototypes        -Wmissing-prototypes
>-Wmissing-declarations     -Wnested-externs -fno-strict-aliasing
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/X11/Xtrans  
>-D_XOPEN_SOURCE=500
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include  
>-I/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include
>-fexpensive-optimizations -fomit-frame-pointer -frename-registers -O2
>-MT makekeys-makekeys.o -MD -MP -MF ".deps/makekeys-makekeys.Tpo" -c -o
>makekeys-makekeys.o `test -f 'makekeys.c' || echo
>'/home/bob/Handhelds/oe/stuff/mips-build/tmp/work/diet-x11-6.2.1cvs20050226-r5/X11/src/util/'`makekeys.c;
>\
>| then mv -f ".deps/makekeys-makekeys.Tpo" ".deps/makekeys-makekeys.Po";
>else rm -f ".deps/makekeys-makekeys.Tpo"; exit 1; fi
>| In file included from
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/sys/types.h:31,
>|                  from
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/X11/Xos.h:59,
>|                  from makekeys.c:34:
>|
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/bits/types.h:127:3:
>#error
>| In file included from
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/sys/types.h:31,
>|                  from
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/X11/Xos.h:59,
>|                  from makekeys.c:34:
>|
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/bits/types.h:136:
>error: syntax error before "__dev_t"
>|
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/bits/types.h:136:
>warning: type defaults to `int' in declaration of `__dev_t'
>|
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/bits/types.h:136:
>warning: data definition has no type or storage class
>|
>/home/bob/Handhelds/oe/stuff/mips-build/tmp/staging/mipsel-linux/include/bits/types.h:140:
>error: syntax error before "__ino64_t"
>
>any hint is greatly appriciated
>regards
>
>rob_w
>
>
>  
