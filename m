Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 23:44:17 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:34756 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20024472AbXEVWoQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 23:44:16 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l4MMi6vd018624
	for <linux-mips@linux-mips.org>; Tue, 22 May 2007 18:44:07 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l4MMi6mi002534;
	Tue, 22 May 2007 18:44:06 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 22 May 2007 18:44:06 -0400 (EDT)
Message-ID: <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
In-Reply-To: <Pine.LNX.4.64.0705221931380.11196@anakin>
References: <20070516151939.GH19816@deprecation.cyrius.com>
    <20070516160313.GA3409@bongo.bofh.it>
    <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
    <20070517151636.GJ3586@deprecation.cyrius.com>
    <20070521154726.GE5943@linux-mips.org>
    <20070522110956.GB29118@linux-mips.org>
    <1179834093.7896.23.camel@scarafaggio>
    <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
    <20070522122808.GD32557@linux-mips.org>
    <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
    <20070522151848.GB19833@networkno.de>
    <33252.129.133.92.31.1179852417.squirrel@webmail.wesleyan.edu>
    <Pine.LNX.4.64.0705221931380.11196@anakin>
Date:	Tue, 22 May 2007 18:44:06 -0400 (EDT)
Subject: Re: Cross-Compile difficulties
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> On Tue, 22 May 2007, sknauert@wesleyan.edu wrote:
>> scripts/basic/fixdep.c:107:23: error: sys/types.h: No such file or
>> directory
>
> You're missing the basic libraries for native compilation.
>
> | apt-get install libc6-dev
>
> Gr{oetje,eeting}s,
>
>

Thanks, I feel like a real idiot. Somehow a bunch of development packages
(libc6-dev, ncurses5-dev, and a few others) got uninstalled on that
machine.

Anyway... I was somewhat able to cross-compile a kernel.

Shiva:/usr/src/linux-2.6.21.1# file vmlinux
vmlinux: ELF 64-bit MSB executable, MIPS, MIPS-IV version 1 (SYSV),
statically linked, not stripped

However, when I rsync it over to my O2, it does not boot. It panics almost
immediately, like all other kernels I compiled natively (on the O2) from
something other than the Debian sources. This is the full panic as
displayed from the PROM:

Status register: 0x34010082<CUI,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
Cause register: 0x8014<CE=0,IP8,EXC=WADE>
Exception PC: 0x801da9fc, Exception RA: 0x8047b0ec
Write address error exception, bad address: 0xfffff000
Saved user regs in hex (&gpda 0x81061838, &_regs 0x81061a38):
arg: 81070000 50000 8049f510 2
tmp: 81070000 a800 804b5808 fff804d9 ffffffff 81412ef4 a13fab68 8
sve: 81070000 c064d6ca 0 46136478 0 c02b80ce 0 be4acb69
t8 81070000 0 t9 0 at 0 v0 c04936d8 v1 0 k1 fffff000
gp 81070000 fp0 sp 0 ra 0

Just to make sure I'm not doing something stupid. Here are the command in
my kernel build sequence:

make CROSS_COMPILE=mips-linux-gnu- oldconfig
make -j 3 CROSS_COMPILE=mips-linux-gnu- all
make CROSS_COMPILE=mips-linux-gnu- INSTALL_MOD_PATH=~/ modules_install
cp vmlinux ~/boot/vmlinux-2.6.21.1
cp System.map ~/boot/System.map-2.6.21.1
cp .config ~/boot/config-2.6.21.1
cd ~/
tar -cf kernel.tar lib boot

CONFIG_CROSSCOMPILE=y in my .config.

I also tried rsyncing the Debian sources over to my Core Duo 2 Debian
machine for cross-compiling. I was unable to get past the .config step.
Debian's patches must hinder cross-compiling in some manner. For example,
make menuconfig seems to refuse to display MIPS as the architecture
anymore.

I've been mainly using a working Debian 2.6.18 config (i.e. the one from
their package which lets me compile working 2.6.18 from the Debian
sources), but the default config (set to IP32, RK5, etc.) panics at boot
as well. Not sure if the message is 100% identical, I can double check if
anyone thinks that would help.

Thanks again for all the help, it's appreciated.



						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
> 							    -- Linus Torvalds
>
>
