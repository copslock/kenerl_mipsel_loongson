Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Sep 2004 10:25:10 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:12679 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224924AbUIFJZG>;
	Mon, 6 Sep 2004 10:25:06 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i869P4Mp010476;
	Mon, 6 Sep 2004 11:25:04 +0200 (MEST)
Date: Mon, 6 Sep 2004 11:25:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Li Shishan <lishishan@utstar.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: R E: Why the program complied by mips-linux-g++ cann't run on
 the target machine
In-Reply-To: <BA3B937FD9473E41998E125463A3914301CA5774@cnmail01.cn.utstarcom.com>
Message-ID: <Pine.GSO.4.58.0409061123590.15075@waterleaf.sonytel.be>
References: <BA3B937FD9473E41998E125463A3914301CA5774@cnmail01.cn.utstarcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 6 Sep 2004, Li Shishan wrote:
>         My  test program is coded by C, but my normal project was  coded by C++;
>
>      If  actually   there requrie the C++ runtime library ,   Can you have any other method for it .
>
>     because the C++  runtime library very huge, my  flash is limited.

That's the disadvantage of using C++: it needs a large runtime.

You can work around it by building your own stripped libstdc++, that includes
only the stuff you really need.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
