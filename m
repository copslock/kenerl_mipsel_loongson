Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 12:52:22 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:62431 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492516Ab0CILwS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 12:52:18 +0100
Received: by ewy24 with SMTP id 24so1012567ewy.27
        for <linux-mips@linux-mips.org>; Tue, 09 Mar 2010 03:52:12 -0800 (PST)
Received: by 10.213.100.151 with SMTP id y23mr4124128ebn.78.1268135532382;
        Tue, 09 Mar 2010 03:52:12 -0800 (PST)
Received: from [192.168.2.2] (ppp91-77-52-186.pppoe.mtu-net.ru [91.77.52.186])
        by mx.google.com with ESMTPS id 16sm3051478ewy.11.2010.03.09.03.52.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 03:52:11 -0800 (PST)
Message-ID: <4B96364E.5050202@mvista.com>
Date:   Tue, 09 Mar 2010 14:51:42 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: move MMC driver registration to board
 code.
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>   <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>      <4B963210.7030906@ru.mvista.com> <f861ec6f1003090345n53570102je68aef14e8b3f3fb@mail.gmail.com>
In-Reply-To: <f861ec6f1003090345n53570102je68aef14e8b3f3fb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:

>>> Where it really belongs to.
>> I disagree (again). SoC platform devices dont belong with the board code.
>>     
>
> Figured as much.  However with additional boards the #ifdef mess in
> common/platform.c
> is only going to get worse. MUCH worse.

   We could probably eliminate the board #ifdef in platfrom.c by not 
supplying the platfrom data for MMC1.

> Just look at the au1000-eth platform data situation!
> I have these platform devices on Au1200/Au1300 even thought they don't have
> a built-in MAC.
>   

   Need to add the SoC type checks then when registering the devices. Or 
at least the #ifdef's. :-)

> The board which uses the device should register it.

   Contrarywise, the SoC that has the devices, should register them.

> But, consider the patch withdrawn.
>   

   Thanks.

> Manuel
>   

WBR, Sergei
