Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 10:34:36 +0100 (BST)
Received: from smtpr1.tom.com ([IPv6:::ffff:202.108.255.195]:15845 "HELO
	tom.com") by linux-mips.org with SMTP id <S8226470AbVGMJeI>;
	Wed, 13 Jul 2005 10:34:08 +0100
Received: from [192.168.10.105] (unknown [218.94.38.156])
	by bjapp5 (Coremail) with SMTP id iMBgikXg1EJPACac.1
	for <yyuasa@gmail.com>; Wed, 13 Jul 2005 17:35:05 +0800 (CST)
X-Originating-IP: [218.94.38.156]
Message-ID: <42D4E053.6020708@tom.com>
Date:	Wed, 13 Jul 2005 17:35:15 +0800
From:	IHOLLO <ihollo@tom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Yoichi Yuasa <yyuasa@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: ADM5120: MIPS-I or MIPS32? WAS(Re: ADM5120: linux-2.4.31-adm.diff.bz2
 does not support PCI bus?)
References: <42D47A74.9070709@tom.com> <4955666b05071223405849abf6@mail.gmail.com>
In-Reply-To: <4955666b05071223405849abf6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ihollo@tom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihollo@tom.com
Precedence: bulk
X-list: linux-mips

Thanks Yoichi, that is exactly what you suggested, turn on New PCI bus 
code(CONFIG_PCI_NEW) then the kernel can be compiled  now.

Here is another question: What CPU type should I choose to compile 
applications for ADM5120? the spec says it is MIPS32, but I can not run 
MIPS32 applications on my board while MIPS-I executable works just fine.

#file busybox (works fine. compiled as mips-I)
busybox: ELF 32-bit LSB MIPS-I executable, MIPS, version 1 (SYSV), 
dynamically linked (uses shared libs), stripped

#file busybox (can not execute this program. compiled as mips32)
busybox: ELF 32-bit LSB executable, MIPS, version 1 (SYSV), dynamically 
linked (uses shared libs), stripped


Yoichi Yuasa wrote:

>Hi,
>
>2005/7/13, IHOLLO <ihollo@tom.com>:
>  
>
>>Hi,
>>
>>I am now working on a board with ADM5120 processor and want a kernel
>>newer than 2.4.18, so I tried the linux-2.4.31-adm.diff.bz2 patch
>>against vanilla 2.4.31 (http://www.linux-mips.org/wiki/ADMtek#Linux_2.4)
>>but failed to compile it with PCI Bus support (It compiles OK without
>>CONFIG_PCI). The compile error looks like this:
>>    
>>
>
>Did you turn on New PCI bus code(CONFIG_PCI_NEW)?
>
>Yoichi
>
>
>
>  
>
