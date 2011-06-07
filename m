Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 02:33:39 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:35711 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491205Ab1FGAdg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Jun 2011 02:33:36 +0200
Received: by qyk32 with SMTP id 32so1255529qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yQaVeiIQ2OTvo6a/Pvt8Kln5IyvOPhEZ9k9hvEXnHKs=;
        b=lWrNrhJXomx1ZwTdNijBGzEC9urWli0cKwtKBos8jo3Vm0W+xe9I8fdDoxWEmTFhJt
         XNsDu33vXrE3eGsBgKhlfFvjLnb16gobPo0Hdj6fIAA2JvCU0GaV/kXgO56aNf+mTC2/
         tzIgnaDAICdT+J8u1CRu59zmHHKFos5U53VJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OGzON2vDgKpMGx/B8sXjRBGUJQVXWd1WKMAv2lPItAolAz3qrpDXqCqSdAz2fxakTF
         xwPIk72ROVriY0dUL4mG6MhSg/HiNEdsij/f/CqHT1NNfyuQSDpAUSW/DZxX1LivdPru
         aq8B1k/3WMk2ElS7RZIByBJ8SkscBtaFdKTuI=
MIME-Version: 1.0
Received: by 10.229.118.69 with SMTP id u5mr4018492qcq.122.1307406808686; Mon,
 06 Jun 2011 17:33:28 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 17:33:28 -0700 (PDT)
In-Reply-To: <4DED4DEB.5030802@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
        <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
        <4DED4DEB.5030802@hauke-m.de>
Date:   Tue, 7 Jun 2011 02:33:28 +0200
Message-ID: <BANLkTikATEB7zoDPBcc4Ubh7ONyHXWBW+w@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5109

W dniu 7 czerwca 2011 00:00 użytkownik Hauke Mehrtens
<hauke@hauke-m.de> napisał:
> On 06/06/2011 12:22 PM, Rafał Miłecki wrote:
>>> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
>>> +               iounmap(bus->mmio);
>>> +               mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>>> +               if (!mmio)
>>> +                       return -ENOMEM;
>>> +               bus->mmio = mmio;
>>> +
>>> +               mmio = ioremap(BCMA_WRAP_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>>> +               if (!mmio)
>>> +                       return -ENOMEM;
>>> +               bus->host_embedded = mmio;
>>
>> Do we really need both? mmio and host_embedded? What about keeping
>> mmio only and using it in calculation for read/write[8,16,32]?
>
> These are two different memory regions, it should be possible to
> calculate the other address, but I do not like that. As host_embedded is
> in a union this does not waste any memory.

Ah, OK, I can see what does happen here. You are using:
1) bus->mmio for first core
2) bus->host_embedded for first agent/wrapper

I'm not sure if this is a correct approach. Doing "core_index *
BCMA_CORE_SIZE" comes from ssb, where it was the way to calculate
offset. In case of BCMA we are reading all the info from (E)EPROM,
which also includes addresses of the cores.

IMO you should use core->addr and core->wrap for read/write ops. I
believe this is approach Broadcom decided to use for BCMA, when
designing (E)EPROM.

You should not need bus->host_embedded then, maybe you could even do
not set bus->mmio?

-- 
Rafał
