Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 16:15:18 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:56607 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904254Ab1KWPPM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 16:15:12 +0100
Received: by vbbfs19 with SMTP id fs19so1690365vbb.36
        for <multiple recipients>; Wed, 23 Nov 2011 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YDbLEhicJskVUoubtbsNIrWf9b82yTE+eDqVKVWzIMM=;
        b=jvCK/tJVFS8jL82EFEYCfz2NwH7XokdQ4RG760yXEfxWv6+AbOiag16DtDOxkz939R
         JS3UOQRic9fpQHcPemluh4Y+8W/b3Err88byqhElHnsweIsuhHs1CTwg/XOXJBrEGm5j
         bA2bnhAArqjbd04jTLe95/PmnMg1Rx9Iu93DA=
MIME-Version: 1.0
Received: by 10.182.146.72 with SMTP id ta8mr8652028obb.35.1322061306348; Wed,
 23 Nov 2011 07:15:06 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Wed, 23 Nov 2011 07:15:05 -0800 (PST)
In-Reply-To: <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
        <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com>
        <4ECCFE72.6090300@openwrt.org>
        <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com>
Date:   Wed, 23 Nov 2011 16:15:05 +0100
Message-ID: <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20009

It seems your board is a older one.
Can you remove the heatsink and post the revision from the SoC?

2011/11/23 René Bolldorf <xsecute@googlemail.com>:
> Hi
>
> 2011/11/23 Gabor Juhos <juhosg@openwrt.org>:
>> Hi René,
>>
>>> I don't know on which board you tested the patches,
>>
>> The patches were tested on an Ubiquiti Bullet 5M (AR7240), on a
>> TP-Link TL-MR3420 (AR7241), and on an Atheros PB44 (AR7161) boards.
>> You can find the bootlog of the Bullet 5M here:
>> http://pastebin.com/p3UiU29M
>>
>>> but the pci read/write function are now broken.
>>
>> Here is a snippet from the original pci_read function:
>>
>>        switch (size) {
>>        case 1:
>>                addr = where & ~3;
>>                mask = 0xff000000 >> ((where % 4) * 8);
>>                tval = reg_read(ATH724X_PCI_DEV_BASE + addr);
>>                tval = tval & ~mask;
>>                *value = (tval >> ((4 - (where % 4))*8));
>>                break;
>>
>> Say, we want to read four values from where={0,1,2,3} and with size=1.
>> Because 'addr' will be zero, we will read the same 32 bits wide register
>> in all cases, so I'm using 'tval = 0x12345678' for simplicity.
>>
>> if where == 0:
>>
>> mask = 0xff000000 >> ((0 % 4) * 8) = 0xff000000 >> (0 * 8) = 0xff000000 >> 0 = 0xff000000
>> tval = 0x12345678 & ~0xff000000 = 0x12345678 & 0x00ffffff = 0x00345678
>> *value = 0x00345678 >> ((4 - (0 % 4 )) * 8) = 0x00345678 >> ((4 - 0) * 8) = 0x00345678 >> (4 * 8) = 0x00345678 >> 32 = 0x00000000
>>
>> Because shift is 32, the CPU will do nothing with the value, so it will
>> return '0x00345678'. The value should be '0x78'.
>>
>> if where == 1:
>>
>> mask = 0xff000000 >> ((1 % 4) * 8) = 0xff000000 >> (1 * 8) = 0xff000000 >> 8 = 0x00ff0000
>> tval = 0x12345678 & ~0x00ff0000 = 0x12345678 & 0xff00ffff = 0x12005678
>> *value = 0x12005678 >> ((4 - (1 % 4 )) * 8) = 0x12005678 >> ((4 - 1) * 8) = 0x12005678 >> (3 * 8) = 0x12005678 >> 24 = 0x00000012
>>
>> The value should be '0x56' instead of '0x00000012'.
>>
>> if where = 2:
>>
>> mask = 0xff000000 >> ((2 % 4) * 8) = 0xff000000 >> (2 * 8) = 0xff000000 >> 16 = 0x0000ff00
>> tval = 0x12345678 & ~0x0000ff00 = 0x12345678 & 0xffff00ff = 0x12340078
>> *value = 0x12340078 >> ((4 - (2 % 4 )) * 8) = 0x12340078 >> ((4 - 2) * 8) = 0x12340078 >> (2 * 8) = 0x12340078 >> 16 = 0x00001234
>>
>> The value should be '0x34' instead of '0x00001234'.
>>
>> if where = 3:
>>
>> mask = 0xff000000 >> ((3 % 4) * 8) = 0xff000000 >> (3 * 8) = 0xff000000 >> 24 = 0x000000ff
>> tval = 0x12345678 & ~0x000000ff = 0x12345678 & 0xffffff00 = 0x12345600
>> *value = 0x12345600 >> ((4 - (3 % 4 )) * 8) = 0x12345600 >> ((4 - 3) * 8) = 0x12345600 >> (1 * 8) = 0x12345600 >> 8 = 0x00123456
>>
>> The value should be '0x12' instead of '0x00123456'.
>>
>> Due to this, and the other errors in the pci_write functions,
>> Linux fails to assign the correct IRQ number for the device.
>> It can be noticed from the output of 'lspci -vv':
>>
>>        Interrupt: pin A routed to IRQ 0
>> vs
>>        Interrupt: pin A routed to IRQ 48
>>
>> I can show you the errors in the write functions, if you would
>> like to see that as well.
>>
>>
>> I'm curious why do you think that it is broken now.
>> You are getting a data bus error by any chance?
>>
>
> after a pci write, the pci read return bogus values.
> However, I go through this tomorrow.
>
>>> -My patchset has the ability to use different irqs (see pci_data).
>>
>> Yes, I know. You can set that from the board setup by calling the
>> {ath,ar}724x_pci_add_data function.
>>
>> However that approach has some limitations:
>>
>> 1. It does not supports assigning a different IRQ for the different
>> interrupt pins (A,B,C,D) of a PCI device. This is not a problem on the
>> AR724X boards, but that functionality is needed by some AR71xx based
>> boards.
>>
>> 2. The devfn field of the struct pci_device is 0 on the AR724X based boards.
>> However on AR71XX they are different. On the PB44 board, the devfn of a PCI
>> device in the first miniPCI slot is 136, and it is 144 for the second slot.
>> So if I want to define the pci_data for the PB44 board, I should write
>> something like this:
>>
>> static struct ath724x_pci_data pb44_pci_data[] = {
>>        [136] = { .irq  = PCI_IRQ_A },
>>        [144] = { .irq  = PCI_IRQ_B },
>> };
>>
>> The array has 136+8 unused entries, which wastes the memory.
>>
>> 3. The {ath,ar}724x_pci_add_data function must be called from the
>> setup code of each board. If the board setup code does not calls the
>> function, the kernel will throw an oops due to a NULL pointer dereference.
>>
>>> int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
>>> {
>>>       unsigned int devfn = dev->devfn;
>>>       int irq = -1;
>>>
>>
>> If the '{ath,ar}724x_pci_add_data' function is not called, pci_data_size = 0,
>> and pci_data = NULL;
>>
>>>       if (devfn > pci_data_size - 1)
>>>               return irq;
>>
>> devfn is always >= 0, and (pci_data_size - 1) = -1 = 0xffffffff, so the
>> condition in this if statement will be evaluated to false ...
>>
>>>       irq = pci_data[devfn].irq;
>>
>> ... and this line will cause the following oops:
>>
>> CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 803c4cc8, ra == 803c4ca4
>> Oops[#1]:
>> Cpu 0
>> $ 0   : 00000000 80510000 00000000 00000000
>> $ 4   : 803b4128 00000a52 ffffffff 0000000a
>> $ 8   : 0000000a 00000000 00000001 00000000
>> $12   : 00000374 0000000f 00000001 ffffffff
>> $16   : 00000000 80510000 803c4c74 8019d838
>> $20   : 803d3fe0 00000000 00000000 00000000
>> $24   : 00000002 800617f0
>> $28   : 81c20000 81c21e50 00000000 803c4ca4
>> Hi    : 00000000
>> Lo    : 068e7780
>> epc   : 803c4cc8 pcibios_map_irq+0x54/0x6c
>>    Not tainted
>> ra    : 803c4ca4 pcibios_map_irq+0x30/0x6c
>> Status: 1000c003    KERNEL EXL IE
>> Cause : 00800008
>> BadVA : 00000000
>> PrId  : 00019374 (MIPS 24Kc)
>> Modules linked in:
>> Process swapper (pid: 1, threadinfo=81c20000, task=81c18000, tls=00000000)
>> Stack : 81c21e58 00000000 ffffffff 00000001 00000000 81c14c00 00000001 803d1840
>>        00000000 80300ce8 803d2a7c 00000000 01000000 803d2af8 81c46800 00000000
>>        803e9584 00000000 80510000 803d404c 00000000 00000000 80510000 803e9584
>>        80510000 80060930 33390000 00000000 0000a498 80143058 00000028 803b0000
>>        00000000 800bc4e4 803e92d0 803e9394 803e9584 00000000 00000000 00000000
>>        ...
>> Call Trace:
>> [<803c4cc8>] pcibios_map_irq+0x54/0x6c
>> [<803d1840>] pci_fixup_irqs+0x78/0xc4
>> [<803d404c>] pcibios_init+0x6c/0x8c
>> [<80060930>] do_one_initcall+0x3c/0x1cc
>> [<803c297c>] kernel_init+0xa4/0x138
>> [<80063c44>] kernel_thread_helper+0x10/0x18
>>
>> Code: 8c4250b4  001080c0  00508021 <8e020000> 8fbf001c  8fb10018  8fb00014  03e00008  27bd0020
>>
>>>
>>>       return irq;
>>> }
>
> Ok
>
>>> -I never hit the pci controller bug, any steps to replicate?
>>
>> Hm, weird. Your devices are based on AR7240 or or AR7241?
>>
>> Regards,
>> Gabor
>>
>
> AR7241 AH-4A
>
> Maybe it is better to split ar71xx and ar72xx pci support completly?
>
