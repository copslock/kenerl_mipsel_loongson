Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 21:10:41 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:29728
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133524AbWCMVHb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Mar 2006 21:07:31 +0000
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 13 Mar 2006 13:16:31 -0800
Message-ID: <4415E12F.1050603@avtrex.com>
Date:	Mon, 13 Mar 2006 13:16:31 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kurt Schwemmer <kurts@vitesse.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
References: <389E6A416914954182ECDFCD844D8269434FC1@MX-COS.vsc.vitesse.com>
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FC1@MX-COS.vsc.vitesse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2006 21:16:31.0669 (UTC) FILETIME=[666EB650:01C646E3]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10798
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Kurt Schwemmer wrote:
> I didn't touch any of the source yet. 
> 
> I'm downloading the 1/10/05 2.6.15 tarball (
> ftp://ftp.linux-mips.org/pub/linux/mips/kernel/v2.6/linux-2.6.15.tar.gz
> )now to see if that fixes things.
> 
> In response to Thiemo's message the error with (V=1) is:
> 
> make -f scripts/Makefile.build obj=arch/mips/kernel
>   /klocal/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-gcc
> -Wp,-MD,arch/mips/kernel/.entry.o.d  -nostdinc -isystem
> /klocal/buildroot/build_mipsel/staging_dir/bin-ccache/../lib/gcc/mipsel-
> linux-uclibc/3.4.5/include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__  -I
> /usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
> -pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
> -Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
> -Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic -Wall
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -ffreestanding -O2     -fomit-frame-pointer  -I
> /usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
> -pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
> -Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
> -Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic    -c -o
> arch/mips/kernel/entry.o arch/mips/kernel/entry.S
> arch/mips/kernel/entry.S: Assembler messages:
> arch/mips/kernel/entry.S:157: Error: opcode not supported on this
> processor: mips32 (mips32) `jr.hb $31'
> make[1]: *** [arch/mips/kernel/entry.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> Also, assembler -v output:
> GNU assembler version 2.16.1 (mipsel-linux-uclibc) using BFD version
> 2.16.1
> 
> Thanks,
> Kurt Schwemmer
> 

You could try using crosstool to generate the compiler instead of buildroot.

Also try passing -v to gcc, that will cause it to show the exact options 
that it is passing to gas.  Perhaps that would shed some light on things.

David Daney
