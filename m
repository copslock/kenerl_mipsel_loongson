Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 18:18:11 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16413 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492089Ab0KXRSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 18:18:08 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ced48f70000>; Wed, 24 Nov 2010 09:18:47 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 24 Nov 2010 09:19:02 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 24 Nov 2010 09:19:02 -0800
Message-ID: <4CED48CE.5060300@caviumnetworks.com>
Date:   Wed, 24 Nov 2010 09:18:06 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
CC:     michael@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org
Subject: Re: Mega rename of device tree routines from of_*() to dt_*()
References: <1290607413.12457.44.camel@concordia> <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
In-Reply-To: <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2010 17:19:02.0069 (UTC) FILETIME=[B0470E50:01CB8BFB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/24/2010 09:02 AM, Stephen Neuendorffer wrote:
>
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+stephen=neuendorffer.name@lists.ozlabs.org [mailto:linuxppc-dev-
>> bounces+stephen=neuendorffer.name@lists.ozlabs.org] On Behalf Of Michael Ellerman
>> Sent: Wednesday, November 24, 2010 6:04 AM
>> To: LKML
>> Cc: linux-mips; microblaze-uclinux@itee.uq.edu.au; devicetree-discuss@lists.ozlabs.org; linuxppc-dev
>> list; sparclinux@vger.kernel.org
>> Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
>>
>> Hi all,
>>
>> There were some murmurings on IRC last week about renaming the of_*()
>> routines. I was procrastinating at the time and said I'd have a look at
>> it, so here I am.
>>
>> The thinking is that on many platforms that use the of_() routines
>> OpenFirmware is not involved at all, this is true even on many powerpc
>> platforms. Also for folks who don't know the OpenFirmware connection it
>> reads as "of", as in "a can of worms".
>>
>> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
>> it would be nice to get rid of, but it's a lot of churn.
>>
>> So I'm hoping people with either say "YES this is a great idea", or "NO
>> this is stupid".
>
> Personally, I think it's a great idea, if only because I stared long and hard
> at the code once upon a time trying to figure out what is really OF-related
> and what isn't.  It's somewhat clearer now that drivers/of has been factored
> out (although, shouldn't it be drivers/dt???)
>
> That said, it *is* alot of code churn.  If it's going to be done, I think it should be
> done in concert with fixing a bunch of the function names which don't really follow any
> sane naming convention, so that the backporting discontinuity only happens once.
>

Oh, you mean things like:

of_{,un}register_platform_driver vs. platform_driver_{,un}register

That one is particularly annoying to me.

David Daney
