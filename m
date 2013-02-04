Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Feb 2013 13:13:53 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:53252 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823081Ab3BDMNvm51p1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Feb 2013 13:13:51 +0100
Received: by mail-lb0-f171.google.com with SMTP id gg13so6600776lbb.16
        for <linux-mips@linux-mips.org>; Mon, 04 Feb 2013 04:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=dCwU74k/Bzwk8s3uknqA9eT7r9C+KnQ0Z2jk8mCCtCo=;
        b=k/L9hOOFLELBGqmxsS40Taol1RhiIRobbLtUR+15wUKtTyp2zjrRIatHezEodYqnp+
         nUWtRylJfVD3/NFluoY1yPJ+y5KlMFMGRh3WB1ZMji4fT9HFLkKoJDyBXn/5M/qj1201
         +fiVr+632brfyQR/a8xiBvqbEqG5zL33K8KbRYNn72TdI6uvnsa1TaVTrClA7javr/PF
         91N3NPZ840BuZPkAk/tSX+3wxmJHe2zn3OV7TONiPN1NyVmwTCRjQ6+DwNt4InkpTZOh
         NvDQztgRQMVVLDKwt6H6AzM1wIj2fC85TV6XvutzjEv4yffWUx4Ck04/pPyzzXsKuQKJ
         koCQ==
X-Received: by 10.152.133.133 with SMTP id pc5mr19008933lab.32.1359980025949;
        Mon, 04 Feb 2013 04:13:45 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-75-188.pppoe.mtu-net.ru. [91.79.75.188])
        by mx.google.com with ESMTPS id b13sm2079412lbd.10.2013.02.04.04.13.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 04:13:44 -0800 (PST)
Message-ID: <510FA5E3.4010403@mvista.com>
Date:   Mon, 04 Feb 2013 16:13:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 3/4] MIPS: pci-ar724x: remove static PCI IO/MEM resources
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org> <1359889185-15779-1-git-send-email-juhosg@openwrt.org> <510E479C.4020305@mvista.com> <510E58B5.9060107@openwrt.org>
In-Reply-To: <510E58B5.9060107@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlOoo/YIeto7338c0PqfsITOuPEduLMllVM2/L9q0KgtNXIAgwZKu/Bj6k4ZaN+1zJ/Yo4b
X-archive-position: 35699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03-02-2013 16:31, Gabor Juhos wrote:

>>> @@ -160,6 +163,16 @@ ath79_register_pci_ar724x(int id,
>>>        res[2].start = irq;
>>>        res[2].end = irq;
>>>
>>> +    res[3].name = "mem_base";
>>> +    res[3].flags = IORESOURCE_MEM;
>>> +    res[3].start = mem_base;
>>> +    res[3].end = mem_base + mem_size - 1;
>>> +
>>> +    res[4].name = "io_base";
>>> +    res[4].flags = IORESOURCE_IO;
>>> +    res[4].start = io_base;
>>> +    res[4].end = io_base;
>>
>>     One I/O port, hm? What is it good for?

> Strictly speaking it is not good for anything. This is a PCIe controller and it
> does not support IO requests at all.

    Is this the case with every PCIe controller or only this particular one?

> However the whole PCI code assumes that
> each PCI controller have an IO resource and uses the hose->io_resource pointer
> unconditionally.

> Additionally, this matches with the removed static resource:

>> -static struct resource ar724x_io_resource = {
>> -	.name   = "PCI IO space",
>> -	.start  = 0,
>> -	.end    = 0,
>> -	.flags  = IORESOURCE_IO,
>> -};
>> -

    Since you seems to always pass 0, maybe you don't need 'io_base' parameter 
to the function above?

> -Gabor

WBR, Sergei
