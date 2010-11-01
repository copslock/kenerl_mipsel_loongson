Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2010 12:45:53 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:43816 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491176Ab0KALps (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Nov 2010 12:45:48 +0100
Received: by ewy19 with SMTP id 19so2624885ewy.36
        for <multiple recipients>; Mon, 01 Nov 2010 04:45:47 -0700 (PDT)
Received: by 10.213.31.73 with SMTP id x9mr2152489ebc.36.1288611947543;
        Mon, 01 Nov 2010 04:45:47 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.40.22])
        by mx.google.com with ESMTPS id q58sm4124420eeh.21.2010.11.01.04.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 04:45:45 -0700 (PDT)
Message-ID: <4CCEA800.9040500@mvista.com>
Date:   Mon, 01 Nov 2010 14:44:00 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jeremy Kerr <jeremy.kerr@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] of: of_mdio: Fix some endianness problems.
References: <1288227827-5447-1-git-send-email-ddaney@caviumnetworks.com> <20101030063237.GC2456@angua.secretlab.ca> <AANLkTi=24H4RNonXu=i3CHhYqbLniDya+BKnj_evw_p6@mail.gmail.com>
In-Reply-To: <AANLkTi=24H4RNonXu=i3CHhYqbLniDya+BKnj_evw_p6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 31-10-2010 5:54, Grant Likely wrote:

>>> In of_mdiobus_register(), the __be32 *addr variable is dereferenced.
>>> This will not work on little-endian targets.  Also since it is
>>> unsigned, checking for less than zero is redundant.

>>> Fix these two issues.

>>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
>>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>>> Cc: Dan Carpenter<error27@gmail.com>
>>> Cc: Greg Kroah-Hartman<gregkh@suse.de>
>>> ---
>>>   drivers/of/of_mdio.c |   23 ++++++++++++++---------
>>>   1 files changed, 14 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>>> index 1fce00e..b370306 100644
>>> --- a/drivers/of/of_mdio.c
>>> +++ b/drivers/of/of_mdio.c
>>> @@ -52,27 +52,32 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>>>
>>>        /* Loop over the child nodes and register a phy_device for each one */
>>>        for_each_child_of_node(np, child) {
>>> -             const __be32 *addr;
>>> +             const __be32 *paddr;
>>> +             u32 addr;
>>>                int len;
>>>
>>>                /* A PHY must have a reg property in the range [0-31] */
>>> -             addr = of_get_property(child, "reg",&len);
>>> -             if (!addr || len<  sizeof(*addr) || *addr>= 32 || *addr<  0) {
>>> +             paddr = of_get_property(child, "reg",&len);
>>> +             if (!paddr || len<  sizeof(*paddr)) {
>>> +addr_err:
>>>                        dev_err(&mdio->dev, "%s has invalid PHY address\n",
>>>                                child->full_name);
>>>                        continue;
>>>                }
>>> +             addr = be32_to_cpup(paddr);
>>> +             if (addr>= 32)
>>> +                     goto addr_err;

>> goto's are fine for jumping to the end of a function to unwind
>> allocations, but please don't use it in this manner.  The original
>> structure will actually work just fine if you do it thusly:

>>                 if (!paddr || len<  sizeof(*paddr) ||
>>                     *(addr = be32_to_cpup(paddr))>= 32) {
>>                         dev_err(&mdio->dev, "%s has invalid PHY address\n",
>>                                 child->full_name);
>>                         continue;
>>                 }

>> Otherwise this patch looks good. After you've reworked and retested
>> I'll pick it up for 2.6.37 (or dave will).

> Actually, I mistyped this.  I think it should be:
>
>                 if (!paddr || len<  sizeof(*paddr) ||
>                     (addr = be32_to_cpup(paddr))>= 32) {

   This assignment would probably cause checkpatch.pl to complain...

WBR, Sergei
