Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2011 04:41:16 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.141]:55547 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490947Ab1B1DlM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Feb 2011 04:41:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id 496B031D56A;
        Mon, 28 Feb 2011 11:24:08 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 19gkLsdSR6Qt; Mon, 28 Feb 2011 11:23:57 +0800 (CST)
Received: from [172.16.2.68] (unknown [222.92.8.142])
        by lemote.com (Postfix) with ESMTP id 9B3CB31D55C;
        Mon, 28 Feb 2011 11:23:57 +0800 (CST)
Message-ID: <4D6B1942.8020700@lemote.com>
Date:   Mon, 28 Feb 2011 11:40:50 +0800
From:   =?UTF-8?B?6IOh5rSq5YW1?= <huhb@lemote.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Jacky Lam <lamshuyin@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Memory needed for hibernation too much
References: <4D672850.80902@gmail.com> <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com> <4D6AF445.6020401@gmail.com> <4D6B0080.1010401@lemote.com> <4D6B10AF.9020709@gmail.com>
In-Reply-To: <4D6B10AF.9020709@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <huhb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huhb@lemote.com
Precedence: bulk
X-list: linux-mips

于 11/02/28 11:04, Jacky Lam 写道:
> On 2/28/2011 9:55 AM, 胡洪兵 wrote:
>> 于 11/02/28 9:03, Jacky Lam 写道:
>>> I create a 300GB swap space (just use up the remaining space in disk, no
>>> special reason). Is that a problem?
>>>
>>
>> You could try to change the memory model to "Sparese Memory".
>>
>> Kernel type --->
>> Memory model (Sparse Memory) --->
>
> My system memory only has 1 node of continuous memory. Any reason for that?
>
The memory address space is not continuous in some cpus, so I suggest to 
change the memory model.

I guess that your system is continuous, so only 1 node is show.

> Jacky
>
>>
>>> Jacky
>>>
>>> On 2/25/2011 4:12 PM, Geert Uytterhoeven wrote:
>>>> On Fri, Feb 25, 2011 at 04:56, Jacky Lam<lamshuyin@gmail.com> wrote:
>>>>> I try the hibernation feature with my MIPS box which has 128MB RAM.
>>>>> After
>>>>> boot up, it remains to have 110MB something. Then I mount ramfs on a
>>>>> directory, create a file 100MB from /dev/urandom and enter
>>>>> hibernation. The
>>>>> process failed because of no memory. Then, I continue to cut the data
>>>>> file
>>>>> size and not success until 20MB.
>>>>>
>>>>> I want to make sure if it is an expected behavior or I am doing some
>>>>> wrong?
>>>> How large is your swapspace? Hibernation needs space on swap to store
>>>> the contents
>>>> of RAM (that cannot be loaded again from somewhere else).
>>>>
>>>> Gr{oetje,eeting}s,
>>>>
>>>> Geert
>>>>
>>>> --
>>>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>>>> geert@linux-m68k.org
>>>>
>>>> In personal conversations with technical people, I call myself a
>>>> hacker. But
>>>> when I'm talking to journalists I just say "programmer" or something
>>>> like that.
>>>> -- Linus Torvalds
>>>>
>>>
>>>
>>>
>>
>>
>
>
>


-- 
---------------------------------------------------------
HuHongbing (Software Department)
Tel	: 0512-52308631
E-mail	: huhb@lemote.com
MSN	: [huhb04@gmail.com]
WEB	: www.lemote.com
JiangSu Lemote Corp. Ltd.
MengLan, Yushan, Changshu, JiangSu Province, China
---------------------------------------------------------
