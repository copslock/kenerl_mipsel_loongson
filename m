Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 06:07:43 +0100 (BST)
Received: from bay1-f99.bay1.hotmail.com ([IPv6:::ffff:65.54.245.99]:30472
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225200AbTEBFHl>; Fri, 2 May 2003 06:07:41 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 1 May 2003 22:07:32 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 02 May 2003 05:07:32 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Thu, 01 May 2003 22:07:32 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F99BGpEI2rV4Zn000015fa@hotmail.com>
X-OriginalArrivalTime: 02 May 2003 05:07:32.0867 (UTC) FILETIME=[BCEB0D30:01C31068]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Keith,

I did try that too...


[root@localhost linux]# make ARCH=mips
make -f scripts/Makefile.build obj=arch/mips/kernel 
arch/mips/kernel/offset.s
  gcc -Wp,-MD,arch/mips/kernel/.offset.s.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -I /usr/src/linux/include/asm/gcc -G 0 
-mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=offset   -S -o 
arch/mips/kernel/offset.s arch/mips/kernel/offset.c
gcc: cannot specify -o with -c or -S and multiple compilations
make[1]: *** [arch/mips/kernel/offset.s] Error 1
make: *** [arch/mips/kernel/offset.s] Error 2


Thanks,
-Mike.






>From: Keith Owens <kaos@sgi.com>
>To: "Michael Anburaj" <michaelanburaj@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board -problems :( Date: Fri, 02 May 
>2003 14:18:13 +1000
>
>On Thu, 01 May 2003 20:25:20 -0700,
>"Michael Anburaj" <michaelanburaj@hotmail.com> wrote:
> >Then I configured using,
> >$ make ARCH=mips menuconfig
> >[root@localhost linux]# make
> >make -f scripts/Makefile.build obj=arch/mips/kernel
> >arch/mips/kernel/offset.s
> >  gcc -Wp,-MD,arch/mips/kernel/.offset.s.d -D__KERNEL__ -Iinclude -Wall
> >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> >-fno-strict-aliasing -fno-common -I /usr/src/linux/include/asm/gcc -G 0
> >-mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap -nostdinc
> >-iwithprefix include    -DKBUILD_BASENAME=offset   -S -o
> >arch/mips/kernel/offset.s arch/mips/kernel/offset.c
> >gcc: cannot specify -o with -c or -S and multiple compilations
> >make[1]: *** [arch/mips/kernel/offset.s] Error 1
> >make: *** [arch/mips/kernel/offset.s] Error 2
>
>You have to specify ARCH=mips on _all_ make commands, not just make
>*config.  Do 'make ARCH=mips' for the second one.
>


_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
