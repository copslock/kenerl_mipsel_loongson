Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 07:47:17 +0100 (BST)
Received: from mail.rennes.fr.clara.net ([62.240.254.62]:27591 "EHLO
	rennes.fr.clara.net") by ftp.linux-mips.org with ESMTP
	id S20023440AbZDXGrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 07:47:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by rennes.fr.clara.net (Postfix) with ESMTP id 6B8C23A2E2;
	Fri, 24 Apr 2009 08:46:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from rennes.fr.clara.net ([127.0.0.1])
	by localhost (rennes.fr.clara.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PoJORDn37eTv; Fri, 24 Apr 2009 08:46:51 +0200 (CEST)
Received: from [10.0.1.235] (unknown [10.0.1.235])
	by rennes.fr.clara.net (Postfix) with ESMTP id 492B439F7A;
	Fri, 24 Apr 2009 08:46:51 +0200 (CEST)
Message-ID: <49F16061.9010207@thiscow.com>
Date:	Fri, 24 Apr 2009 08:46:57 +0200
From:	Erwan Lerale <erwan@thiscow.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	loongson-dev@googlegroups.com
CC:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [loongson-dev] Re: a pre-release of merging loongson patchs to
 linux-2.6.29.1
References: <1240501332.28136.24.camel@falcon> <49F0AFA3.6080408@thiscow.com> <1240535343.25824.14.camel@falcon>
In-Reply-To: <1240535343.25824.14.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <erwan@thiscow.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erwan@thiscow.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin a écrit :
>> I can not compile it :
>>
>>   CC      arch/mips/loongson/common/bonito-irq.o
>>   CC      arch/mips/loongson/common/mem.o
>>   CC      arch/mips/loongson/common/dbg_io.o
>> cc1: warnings being treated as errors
>> arch/mips/loongson/common/dbg_io.c: In function �prom_printf
>> arch/mips/loongson/common/dbg_io.c:178: error: the frame size of 1040
>> bytes is larger than 1024 bytes
>> make[1]: *** [arch/mips/loongson/common/dbg_io.o] Error 1
>> make: *** [arch/mips/loongson/common] Error 2
>>
>>     
>
> which gcc compiler do you use? gcc 4.4? i just try to compile it in gcc
> 4.4, get the same error. but i only test it in gcc 4.3(cross-compiler)
> before, only a few "trivial" warnings.
>
> a new branch for gcc 4.4 will be created as quickly as i can.
>
>   

Yeap :

gcc version 4.4.0-pre9999 built 20090212 (Gentoo SVN ebuild) rev. 144120 ()


>
> really thanks for your encouragement, welcome to take part in, lots of
> source code lines need to be cleaned up.
>
>   

I would be happy to help with the code but my C skills are need the 
"hello world" stuff  :)
I can help with testing and writing documentations.

Cheers
Erwan
