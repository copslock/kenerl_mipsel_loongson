Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Sep 2004 08:58:25 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:33466 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224914AbUIEH6T>;
	Sun, 5 Sep 2004 08:58:19 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i857wGMp000634
	for <linux-mips@linux-mips.org>; Sun, 5 Sep 2004 09:58:16 +0200 (MEST)
X-Received: from dolphin.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i854cuMo019060
	for <Geert.Uytterhoeven@sonycom.com>;
	Sun, 5 Sep 2004 06:38:56 +0200 (MEST)
X-Received: from ns1.nerdnet.nl ([217.170.15.1] helo=nerdnet.nl ident=root)
	by dolphin.sonytel.be with esmtp (Exim 4.41) id 1C3ono-0004jB-Ga
	for Geert.Uytterhoeven@sonycom.com; Sun, 05 Sep 2004 06:38:56 +0200
X-Received: from hzvscan2.utstar.com.cn ([218.108.42.27])
	by nerdnet.nl (8.13.1/8.13.1/Debian-11) with ESMTP id i854crss015193
	for <geert@linux-m68k.org>; Sun, 5 Sep 2004 06:38:55 +0200
X-Received: from cnmail01.cn.utstarcom.com (localhost [127.0.0.1])
	by hzvscan2.utstar.com.cn (8.11.6/8.11.6) with SMTP id i854Ymn15719
	for <geert@linux-m68k.org>; Sun, 5 Sep 2004 12:34:48 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: Why the program complied by mips-linux-g++ cann't run on the
	target machine
Date: Sun, 5 Sep 2004 12:39:09 +0800
Message-ID: <BA3B937FD9473E41998E125463A3914301C68473@cnmail01.cn.utstarcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why the program complied by mips-linux-g++ cann't run on the
	target machine
Thread-Index: AcSSwALHqU97jn0tTjOzJ6GCeF/nagAOZQEw
From: "Li Shishan" <lishishan@utstar.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Virus-Scanned: clamd / ClamAV version 0.75-1, clamav-milter version 0.75c
	on nerdcentral
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by witte.sonytel.be id
	i854cuMo019060
X-Spambayes-Classification: ham; 0.00
ReSent-Date: Sun, 5 Sep 2004 09:58:04 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: Linux/MIPS Development <linux-mips@linux-mips.org>
ReSent-Subject: RE: Why the program complied by mips-linux-g++ cann't run on
 the target machine
ReSent-Message-ID: <Pine.GSO.4.58.0409050958040.28961@waterleaf.sonytel.be>
Return-Path: <geert@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@sonycom.com
Precedence: bulk
X-list: linux-mips


   Hi  Geert:
        I am very appreciated to your reply,   thank you very  much   !!!

       When I  excute  the command : ldd ./ccgame,  give result : ./ldd: not found .   what can I do for that ?

        If as you say ,require the c++ runtime libraries on the target .   firstly , my  test program  is coded by  C ,not C++ , if it also require c++ libraries?

 secondly, my target flash is very limited,  the C++ runtime libraries  is very large .
       

-----Original Message-----
From: geert@sonycom.com [mailto:geert@sonycom.com]On Behalf Of Geert
Uytterhoeven
Sent: 2004Äê9ÔÂ5ÈÕ 4:44
To: Li Shishan
Cc: Linux/MIPS Development
Subject: Re: Why the program complied by mips-linux-g++ cann't run on
the target machine


On Sat, 4 Sep 2004, Li Shishan wrote:
>                I  use the   mips-linux-g++  complie a program.  and I excuted it on the target machine , but cann't, what's wrong?
>
>               For example:
>
>                For PC, I use g++  -c -o ccgame.o ccgame.cpp
> 		                    g++  -o ccgame ./ccgame.o
> 		execute it will give: Hello, world!
>
> 		For the target board, I use mips-linux-g++  -c -o ccgame.o ccgame.cpp
> 		                             mips-linux-g++  -o ccgame ./ccgame.o
> 		excute it will give " /bin/sh: ./ccgame: not found".
>
> 		Is there something wrong?

Look like you didn't install the C++ runtime libraries on the target.
What does `ldd ./ccgame' say?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
