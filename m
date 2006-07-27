Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 18:10:23 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:36737 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8134062AbWG0RKN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Jul 2006 18:10:13 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 7046D469C6; Thu, 27 Jul 2006 19:10:13 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G68Xz-0000iX-E0; Thu, 27 Jul 2006 17:17:15 +0100
Date:	Thu, 27 Jul 2006 17:17:15 +0100
To:	Shan Wang <swang@eventmine.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: is sde lite a complete toolchain?
Message-ID: <20060727161715.GA4505@networkno.de>
References: <583C102FDFBE2E4FB8ADF0D680B0798C0B53CB@efs01.eventmine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583C102FDFBE2E4FB8ADF0D680B0798C0B53CB@efs01.eventmine.local>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Shan Wang wrote:
> Hi all,
> 
>  
> 
> I downloaded the SDE lite toolchain from MIPS Technologies. I can use
> the makefiles to build all the examples come with the package and test
> them with the simulator. But when I tried to use sde-gcc to cross
> compile the hello world example directly:

Note that those examples are for a bare-metal embedded system without OS,
they won't work on Linux/MIPS.

> sde-gcc -Wall -mips32 -mtune=4kc -EL hello.c -o hello

Also, sde-gcc is a compiler for embedded ELF targets, it won't produce
Linux binaries.

> I got errors like the following:
> 
> /home/linuxdev/packages/sde-lite-linux/bin/../lib/gcc/sde/3.4.4/../../..
> /../sde/bin/ld: warning: cannot find entry symbol __start;
> 
>  defaulting to 0000000080020000
> 
> /tmp/ccEaLxlW.o: In function `main':
> 
> hello.c:(.text+0x20): undefined reference to `printf'
> 
> hello.c:(.text+0x20): relocation truncated to fit: R_MIPS_26 against
> `printf'
> 
> collect2: ld returned 1 exit status

This is the expected result, since your command line misses to include
the necessary libraries and the board support package.

> Does that mean the SDE lite package is not a complete cross toolchain,
> can I use it to compile my own application? 

This depends on what your target platform is. If it is Linux/MIPS, you
may want to have a look at http://www.linux-mips.org/wiki/Toolchains.


Thiemo
