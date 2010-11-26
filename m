Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 08:37:01 +0100 (CET)
Received: from rs35.luxsci.com ([66.216.127.90]:35289 "EHLO rs35.luxsci.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492021Ab0KZHgy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Nov 2010 08:36:54 +0100
Received: from [10.20.0.14] (user-118btu4.cable.mindspring.com [66.133.247.196])
        (authenticated bits=0)
        by rs35.luxsci.com (8.13.1/8.13.7) with ESMTP id oAQ7aOl8023288
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 26 Nov 2010 01:36:25 -0600
Message-ID: <4CEF6373.60105@firmworks.com>
Date:   Thu, 25 Nov 2010 21:36:19 -1000
From:   Mitch Bradley <wmb@firmworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
MIME-Version: 1.0
To:     michael@ellerman.id.au
CC:     Grant Likely <grant.likely@secretlab.ca>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Scian <andrea.scian@dave.eu>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
References: <1290607413.12457.44.camel@concordia>        <1290692075.689.20.camel@concordia>     <AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>  <1290741341.9453.377.camel@concordia>  <4CEF3AB1.9060200@firmworks.com> <1290750606.9453.394.camel@concordia>
In-Reply-To: <1290750606.9453.394.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <wmb@firmworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wmb@firmworks.com
Precedence: bulk
X-list: linux-mips


>> One Laptop Per Child ships real Open Firmware on its x86 Linux systems,
>> of which approximately 2 million have been shipped or ordered.  An ARM
>> version, also with OFW, is in the works.
>
> OK. I don't see any code under arch/x86 or arch/arm that uses of_()
> routines though? Or is it under drivers or something?
>

Andres Salomon has been working for some time to get some Open Firmware 
support for x86 upstream.  As you can probably imagine, it has been slow 
going, but seems to be getting close.

The OLPC ARM work is just beginning, so nothing has been submitted yet. 
  The first hardware prototypes are still being debugged. Lennert 
Buytenhek is the key OS person who will be involved.
