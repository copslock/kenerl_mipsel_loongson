Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 15:27:22 +0100 (BST)
Received: from [IPv6:::ffff:212.130.55.83] ([IPv6:::ffff:212.130.55.83]:776
	"EHLO NTEX.tt.dk") by linux-mips.org with ESMTP id <S8225193AbTGWO1U>;
	Wed, 23 Jul 2003 15:27:20 +0100
Received: from lnsw.ttnet ([89.1.6.39]) by NTEX.tt.dk with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 3ZYQSRDM; Wed, 23 Jul 2003 16:26:42 +0200
Received: from brmlinux.ttnet ([89.1.5.102] helo=tt.dk)
	by lnsw.ttnet with esmtp (Exim 3.35 #1 (Debian))
	id 19fKZm-000601-00; Wed, 23 Jul 2003 16:26:42 +0200
Message-ID: <3F1E9B22.8000604@tt.dk>
Date: Wed, 23 Jul 2003 16:26:42 +0200
From: Brian Murphy <brm@tt.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en, en-ie
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: odd link error
References: <Pine.GSO.4.44.0307230844470.17973-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brm@tt.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@tt.dk
Precedence: bulk
X-list: linux-mips

David Kesselring wrote:

>I know my build for a custom board isn't right but it got through the
>compiles only to get this link error. Does anyone know what it might point
>to?
>
>mips64el-linux-ld --oformat elf32-tradlittlemips -G 0 -static  -T
>arch/mips64/ld.script.elf32 -Ttext  arch/mips64/kernel/head.o
>arch/mips64/kernel/init_task.o init/main.o init/version.o init/do_mounts.o
>\
>        --start-group \
>        arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o kernel/kernel.o
>mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o
>arch/mips/ramdisk/ramdisk.o \
>         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
>drivers/net/net.o drivers/media/media.o \
>        net/network.o \
>        arch/mips64/lib/lib.a
>/home/dkesselr/stbsw/linux/linux-64sead/lib/lib.a \
>        --end-group \
>        -o vmlinux
>mips64el-linux-ld: invalid hex number `arch/mips64/kernel/head.o'
>make: *** [vmlinux] Error 1
>
>  
>
-Ttext expects an argument, the hex number mentioned, and it is for some 
reason missing.
Since

arch/mips64/kernel/head.o

is not a valid hex number the build fails. You probably have some make 
variable which is not
defined which should be. You should look at the makefile which contains 
the linker line
and find -Ttext $(MISSING_VARIABLE) and find out why MISSING_VARIABLE is 
not set.

/Brian
