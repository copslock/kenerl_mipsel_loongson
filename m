Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 13:19:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51547 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903542Ab2EALTM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 May 2012 13:19:12 +0200
Message-ID: <4F9FC65E.6000501@openwrt.org>
Date:   Tue, 01 May 2012 13:17:50 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/14] MIPS: pci: parse memory ranges from devicetree
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-2-git-send-email-blogic@openwrt.org> <4F9EC3FD.4010109@cavium.com>
In-Reply-To: <4F9EC3FD.4010109@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 30/04/12 18:55, David Daney wrote:
>>       struct pci_ops *pci_ops;
>>       struct resource *mem_resource;
>> @@ -142,4 +148,10 @@ static inline int pci_get_legacy_ide_irq(struct
>> pci_dev *dev, int channel)
>>
>>   extern char * (*pcibios_plat_setup)(char *str);
>>
>> +#ifdef CONFIG_OF
>> +/* this function parses memory ranges from a device node */
>> +extern void __devinit pci_load_OF_ranges(struct pci_controller *hose,
>> +                     struct device_node *node);
>> +#endif
>
> Again, no #ifdef. 


Hi,

are you sure that we don't want to #ifdef this prototype ? The function
is only available when OF is selected.

Thanks,
John
