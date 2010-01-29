Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 16:53:11 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:36742 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492105Ab0A2PxH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 16:53:07 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id 25A271B411C; Fri, 29 Jan 2010 15:53:03 +0000 (UTC)
Date:   Fri, 29 Jan 2010 15:53:03 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     YD <ydgoo9@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: GCC 4.4.2(mips) with -mplt option
Message-ID: <20100129155303.GB3376@woodpecker.gentoo.org>
Mail-Followup-To: YD <ydgoo9@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
References: <38dc7fce1001290227v746c0a3dp4b3d81a58e73cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dc7fce1001290227v746c0a3dp4b3d81a58e73cf83@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-archive-position: 25738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18894

On 19:27 Fri 29 Jan     , YD wrote:
> Hello,
> 
> I have built the toolchain using the buildroot ( GCC 4.4.2 with
> uClibc-0.9.30.1 )

I think you need to check if uClibc supports this feature.
-mplt need support from libc, specifically dynamic loader, ld.so.

> 
> Everything works well but when I compiled with -mplt option, always it
> fails with Segmentation fault.
> 
> I read some articles that with -mplt option, preformance will be 10%
> highter than without plt option.
> 
> I don't know why this fails everytime. please help me...
> 
> #include <stdio.h>
> int main()
> {
>  printf("Hello world \n"); return 0;
> }
> 
> #mipsel-linux-gcc  -o a a.c
>  Hello world
> #mipsel-linux-gcc -mplt -o a a.c
>  Segmentation fault
> #mipsel-linux-gcc -mplt -no-shared -o a a.c
>  Segmentation fault
> #mipsel-linux-gcc -mplt -no-shared -mabicalls -o a a.c
>  Segmentation fault

And -no-shared is actually not needed
http://gcc.gnu.org/ml/gcc/2008-12/msg00010.html

You should be able to verify this by 'mipsel-linux-gcc -v'

Zhang, Le
