Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 19:13:26 +0100 (BST)
Received: from zhongguo.thiscow.com ([88.191.99.114]:30428 "EHLO
	zhongguo.thiscow.com") by ftp.linux-mips.org with ESMTP
	id S20021612AbZDWSNT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 19:13:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by zhongguo.thiscow.com (Postfix) with ESMTP id 5E3CC1AE238;
	Thu, 23 Apr 2009 20:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at thiscow.com
Received: from zhongguo.thiscow.com ([127.0.0.1])
	by localhost (zhongguo.thiscow.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcgadJ7D3xNz; Thu, 23 Apr 2009 20:13:17 +0200 (CEST)
Received: from [192.168.0.5] (chl35-1-88-163-125-22.fbx.proxad.net [88.163.125.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: erwan@thiscow.fr)
	by zhongguo.thiscow.com (Postfix) with ESMTPSA id 2DF3C1AE00B;
	Thu, 23 Apr 2009 20:13:17 +0200 (CEST)
Message-ID: <49F0AFA3.6080408@thiscow.com>
Date:	Thu, 23 Apr 2009 20:12:51 +0200
From:	Erwan Lerale <erwan@thiscow.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
MIME-Version: 1.0
To:	loongson-dev@googlegroups.com
CC:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] a pre-release of merging loongson patchs to linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon>
In-Reply-To: <1240501332.28136.24.camel@falcon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <erwan@thiscow.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erwan@thiscow.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> hi, all
>
> these days, I am working on merging loongson patchs to linux-2.6.29.1, 
> the fuloong(2f) & yeeloong source code have been completely merged to an
> 2f directory, most of the 2e & 2f source code have been merged except
> the irq.c & reset.c, fixup-loongson2e.c & fixup-loongson2f.c.
>   

Cool ! :)

[...]

> a current version is released to git://dev.lemote.com/rt4ls.git, 
> (for avoid creating another git repository for it, i just use my
> RT_PREEMPT git tree instead, so, it may be very big :-( )
>
> $ git clone git://dev.lemote.com/rt4ls.git
> $ git checkout linux-2.6.29-stable-loongson --track
> origin/linux-2.6.29-stable-loongson
>   

You meant :

git checkout -b linux-2.6.29-stable-loongson --track
origin/linux-2.6.29-stable-loongson

don't you ?


I can not compile it :

  CC      arch/mips/loongson/common/bonito-irq.o
  CC      arch/mips/loongson/common/mem.o
  CC      arch/mips/loongson/common/dbg_io.o
cc1: warnings being treated as errors
arch/mips/loongson/common/dbg_io.c: In function �prom_printf
arch/mips/loongson/common/dbg_io.c:178: error: the frame size of 1040
bytes is larger than 1024 bytes
make[1]: *** [arch/mips/loongson/common/dbg_io.o] Error 1
make: *** [arch/mips/loongson/common] Error 2

I have used the config file from here :
arch/mips/configs/yeeloong2f_defconfig

Cheers and thanks for your work !

Erwan
