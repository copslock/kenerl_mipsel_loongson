Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2011 18:25:26 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:11210 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1BDRZS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Feb 2011 18:25:18 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d4c367d0002>; Fri, 04 Feb 2011 12:25:22 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Feb 2011 09:25:11 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Feb 2011 09:25:11 -0800
Message-ID: <4D4C3676.50802@caviumnetworks.com>
Date:   Fri, 04 Feb 2011 09:25:10 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     naveen yadav <yad.naveen@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Himanshu Aggarwal <lkml.himanshu@gmail.com>,
        kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: page size change on MIPS
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>      <4D3DCB5A.6060107@caviumnetworks.com>   <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>  <20110131130820.GB26217@linux-mips.org> <AANLkTi=UTRk8e6fv3USP5RPKY-Fg0ehGBXrf0bD8NthX@mail.gmail.com> <AANLkTimCfioamQWGeRCFFN=OoWE7-PhGs2tCH+_9H=HO@mail.gmail.com>
In-Reply-To: <AANLkTimCfioamQWGeRCFFN=OoWE7-PhGs2tCH+_9H=HO@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2011 17:25:11.0159 (UTC) FILETIME=[7A03B870:01CBC490]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/03/2011 08:16 PM, naveen yadav wrote:
> Hi, I am adding readelf info also .
>
> mips-linux-gnu-readelf -S squashfs-root/bin/busybox
> There are 35 section headers, starting at offset 0x174290:
>

Section headers are not relevant to any of this.  You need to look at 
the program headers.  Try 'readelf -l'

David Daney


[...]
>>
>>
>> On Mon, Jan 31, 2011 at 6:38 PM, Ralf Baechle<ralf@linux-mips.org>  wrote:
>>> On Sun, Jan 30, 2011 at 08:32:43PM +0530, Himanshu Aggarwal wrote:
>>>
>>>> Why should the application or the toolchains depend on pagesize? I am
>>>> not very clear on this. Can someone explain it?
>>>
>>> To allow loading directly with mmap the executable file's layout must
>>> be such that it's it's segments are on offsets that are a multiple of
>>> the page size so in turn the linker must know that alignment.
>>>
>>>   Ralf
>>>
>>
>
