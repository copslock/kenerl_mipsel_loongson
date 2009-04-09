Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 10:02:45 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:46763 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S28643917AbZDIJBj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 10:01:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 3F61C34131;
	Thu,  9 Apr 2009 16:58:38 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1JxWWOmKstK; Thu,  9 Apr 2009 16:58:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 4CBAE34129;
	Thu,  9 Apr 2009 16:58:32 +0800 (CST)
Message-ID: <49DDB965.3060200@lemote.com>
Date:	Thu, 09 Apr 2009 17:01:25 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Arnaud Patard <apatard@mandriva.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?UTF-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
References: <49DD7E88.7040305@lemote.com> <m3prfm6x1d.fsf@anduin.mandriva.com>
In-Reply-To: <m3prfm6x1d.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Arnaud Patard 写道:
> yanhua <yanh@lemote.com> writes:
>
> Hi,
>
>
>   
>> Mini fuloong, yeeloong are all Loongson2F based systems. Loongson2F have
>> builtin DDR2 and PCIX controller. The PCIX controller have a similar
>> programming interface with FPGA northbridge used in Loongson2E.
>>     
>
> First, please read Documentation/SubmittingPatches first. There's no
> signed-off-by and this patch is too big. So big patches are making
> review a nightmare, please split it into smaller pieces :(
>   
Thanks for your reviewing this patch and your advice.  I will split them 
into smaller pieces.
> Also, I'd like to see a different directories layout. You're doing :
> arch/mips/lemote/
>     lm2e/
>     lm2f/
>         common/
>         fuloong/
>         yeeloong/
>   
This is just for historical reasons. Before, we have loongson2e machines 
named as fulong(from loogson2f, changeed to fuloong) merged into main 
kernel.
so I keep that to make 2e machines unchanged.

Maybe it's better to break the historical doing to get a more clear 
directory structure.
> This is quite annoying because:
> - I'll prefer seeing loongson instead of Lemote. I've some ST machines
>   here they do share a lot of code with the 2e/2f so I'd like to avoid
>   duplicating code.
>
> - There's some code very similar between 2e, 2f-yeelong and
>   2f-fuloong and other machines. Why not putting them in a common
>   directory instead of duplicating again some code ?
>
> To sum up, imho, it would be better to have something like :
> arch/mips/loongson/
>     common/
>     2e/
>     2f/ (or something similar)
>        common/
>        yeelong/
>        fuloong/
>        ...
>   
OK, I will rearange the patch. Thanks again.
> Arnaud
>
>   


-- 
晏华
