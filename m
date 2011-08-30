Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 02:14:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10747 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491756Ab1H3AOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 02:14:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5c2bac0000>; Mon, 29 Aug 2011 17:15:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 29 Aug 2011 17:14:30 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 29 Aug 2011 17:14:28 -0700
Message-ID: <4E5C2B62.9040007@cavium.com>
Date:   Mon, 29 Aug 2011 17:14:26 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
References: <20110829232029.GA15763@zapo> <4E5C2490.6040203@cavium.com> <4E5C26D4.3000906@paralogos.com>
In-Reply-To: <4E5C26D4.3000906@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2011 00:14:30.0055 (UTC) FILETIME=[C95A5B70:01CC66A9]
X-archive-position: 31012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21967

On 08/29/2011 04:55 PM, Kevin D. Kissell wrote:
> I submitted that exact patch (David's more minimal version) in December
> 2010 (and I did test it).  Did it not take?

Evidently not.  Perhaps Ralf will see fit to commit it this time.

>  See the thread "SMTC
> support status in latest git head".  The patch went out on December 24
> (why I was spending my Christmas Eve fixing MIPS Linux is another
> question... :op )
>

... one which I will not attempt to address.

David Daney.


>              Kevin K.
>
> On 08/29/11 16:45, David Daney wrote:
>> On 08/29/2011 04:20 PM, Edgar E. Iglesias wrote:
>>> Hi,
>>>
>>> Commit 362e696428590f7d0a5d0971a2d04b0372a761b8
>>> reorders a bunch of insns to improve the flow of the pipeline but
>>> for MT_SMTC kernels, AFAICT, the saving of CP0_STATUS seems wrong.
>>
>> Indeed.
>>
>>>
>>> Am I missing something?
>>>
>>
>> It does look like in the MIPS_MT_SMTC case we are clobbering the value
>> in v1.
>>
>>> If not here is a patch, tested with qemu.
>>>
>>
>> How about the attached completely untested one instead?
>>
>> David Daney
>
>
