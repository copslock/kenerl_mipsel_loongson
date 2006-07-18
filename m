Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 13:49:01 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:2784 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S3949191AbWGRMsw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2006 13:48:52 +0100
Received: (qmail 13881 invoked by uid 507); 18 Jul 2006 21:28:55 +0800
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 18 Jul 2006 21:28:55 +0800
Message-ID: <44BCD870.8090206@ict.ac.cn>
Date:	Tue, 18 Jul 2006 20:47:44 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	qi tao <demon19840308@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: cross compiling gcc for mips
References: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl> <Pine.LNX.4.64N.0607181150160.31692@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0607181150160.31692@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

They are "No such file or directory" :)

Maciej W. Rozycki 写道:
> On Tue, 18 Jul 2006, qi tao wrote:
> 
>> However when I do "make all-gcc" I get the following errors:
>>  
>>
>>  -c ../../gcc-4.1.1/gcc/crtstuff.c -DCRT_BEGIN \
>>  -o crtbegin.o
>> In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
>> .../../gcc-4.1.1/gcc/tsystem.h:90:19: error: stdio.h: 没有那个文件或目录
>> .../../gcc-4.1.1/gcc/tsystem.h:93:23: error: sys/types.h: 没有那个文件或目录
>> .../../gcc-4.1.1/gcc/tsystem.h:96:19: error: errno.h: 没有那个文件或目录
>> .../../gcc-4.1.1/gcc/tsystem.h:103:20: error: string.h: 没有那个文件或目录
>> .../../gcc-4.1.1/gcc/tsystem.h:104:20: error: stdlib.h: 没有那个文件或目录
>> .../../gcc-4.1.1/gcc/tsystem.h:105:20: error: unistd.h: 没有那个文件或目录
>> In file included from
>> /opt/cross_src4.1.1/gcc-build/./gcc/include/syslimits.h:7,
>>                 from /opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:11,
>>                 from ../../gcc-4.1.1/gcc/tsystem.h:108,
>>                 from ../../gcc-4.1.1/gcc/crtstuff.c:68:
>> /opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:122:61: error: limits.h:
>> 没 有那个文件或目录
>> In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
>> .../../gcc-4.1.1/gcc/tsystem.h:111:18: error: time.h: 没有那个文件或目录
>> make[1]: *** [crtbegin.o] 错误 1 ==> error 1
>> make[1]: Leaving directory `/opt/cross_src4.1.1/gcc-build/gcc'
>> make: *** [all-gcc] 错误 2  ==> error 2
>>
>> what should i do??  thanks for your help ! thank you
> 
>  It would raise the probability of someone being able to provide you some 
> help if you set your locale to English before reporting error messages.
> 
>   Maciej
