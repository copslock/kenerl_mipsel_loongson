Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 19:47:20 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2630 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491084Ab1EIRrP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2011 19:47:15 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dc828da0001>; Mon, 09 May 2011 10:48:10 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 9 May 2011 10:47:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 9 May 2011 10:47:08 -0700
Message-ID: <4DC82897.7020206@caviumnetworks.com>
Date:   Mon, 09 May 2011 10:47:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>,
        rdsandiford@googlemail.com
Subject: Re: RFC: A new MIPS64 ABI
References: <4D5990A4.2050308__41923.1521235362$1297715435$gmane$org@caviumnetworks.com> <87hbbxqihm.fsf@firetop.home> <20110509142828.GA7196@linux-mips.org>
In-Reply-To: <20110509142828.GA7196@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2011 17:47:08.0570 (UTC) FILETIME=[1E152FA0:01CC0E71]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/09/2011 07:28 AM, Ralf Baechle wrote:
> On Mon, Feb 21, 2011 at 07:45:41PM +0000, Richard Sandiford wrote:
>
>> David Daney<ddaney@caviumnetworks.com>  writes:
>>> Background:
>>>
>>> Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
>>> user virtual memory space.  This is due the way MIPS32 memory space is
>>> segmented.  Only the range from 0..2^31-1 is available.  Pointer
>>> values are always sign extended.
>>>
>>> Because there are not already enough MIPS ABIs, I present the ...
>>>
>>> Proposal: A new ABI to support 4GB of address space with 32-bit
>>> pointers.
>>
>> FWIW, I'd be happy to see this go into GCC.
>
> So am I for the kernel primarily because it's not really a new ABI but
> an enhancement of the existing N32 ABI.
>

The patches are resting peacefully on my laptop.  Now with endorcements 
like these, I may be forced to actually finish them...

David Daney
