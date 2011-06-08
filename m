Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 02:06:20 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:32920 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab1FHAGR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 02:06:17 +0200
Received: by qwi2 with SMTP id 2so8941qwi.36
        for <linux-mips@linux-mips.org>; Tue, 07 Jun 2011 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K+Z40NT6khlEY56HN+YhQYngCQXk2G3BTYBEW4PB1ss=;
        b=THxuYTE3GBQleFI2pZPgegGtkkp0vBvlwtYisUKSCzc/+rmJoh0nCY2p4rBpRY9Uvy
         D1d02rzqFtJTLhqEztxKI3CqPVKhOVmhVSOtobXomKkFkKxAd/XBNVz7m7zVFgbQvmLd
         38xR+zT1hgj1sXqdGo3haNR3Agqr0qGwR2pzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CQHF0TQBzPanR3RyPoCzYAMnUhQp8e47waZQwnLyo0HkJEFGkVFWwTtmBpgdFAuXxU
         w74AcVbOlorljQvCkSwWWXzHHUs0c3c9YanNvEFCLxSlSZC33GoUueN9vVgYmPAvU/M/
         MjgAKJ+XolDj+MiLTicC74rHCL/DDCbSOyBHA=
MIME-Version: 1.0
Received: by 10.229.142.11 with SMTP id o11mr5001194qcu.46.1307491571634; Tue,
 07 Jun 2011 17:06:11 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Tue, 7 Jun 2011 17:06:11 -0700 (PDT)
In-Reply-To: <4DEE9BCD.1030304@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <201106061503.14852.arnd@arndb.de>
        <4DED48EA.7070001@hauke-m.de>
        <201106062353.40470.arnd@arndb.de>
        <4DEDF98C.6020905@broadcom.com>
        <4DEE9BCD.1030304@hauke-m.de>
Date:   Wed, 8 Jun 2011 02:06:11 +0200
Message-ID: <BANLkTikUqj-R72XaOXnifhKv-n1ZSJMxDQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Arend van Spriel <arend@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        George Kashperko <george@znau.edu.ua>,
        Greg KH <greg@kroah.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6317

2011/6/7 Hauke Mehrtens <hauke@hauke-m.de>:
> On 06/07/2011 12:12 PM, Arend van Spriel wrote:
>> On 06/06/2011 11:53 PM, Arnd Bergmann wrote:
>>> On Monday 06 June 2011 23:38:50 Hauke Mehrtens wrote:
>>>> Accessing chip common should be possible without scanning the hole bus
>>>> as it is at the first position and initializing most things just needs
>>>> chip common. For initializing the interrupts scanning is needed as we do
>>>> not know where the mips core is located.
>>>>
>>>> As we can not use kalloc on early boot we could use a function which
>>>> uses kalloc under normal conditions and when on early boot the
>>>> architecture code which starts the bcma code should also provide a
>>>> function which returns a pointer to some memory in its text segment to
>>>> use. We need space for 16 cores in the architecture code.
>>>>
>>>> In addition bcma_bus_register(struct bcma_bus *bus) has to be divided
>>>> into two parts. The first part will scan the bus and initialize chip
>>>> common and mips core. The second part will initialize pci core and
>>>> register the devices in the system. When using this under normal
>>>> conditions they will be called directly after each other.
>>> Just split out the minimal low-level function from the bcma_bus_scan
>>> then, to locate a single device based on some identifier. The
>>> bcma_bus_scan() function can then repeatedly allocate one device
>>> and pass it to the low-level function when doing the proper scan,
>>> while the arch code calls the low-level function directly with static
>>> data.
>>
>> If going for this we should pass struct bcma_device_id as match
>> parameter as that identifies the core appropriately although you
>> probably only want to match manufacturer and core identifiers.
>>
>> Gr. AvS
>>
>
> What is the problem with scanning the full bus?

Because full scanning needs one of the following:
1) Working alloc - not possible for SoCs
2) Hacks with wrappers, static cores info, lack of optimization (list)


> A special scan function would just skip the wrong cores so I do not see
> any advantage in that.
>
> We could build a scan function which searches for one core and uses a
> struct bcma_core stored on the stack and returns the struct bcma_core if
> it found the wanted one.

Yeah, this should be quite easy.

struct bcma_device core = bcma_early_find_core(bus, CC);
bcma_cc_init(core);


> Then we could search for chipcommon and mips
> and store then in arch code in arch/mips/bcm47xx and use them.

Not sure about this one. You have drivers for chipcommon and mips as
part of bcma. Do you need to involve arch/mips/bcm47xx to this?


> When boot
> is ready and we are searching the complete bus there is probably
> something differences in the init process from normal init as we already
> initialized chipcommon sometime earlier.

Nothing hard to handle.


> I Would prefer to scan the bus
> completely and initialize chipcommon and mips in early boot.

Really, I've nothing against scanning and splitting init into "early"
and "late". It's going back to static fields and wrappers that I don't
like :(

-- 
Rafał
