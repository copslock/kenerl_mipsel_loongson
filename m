Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Sep 2004 09:02:51 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:42171 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224914AbUIEICr>;
	Sun, 5 Sep 2004 09:02:47 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i8582kMp000799;
	Sun, 5 Sep 2004 10:02:46 +0200 (MEST)
Date: Sun, 5 Sep 2004 10:02:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Li Shishan <lishishan@utstar.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: Why the program complied by mips-linux-g++ cann't run on the
 target machine
In-Reply-To: <BA3B937FD9473E41998E125463A3914301C68473@cnmail01.cn.utstarcom.com>
Message-ID: <Pine.GSO.4.58.0409050958440.28961@waterleaf.sonytel.be>
References: <BA3B937FD9473E41998E125463A3914301C68473@cnmail01.cn.utstarcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 5 Sep 2004, Li Shishan wrote:
>         I am very appreciated to your reply,   thank you very  much   !!!
>
>        When I  excute  the command : ldd ./ccgame,  give result : ./ldd: not found .   what can I do for that ?

Install ldd to find out?

>         If as you say ,require the c++ runtime libraries on the target .   firstly , my  test program  is coded by  C ,not C++ , if it also require c++ libraries?

If you compile it with g++, it will need the C++ runtime library, even if the
program source is plain C:

| anakin$ cat hello.c
| #include <stdio.h>
| #include <stdlib.h>
|
| int main(int argc, char *argv[])
| {
|     printf("Hello, world! [C]\n");
|     exit(0);
| }
|
| anakin$ gcc hello.c
| anakin$ ldd a.out
|                 libc.so.6 => /lib/tls/libc.so.6 (0x41019000)
|         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x41000000)
| anakin$ mv hello.c hello.C
| anakin$ g++ hello.C
| anakin$ ldd a.out
|                 libstdc++.so.5 => /usr/lib/libstdc++.so.5 (0x40016000)
|         libm.so.6 => /lib/tls/libm.so.6 (0x41156000)
|         libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x4131a000)
|         libc.so.6 => /lib/tls/libc.so.6 (0x41019000)
|         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x41000000)
| anakin$

>  secondly, my target flash is very limited,  the C++ runtime libraries  is very large .

If it's C, why not compile it with the C compiler instead of the C++ compiler?

> -----Original Message-----
> From: geert@linux-m68k.org Geert Uytterhoeven
> Sent: 2004Äê9ÔÂ5ÈÕ 4:44
> To: Li Shishan
> Cc: Linux/MIPS Development
> Subject: Re: Why the program complied by mips-linux-g++ cann't run on
> the target machine
>
>
> On Sat, 4 Sep 2004, Li Shishan wrote:
> >                I  use the   mips-linux-g++  complie a program.  and I excuted it on the target machine , but cann't, what's wrong?
> >
> >               For example:
> >
> >                For PC, I use g++  -c -o ccgame.o ccgame.cpp
> > 		                    g++  -o ccgame ./ccgame.o
> > 		execute it will give: Hello, world!
> >
> > 		For the target board, I use mips-linux-g++  -c -o ccgame.o ccgame.cpp
> > 		                             mips-linux-g++  -o ccgame ./ccgame.o
> > 		excute it will give " /bin/sh: ./ccgame: not found".
> >
> > 		Is there something wrong?
>
> Look like you didn't install the C++ runtime libraries on the target.
> What does `ldd ./ccgame' say?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
