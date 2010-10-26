Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 00:19:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4270 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab0JZWS4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 00:18:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc753e40000>; Tue, 26 Oct 2010 15:19:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 26 Oct 2010 15:19:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 26 Oct 2010 15:19:06 -0700
Message-ID: <4CC753BE.5010705@caviumnetworks.com>
Date:   Tue, 26 Oct 2010 15:18:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Add some irq definitins required by OF
References: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com> <AANLkTi=M0Fk5EGy+JB2CZcGxspv3hPde10A-R5sUs3Jq@mail.gmail.com>
In-Reply-To: <AANLkTi=M0Fk5EGy+JB2CZcGxspv3hPde10A-R5sUs3Jq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2010 22:19:06.0029 (UTC) FILETIME=[CD7E95D0:01CB755B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/14/2010 06:27 PM, Grant Likely wrote:
> On Thu, Oct 14, 2010 at 3:02 PM, David Daney<ddaney@caviumnetworks.com>  wrote:
[...]
>>
>> +#define NO_IRQ UINT_MAX
>
> Really?  The verdict came down a long time ago that 0 is to be the
> value that means no irq, and only a few architectures still define
> NO_IRQ as -1.  It is assumed that the architectures which do not
> define NO_IRQ use 0 as the invalid value.  Mostly notably x86 does not
> define NO_IRQ, and Linus nack'd the patch to add it.
>

I was not part of that discussion.

I would however note, that all the irq functions return unsigned, so a 
value of -1 is meaningless.  Also my understanding is that 8259 based 
systems use the values of 0 - 15 as the interrupt numbers, making 0 
unavailable for use as NO_IRQ.

Given these constraints, UINT_MAX would seem to be a good value.  It has 
to be defined as something *and* have global visibility, because it is 
part of the OF irq mapping functions API.

David Daney
