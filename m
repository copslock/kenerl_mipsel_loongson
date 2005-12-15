Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2005 18:48:35 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.194]:38993 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3467095AbVLOSsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Dec 2005 18:48:17 +0000
Received: by xproxy.gmail.com with SMTP id s18so332896wxc
        for <linux-mips@linux-mips.org>; Thu, 15 Dec 2005 10:48:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dE+LBpFuMGKpGSeJCj1svWQd47UiUK3dxO0/5+X4F+fSXbxQT9LsHfEXBezzydi7LHiN4L6kAMvV+MM3+aYNQzFLEJhOCI8m8J2iHzZJhsjfSYlerZGoWTr3dLiZwyzx5UwcGjztCJBv9nxEKf+z4v+K2WQ1qhoQ0Lzfku4f9kM=
Received: by 10.70.87.10 with SMTP id k10mr3154863wxb;
        Thu, 15 Dec 2005 10:48:50 -0800 (PST)
Received: by 10.70.26.3 with HTTP; Thu, 15 Dec 2005 10:48:50 -0800 (PST)
Message-ID: <9498e5c10512151048n1e615614r7ded00ad77c48724@mail.gmail.com>
Date:	Fri, 16 Dec 2005 00:18:50 +0530
From:	Shireesh Annam <annamshr@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 2.4.22 Kernel Build Error
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051215145132.GA2812@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <9498e5c10512150449x625a7270s168d6a6339330e29@mail.gmail.com>
	 <20051215145132.GA2812@linux-mips.org>
Return-Path: <annamshr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: annamshr@gmail.com
Precedence: bulk
X-list: linux-mips

I'm now using the SDE-Linux 5.03.06 for the big-endian target. I
started the 2.4.22 kernel build process, but soon I get the following
compile error.

**********
make[2]: Entering directory `/root/linux/arch/mips/mm'
mips-linux-gcc -D__KERNEL__ -I/root/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -I /root/linux/include/asm/gcc -G 0
-mno-abicalls -fno-pic -pipe  -mabi=32 -mcpu=r4600 -mips2 -Wa,--trap  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=sc_ip22  -c -o
sc-ip22.o sc-ip22.c
{standard input}: Assembler messages:
{standard input}:126: Error: Number (0x9000000080000000) larger than 32 bits
{standard input}:148: Error: Number (0x9000000080000000) larger than 32 bits
{standard input}:168: Error: Number (0x9000000080000000) larger than 32 bits
make[2]: *** [sc-ip22.o] Error 1
make[2]: Leaving directory `/root/linux/arch/mips/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/root/linux/arch/mips/mm'
make: *** [_dir_arch/mips/mm] Error 2

**********

I'm not able to understand these error messages. Could someone throiw
some light on this issue? Is this because of the toolchain that I'm
using for building the kernel?

Thanks,
Shireesh

On 12/15/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> You're trying to build a stoneage kernel with a much newer compiler -
> SDE 6 uses gcc 3.4 - which doesn't work.  Use an older compiler such
> as gcc <= 3.3.x.  SDE 5.x contains gcc 2.96 btw.
>
>   Ralf
>
