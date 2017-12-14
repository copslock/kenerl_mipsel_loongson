Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2017 16:03:26 +0100 (CET)
Received: from mail-lf0-x22a.google.com ([IPv6:2a00:1450:4010:c07::22a]:39234
        "EHLO mail-lf0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdLNPDT7f0Tq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Dec 2017 16:03:19 +0100
Received: by mail-lf0-x22a.google.com with SMTP id l81so7014867lfl.6
        for <linux-mips@linux-mips.org>; Thu, 14 Dec 2017 07:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o8Gajs/bdP2fEYJq5gkhH/QSzql3qEbIbQK68z1wfdE=;
        b=OPA3I3bnZawirS0lriOI/mNHR9APQS4C6+wqUYol9Kh98TWxqjq/L7vhsmgm0ixDFX
         FnSgp3D0bbBhNSr61Cm0thaJ0yBLc+YQ0UQyqMzqHcffNiXqy8H4rTm4Qfd3DugRDdLL
         tIU2pv3zmk9kMDa5blZISugHMnXgsE8Ek631RR5QJhMimJSscmbbCc9pwjO1DgWn5Wv2
         MATUVZsDJflAH6D8KiWtVHKA8Pe1KFfqMeAfnZAQIVDxQryBdyUG7EtUjNsVkm5lQ2Dq
         SROczfyUe62eVcMrQseRjgJ+Ab6i8nYrLP4mQtMp0aZFrRJCBKdDIPlSEa8hcbaUPv9H
         McPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o8Gajs/bdP2fEYJq5gkhH/QSzql3qEbIbQK68z1wfdE=;
        b=NQYrqWLj4DaWT2RC5XDouvLApUr8xj+zmZsAOwH4VucWKWJkl3rlrNMThT/OXbqbIo
         IeKkur8m3J+1m9kxkkV9n/lXD4rnBaGjZfpFIbUAn7HHTS6HxIGzRAHf/jTWoOuQHMLo
         tsFC/VhZ5V3qX4FDKbGOBisLj0j8ZHsBj5Mm6C+vWOIQBFUqrAdGLoelR/S+N1nYMJEg
         oFcYHpYNA1YEH5dEK8fiGyj4pyiyJbNK+KTRA02Af4qK55ZPv0+9tigJDq6sU8BeXl7T
         I31wqlrbXaBUXaWgXSIhLkDyd5WUj4es7XCvfhnkmFut93yAqLO8cmswHSeUv7UM5iC2
         VmrQ==
X-Gm-Message-State: AKGB3mIewGz8h7ZyV8zoLjXEgmkMQRTqo+L83AMZ0k22b9NWFOXbyngU
        0ZhWKtFQBCDH1hXsiJhczbBWADbW
X-Google-Smtp-Source: ACJfBouq3ez4mLBY0va1V8aD94XglxLwN7dmxdpGEgoHchWgy78vBfbP+FLpHrt6pv25lfhyA2ZGdA==
X-Received: by 10.25.219.81 with SMTP id s78mr4139743lfg.61.1513263794142;
        Thu, 14 Dec 2017 07:03:14 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id t85sm826713ljb.91.2017.12.14.07.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2017 07:03:13 -0800 (PST)
Subject: Re: [P5600 && EVA memory caching question] PCI region
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
Date:   Thu, 14 Dec 2017 18:03:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171206114611.GM5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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

Hi, James.

Do I understand correctly, that in case of CONFIG_EVA=y, any logical 
address from 0x00000000 - 0xBFFFFFFF (3G) range accessed from the kernel 
space is:
1) Unmapped (no TLB translations)
2) Is mapped 1:1 to physical addresses? E.g, readl from 0x20000000 is, 
in fact a read from physical address 0x20000000? I mean, in legacy 
memory mapping scheme, logical addresses 0x80000000 - 0xBFFFFFFF in 
kernel space were being translated to the physical addresses from the 
low 512Mb (phys 0x00000000 - 0x20000000), no such bits stripping or 
something for EVA, the mapping is 1:1?

As for userspace addresses, the addresses from the 0x00000000 - 
0xBFFFFFFF range are:
1) Overlayed with the range which is directly accessible from the kernel 
space
2) These addresses are mapped in userland, so, read from logical address 
0x20000000 in userland may result in read from any physical address 
located in range 0x00000000 - 0xBFFFFFFF as defined by TLB for that 
particular userland thread?

TIA,
Yuri

On 12/06/2017 02:46 PM, James Hogan wrote:
> Hi Yuri,
>
> On Wed, Dec 06, 2017 at 01:36:48PM +0300, Yuri Frolov wrote:
>> Hi,
>>
>> I'm trying to expand PCI mapped region using EVA addressing scheme for
>> 'Baikal' P5600-based family of boards.
>>
>> Currently, we've got only one PCIe mapped region, 0x08000000 -
>> 0x1BDBFFFF (~330Mb).
>>
>> This window is unsufficient for some PCIe cards, so I'm trying to expand
>> (or add one more) PCIe mapped region by moving 'Hi Memory DRAM block'
>> from 0x20000000 to 0x40000000 (dts changed, BAIKAL_HIGHMEM_START and
>> HIGHMEM_START are changed in
>> arch/mips/include/asm/mach-baikal/hardware.h
>> /arch/mips/include/asm/mach-baikal/spaces.h respectively) and and
>> allocating this region for PCIe.
>>
>> So far, PCI subsystem is initialized during the boot successfully (as
>> far as I can see):
>>
>> dw_pcie_init: DEV_ID_VEND_ID=0x80601d39 CLASS_CODE_REV_ID=0x1
>> dw_pcie_init: PCIe error code = 0x0
>> dw_pcie_init: PCIe link speed GEN1
>> device: 'pci0000:01': device_add
>> PM: Adding info for No Bus:pci0000:01
>> device: '0000:01': device_add
>> PM: Adding info for No Bus:0000:01
>> PCI host bridge to bus 0000:01
>> pci_bus 0000:01: root bus resource [mem 0x20000000-0x37ffffff]
>> pci_bus 0000:01: root bus resource [io  0x18020000-0x1bdaffff]
>> pci_bus 0000:01: root bus resource [bus 01-ff]
>> pci_bus 0000:01: scanning bus
>> pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
>> pci 0000:01:00.0: calling quirk_f0_vpd_link+0x0/0x98
>> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
>> pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x0007ffff]
>> pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
>> pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
>> pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>
>> pci 0000:01:00.0: PME# disabled
>> device: '0000:01:00.0': device_add
>> bus: 'pci': add device 0000:01:00.0
>> PM: Adding info for pci:0000:01:00.0
>> pci_bus 0000:01: fixups for bus
>> pci_bus 0000:01: bus scan returning with max=01
>> pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
>> pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
>> pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
>> pci 0000:01:00.0: BAR 2: assigned [io  0x18020000-0x1802001f]
>> pci 0000:01:00.0: calling quirk_e100_interrupt+0x0/0x20c
>> pci 0000:01:00.0: calling baikal_t1_pcie_link_speed_fixup+0x0/0x228
>> pci 0000:01:00.0: Link Capability is GEN1, x1
>>
>> but PCIe networking card (e1000e) driver fails to load:
>>
>> bus: 'pci': driver_probe_device: matched device 0000:01:00.0 with driver
>> e1000e
>> bus: 'pci': really_probe: probing driver e1000e with device 0000:01:00.0
>> devices_kset: Moving 0000:01:00.0 to end of list
>> PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
>> e1000e 0000:01:00.0: enabling bus mastering
>> e1000_probe:7054 mmio_start 0x200c0000 mmio_len 0x20000
>>
>> e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic
>> conservative mode
>>
>> PCI MSI: setup hwirq:0  virq:51
>> PCI MSI: setup hwirq:1  virq:52
>> PCI MSI: setup hwirq:2  virq:53
>>
>> e1000_get_phy_id_82571:444 ret_val = e1e_rphy(hw, MII_PHYSID1, &phy_id);
>> ret_val = -2
>>
>> It turns out, that PHY ID can't be read from the memory, mapped on
>> driver initialization function by ioremap.
>>
>>    __ioremap (arch/mips/mm/ioremap.c) considers all the memory above the
>> low 512Mb as DRAM and maps the physical addresses 0x20000000 -
>> 0x3FFFFFFF to logical addresses starting from c0000000 and higher.
>>
>> arch/mips/include/asm/mach-baikal/kernel-entry-init.h defines EVA memory
>> map with virtual addresses range 0xc0000000 - 0xdfffffff as 'MK (kseg2)'
>> i.e. "mapped kernel" with cashing segment attributes defined in SegCtl0,
>> Cfg1: "cacheable, coherent, write-back, write-allocate, read misses
>> request shared attribute".
>>
>> I've tried to change the caching attribute (bits 16:18 in SegCtl0) to
>> 0x2 ("uncached, not coherent"), but
>>
>> this hasn't yield any visible effect on PCIe e1000e initialization.
> Mapped kernel segments don't use the CCA in SegCtl. Each page mapping
> has its own CCA specified in the TLB, which would have been loaded from
> page tables set up by e.g. remap_area_pte(), and the ioremap() macro
> does pass _CACHE_UNCACHED as the flags argument. I would recommend
> checking the phys_addr and flags coming in to remap_area_pte().
>
> If that all looks correct you could also try:
> - Dump the TLB contents straight after accessing that address to check
>    they are loaded correctly, i.e. call dump_tlb_all() from
>    <asm/tlbdebug.h>.
> - If the TLB contents look wrong, try disabling hardware page table
>    walker to determine whether that is misconfigured (add nohtw to kernel
>    command line).
>
> Hope that helps
>
> Cheers
> James
