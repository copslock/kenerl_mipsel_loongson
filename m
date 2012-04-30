Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 19:04:11 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49073 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903715Ab2D3REH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 19:04:07 +0200
Message-ID: <4F9EC5B8.502@openwrt.org>
Date:   Mon, 30 Apr 2012 19:02:48 +0200
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
X-archive-position: 33097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,
>
> No need for the #ifdef here.
>

i will fix this globally in the patch


>> +void __devinit pci_load_OF_ranges(struct pci_controller *hose,
>> +                struct device_node *node)
>> +{
>
> s/load_OF/load_of/

ok, some other arch did _OF_ so i blindly copied it.


>> +    const __be32 *ranges;
>> +    int rlen;
>> +    int pna = of_n_addr_cells(node);
>> +    int np = pna + 5;
>> +
>> +    pr_info("PCI host bridge %s ranges:\n", node->full_name);
>> +    ranges = of_get_property(node, "ranges",&rlen);
>> +    if (ranges == NULL)
>> +        return;
>> +    hose->of_node = node;
>> +
>> +    while ((rlen -= np * 4)>= 0) {
>> +        u32 pci_space;
>> +        struct resource *res = 0;
>> +        unsigned long long addr, size;
>> +
>> +        pci_space = ranges[0];
>> +        addr = of_translate_address(node, ranges + 3);
>> +        size = of_read_number(ranges + pna + 3, 2);
>
> All of this should be able to be replaced with of_get_address();
>
> There is a bunch of of/pci related infrastructure.  Can any of it be
> leveraged?

i look at it when i made the patch 3 months ago. the pci ranges are
mapped very differently to normal reg= <addr len>;  properties. You can
find some info about this at the bottom of this link
http://devicetree.org/Device_Tree_Usage 
