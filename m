Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 09:39:22 +0200 (CEST)
Received: from h1.mediaprovider.org ([IPv6:2a03:4000:6:1021::4]:55784 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991947AbeHUHjTGzFz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 09:39:19 +0200
Received: from odin.localnet (p54B0473A.dip0.t-ipconnect.de [84.176.71.58])
        by h1.direct-netware.de (Postfix) with ESMTPA id 67CBB1008D7;
        Tue, 21 Aug 2018 09:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vplace.de; s=mail;
        t=1534837158; bh=x13k4a1x27bEXZ4ay7dWlO3hTdii/R9conodExOat9o=;
        h=From:To:Reply-To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWda8akr0/rZXIbap0IPzdlj4xTykNKZZkr68eo2al90m8BVs7tG9A97QpKqPqG5r
         fbddX0Au62P0lBYCwricP2peOtioZWT/itiPLBj7X5JfOlZWSrkduolgenyM5RntXP
         5N+uafQUd9bpY3iaAtkf4V5LaW3V7AtIW4Swsjuw=
Received: from loki.localnet (unknown [172.16.255.10])
        by odin.localnet (Postfix) with ESMTP id BA5B6D85BC5;
        Tue, 21 Aug 2018 09:39:16 +0200 (CEST)
From:   Tobias Wolf <t.wolf@vplace.de>
To:     Paul Burton <paul.burton@mips.com>
Reply-To: Tobias Wolf <dev-NTEO@vplace.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: Fix memory reservation in bootmem_init for certain non-usermem setups
Date:   Tue, 21 Aug 2018 09:39:14 +0200
Message-ID: <1625136.EXtXsaCBjZ@loki>
In-Reply-To: <20180820233111.xww5232dxbuouf4n@pburton-laptop>
References: <1983860.23LM468bU3@loki> <7994529.fS1YjVU6T6@loki> <20180820233111.xww5232dxbuouf4n@pburton-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <t.wolf@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: t.wolf@vplace.de
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

Dear Paul,

Am Dienstag, 21. August 2018, 01:31:11 CEST schrieb Paul Burton:
[...]
> 
> Could you please give an example of a typical memory layout on your
> platform, and what mem= arguments you're using? That would help a lot in
> being able to understand what's going wrong with the existing code.

Here is the boot log without the patch

[    0.000000] SoC Type: Ralink RT2880 id:2 rev:1
[...]
[    0.000000] CPU0 revision is: 0001906c (MIPS 4KEc)
[    0.000000] MIPS: machine is Belkin F5D8235 v1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 02000000 @ 08000000 (usable)
[    0.000000] Wasting 1048576 bytes for tracking 32768 unused pages
[...]
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000009ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000009ffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x0000000009ffffff]
[...]
[    0.000000] Memory: 23712K/163840K available (3334K kernel code, 162K 
rwdata, 808K rodata, 2984K init, 208K bss, 140128K reserved, 0K cma-reserved)
[...]
[    0.000000] NR_IRQS: 256
[    0.000000] Failed to request intc memory
[    0.000000] Kernel panic - not syncing: Failed to request resources for 
ralink,rt2880-sysc
[    0.000000] Rebooting in 1 seconds..
[    0.000000] Reboot failed -- System halted

... and here with ...

[    0.000000] SoC Type: Ralink RT2880 id:2 rev:1
[...]
[    0.000000] CPU0 revision is: 0001906c (MIPS 4KEc)
[    0.000000] MIPS: machine is Belkin F5D8235 v1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 02000000 @ 08000000 (usable)
[    0.000000] Wasting 1048576 bytes for tracking 32768 unused pages
[    0.000000] Initrd not found or empty - disabling initrd
[...]
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000008000000-0x0000000009ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000008000000-0x0000000009ffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000008000000-0x0000000009ffffff]
[...]
[    0.000000] Memory: 26700K/32768K available (3334K kernel code, 162K 
rwdata, 808K rodata, 1192K init, 208K bss, 6068K reserved, 0K cma-reserved)
[...]
[    0.000000] NR_IRQS: 256
[    0.000000] CPU Clock: 266MHz

The command line does not contain any custom "mem=" entries, that's why the 
patch checks "usermem". Please be aware that the platform already has a memory 
related issue I tried to fix with another patch "mm: Fix alloc_node_mem_map 
with ARCH_PFN_OFFSET calculation" [1]. So you might be right that this is not 
the root cause for both issues. I guess the patch might be useful anyway as it 
originated from the "early_parse_mem" function and memory was not reserved for 
non usermem setups anyway.

Currently I'm testing this device with an OpenWRT based image and compiled a 
vanilla kernel separately to validate that this is not triggered outside the 
mainline one.

Best regards
Tobias

[1] https://patchwork.linux-mips.org/patch/14627/
