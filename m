Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 18:45:11 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:42653 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20021719AbXEWRpG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 18:45:06 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l4NHflka031576
	for <linux-mips@linux-mips.org>; Wed, 23 May 2007 13:41:48 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l4NHflGs023129;
	Wed, 23 May 2007 13:41:47 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Wed, 23 May 2007 13:41:47 -0400 (EDT)
Message-ID: <58292.129.133.92.31.1179942107.squirrel@webmail.wesleyan.edu>
In-Reply-To: <4653B81E.9010802@gentoo.org>
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
    <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
    <4653B81E.9010802@gentoo.org>
Date:	Wed, 23 May 2007 13:41:47 -0400 (EDT)
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
X-archive-position: 15147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> sknauert@wesleyan.edu wrote:
>>> On Tue, 22 May 2007, sknauert@wesleyan.edu wrote:
>>>> scripts/basic/fixdep.c:107:23: error: sys/types.h: No such file or
>>>> directory
>>> You're missing the basic libraries for native compilation.
>>>
>>> | apt-get install libc6-dev
>>>
>>> Gr{oetje,eeting}s,
>>>
>>>
>>
>> Thanks, I feel like a real idiot. Somehow a bunch of development
>> packages
>> (libc6-dev, ncurses5-dev, and a few others) got uninstalled on that
>> machine.
>>
>> Anyway... I was somewhat able to cross-compile a kernel.
>>
>> Shiva:/usr/src/linux-2.6.21.1# file vmlinux
>> vmlinux: ELF 64-bit MSB executable, MIPS, MIPS-IV version 1 (SYSV),
>> statically linked, not stripped
>>
>> However, when I rsync it over to my O2, it does not boot. It panics
>> almost
>> immediately, like all other kernels I compiled natively (on the O2) from
>> something other than the Debian sources. This is the full panic as
>> displayed from the PROM:
>>
>> Status register: 0x34010082<CUI,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
>> Cause register: 0x8014<CE=0,IP8,EXC=WADE>
>> Exception PC: 0x801da9fc, Exception RA: 0x8047b0ec
>> Write address error exception, bad address: 0xfffff000
>> Saved user regs in hex (&gpda 0x81061838, &_regs 0x81061a38):
>> arg: 81070000 50000 8049f510 2
>> tmp: 81070000 a800 804b5808 fff804d9 ffffffff 81412ef4 a13fab68 8
>> sve: 81070000 c064d6ca 0 46136478 0 c02b80ce 0 be4acb69
>> t8 81070000 0 t9 0 at 0 v0 c04936d8 v1 0 k1 fffff000
>> gp 81070000 fp0 sp 0 ra 0
>>
>> Just to make sure I'm not doing something stupid. Here are the command
>> in
>> my kernel build sequence:
>>
>> make CROSS_COMPILE=mips-linux-gnu- oldconfig
>> make -j 3 CROSS_COMPILE=mips-linux-gnu- all
>> make CROSS_COMPILE=mips-linux-gnu- INSTALL_MOD_PATH=~/ modules_install
>> cp vmlinux ~/boot/vmlinux-2.6.21.1
>> cp System.map ~/boot/System.map-2.6.21.1
>> cp .config ~/boot/config-2.6.21.1
>> cd ~/
>> tar -cf kernel.tar lib boot
>>
>> CONFIG_CROSSCOMPILE=y in my .config.
>>
>> I also tried rsyncing the Debian sources over to my Core Duo 2 Debian
>> machine for cross-compiling. I was unable to get past the .config step.
>> Debian's patches must hinder cross-compiling in some manner. For
>> example,
>> make menuconfig seems to refuse to display MIPS as the architecture
>> anymore.
>>
>> I've been mainly using a working Debian 2.6.18 config (i.e. the one from
>> their package which lets me compile working 2.6.18 from the Debian
>> sources), but the default config (set to IP32, RK5, etc.) panics at boot
>> as well. Not sure if the message is 100% identical, I can double check
>> if
>> anyone thinks that would help.
>>
>> Thanks again for all the help, it's appreciated.
>>
>
> One, make sure you're doing "make vmlinux.32", and two, CONFIG_BUILD_ELF64
> is
> _not_ enabled. For 2.6.20, I had to cram in a patch from Frank to get
> these
> things to not PROM crash (due to the elimination of CPHYSADDY and
> replacement by
> __pa()), but on 2.6.21, this patch was unnecessary.  Unsure about
> 2.6.22-rcX.
>

I tried the vmlinux.32 I had been generating previously, same response
from the PROM.

Didn't see any options something like CONFIG_BUILD_ELF64 in menuconfig
(the closest thing was kernel code model which is 64-bit only), so I just
manually edited the .config. I think my issue is that Debian's working
.config is setting some options contrary to what they need to be for a
later kernel or one without Debian's patches. With CONFIG_BUILD_ELF64=n
and the Debian .config I got compile errors.

Building from the default make menuconfig, then selecting the appropriate
O2 hardware, actually compiled and didn't panic at boot. However, nothing
happened after the PROM loaded the kernel. This happens for both the
vmlinux and vmlinux.32 kernels produced. The framebuffer (4Mb) didn't
start and I couldn't ssh in. This is more or less the same behavior as the
2.6.22-rc test kernel posted.

Anybody have a confirmed working .config for an O2?

> O2's will boot a pure 64bit kernel, but my experience is that they are
> ridiculously slow at it (the console lags severely).  vmlinux.32 is the
> modern
> method of 64bit-code-in-a-32bit-shell, which the O2's and IP22 systems
> will
> swallow much better.
>
> Also, gbefb must be no greater than 4MB memory in menuconfig.
>
> And what's the MHz of your R5000?  300MHz?, if so, it'll be the RM5200,
> and
> you'll want "RM52xx" for CPU instead.
>

Its 300 Mhz, but I'm not actually sure as to whether its an R5000 or
R5200. hinv and dmesg show it as R5000, though apparently this is normal
hinv behavior for the R5200. If I switched R5000 to R5200 in the Debian
sources, the resulting kernel won't boot. Is it possible that my compiling
woes might be from the necessity to compile for R5200? Or should it be
backwards compatible, so I only miss out on optimizations.

>
> --Kumba
>
> --
> Gentoo/MIPS Team Lead
>
> "Such is oft the course of deeds that move the wheels of the world: small
> hands
> do them because they must, while the eyes of the great are elsewhere."
> --Elrond
>
>
