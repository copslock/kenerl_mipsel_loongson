Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 07:36:16 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:51082 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225814AbUDNGgO>;
	Wed, 14 Apr 2004 07:36:14 +0100
Received: (qmail 11389 invoked from network); 14 Apr 2004 06:30:46 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 14 Apr 2004 06:30:46 -0000
Message-ID: <407D843B.1070405@ict.ac.cn>
Date: Wed, 14 Apr 2004 14:34:35 -0400
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: remex_cao@sjtu.edu.cn
CC: linux-mips@linux-mips.org
Subject: Re: 
References: <20040414060301.F2F297B01A5@mx1.sjtu.edu.cn>
In-Reply-To: <20040414060301.F2F297B01A5@mx1.sjtu.edu.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



caoxiang wrote:

>Greetings
>
>I've encountered a problem when I am porting linux 2.4.3 to the SEAD-2 board.
>
>The tool-chain I used include:
>
>gcc-mipsel-linux-2.95.4
>
>gcc-mips-linux-2.95.4
>
>binutils-mipsel-linux-2.13.1
>
>An error occured like that When I make the kernel:
>
>mipsel-linux-ld -static -G 0 -T arch/mips/ld.script arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
>        --start-group \
>        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
>        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o drivers/usb/usbdrv.o \
>        net/network.o \
>        arch/mips/lib/lib.a /usr/local/0_mips/linux-2.4.3/lib/lib.a arch/mips/mips-boards/sead/sead.o arch/mips/mips-
> boards/generic/mipsboards.o \
>        --end-group \
>        -o vmlinux
>mipsel-linux-ld: target elf32-littlemips not found
>  
>
change elf32-littlemips in arch/mips/ld.script to elf32-tradlittlemips

use mipsel-linux-ld --verbose to show supported OUTPUT_FORMAT of your ld

>make: *** [vmlinux] Error 1
>
>As I change to big endian the problem still exists. Shall I apply some patch?
>
>Thanks for help.
>
>remex
>
