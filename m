Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 18:38:47 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17473 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492094Ab0BORin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 18:38:43 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7986aa0000>; Mon, 15 Feb 2010 09:38:50 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 09:38:39 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 09:38:39 -0800
Message-ID: <4B79869F.2040700@caviumnetworks.com>
Date:   Mon, 15 Feb 2010 09:38:39 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     David Daney <david.s.daney@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 4/6] MIPS: Implement Read Inhibit/eXecute Inhibit
References: <4B733C71.8030304@caviumnetworks.com>        <1265843569-5786-4-git-send-email-ddaney@caviumnetworks.com>    <f861ec6f1002141216t233fde34t1586bcd50dc051b4@mail.gmail.com>   <4B78A0C1.1070509@gmail.com> <4B78AC97.8030404@gmail.com> <f861ec6f1002150934y57d57408pfe62aceca763fe10@mail.gmail.com>
In-Reply-To: <f861ec6f1002150934y57d57408pfe62aceca763fe10@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2010 17:38:39.0921 (UTC) FILETIME=[B5D78210:01CAAE65]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/15/2010 09:34 AM, Manuel Lauss wrote:
> Hi David,
>
> On Mon, Feb 15, 2010 at 3:08 AM, David Daney<david.s.daney@gmail.com>  wrote:
>>> On 02/14/2010 12:16 PM, Manuel Lauss wrote:
>
>>>> this patch breaks my Alchemy builds:
>
>> Try the attached patch, it allows me to build an au1000 kernel. But since I
>> don't have harware, I cannot test it.
>
> Boots my userspace, thank you!
>

Ok.  I am working on a functionally equivalent, but slightly cleaner patch.

Thanks for your patience,

David Daney


>
>> I started with pb1500_defconfig, but had to disable au1000_eth.c:
>>
>> drivers/net/au1000_eth.c: In function ‘au1000_probe’:
>> drivers/net/au1000_eth.c:1009: error: implicit declaration of function
>> ‘DECLARE_MAC_BUF’
>> drivers/net/au1000_eth.c:1009: error: ‘ethaddr’ undeclared (first use in
>> this function)
>> drivers/net/au1000_eth.c:1009: error: (Each undeclared identifier is
>> reported only once
>> drivers/net/au1000_eth.c:1009: error: for each function it appears in.)
>
> I'll try to fix this; usually I only build db1200_defconfig.
>
> Manuel
>
