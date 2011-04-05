Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 15:05:10 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47874 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491753Ab1DENFG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Apr 2011 15:05:06 +0200
Message-ID: <4D9B13E0.9000202@openwrt.org>
Date:   Tue, 05 Apr 2011 15:06:40 +0200
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
References: <1302006830-10345-1-git-send-email-blogic@openwrt.org>         <1302006995.2760.120.camel@localhost>  <4D9B11C5.3030308@openwrt.org> <1302008284.2760.129.camel@localhost>
In-Reply-To: <1302008284.2760.129.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 05/04/11 14:58, Artem Bityutskiy wrote:
> On Tue, 2011-04-05 at 14:57 +0200, John Crispin wrote:
>   
>> we could dynamically allocate the instance of struct map_info and then
>> use map_priv_1 to indicate whether the device is probing or not.
>>     
> Yeah, may be you could indeed use map_priv_1 instead of the global
> variable already now? 
>
>   
Hi,

ok, let me add it to the patch ...

thanks, John
