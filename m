Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Apr 2009 13:26:29 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:56997 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022042AbZDMM0W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Apr 2009 13:26:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 2644C3410F;
	Mon, 13 Apr 2009 20:23:01 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QmBO5kzm0S2C; Mon, 13 Apr 2009 20:22:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 5CCC53410C;
	Mon, 13 Apr 2009 20:22:52 +0800 (CST)
Message-ID: <49E32F52.6060001@lemote.com>
Date:	Mon, 13 Apr 2009 20:25:54 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	yanhua <yanh@lemote.com>, Arnaud Patard <apatard@mandriva.com>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?UTF-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
References: <49DD7E88.7040305@lemote.com> <m3prfm6x1d.fsf@anduin.mandriva.com> <49DDB965.3060200@lemote.com> <20090413113640.GB6137@adriano.hkcable.com.hk>
In-Reply-To: <20090413113640.GB6137@adriano.hkcable.com.hk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Zhang Le 写道:
> On 17:01 Thu 09 Apr     , yanhua wrote:
> [snip]
>   
>> This is just for historical reasons. Before, we have loongson2e machines  
>> named as fulong(from loogson2f, changeed to fuloong) merged into main  
>> kernel.
>>     
>
> I suggest we might as well change fulong to fuloong2e, while call 2f based
> fuloong fuloong2f (or something similar, you get the idea).
>
> Because, fulong and fuloong are almost indistinguishable, neither on spelling
> nor on pronunciation.
>
>   
Yes， We will rearrange the directory structure and make they share the 
common code.
> Of course, we can deal with fulong(2e) later. However, I strongly suggest we get
> fuloong2f right in the first place.
>
> Zhang, Le
>
>   


-- 
晏华
