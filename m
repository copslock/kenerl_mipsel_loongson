Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2003 10:21:15 +0000 (GMT)
Received: from [IPv6:::ffff:211.16.123.115] ([IPv6:::ffff:211.16.123.115]:62198
	"EHLO stardust") by linux-mips.org with ESMTP id <S8225199AbTCLKVP>;
	Wed, 12 Mar 2003 10:21:15 +0000
Received: from stardust ([127.0.0.1])
	by stardust with smtp (Exim 3.36 #1 (Debian))
	id 18t3LT-0002It-00; Wed, 12 Mar 2003 19:20:23 +0900
Date: Wed, 12 Mar 2003 19:20:22 +0900
From: KUNITAKE Koichi <kunitake@linux-ipv6.org>
To: usagi-users@linux-ipv6.org
Cc: linux-mips@linux-mips.org
Subject: Re: (usagi-users 02267) Re: Usagi kernel for MIPS target
In-Reply-To: <20030312084946.7398.qmail@webmail27.rediffmail.com>
References: <20030312084946.7398.qmail@webmail27.rediffmail.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E18t3LT-0002It-00@stardust>
Return-Path: <kunitake@linux-ipv6.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kunitake@linux-ipv6.org
Precedence: bulk
X-list: linux-mips

  I think you cant use "xconfig" on Cross-compiling env, please edit
linux24/Makefile and use "make config". After all, please exec following
commands.

$ make config
$ make dep; make clean; make zImage

On 12 Mar 2003 08:49:46 -0000
"Santosh " <ipv6_san@rediffmail.com> wrote:

>i tried compiling this way
>
># make ARCH=mips xconfig
>i get
>ERROR - Attempting to write value for unconfigured variable 
>(CONFIG_VTAG_ICACHE)
>ERROR - Attempting to write value for unconfigured variable 
>(CONFIG_BINFMT_ELF32)
>ERROR - Attempting to write value for unconfigured variable 
>(CONFIG_SERIAL)
>ERROR - Attempting to write value for unconfigured variable 
>(CONFIG_RTC)
>
>Don't know what's wrong.
>I have configured for MIPS Malta (Experimental) board
>
>then i did # make ARCH=mips dep
>
>finally # make ARCH=mips CROSS_COMPILE=mipsel-linux-
>
>Now i get
>binfmt_elf.c: In function 'load_elf_interp':
>binfmt_elf.c:278: 'EF_MIPS_ABI2' undeclared
>binfmt_elf.c:278: 'EF_MIPS_ABI' undeclared
>make[2]:Leaving directory '/home/user/usagi/kernel/linux24/fs'
>make:***[_dir_fs]Error 2
>
>Is Usagi stable on MIPS Malta board ??
>Pls tell me what's wrong.
>
>-Santosh
