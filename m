Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 07:48:09 +0100 (BST)
Received: from bay1-f146.bay1.hotmail.com ([IPv6:::ffff:65.54.245.146]:63754
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225200AbTEBGsH>; Fri, 2 May 2003 07:48:07 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 1 May 2003 23:47:58 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 02 May 2003 06:47:57 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: kaos@sgi.com
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Thu, 01 May 2003 23:47:57 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F146KLpgTFur2i000018f6@hotmail.com>
X-OriginalArrivalTime: 02 May 2003 06:47:58.0010 (UTC) FILETIME=[C42EE9A0:01C31076]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Keith,

Thanks a lot.

Now its showing some ray of hope....

drivers/char/nvram.c | /sbin/genksyms  -k 2.5.47 > 
include/linux/modules/drivers/char/nvram.ver.tmp
drivers/char/nvram.c:45: warning: `PC' redefined
include/asm/ptrace.h:18: warning: this is the location of the previous 
definition
drivers/char/nvram.c:61: #error Cannot build nvram driver for this machine 
configuration.
make[3]: *** [include/linux/modules/drivers/char/nvram.ver] Error 1
make[2]: *** [drivers/char] Error 2
make[1]: *** [_modver_drivers] Error 2
make: *** [.hdepend] Error 2


Is this (NVRAM) not a mandatory device? If so is it possible to remove it 
using the menuconfig? I chose Atlas 4Kc. Let me know where it is located or 
the issue with this issue.

Thanks again,
-Mike.






>From: Keith Owens <kaos@sgi.com>
>To: "Michael Anburaj" <michaelanburaj@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board -problems :( Date: Fri, 02 May 
>2003 15:22:13 +1000
>
>On Thu, 01 May 2003 22:07:32 -0700,
>"Michael Anburaj" <michaelanburaj@hotmail.com> wrote:
> >I did try that too...
> >
> >[root@localhost linux]# make ARCH=mips
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
>Because you mentioned Redhat 9, I have to assume that you are cross
>compiling from i386 to mips, is that correct?  If so, you need make
>ARCH=mips and you have to specify the cross compile tools as well,
>something like this :-
>
>   make ARCH=mips CROSS_COMPILE=/usr/bin/mips-linux- ...
>
>If you are doing a native mips compile then the problem is that your
>version of gcc does not like one or more of the command options, the
>unknown option is being treated as a filename.
>


_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail
