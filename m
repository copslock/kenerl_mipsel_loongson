Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Sep 2004 21:44:03 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15593 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224954AbUIDUn6>;
	Sat, 4 Sep 2004 21:43:58 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i84KhsMp027869;
	Sat, 4 Sep 2004 22:43:56 +0200 (MEST)
Date: Sat, 4 Sep 2004 22:43:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Li Shishan <lishishan@utstar.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Why the program complied by mips-linux-g++ cann't run on the
 target machine
In-Reply-To: <BA3B937FD9473E41998E125463A3914301C68183@cnmail01.cn.utstarcom.com>
Message-ID: <Pine.GSO.4.58.0409042243081.3434@waterleaf.sonytel.be>
References: <BA3B937FD9473E41998E125463A3914301C68183@cnmail01.cn.utstarcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

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
