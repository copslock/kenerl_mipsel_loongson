Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 23:01:51 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:16792 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225321AbUK2XBq>; Mon, 29 Nov 2004 23:01:46 +0000
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane.cc.vt.edu [10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id iATMxDKB007910;
	Mon, 29 Nov 2004 17:59:13 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by zidane.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id CBR86234 (AUTH spbecker);
	Mon, 29 Nov 2004 18:01:30 -0500 (EST)
Message-ID: <41ABAA4F.6030403@gentoo.org>
Date: Mon, 29 Nov 2004 18:01:35 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041125)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
CC: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A3E3E7.7020701@gentoo.org> <41A510DE.8030004@gmx.net> <41A536A5.5050508@gentoo.org> <41ABA8E2.40709@gmx.net>
In-Reply-To: <41ABA8E2.40709@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> Hi Steve,
> 
> I also want to build a root file system for the target.
> I tried to build the tool chain you described above.
> I used crossdev on gentoo: "crossdev --arch=mips --vbinutils=2.15.91.0.2 
> --vheaders=2.4.25 --vgcc=3.4.3 --vglibc=2.3.4.20041102"
> But it fails.
> 
> mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC -DCROSS_COMPILE   
> -W -Wall -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes 
> -Wold-style-definition  -isystem ./include  -fPIC -DHAVE_SYSLOG -g  
> -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  -D_LIBC_PROVIDES_SSP_ -I. -I. 
> -I../../gcc -I../../gcc/. -I../../gcc/../include   -DL_eprintf -c 
> ../../gcc/libgcc2.c -o libgcc/./_eprintf.o
> /var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/xgcc 
> -B/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc/ 
> -B/home/crossdev/mips/mips-unknown-linux-gnu/bin/ 
> -B/home/crossdev/mips/mips-unknown-linux-gnu/lib/ -isystem 
> /home/crossdev/mips/mips-unknown-linux-gnu/include -isystem 
> /home/crossdev/mips/mips-unknown-linux-gnu/sys-include -O2  -DIN_GCC 
> -DCROSS_COMPILE   -W -Wall -Wwrite-strings -Wstrict-prototypes 
> -Wmissing-prototypes -Wold-style-definition  -isystem ./include  -fPIC 
> -DHAVE_SYSLOG -g  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  
> -D_LIBC_PROVIDES_SSP_ -I. -I. -I../../gcc -I../../gcc/. 
> -I../../gcc/../include   -DL__gcc_bcmp -c ../../gcc/libgcc2.c -o 
> libgcc/./__gcc_bcmp.o
> ../../gcc/unwind-dw2.c: In function `uw_frame_state_for':
> ../../gcc/unwind-dw2.c:1027: error: structure has no member named `sc_regs'
> ../../gcc/unwind-dw2.c:1027: error: structure has no member named `sc_pc'
> make[2]: *** [libgcc/./unwind-dw2.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[2]: Leaving directory 
> `/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
> make[1]: *** [libgcc.a] Error 2
> make[1]: Leaving directory 
> `/var/tmp/portage/crossdevbuild/gcc-3.4.3/buildboothere-mips/gcc'
> make: *** [all-gcc] Error 2
> 
> How did you build the tool chain?
> What kernel headers did you use?
> If I use kernel headers 2.6.8.1 (I realy need 2.6 heraders!)  the 
> installation of the headers fails!
> 
> It would be great If you can tell me which paramerter I have to use with 
> crossdev to get a working tool chain.
> 
> Best regards
> TheNop

Well, this really is more of a question for the gentoo-mips mailing 
list.  But anyway, 2.4 headers newer than our 2.4.22-r1 ebuild are 
broken (I can't remember exactly how at the moment), and we *really* 
don't support 2.6 headers at all.  In fact, building against them breaks 
glibc on o32 userland.  The only reason we have them in portage at all 
right now is for our n32 userland (which is broken in other ways because 
of the headers).  Eventually we'll have a sanitized 2.6 headers package 
that should work, but it may not be anytime soon.

Anyway to answer your question, I used crossdev to build a bootstrap C 
compiler (crossdev -k), then I did the rest by hand.  You might also 
need to get kumba's latest version of the crossdev script from gentoo's 
viewcvs under gentoo/users/kumba/crossdev/ just to get past the first part.

Why do you *need* 2.6 headers anyhow?  You can still run a 2.6 kernel 
with a userland compiled with 2.4 headers.

Steve
