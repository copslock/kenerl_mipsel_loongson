Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Sep 2004 10:25:42 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:13703 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224930AbUIFJZI>;
	Mon, 6 Sep 2004 10:25:08 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i869P7Mp010480
	for <linux-mips@linux-mips.org>; Mon, 6 Sep 2004 11:25:07 +0200 (MEST)
X-Received: from dolphin.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i866KjMo028945
	for <Geert.Uytterhoeven@sonycom.com>;
	Mon, 6 Sep 2004 08:20:46 +0200 (MEST)
X-Received: from ns1.nerdnet.nl ([217.170.15.1] helo=nerdnet.nl ident=root)
	by dolphin.sonytel.be with esmtp (Exim 4.41) id 1C4Crt-0007TI-MS
	for Geert.Uytterhoeven@sonycom.com; Mon, 06 Sep 2004 08:20:45 +0200
X-Received: from hzvscan2.utstar.com.cn ([218.108.42.27])
	by nerdnet.nl (8.13.1/8.13.1/Debian-11) with ESMTP id i866KfQm026039
	for <geert@linux-m68k.org>; Mon, 6 Sep 2004 08:20:44 +0200
X-Received: from cnmail01.cn.utstarcom.com (localhost [127.0.0.1])
	by hzvscan2.utstar.com.cn (8.11.6/8.11.6) with SMTP id i866GQj25496
	for <geert@linux-m68k.org>; Mon, 6 Sep 2004 14:16:34 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: R E: Why the program complied by mips-linux-g++ cann't run on the
	target machine
Date: Mon, 6 Sep 2004 14:20:46 +0800
Message-ID: <BA3B937FD9473E41998E125463A3914301CA5774@cnmail01.cn.utstarcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why the program complied by mips-linux-g++ cann't run on the
	target machine
Thread-Index: AcSTHtq6essUq055Q1S8O5F3vWD+HgAuezAA
From: "Li Shishan" <lishishan@utstar.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Virus-Scanned: clamd / ClamAV version 0.75-1, clamav-milter version 0.75c
	on nerdcentral
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by witte.sonytel.be id i866KjMo028945
X-Spambayes-Classification: ham; 0.00
ReSent-Date: Mon, 6 Sep 2004 11:25:06 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: Linux/MIPS Development <linux-mips@linux-mips.org>
ReSent-Subject: R E: Why the program complied by mips-linux-g++ cann't run
 on the target machine
ReSent-Message-ID: <Pine.GSO.4.58.0409061125060.15075@waterleaf.sonytel.be>
Return-Path: <geert@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@sonycom.com
Precedence: bulk
X-list: linux-mips



  Hi:
        My  test program is coded by C, but my normal project was  coded by C++;

     If  actually   there requrie the C++ runtime library ,   Can you have any other method for it .
 
    because the C++  runtime library very huge, my  flash is limited.

    Thank you very much for reply!!!  

-----Original Message-----
From: geert@sonycom.com [mailto:geert@sonycom.com]On Behalf Of Geert Uytterhoeven
Sent: 2004年9月5日 16:03
To: Li Shishan
Cc: Linux/MIPS Development
Subject: RE: Why the program complied by mips-linux-g++ cann't run on the target machine


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
> Sent: 2004Äê9ÔÂ5èÕ 4:44
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
