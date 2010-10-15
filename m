Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 21:55:55 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:41313 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491762Ab0JOTzv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 21:55:51 +0200
Received: by ywp6 with SMTP id 6so630180ywp.36
        for <multiple recipients>; Fri, 15 Oct 2010 12:55:44 -0700 (PDT)
Received: by 10.150.185.4 with SMTP id i4mr2271013ybf.227.1287172544232; Fri,
 15 Oct 2010 12:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.49.9 with HTTP; Fri, 15 Oct 2010 12:55:24 -0700 (PDT)
In-Reply-To: <4CB8B070.80903@caviumnetworks.com>
References: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTi=M0Fk5EGy+JB2CZcGxspv3hPde10A-R5sUs3Jq@mail.gmail.com> <4CB8B070.80903@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Fri, 15 Oct 2010 13:55:24 -0600
X-Google-Sender-Auth: CiAKiNA7TK020l3Cd8P1PXRt03Y
Message-ID: <AANLkTinNf3UcYPKoKcPktWBLZc40Mn4BuuBLJrR2rVHK@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add some irq definitins required by OF
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Fri, Oct 15, 2010 at 1:50 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/14/2010 06:27 PM, Grant Likely wrote:
>>
>> On Thu, Oct 14, 2010 at 3:02 PM, David Daney<ddaney@caviumnetworks.com>
>>  wrote:
>>>
>>> Using the forthcoming open firmware (OF) on mips patches, requires
>>> that several interrupt related definitions be added.
>>>
>>> In the future we may want to allow some sort of override for
>>> irq_create_mapping, but for now it is just supplies an identity
>>> mapping.
>>>
>>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>
>> Hi David,
>>
>> If you try my current next-devicetree branch then this patch should
>> not be necessary.  I was able to build the mips patch before I posted it.
>>
>
> This is what I get building on your next-devicetree branch:
>
>  CC      drivers/of/of_i2c.o
> drivers/of/of_i2c.c: In function 'of_i2c_register_devices':
> drivers/of/of_i2c.c:70: error: implicit declaration of function
> 'irq_dispose_mapping'
>
>
> Hence the part of my patch where I added those irq_create_mapping() and
> irq_dispose_mapping() functions.

Oops, I missed that.  I obviously didn't have CONFIG_I2C enabled when
I build tested.  I'll craft a patch so that MIPS doesn't need to
define it.

g.
