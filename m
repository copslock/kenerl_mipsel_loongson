Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2003 06:37:00 +0000 (GMT)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:45454
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8224851AbTCPGg7>; Sun, 16 Mar 2003 06:36:59 +0000
Received: (qmail 5028 invoked from network); 16 Mar 2003 06:20:51 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 16 Mar 2003 06:20:51 -0000
Message-ID: <3E74CF10.5080305@ict.ac.cn>
Date: Sun, 16 Mar 2003 14:22:56 -0500
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020809
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Arthur Petitpierre <arthur.petitpierre@gadz.org>
CC: linux-mips@linux-mips.org
Subject: Re: kernel compilation error on indy with r4600
References: <20030316011613.766aa81d.arthur.petitpierre@gadz.org>
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Arthur Petitpierre wrote:

>	Hi,
>
>I've got an Indy whith a r46000 cpu and a Debian installed on it, and when I try to compile a new kernel (with gcc-2.95),
>I do 'make menuconfig', 'make dep' without any problem and when I try 'make vmlinux', I got error as following :
>
>gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs 
>
^^^^^^Are you sure you are using mips gcc? If you are cross-compiling,it 
should normally be mips(el)-linux-gcc here

>-O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /usr/src/kernel-source-2.4.19/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
>as: unrecognized option `-mcpu=r4600'
>init/main.c: In function `calibrate_delay':
>init/main.c:199: Internal compiler error:
>init/main.c:199: output pipe has been closed
>make: *** [init/main.o] Error 1
>
>Any solution to fix it. Thanks,
>		Arthur
>
>
>
>  
>
