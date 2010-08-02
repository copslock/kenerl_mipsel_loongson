Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 18:51:49 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12151 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493127Ab0HBQvp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Aug 2010 18:51:45 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c56f7ba0000>; Mon, 02 Aug 2010 09:52:10 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 2 Aug 2010 09:51:41 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 2 Aug 2010 09:51:41 -0700
Message-ID: <4C56F79D.3090709@caviumnetworks.com>
Date:   Mon, 02 Aug 2010 09:51:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] OCTEON: workaround linking failures with gcc-4.4.x 32-bits
 toolchains
References: <201007290013.08797.florian@openwrt.org> <4C50AC0C.9010507@caviumnetworks.com> <20100802145904.GA6123@linux-mips.org>
In-Reply-To: <20100802145904.GA6123@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2010 16:51:41.0566 (UTC) FILETIME=[FB5EA9E0:01CB3262]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 08/02/2010 07:59 AM, Ralf Baechle wrote:
> On Wed, Jul 28, 2010 at 03:15:40PM -0700, David Daney wrote:
>
>>> executables by default, we will produce __lshrti3 in sched_clock() which is
>>> never resolved so the kernel fails to link. Unconditionally use the inline
>>> assembly version as suggested by David Daney, which works around the issue.
>>>
>>> CC: David Daney<ddaney@caviumnetworks.com>
>>> Signed-off-by: Florian Fainelli<florian@openwrt.org>
>>
>> Acked-by: David Daney<ddaney@caviumnetworks.com>
>
> Applied - but maybe we should just add lshrti3 instead?  We already have
> ashldi3, ashrdi3 and lshrdi3.

Too slow I think.  If we are doing 128-bit arithmetic, it should only be 
for tricky things that we are optimizing to go real fast.  In this case, 
we don't want to be making function calls.

Well that is my $0.02

David Daney
