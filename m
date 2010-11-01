Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2010 15:21:20 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:41506 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491193Ab0KAOVP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Nov 2010 15:21:15 +0100
Received: by gwj17 with SMTP id 17so3488429gwj.36
        for <multiple recipients>; Mon, 01 Nov 2010 07:21:09 -0700 (PDT)
Received: by 10.151.46.14 with SMTP id y14mr25355761ybj.383.1288621269098;
 Mon, 01 Nov 2010 07:21:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.15.4 with HTTP; Mon, 1 Nov 2010 07:20:48 -0700 (PDT)
In-Reply-To: <4CCEA800.9040500@mvista.com>
References: <1288227827-5447-1-git-send-email-ddaney@caviumnetworks.com>
 <20101030063237.GC2456@angua.secretlab.ca> <AANLkTi=24H4RNonXu=i3CHhYqbLniDya+BKnj_evw_p6@mail.gmail.com>
 <4CCEA800.9040500@mvista.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Mon, 1 Nov 2010 10:20:48 -0400
X-Google-Sender-Auth: aJ_SFnkJBqV3HrgTGjomm8X0rdg
Message-ID: <AANLkTikV1QjvROa4jQWxS=tgkUfYh9BrYLSYBC-dxCEX@mail.gmail.com>
Subject: Re: [PATCH] of: of_mdio: Fix some endianness problems.
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jeremy Kerr <jeremy.kerr@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Mon, Nov 1, 2010 at 7:44 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 31-10-2010 5:54, Grant Likely wrote:
>
>>>> In of_mdiobus_register(), the __be32 *addr variable is dereferenced.
>>>> This will not work on little-endian targets.  Also since it is
>>>> unsigned, checking for less than zero is redundant.
>
>>>> Fix these two issues.
>
>>>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>>> Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
>>>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>>>> Cc: Dan Carpenter<error27@gmail.com>
>>>> Cc: Greg Kroah-Hartman<gregkh@suse.de>
>>>> ---
>>>>  drivers/of/of_mdio.c |   23 ++++++++++++++---------
>>>>  1 files changed, 14 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>>>> index 1fce00e..b370306 100644
>>>> --- a/drivers/of/of_mdio.c
>>>> +++ b/drivers/of/of_mdio.c
>>>> @@ -52,27 +52,32 @@ int of_mdiobus_register(struct mii_bus *mdio, struct
>>>> device_node *np)
>>>>
>>>>       /* Loop over the child nodes and register a phy_device for each
>>>> one */
>>>>       for_each_child_of_node(np, child) {
>>>> -             const __be32 *addr;
>>>> +             const __be32 *paddr;
>>>> +             u32 addr;
>>>>               int len;
>>>>
>>>>               /* A PHY must have a reg property in the range [0-31] */
>>>> -             addr = of_get_property(child, "reg",&len);
>>>> -             if (!addr || len<  sizeof(*addr) || *addr>= 32 || *addr<
>>>>  0) {
>>>> +             paddr = of_get_property(child, "reg",&len);
>>>> +             if (!paddr || len<  sizeof(*paddr)) {
>>>> +addr_err:
>>>>                       dev_err(&mdio->dev, "%s has invalid PHY
>>>> address\n",
>>>>                               child->full_name);
>>>>                       continue;
>>>>               }
>>>> +             addr = be32_to_cpup(paddr);
>>>> +             if (addr>= 32)
>>>> +                     goto addr_err;
>
>>> goto's are fine for jumping to the end of a function to unwind
>>> allocations, but please don't use it in this manner.  The original
>>> structure will actually work just fine if you do it thusly:
>
>>>                if (!paddr || len<  sizeof(*paddr) ||
>>>                    *(addr = be32_to_cpup(paddr))>= 32) {
>>>                        dev_err(&mdio->dev, "%s has invalid PHY
>>> address\n",
>>>                                child->full_name);
>>>                        continue;
>>>                }
>
>>> Otherwise this patch looks good. After you've reworked and retested
>>> I'll pick it up for 2.6.37 (or dave will).
>
>> Actually, I mistyped this.  I think it should be:
>>
>>                if (!paddr || len<  sizeof(*paddr) ||
>>                    (addr = be32_to_cpup(paddr))>= 32) {
>
>  This assignment would probably cause checkpatch.pl to complain...

checkpatch isn't always right.  Alternately, I'd also be okay with
David's approach of splitting the tests into two if() blocks if
without the goto...

Actually, don't worry about it.  I just merged David's patch and
removed the goto myself in the process.

g.
