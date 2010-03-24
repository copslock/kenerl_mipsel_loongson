Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 17:27:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15888 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492213Ab0CXQ1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Mar 2010 17:27:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4baa3d820000>; Wed, 24 Mar 2010 09:27:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Mar 2010 09:27:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Mar 2010 09:27:08 -0700
Message-ID: <4BAA3D5C.1000202@caviumnetworks.com>
Date:   Wed, 24 Mar 2010 09:27:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Zhuang Yuyao <mlistz@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>        <4BA79E69.1040803@caviumnetworks.com>   <e732b6801003221830y2c2ca423tb67d74f7a3639c22@mail.gmail.com>   <4BA81BC7.5060600@caviumnetworks.com> <e732b6801003221845i4f86ff8ftea56d656bfd20f10@mail.gmail.com>
In-Reply-To: <e732b6801003221845i4f86ff8ftea56d656bfd20f10@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2010 16:27:08.0335 (UTC) FILETIME=[D92433F0:01CACB6E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/22/2010 06:45 PM, Zhuang Yuyao wrote:
> On Tue, Mar 23, 2010 at 9:39 AM, David Daney<ddaney@caviumnetworks.com>  wrote:
>
>> The issue is maintaining mappings for 32-bit PCI devices.  If you only want
>> to support 64-bit devices, it would be easier to address the issue.
>>
>> David Daney
>>
>
> Wow, that is a great news, I do not known if my adaptec 3045e raid
> card is a 64bit device, but if I only want to support 64bit devices,
> Is there a quick fix for it?
>

I don't know.  You could try to make all DMA accesses go via BAR2.  That 
would break many 32-bit devices though.

David Daney

> Zhuang Yuyao
>
