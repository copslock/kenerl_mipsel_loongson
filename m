Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:56:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44808 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491171Ab1DEM4K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Apr 2011 14:56:10 +0200
Message-ID: <4D9B11C5.3030308@openwrt.org>
Date:   Tue, 05 Apr 2011 14:57:41 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V7] MIPS: lantiq: add NOR flash support
References: <1302006830-10345-1-git-send-email-blogic@openwrt.org> <1302006995.2760.120.camel@localhost>
In-Reply-To: <1302006995.2760.120.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips


>> +
>> +static int ltq_mtd_probing;
>>     
> ... I'm worried about this global variable. If you have multiple
> instances of such NOR flash, then you theoretically may have a situation
> when one of them is being probed, while another is being used for real.
> And this single global switch will break the one which is used for real.
>
> IOW, the right solution would be to have per-chip flag, not a global
> flag.
>
>   

Hi,

we could dynamically allocate the instance of struct map_info and then
use map_priv_1 to indicate whether the device is probing or not.

this would avoid using a global variable

John
