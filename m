Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 06:22:32 +0100 (BST)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:27359 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225200AbTEBFW2>;
	Fri, 2 May 2003 06:22:28 +0100
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.9/8.12.2/linux-outbound_gateway-1.2) with SMTP id h425MME0012695;
	Thu, 1 May 2003 22:22:22 -0700
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA04935; Fri, 2 May 2003 15:22:20 +1000
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 46DBC3001F4; Fri,  2 May 2003 15:22:18 +1000 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id CD471164; Fri,  2 May 2003 15:22:18 +1000 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Michael Anburaj" <michaelanburaj@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :( 
In-reply-to: Your message of "Thu, 01 May 2003 22:07:32 MST."
             <BAY1-F99BGpEI2rV4Zn000015fa@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 May 2003 15:22:13 +1000
Message-ID: <9709.1051852933@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Thu, 01 May 2003 22:07:32 -0700, 
"Michael Anburaj" <michaelanburaj@hotmail.com> wrote:
>I did try that too...
>
>[root@localhost linux]# make ARCH=mips
>make -f scripts/Makefile.build obj=arch/mips/kernel 
>arch/mips/kernel/offset.s
>  gcc -Wp,-MD,arch/mips/kernel/.offset.s.d -D__KERNEL__ -Iinclude -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
>-fno-strict-aliasing -fno-common -I /usr/src/linux/include/asm/gcc -G 0 
>-mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap -nostdinc 
>-iwithprefix include    -DKBUILD_BASENAME=offset   -S -o 
>arch/mips/kernel/offset.s arch/mips/kernel/offset.c
>gcc: cannot specify -o with -c or -S and multiple compilations
>make[1]: *** [arch/mips/kernel/offset.s] Error 1
>make: *** [arch/mips/kernel/offset.s] Error 2

Because you mentioned Redhat 9, I have to assume that you are cross
compiling from i386 to mips, is that correct?  If so, you need make
ARCH=mips and you have to specify the cross compile tools as well,
something like this :-

  make ARCH=mips CROSS_COMPILE=/usr/bin/mips-linux- ...

If you are doing a native mips compile then the problem is that your
version of gcc does not like one or more of the command options, the
unknown option is being treated as a filename.
