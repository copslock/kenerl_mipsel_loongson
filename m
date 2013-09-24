Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 23:49:57 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56567 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815989Ab3IXVty6i9HN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Sep 2013 23:49:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B84958F61;
        Tue, 24 Sep 2013 23:49:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eLJpx7UuMsbm; Tue, 24 Sep 2013 23:49:48 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:405d:6e10:9f33:b074] (unknown [IPv6:2001:470:1f0b:447:405d:6e10:9f33:b074])
        by hauke-m.de (Postfix) with ESMTPSA id 01F17857F;
        Tue, 24 Sep 2013 23:49:47 +0200 (CEST)
Message-ID: <524208F7.5060503@hauke-m.de>
Date:   Tue, 24 Sep 2013 23:49:43 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com> <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 08/11/2013 01:40 PM, Jayachandran C wrote:
> Allow usage of scratch register for current pgd even when
> MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
> for 64r2 platforms to indicate availability of Xcontext for saving
> cpuid, thus freeing Context to be used for saving PGD. This option
> was also tied to using a scratch register for storing PGD.
> 
> This commit will allow usage of scratch register to store the current
> pgd if one can be allocated for the platform, even when
> MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
> Context register in this case.
> 
> The code to store the current pgd for the TLB miss handler is now
> generated in all cases. When scratch register is available, the PGD
> is also stored in the scratch register.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

This patch breaks booting for me on bcm47xx. I found this commit by
bisecting and then reverted it and it made bcm47xx boot again. The boot
process stops after: [    0.000000] Inode-cache hash table entries: 4096
(order: 2, 16384 bytes)

The next message would be: [    0.000000] Writing ErrCtl register=00000000

This issue was seen on bcm4716.

This is the boot log:

CFE> boot -tftp -elf
192.168.1.195:/brcm47xx/openwrt-brcm47xx-vmlinux-initramfs.elf
Loader:elf Filesys:tftp Dev:eth0
File:192.168.1.195:/brcm47xx/openwrt-brcm47xx-vmlinux-initramfs.elf
Options:(null)
Loading: 0x80001000/4593328 0x804626b0/279760 Entry at 0x80264800
Closing network.
Starting program at 0x80264800
[    0.000000] Linux version 3.12.0-rc1+ (hauke@hauke-desktop) (gcc
version 4.6.4 (OpenWrt/Linaro GCC 4.6-2013.05 r37948) ) #151 Tue Sep 24
23:35:35 CEST 2013
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 00019740 (MIPS 74Kc)
[    0.000000] bcm47xx: using bcma bus
[    0.000000] bcma: bus0: Found chip with id 0x4716, rev 0x01 and
package 0x0A
[    0.000000] bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id
0x800, rev 0x1F, class 0x0)
[    0.000000] bcma: bus0: Core 3 found: MIPS 74K (manuf 0x4A7, id
0x82C, rev 0x01, class 0x0)
[    0.000000] bcma: bus0: Found M25P64 serial flash (size: 8192KiB,
blocksize: 0x10000, blocks: 128)
[    0.000000] bcma: bus0: Early bus registered
[    0.000000] MIPS: machine is Netgear WNDR3400 V1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 04000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x03ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x03ffffff]
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32
bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases,
linesize 32 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 16256
[    0.000000] Kernel command line:  noinitrd console=ttyS0,115200
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
