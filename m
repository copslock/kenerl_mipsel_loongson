Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 18:01:01 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15865 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492069Ab0KXRAy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Nov 2010 18:00:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ced44ed0000>; Wed, 24 Nov 2010 09:01:33 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 24 Nov 2010 09:01:47 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 24 Nov 2010 09:01:47 -0800
Message-ID: <4CED44BE.1030405@caviumnetworks.com>
Date:   Wed, 24 Nov 2010 09:00:46 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     michael@ellerman.id.au
CC:     LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
References: <1290607413.12457.44.camel@concordia>
In-Reply-To: <1290607413.12457.44.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2010 17:01:47.0505 (UTC) FILETIME=[47A11E10:01CB8BF9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/24/2010 06:03 AM, Michael Ellerman wrote:
> Hi all,
>
> There were some murmurings on IRC last week about renaming the of_*()
> routines. I was procrastinating at the time and said I'd have a look at
> it, so here I am.
>
> The thinking is that on many platforms that use the of_() routines
> OpenFirmware is not involved at all, this is true even on many powerpc
> platforms. Also for folks who don't know the OpenFirmware connection it
> reads as "of", as in "a can of worms".
>
> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".
>
> As step one I've just renamed as many routines as I could find to see
> what the resulting patch looks like, so we can quantify the churn. I
> also did device.of_node, which is used quite a bit.
>
> Thoughts?
>
> of ->  dt most places I could think of (done mechanically):
>
[...]
>   drivers/of/address.c                               |  114 ++++++------
>   drivers/of/base.c                                  |   14 +-
>   drivers/of/device.c                                |   36 ++--
>   drivers/of/fdt.c                                   |    4 +-
>   drivers/of/gpio.c                                  |   32 ++--
>   drivers/of/irq.c                                   |    4 +-
>   drivers/of/of_i2c.c                                |   18 +-
>   drivers/of/of_mdio.c                               |   16 +-
>   drivers/of/of_spi.c                                |   12 +-
>   drivers/of/pdt.c                                   |    4 +-
>   drivers/of/platform.c                              |  212 ++++++++++----------

Well, not that I care one way or the other, but for consistency you 
should change all these directory and file names as well.

David Daney
