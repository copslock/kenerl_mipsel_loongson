Received:  by oss.sgi.com id <S553690AbQJaCPC>;
	Mon, 30 Oct 2000 18:15:02 -0800
Received: from u-180.karlsruhe.ipdial.viaginterkom.de ([62.180.21.180]:63755
        "EHLO u-180.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553660AbQJaCO3>; Mon, 30 Oct 2000 18:14:29 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJaCOM>;
        Tue, 31 Oct 2000 03:14:12 +0100
Date:   Tue, 31 Oct 2000 03:14:12 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jordan Crouse <jordanc@Censoft.com>
Cc:     linux-mips@oss.sgi.com, jasonk@Censoft.com, markl@Censoft.com
Subject: Re: Compiling libc
Message-ID: <20001031031412.C26425@bacchus.dhis.org>
References: <39FE0338.AAB08D9A@censoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39FE0338.AAB08D9A@censoft.com>; from jordanc@Censoft.com on Mon, Oct 30, 2000 at 04:24:40PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 04:24:40PM -0700, Jordan Crouse wrote:

> This is one for all the libc folks out there..
> 
> I am running into some big problems trying to compile libc-001023 as
> downloaded from the ftp site just the other day. 
> 
> Basically, after compiling everything, I start to verify my build and I
> get the following whilst in the /iconv directory (actually, I get it all
> over the place):
> 
> mips_41xx_le-gcc -nostdlib -nostartfiles -o iconv_prog
> -Wl,-dynamic-linker=/opt/hardhat/devkit/mips/41xx_le/mipsel-hardhat-linux/lib/ld.so.1  
> ../csu/crt1.o ../csu/crti.o `mips_41xx_le-gcc
> --print-file-name=crtbegin.o` iconv_prog.o 
> -Wl,-rpath-link=..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:../crypt:../linuxthreads
> ../libc.so.6 ../libc_nonshared.a -lgcc `mips_41xx_le-gcc
> --print-file-name=crtend.o` ../csu/crtn.o
> ../libc.so.6: undefined reference to `__pthread_initialize_minimal'
> 
> This is driving me up the wall and down the other side since it is
> obvious that the linuxthreads directory is part of the rpath, and I know
> that all of the pthreads libraries are compiled, so I can't find a
> single reason why it doesn't work.  
> 
> A little background for you...  mips_41xx_le is actually the
> mipsel-linux compiler under a different name (from the MontaVista CDK). 
> I invoked my configure script as such:
> 
> ./configure --enable-add-ons=linuxthreads
> --prefix=/opt/hardhat/devkit/mips/41xx_le/mipsel-hardhat-linux
> mipsel-hardhat-linux
> 
> I would really appreciate any patches, advice or therapy.

No patches but the advice to dump this compiler entirely for glibc 2.2 use.
Your compiler seems to be a derivate of egcs 1.0 or similar vintage which
like in this case misstreats undefined weak symbols.

  Ralf
