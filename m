Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 07:22:19 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4536 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816671Ab3IYFWQTccSr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 07:22:16 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 24 Sep 2013 22:15:30 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 24 Sep 2013 22:21:58 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 24 Sep 2013 22:21:58 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 6108F246A4; Tue, 24
 Sep 2013 22:21:57 -0700 (PDT)
Date:   Wed, 25 Sep 2013 10:56:35 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Hauke Mehrtens" <hauke@hauke-m.de>
cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130925052634.GH24359@jayachandranc.netlogicmicro.com>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
 <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
 <524208F7.5060503@hauke-m.de>
MIME-Version: 1.0
In-Reply-To: <524208F7.5060503@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7E5CAEF81R094377295-01-01
Content-Type: multipart/mixed;
 boundary=C7zPtVaVf+AK4Oqc
Content-Disposition: inline
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, Sep 24, 2013 at 11:49:43PM +0200, Hauke Mehrtens wrote:
> On 08/11/2013 01:40 PM, Jayachandran C wrote:
> > Allow usage of scratch register for current pgd even when
> > MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
> > for 64r2 platforms to indicate availability of Xcontext for saving
> > cpuid, thus freeing Context to be used for saving PGD. This option
> > was also tied to using a scratch register for storing PGD.
> > 
> > This commit will allow usage of scratch register to store the current
> > pgd if one can be allocated for the platform, even when
> > MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
> > Context register in this case.
> > 
> > The code to store the current pgd for the TLB miss handler is now
> > generated in all cases. When scratch register is available, the PGD
> > is also stored in the scratch register.
> > 
> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> 
> This patch breaks booting for me on bcm47xx. I found this commit by
> bisecting and then reverted it and it made bcm47xx boot again. The boot
> process stops after: [    0.000000] Inode-cache hash table entries: 4096
> (order: 2, 16384 bytes)
> 
> The next message would be: [    0.000000] Writing ErrCtl register=00000000
> 
> This issue was seen on bcm4716.
> 
> This is the boot log:
> 
> CFE> boot -tftp -elf
> 192.168.1.195:/brcm47xx/openwrt-brcm47xx-vmlinux-initramfs.elf
> Loader:elf Filesys:tftp Dev:eth0
> File:192.168.1.195:/brcm47xx/openwrt-brcm47xx-vmlinux-initramfs.elf
> Options:(null)
> Loading: 0x80001000/4593328 0x804626b0/279760 Entry at 0x80264800
> Closing network.
> Starting program at 0x80264800
> [    0.000000] Linux version 3.12.0-rc1+ (hauke@hauke-desktop) (gcc
> version 4.6.4 (OpenWrt/Linaro GCC 4.6-2013.05 r37948) ) #151 Tue Sep 24
> 23:35:35 CEST 2013
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU revision is: 00019740 (MIPS 74Kc)
> [    0.000000] bcm47xx: using bcma bus
> [    0.000000] bcma: bus0: Found chip with id 0x4716, rev 0x01 and
> package 0x0A
> [    0.000000] bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id
> 0x800, rev 0x1F, class 0x0)
> [    0.000000] bcma: bus0: Core 3 found: MIPS 74K (manuf 0x4A7, id
> 0x82C, rev 0x01, class 0x0)
> [    0.000000] bcma: bus0: Found M25P64 serial flash (size: 8192KiB,
> blocksize: 0x10000, blocks: 128)
> [    0.000000] bcma: bus0: Early bus registered
> [    0.000000] MIPS: machine is Netgear WNDR3400 V1
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 04000000 @ 00000000 (usable)
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x00000000-0x03ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00000000-0x03ffffff]
> [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32
> bytes.
> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases,
> linesize 32 bytes
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 16256
> [    0.000000] Kernel command line:  noinitrd console=ttyS0,115200
> [    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
> [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)

Can you please try the attached patch? This patch was made for a slightly
older tlbex.c, and seems to have missed this.

Thanks,
JC.

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: attachment;
 filename=flush-fix.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 73d17f4..fffa7fe 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2180,10 +2180,8 @@ static void flush_tlb_handlers(void)
 			   (unsigned long)handle_tlbs_end);
 	local_flush_icache_range((unsigned long)handle_tlbm,
 			   (unsigned long)handle_tlbm_end);
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd,
 			   (unsigned long)tlbmiss_handler_setup_pgd_end);
-#endif
 }
 
 void build_tlb_refill_handler(void)

--C7zPtVaVf+AK4Oqc--
