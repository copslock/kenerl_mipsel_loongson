Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2011 04:04:26 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:49622 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491894Ab1B1DET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Feb 2011 04:04:19 +0100
Received: by gxk21 with SMTP id 21so1462628gxk.36
        for <linux-mips@linux-mips.org>; Sun, 27 Feb 2011 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xx0OdQ3RIo0p0oE+ImqObV6aA4ks2UBQaPpcdWb4+KM=;
        b=GH52cOSE+7TU4t9+SaA1FUT4Jbxdxswwo7rJoiTeTRlrLEbMmbnfh2NYyhExKLnqh1
         QNGjg8tCDFmiQVq3dqHqPFy1u5l64O0tllazJOZg+xsbO6m0VqAo7i1uNeJ6VuHwregS
         h4j2bNSm9Cv/GU4lVRPtb/e40hwyfFInyHeT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FJVhTn6gWcJXGk9XvNXo8BeAl2eHSZPxLzPnI4npkZ8Vg9bLnQBd9IK+r1p9IRnM3J
         PiPzM1+PtcHriWxgIQWmJsN6fg+AG+eWas0VdergqAW72ZQjaW233FGiGJ5DqHb6C8JF
         cJgI27NuXPe/bXM+xwSgxN5dGe8EoFT0TnkGg=
Received: by 10.236.191.71 with SMTP id f47mr2909082yhn.36.1298862253329;
        Sun, 27 Feb 2011 19:04:13 -0800 (PST)
Received: from [192.168.100.231] ([220.232.195.195])
        by mx.google.com with ESMTPS id 14sm1863202yhl.22.2011.02.27.19.04.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 19:04:12 -0800 (PST)
Message-ID: <4D6B10AF.9020709@gmail.com>
Date:   Mon, 28 Feb 2011 11:04:15 +0800
From:   Jacky Lam <lamshuyin@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     =?UTF-8?B?6IOh5rSq5YW1?= <huhb@lemote.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Memory needed for hibernation too much
References: <4D672850.80902@gmail.com> <AANLkTik8ynTVq--A-u1nYCt_AX4RPqVGdep6JfZ7m86x@mail.gmail.com> <4D6AF445.6020401@gmail.com> <4D6B0080.1010401@lemote.com>
In-Reply-To: <4D6B0080.1010401@lemote.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <lamshuyin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lamshuyin@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/28/2011 9:55 AM, 胡洪兵 wrote:
> 于 11/02/28 9:03, Jacky Lam 写道:
>> I create a 300GB swap space (just use up the remaining space in disk, no
>> special reason). Is that a problem?
>>
>
> You could try to change the memory model to "Sparese Memory".
>
> Kernel type --->
>  Memory model (Sparse Memory)  --->

     My system memory only has 1 node of continuous memory. Any reason 
for that?

Jacky

>
>> Jacky
>>
>> On 2/25/2011 4:12 PM, Geert Uytterhoeven wrote:
>>> On Fri, Feb 25, 2011 at 04:56, Jacky Lam<lamshuyin@gmail.com> wrote:
>>>> I try the hibernation feature with my MIPS box which has 128MB RAM.
>>>> After
>>>> boot up, it remains to have 110MB something. Then I mount ramfs on a
>>>> directory, create a file 100MB from /dev/urandom and enter
>>>> hibernation. The
>>>> process failed because of no memory. Then, I continue to cut the data
>>>> file
>>>> size and not success until 20MB.
>>>>
>>>> I want to make sure if it is an expected behavior or I am doing some
>>>> wrong?
>>> How large is your swapspace? Hibernation needs space on swap to store
>>> the contents
>>> of RAM (that cannot be loaded again from somewhere else).
>>>
>>> Gr{oetje,eeting}s,
>>>
>>> Geert
>>>
>>> -- 
>>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>>> geert@linux-m68k.org
>>>
>>> In personal conversations with technical people, I call myself a
>>> hacker. But
>>> when I'm talking to journalists I just say "programmer" or something
>>> like that.
>>> -- Linus Torvalds
>>>
>>
>>
>>
>
>
