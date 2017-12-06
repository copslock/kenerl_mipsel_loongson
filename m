Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 11:37:05 +0100 (CET)
Received: from mail-lf0-x231.google.com ([IPv6:2a00:1450:4010:c07::231]:46687
        "EHLO mail-lf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990416AbdLFKg4YjfMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 11:36:56 +0100
Received: by mail-lf0-x231.google.com with SMTP id r143so3662977lfe.13
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2017 02:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=68xVrIOz2zMVE78YiUrcg5FyD5yWPNJ8SrNRJV1zZgs=;
        b=LQvuutVW15r3iZs6SMI2YetUi1lZjx546XfMNWVDQabceLqU05qYTXQzMl5eMbdlHH
         CxWq7hWz4g2fh32H3cuBN9iM3bFKaz+WRbSceAVRtCMCuMMaySDumsWsr8TsmPVqjcu/
         uN9wiYQ2bubbINftnPXNArN7mbMEO63kHAvqOQUqBvOh9Cs3Vy3Uv/Fx2l1oW+VzVrq9
         iHpXrUZ3vOtU50DpaVbMr5eiILQg/X3aFOPnQD24va2FdwK0KiiQD5LfuRUkRcVmraRC
         RKvS5znDxsCY1EJ3guIEJUfmRHo3ttrxJL1bVlobyI/P9KY1JKSP0gGUjliLeDcLPf3k
         MvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=68xVrIOz2zMVE78YiUrcg5FyD5yWPNJ8SrNRJV1zZgs=;
        b=Fus/A4H2cM9Sn44yqldZ1uimGdk9iIlTdPcVm3Jmh7mAfovTB6+JtYLT0CKtJM1klG
         kikUOr6ZndgH8sR0S26dX+Dv4QRx4SigSNizbXs5B8Bbi4CPxJ86LO6VxVC60fpui7q/
         MVHNFHFmkHeQmOfQ7IcdGRj343JRvsOQWGm6tfRbv5TJ+X+RyEZeKmgeFvmRAtvdONww
         4sEZ4KE093avEMEIMPlzbnhguQKwaRGMx7AVtvHOodIzZwFfpCcVka8/WxxiIkX4gAj0
         2fYFMKS3t6jG0GIj90S/76NW1fAMcdFE+3lbxtxvQbhry/g4fBDJEMZ6F9w1GbYGxKzU
         3M6A==
X-Gm-Message-State: AJaThX7K1T492GcflohxejVaRTqwOINE+6/JsSnzdrQv9UkP8AAztSH1
        iDP6LrKGlq8xaQWZZM9Ua64=
X-Google-Smtp-Source: AGs4zMbZ88MX+uc/PbvkD+0RDDjlSdJfvRTHn2/6CJS9QrB/DVv5s23dydNRWUObf8mZLwnTC798Ug==
X-Received: by 10.25.196.77 with SMTP id u74mr10590620lff.72.1512556610076;
        Wed, 06 Dec 2017 02:36:50 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id g15sm445860lfj.21.2017.12.06.02.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 02:36:48 -0800 (PST)
From:   Yuri Frolov <crashing.kernel@gmail.com>
Subject: [P5600 && EVA memory caching question] PCI region
To:     linux-mips@linux-mips.org
Cc:     James Hogan <james.hogan@imgtec.com>, paul.burton@imgtec.com
Message-ID: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
Date:   Wed, 6 Dec 2017 13:36:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61318
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

Hi,

I'm trying to expand PCI mapped region using EVA addressing scheme for 
'Baikal' P5600-based family of boards.

Currently, we've got only one PCIe mapped region, 0x08000000 - 
0x1BDBFFFF (~330Mb).

This window is unsufficient for some PCIe cards, so I'm trying to expand 
(or add one more) PCIe mapped region by moving 'Hi Memory DRAM block' 
from 0x20000000 to 0x40000000 (dts changed, BAIKAL_HIGHMEM_START and 
HIGHMEM_START are changed in 
arch/mips/include/asm/mach-baikal/hardware.h 
/arch/mips/include/asm/mach-baikal/spaces.h respectively) and and 
allocating this region for PCIe.

So far, PCI subsystem is initialized during the boot successfully (as 
far as I can see):

dw_pcie_init: DEV_ID_VEND_ID=0x80601d39 CLASS_CODE_REV_ID=0x1
dw_pcie_init: PCIe error code = 0x0
dw_pcie_init: PCIe link speed GEN1
device: 'pci0000:01': device_add
PM: Adding info for No Bus:pci0000:01
device: '0000:01': device_add
PM: Adding info for No Bus:0000:01
PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [mem 0x20000000-0x37ffffff]
pci_bus 0000:01: root bus resource [io  0x18020000-0x1bdaffff]
pci_bus 0000:01: root bus resource [bus 01-ff]
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
pci 0000:01:00.0: calling quirk_f0_vpd_link+0x0/0x98
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x0007ffff]
pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold

pci 0000:01:00.0: PME# disabled
device: '0000:01:00.0': device_add
bus: 'pci': add device 0000:01:00.0
PM: Adding info for pci:0000:01:00.0
pci_bus 0000:01: fixups for bus
pci_bus 0000:01: bus scan returning with max=01
pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
pci 0000:01:00.0: BAR 2: assigned [io  0x18020000-0x1802001f]
pci 0000:01:00.0: calling quirk_e100_interrupt+0x0/0x20c
pci 0000:01:00.0: calling baikal_t1_pcie_link_speed_fixup+0x0/0x228
pci 0000:01:00.0: Link Capability is GEN1, x1

but PCIe networking card (e1000e) driver fails to load:

bus: 'pci': driver_probe_device: matched device 0000:01:00.0 with driver 
e1000e
bus: 'pci': really_probe: probing driver e1000e with device 0000:01:00.0
devices_kset: Moving 0000:01:00.0 to end of list
PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
e1000e 0000:01:00.0: enabling bus mastering
e1000_probe:7054 mmio_start 0x200c0000 mmio_len 0x20000

e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic 
conservative mode

PCI MSI: setup hwirq:0  virq:51
PCI MSI: setup hwirq:1  virq:52
PCI MSI: setup hwirq:2  virq:53

e1000_get_phy_id_82571:444 ret_val = e1e_rphy(hw, MII_PHYSID1, &phy_id); 
ret_val = -2

It turns out, that PHY ID can't be read from the memory, mapped on 
driver initialization function by ioremap.

  __ioremap (arch/mips/mm/ioremap.c) considers all the memory above the 
low 512Mb as DRAM and maps the physical addresses 0x20000000 - 
0x3FFFFFFF to logical addresses starting from c0000000 and higher.

arch/mips/include/asm/mach-baikal/kernel-entry-init.h defines EVA memory 
map with virtual addresses range 0xc0000000 - 0xdfffffff as 'MK (kseg2)' 
i.e. "mapped kernel" with cashing segment attributes defined in SegCtl0, 
Cfg1: "cacheable, coherent, write-back, write-allocate, read misses 
request shared attribute".

I've tried to change the caching attribute (bits 16:18 in SegCtl0) to 
0x2 ("uncached, not coherent"), but

this hasn't yield any visible effect on PCIe e1000e initialization.

Could the experts suggest something?..

TIA,

Yuri
