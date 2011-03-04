Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 21:11:50 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:38260 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491993Ab1CDULq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Mar 2011 21:11:46 +0100
Message-ID: <4D7147CC.1020009@openwrt.org>
Date:   Fri, 04 Mar 2011 21:13:00 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH V3 06/10] MIPS: lantiq: add NOR flash support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-7-git-send-email-blogic@openwrt.org> <4D70DDEA.2050308@mvista.com>
In-Reply-To: <4D70DDEA.2050308@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

>> +    if (ltq_mtd_probing)
>> +        adr ^= 2;
>> +    spin_lock_irqsave(&ebu_lock, flags);
>> +    temp.x[0] = *((__u16 *)(map->virt + adr));
>> +    spin_unlock_irqrestore(&ebu_lock, flags);
>
>    Hm, what does this lock gain, if the read is atomic anyway?

the SoC has a hardware arbitor for the EBU. I have so far not been able
to activate it properly and the lock is needed to protect from PCI and
NOR i/o clashing with eachother. i know that the arbitor works when
using lantiqs 2.6.28. i will provide a follow up patch once i figured
how to bring up the arbitor properly. until that time we need to use the
lock.

thanks,
John
