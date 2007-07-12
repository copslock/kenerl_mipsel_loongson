Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 12:46:42 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:50342 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022376AbXGLLqk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 12:46:40 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 38102B9296;
	Thu, 12 Jul 2007 13:46:32 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1I8x7u-00082w-TP; Thu, 12 Jul 2007 12:46:30 +0100
Date:	Thu, 12 Jul 2007 12:46:30 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	saravanan <sar_van81@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: yamon on DBAU1200
Message-ID: <20070712114630.GA30622@networkno.de>
References: <985016.94566.qm@web94311.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985016.94566.qm@web94311.mail.in2.yahoo.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

saravanan wrote:
> hi,
> 
> has anyone compiled yamon bootloader ? i tried to compile yamon bootloader (yamon-0227.zip) which came in along with my board -DBAU1200. but i was not successful. the following is the error :
> 
> suse:/home/alchemy/ALCHEMY/YAMON/02.27/yamon/bin # make
> rm -f ./EL/comptime.o ./EB/comptime.o
> mipsel-linux-uclibc-gcc -G 0 -mips32 -mno-abicalls -fno-pic -D_32_ -c -g -O2 -Wimplicit -Wformat '-D_REVMAJ_="02"' '-D_REVMIN_="27GDB1200"' -I./../include -I./../arch/include   -DDB1200_CONFIG=1 -D_ASSEMBLER_ -EL -DEL -o reset.o ./../init/reset/reset.S
> mipsel-linux-uclibc-gcc: unrecognized option `-EL'

Your crosscompiler is broken. ISTR there was a bug in some gcc versions
where the compiler failed to accept its default endian option.

> mipsel-linux-uclibc-ld -G 0 -T ./link/link.xn -o ./reset-02.27GDB1200.elf -Map ./reset-02.27GDB1200.map --oformat elf32-littlemips  reset.o
> mipsel-linux-uclibc-ld: target elf32-littlemips not found
> make: *** [reset-02.27GDB1200.elf] Error 1

The source expects the old object format, for reasonably modern
toolchains it's now elf32-tradlittlemips.

> does yamon have support for producing image in little endian format ?

At least the version I know of supports both endian modes from a single
binary image. I don't know if that feature is also present in the AU1200
version.


Thiemo
