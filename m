Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2011 15:35:31 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:36738 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491755Ab1DDNfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2011 15:35:25 +0200
Message-ID: <4D99C974.5060800@openwrt.org>
Date:   Mon, 04 Apr 2011 15:36:52 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V5 06/10] MIPS: lantiq: add NOR flash support
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>         <1301470076-17279-7-git-send-email-blogic@openwrt.org> <1301661832.2789.56.camel@localhost>
In-Reply-To: <1301661832.2789.56.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Artem

thanks for the feedback, comments inline
>
>> +ltq_copy_from(struct map_info *map, void *to,
>> +	unsigned long from, ssize_t len)
>> +{
>> +	unsigned char *f = (unsigned char *) (map->virt + from);
>> +	unsigned char *t = (unsigned char *) to;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ebu_lock, flags);
>> +	while (len--)
>> +		*t++ = *f++;
>> +	spin_unlock_irqrestore(&ebu_lock, flags);
>>     
> Can you use memcpy here instead?
>
>   

as we are copying to/from iomem, we cannot use memcpy as the
pre-fetching breaks the copy process. the normal alternative is to use
memcpy_to/fromio, however on MIPS this breaks down to a normal memcpy.

i will fold your comments into the patch and resend it ASAP

thanks, John
