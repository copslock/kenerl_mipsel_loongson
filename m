Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 16:12:16 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:33903 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab1CDPMN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 16:12:13 +0100
Received: by bwz1 with SMTP id 1so2235555bwz.36
        for <multiple recipients>; Fri, 04 Mar 2011 07:12:03 -0800 (PST)
Received: by 10.204.233.15 with SMTP id jw15mr684226bkb.48.1299251523453;
        Fri, 04 Mar 2011 07:12:03 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id b16sm1621228bkw.2.2011.03.04.07.12.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 07:12:02 -0800 (PST)
Message-ID: <4D7100E8.101@mvista.com>
Date:   Fri, 04 Mar 2011 18:10:32 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH V3 06/10] MIPS: lantiq: add NOR flash support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-7-git-send-email-blogic@openwrt.org> <4D70DDEA.2050308@mvista.com>
In-Reply-To: <4D70DDEA.2050308@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

I wrote:

>> NOR flash is attached to the same EBU (External Bus Unit) as PCI. As 
>> described
>> in the PCI patch, the EBU is a little buggy, resulting in the upper 
>> and lower
>> 16 bit of the data on a 32 bit read are swapped. (essentially we have 
>> a addr^=2)

>    "Are" not needed.

>> To work around this we do a addr^=2 during the probe. Once probed we 
>> adapt
>> cfi->addr_unlock1 and cfi->addr_unlock2 to represent the endianess bug.

>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
>> Cc: David Woodhouse<dwmw2@infradead.org>
>> Cc: Daniel Schwierzeck<daniel.schwierzeck@googlemail.com>
>> Cc: linux-mips@linux-mips.org
>> Cc: linux-mtd@lists.infradead.org
> [...]

>> diff --git a/drivers/mtd/maps/lantiq.c b/drivers/mtd/maps/lantiq.c
>> new file mode 100644
>> index 0000000..674be0a
>> --- /dev/null
>> +++ b/drivers/mtd/maps/lantiq.c
>> @@ -0,0 +1,190 @@
[...]
>> +void
>> +ltq_copy_from(struct map_info *map, void *to,
>  > +    unsigned long from, ssize_t len)

>    Shouldn't it be static?

>> +{
>> +    unsigned char *p;
>> +    unsigned char *to_8;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&ebu_lock, flags);
>> +    from = (unsigned long) (map->virt + from);

>    Why not:

>     from += (unsigned long) map->virt;

> like you do in ltq_copy_to()?

>> +    p = (unsigned char *) from;

>    Could be done in initializer, like in ltq_copy_to().

>> +    to_8 = (unsigned char *) to;
>> +    while (len--)
>> +        *to_8++ = *p++;

>    BTW, you could use memcpy_fromio().

    Actually not, as on MIPS it's implemented via memcpy(). On ARM it doesn 
byte-by-byte copying -- that's why I remembered about it...

WBR, Sergei
