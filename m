Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 03:16:09 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:36231
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994626AbeISBQCJc6Rn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 03:16:02 +0200
Received: by mail-it0-x244.google.com with SMTP id u13-v6so5635085iti.1;
        Tue, 18 Sep 2018 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ke7YtyelSAcMOaEHMbPE+f1MhMCuSW5d9/yYwA4nRjQ=;
        b=WrS6x1m0/1wdThRfa2zu+PNqfLGgXIlJTxOZVj2SHOX7zrIi/Bc+drXWhNdMZXK9t8
         +HiGmVEvAwap/XUo2C3KHO0liusTUjmNwuZOE1Jc+87ZoilL1gTsniEBlLs0MHIhrfFQ
         PYfvYrWg9Jk2HR5TH09odDQO01IBN4jDSQzPc3ztby9GVy0xS77ePbtoI2U7DPG1y+j5
         sNGlJaYYHkyzo4vIaB/du3U5Yu1CilyS7ClKnU4BPdhVVYg0tqBNiI8iRRjXJJiu3FW9
         jYXPuGYPIlBcAroPkXsz8sS1fpRHqfIu+Re5eboAlfEEZSEMU0CQ81ebs0G2Cr1OpgJg
         plkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ke7YtyelSAcMOaEHMbPE+f1MhMCuSW5d9/yYwA4nRjQ=;
        b=acEr4QkkWSvspWQ3OBID0/p+OrxY2PtT5HOBRP/hoj03dhyJdSNBAOA9HGOyiLjOIY
         jnjR666OkhNNC46Er3iO+KcFnBulLNdz4DaSlKdoloDVSbUp7X/htt8sh+XcCjGCZ3LT
         5oxuJT8xZRV2vMsETyNNMkXlkcrzppdu3RMOzR9uhdtoO5762ppUgbEvSWV1e6/lTQmt
         EAXZFizaXJaxaRuHpr1WfZrYFmj9Guj7udF6arIDrspwXaYpgVQft5G1i2WwvTNxlyYd
         XBp/GV0xzgETXi9FuBQ8zo/EMfRyKFa15Xe663eHRMKZBpqIRL/WwwvjHDyHEkIFgEwG
         M3Fg==
X-Gm-Message-State: APzg51CEnIsmMQCymdbghvEZMY/gBC970Hz9quuDoc7W7Ga3uKY8kw1p
        fUFM1atF8sqEWvvMoHADHDCFeWwd5/WKpQgPtDQ=
X-Google-Smtp-Source: ANB0VdZYGpYwPhIWPnnhDO/McyddXYiixf7Ah3bzfW+sgfMo0t70bcUXwDs3TqBTCIUn7keAEnA400PN+L8ohakcGlg=
X-Received: by 2002:a24:19d5:: with SMTP id b204-v6mr20621491itb.25.1537319755795;
 Tue, 18 Sep 2018 18:15:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1883:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 18:15:54
 -0700 (PDT)
In-Reply-To: <20180918231714.oibdygquyojqud45@pburton-laptop>
References: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
 <1536991273-20649-2-git-send-email-chenhc@lemote.com> <20180918231714.oibdygquyojqud45@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 19 Sep 2018 09:15:54 +0800
X-Google-Sender-Auth: rcc0MS1TXSZmauaRlgOYjKwITYw
Message-ID: <CAAhV-H6r0Zy8KXLvPm12dRqNAEVm-YBztPAGefe6V1-NGn_zXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Paul,

I will improve this patch, and could you please read my new comments
on the VDSO patch?

Thanks,
Huacai

On Wed, Sep 19, 2018 at 7:17 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Sat, Sep 15, 2018 at 02:01:13PM +0800, Huacai Chen wrote:
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/pci/ops-loongson3.c | 29 +++++++++++++++++++++--------
>>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> Please can you add a commit message, even if it's brief.
>
>> diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
>> index 9e11843..3100117 100644
>> --- a/arch/mips/pci/ops-loongson3.c
>> +++ b/arch/mips/pci/ops-loongson3.c
>> @@ -24,16 +24,29 @@ static int loongson3_pci_config_access(unsigned char access_type,
>>       int function = PCI_FUNC(devfn);
>>       int reg = where & ~3;
>>
>> -     addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
>> -     if (busnum == 0) {
>> -             if (device > 31)
>> +     if (where < 256) { /* standard config */
>
> This can be PCI_CFG_SPACE_SIZE instead of the magic 256 number, to make
> it clearer what's going on.
>
>> +             addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
>> +             if (busnum == 0) {
>> +                     if (device > 31)
>> +                             return PCIBIOS_DEVICE_NOT_FOUND;
>> +                     addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
>
> I know this is existing code, but we could clean up some unnecessary
> brackets whilst we're here:
>
>   addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | (addr & 0xffff));
>
> Actually we can go further than that - the only thing in bits 16 & above
> of addr is busnum & we already know it's zero, so we don't need to mask
> addr at all & this line can be simplified to:
>
>   addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);
>
>> +                     type = 0;
>
> Is the type variable ever used? It looks unused both in the existing
> code & after this patch - can we just remove it?
>
>> +             } else {
>> +                     addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
>> +                     type = 0x10000;
>
> Similar comments to above - we could drop some brackets & perhaps drop
> the type variable.
>
>> +             }
>> +     } else {  /* extended config */
>
> Should this be "} else if (where < PCI_CFG_SPACE_EXP_SIZE) {"?
>
>> +             struct pci_dev *rootdev;
>> +
>> +             rootdev = pci_get_domain_bus_and_slot(0, 0, 0);
>> +             if (!rootdev)
>> +                     return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +             addr = pci_resource_start(rootdev, 3);
>> +             if (!addr)
>>                       return PCIBIOS_DEVICE_NOT_FOUND;
>> -             addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
>> -             type = 0;
>>
>> -     } else {
>> -             addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
>> -             type = 0x10000;
>> +             addrp = (void *)TO_UNCAC(addr | busnum << 20 | device << 15 | function << 12 | reg);
>>       }
>>
>>       if (access_type == PCI_ACCESS_WRITE)
>> --
>> 2.7.0
>
> Thanks,
>     Paul
