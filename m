Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 02:39:36 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16088 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492190Ab0CWBjc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Mar 2010 02:39:32 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ba81bdc0000>; Mon, 22 Mar 2010 18:39:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Mar 2010 18:39:19 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Mar 2010 18:39:19 -0700
Message-ID: <4BA81BC7.5060600@caviumnetworks.com>
Date:   Mon, 22 Mar 2010 18:39:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Zhuang Yuyao <mlistz@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>        <4BA79E69.1040803@caviumnetworks.com> <e732b6801003221830y2c2ca423tb67d74f7a3639c22@mail.gmail.com>
In-Reply-To: <e732b6801003221830y2c2ca423tb67d74f7a3639c22@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2010 01:39:19.0781 (UTC) FILETIME=[A8322950:01CACA29]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/22/2010 06:30 PM, Zhuang Yuyao wrote:
> Thanks for your reply. Will this issue be solved soon? Is it a
> hardware issue or a software one?

A combination.  I think a Software fix is possible.

> Can I make the 4G-256M memory
> reserved so that kernel will not try to allocate memory in this area?
>

I have never tried it.

The issue is maintaining mappings for 32-bit PCI devices.  If you only 
want to support 64-bit devices, it would be easier to address the issue.

David Daney

> can not use more than 4G ram is bothersome since the memory is so cheap now. :-)
>
> Thanks very much.
>
> On Tue, Mar 23, 2010 at 12:44 AM, David Daney<ddaney@caviumnetworks.com>  wrote:
>>
>> This is a known issue.
>>
>> passing mem==3072M will restrict kernel memory usage thus avoiding the
>> issue.
>>
>> David Daney
>>
>
