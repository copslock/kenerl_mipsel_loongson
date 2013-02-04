Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Feb 2013 14:14:51 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:56526 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817032Ab3BDNOtvFFQ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Feb 2013 14:14:49 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tZt8X6F7sFPU; Mon,  4 Feb 2013 14:14:46 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CD32C2840E6;
        Mon,  4 Feb 2013 14:14:45 +0100 (CET)
Message-ID: <510FB449.2040806@openwrt.org>
Date:   Mon, 04 Feb 2013 14:14:49 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 3/4] MIPS: pci-ar724x: remove static PCI IO/MEM resources
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org> <1359889185-15779-1-git-send-email-juhosg@openwrt.org> <510E479C.4020305@mvista.com> <510E58B5.9060107@openwrt.org> <510FA5E3.4010403@mvista.com>
In-Reply-To: <510FA5E3.4010403@mvista.com>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.02.04. 13:13 keltezéssel, Sergei Shtylyov írta:
> Hello.
> 
> On 03-02-2013 16:31, Gabor Juhos wrote:
> 
>>>> @@ -160,6 +163,16 @@ ath79_register_pci_ar724x(int id,
>>>>        res[2].start = irq;
>>>>        res[2].end = irq;
>>>>
>>>> +    res[3].name = "mem_base";
>>>> +    res[3].flags = IORESOURCE_MEM;
>>>> +    res[3].start = mem_base;
>>>> +    res[3].end = mem_base + mem_size - 1;
>>>> +
>>>> +    res[4].name = "io_base";
>>>> +    res[4].flags = IORESOURCE_IO;
>>>> +    res[4].start = io_base;
>>>> +    res[4].end = io_base;
>>>
>>>     One I/O port, hm? What is it good for?
> 
>> Strictly speaking it is not good for anything. This is a PCIe controller and it
>> does not support IO requests at all.
> 
>    Is this the case with every PCIe controller or only this particular one?

It is a limitation of this controller.

> 
>> However the whole PCI code assumes that
>> each PCI controller have an IO resource and uses the hose->io_resource pointer
>> unconditionally.
> 
>> Additionally, this matches with the removed static resource:
> 
>>> -static struct resource ar724x_io_resource = {
>>> -    .name   = "PCI IO space",
>>> -    .start  = 0,
>>> -    .end    = 0,
>>> -    .flags  = IORESOURCE_IO,
>>> -};
>>> -
> 
>    Since you seems to always pass 0, maybe you don't need 'io_base' parameter to
> the function above?

The AR724x SoCs SoCs have one PCIe controller only. However newer chips have
more than one PCIe controllers, and each of those controllers needs a different
io_base value to avoid resource conflicts. I'm preparing patches for newer SoCs
and if everything goes well I will send those today.

-GAbor
