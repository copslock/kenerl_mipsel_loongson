Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 04:25:34 +0100 (BST)
Received: from bay1-f28.bay1.hotmail.com ([IPv6:::ffff:65.54.245.28]:51209
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225200AbTEBDZb>; Fri, 2 May 2003 04:25:31 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 1 May 2003 20:25:21 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 02 May 2003 03:25:20 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Thu, 01 May 2003 20:25:20 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F28gEpTX5V3Gyk00001423@hotmail.com>
X-OriginalArrivalTime: 02 May 2003 03:25:21.0224 (UTC) FILETIME=[762C9480:01C3105A]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I gave up on the linux source from Redhat 9. Now I pulled source from CVS
$ cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co linux

Then I configured using,
$ make ARCH=mips menuconfig

selected Atlas board & saved it.

Then I get the following errors while trying to build the image:

[root@localhost linux]# make
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

Please somebody, who built linux image for Atlas 4Kc board earlier, show me 
the procedure to build Redboot linux images (srec).

will this dream come true? I am new to linux & I could only affored a Atlas 
board for myself to learn linux on MIPS at home.

Please help me!!!

Thanks,
-Mike.



>From: "Michael Anburaj" <michaelanburaj@hotmail.com>
>To: linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board
>Date: Thu, 01 May 2003 01:53:21 -0700
>
>Hi,
>
>I got passed the config issue, Thanks to all & Greg.
>
>Now when I try making "make ARCH=mips", I get a lot of errors:
>
>/usr/src/linux-2.4.20-6/include/linux/mm.h:188: parse error before 
>`pte_addr_t'
>/usr/src/linux-2.4.20-6/include/linux/mm.h:188: warning: no semicolon at 
>end of
>struct or union
>/usr/src/linux-2.4.20-6/include/linux/mm.h:188: warning: no semicolon at 
>end of
>struct or union
>/usr/src/linux-2.4.20-6/include/linux/mm.h:189: warning: type defaults to 
>`int'
>in declaration of `pte'
>/usr/src/linux-2.4.20-6/include/linux/mm.h:189: warning: data definition 
>has no
>type or storage class
>/usr/src/linux-2.4.20-6/include/linux/mm.h:208: parse error before `}'
>
>
>I get more error like the ones above.
>
>Please let me know the reason for the same.
>
>Thanks,
>-Mike.
>
>_________________________________________________________________
>Protect your PC - get McAfee.com VirusScan Online  
>http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
>
>


_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail
