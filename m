Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2013 10:57:29 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:60599 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822664Ab3AHHO1fUp7q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2013 08:14:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3396B258B42;
        Tue,  8 Jan 2013 08:14:22 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HCzsSkAV0056; Tue,  8 Jan 2013 08:14:22 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 8C758258B3B;
        Tue,  8 Jan 2013 08:14:21 +0100 (CET)
Message-ID: <50EBC74C.6070602@openwrt.org>
Date:   Tue, 08 Jan 2013 08:14:20 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        John Crispin <blogic@openwrt.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dezhong Diao <dediao@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        u-boot@lists.denx.de
Subject: Proposal for an interface to pass a DT to the kernel on MIPS
X-Enigmail-Version: 1.4.6
Content-Type: multipart/mixed;
 boundary="------------090002030000070605090100"
X-Antivirus: avast! (VPS 130107-1, 2013.01.07), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35392
X-Approved-By: ralf@linux-mips.org
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

This is a multi-part message in MIME format.
--------------090002030000070605090100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the duplicated post. The first version did not go through to the
e-mail addresses at the linux-mips.org domain due to problems with the SMTP server.

---

Hi Everyone!

I'm working on adding device tree support for the ath79 platform. I have
experimental patches for several things already however my main problem
currently is how the DT should be passed to the kernel.

There were a thread [1] about that on the lmo list in 2011 already, but there
were no clear statements about the correct method. I'm using a simple approach
during my tests to resolve this problem.

The bootloader puts a magic value to the 'a0' register and the address of the
FDT blob is stored in the 'a1' register. I have created the attached patch for
U-Boot and that that implements this method. It is against the 'testing' branch
of the MIPS U-Boot Custodian Tree [2].

I would like to hear others' opinion about it, before I would invest too much
time into an unusable solution. :)

Regards,
Gabor

1. http://www.linux-mips.org/archives/linux-mips/2011-06/msg00059.html
2. git://git.denx.de/u-boot-mips.git
3. bootlog with the patched U-Boot:

> U-Boot> setenv bootargs 'console=ttyATH0,115200 init=/etc/preinit'
> U-Boot> setenv serverip 192.168.1.254; setenv ipaddr 192.168.1.1
> U-Boot> tftp 0xa0800000 tl-wr703n.dtb
> dup 1 speed 100
> Using eth0 device
> TFTP from server 192.168.1.254; our IP address is 192.168.1.1
> Filename 'tl-wr703n.dtb'.
> Load address: 0xa0800000
> Loading: #
> done
> Bytes transferred = 1957 (7a5 hex)
> U-Boot> tftp 0xa0900000 openwrt-ath79-uImage-initramfs-lzma.bin
> Using eth0 device
> TFTP from server 192.168.1.254; our IP address is 192.168.1.1
> Filename 'openwrt-ath79-uImage-initramfs-lzma.bin'.
> Load address: 0xa0900000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ###########################################################
> done
> Bytes transferred = 2627551 (2817df hex)
> U-Boot> bootm 0xa0900000 - 0xa0800000
> ## Booting kernel from Legacy Image at a0900000 ...
>    Image Name:   MIPS OpenWrt Linux-3.8-rc2
>    Created:      2013-01-07  19:54:05 UTC
>    Image Type:   MIPS Linux Kernel Image (lzma compressed)
>    Data Size:    2627487 Bytes = 2.5 MiB
>    Load Address: 80060000
>    Entry Point:  80060000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at a0800000
>    Booting using the fdt blob at 0xa0800000
>    Uncompressing Kernel Image ... OK
>    Loading Device Tree to 81f72000, end 81f757a4 ... OK
> 
> Starting kernel ...
> 
> Linux version 3.8.0-rc2 (juhosg@mag2) (gcc version 4.6.4 20121106 (prerelease) (Linaro GCC 4.6-2012.11) ) #456 Mon Jan 7 20:53:57 CET 2013
> ath79: using Device Tree passed by bootloader
> bootconsole [early0] enabled
> CPU revision is: 00019374 (MIPS 24Kc)
> SoC: Atheros AR9330 rev 1
> Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:25.000MHz
> Determined physical RAM map:
>  memory: 02000000 @ 80000000 (usable)
>  memory: 02000000 @ 00000000 (usable)
> Initrd not found or empty - disabling initrd
> Zone ranges:
>   Normal   [mem 0x00000000-0x1fffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x00000000-0x01ffffff]
> Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
> Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
> Kernel command line: console=ttyATH0,115200 init=/etc/preinit rootfstype=squashfs,yaffs,jffs2 noinitrd
> PID hash table entries: 128 (order: -3, 512 bytes)
> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> __ex_table already sorted, skipping sort
> Writing ErrCtl register=00000000
> Readback ErrCtl register=00000000
> Memory: 26784k/32768k available (2682k kernel code, 5984k reserved, 822k data, 1548k init, 0k highmem)
> SLUB: Genslabs=9, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:51
> Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> ATH79: using Flattened Device Tree
> bio: create slab <bio-0> at 0
> cfg80211: Calling CRDA to update world regulatory domain
> Switching to clocksource MIPS
> NET: Registered protocol family 2
> TCP established hash table entries: 512 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 512 bind 512)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> jffs2: version 2.2. (NAND) (SUMMARY)  Â© 2001-2006 Red Hat, Inc.
> msgmni has been set to 52
> io scheduler noop registered
> io scheduler deadline registered (default)
> Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> 18020000.uart: ttyATH0 at MMIO 0x18020000 (irq = 11) is a AR933X UART
> console [ttyATH0] enabled, bootconsole disabled
> console [ttyATH0] enabled, bootconsole disabled
> ieee80211 phy0: Atheros AR9330 Rev:0 mem=0xb8100000, irq=2
> TCP: cubic registered
> NET: Registered protocol family 17
> 8021q: 802.1Q VLAN Support v1.8
> Freeing unused kernel memory: 1548k freed
> input: buttons.3 as /devices/buttons.3/input/input0
> - preinit -
> Press the [f] key and hit [enter] to enter failsafe mode
> - regular preinit -
> - init -
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PPP generic driver version 2.4.2
> ip_tables: (C) 2000-2006 Netfilter Core Team
> NET: Registered protocol family 24
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> nf_conntrack version 0.5.0 (442 buckets, 1768 max)
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver ums-alauda
> usbcore: registered new interface driver ums-cypress
> usbcore: registered new interface driver ums-datafab
> usbcore: registered new interface driver ums-freecom
> usbcore: registered new interface driver ums-isd200
> usbcore: registered new interface driver ums-jumpshot
> usbcore: registered new interface driver ums-karma
> usbcore: registered new interface driver ums-sddr09
> usbcore: registered new interface driver ums-sddr55
> usbcore: registered new interface driver ums-usbat
> 
> Please press Enter to activate this console.
> 
> 
> BusyBox v1.19.4 (2013-01-06 20:43:13 CET) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
> 
>   _______                     ________        __
>  |       |.-----.-----.-----.|  |  |  |.----.|  |_
>  |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
>  |_______||   __|_____|__|__||________||__|  |____|
>           |__| W I R E L E S S   F R E E D O M
>  -----------------------------------------------------
>  BARRIER BREAKER (Bleeding Edge, r35026)
>  -----------------------------------------------------
>   * 1/2 oz Galliano         Pour all ingredients into
>   * 4 oz cold Coffee        an irish coffee mug filled
>   * 1 1/2 oz Dark Rum       with crushed ice. Stir.
>   * 2 tsp. Creme de Cacao
>  -----------------------------------------------------
> root@OpenWrt:/#



--------------090002030000070605090100
Content-Type: text/x-patch;
 name="0001-MIPS-bootm.c-add-support-for-passing-device-tree-to-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-bootm.c-add-support-for-passing-device-tree-to-.pa";
 filename*1="tch"

>From 40fd1ec80a4396faf85013c66004f8d95ed3c554 Mon Sep 17 00:00:00 2001
From: Gabor Juhos <juhosg@openwrt.org>
Date: Thu, 3 Jan 2013 21:19:11 +0100
Subject: [PATCH] MIPS: bootm.c: add support for passing device-tree to Linux

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/include/asm/config.h |    1 +
 arch/mips/lib/bootm.c          |  121 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/config.h b/arch/mips/include/asm/config.h
index 02fbfb3..82c4148 100644
--- a/arch/mips/include/asm/config.h
+++ b/arch/mips/include/asm/config.h
@@ -22,5 +22,6 @@
 #define _ASM_CONFIG_H_
 
 #define CONFIG_NEEDS_MANUAL_RELOC
+#define CONFIG_LMB
 
 #endif
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index a36154a..e57066c 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -27,6 +27,9 @@
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
 #include <asm/addrspace.h>
+#include <fdt.h>
+#include <libfdt.h>
+#include <fdt_support.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -43,7 +46,36 @@ static int linux_env_idx;
 static void linux_params_init(ulong start, char *commandline);
 static void linux_env_set(char *env_name, char *env_val);
 
-static void boot_prep_linux(bootm_headers_t *images)
+static ulong arch_get_sp(void)
+{
+	ulong ret;
+
+	asm("move %0, $sp" : "=r"(ret) : );
+	return ret;
+}
+
+void arch_lmb_reserve(struct lmb *lmb)
+{
+	ulong sp;
+
+	/*
+	 * Booting a (Linux) kernel image
+	 *
+	 * Allocate space for command line and board info - the
+	 * address should be as high as possible within the reach of
+	 * the kernel (see CONFIG_SYS_BOOTMAPSZ settings), but in unused
+	 * memory, which means far enough below the current stack
+	 * pointer.
+	 */
+	sp = arch_get_sp();
+	debug("## Current stack ends at 0x%08lx\n", sp);
+
+	/* adjust sp by 4K to be safe */
+	sp -= 4096;
+	lmb_reserve(lmb, sp, CONFIG_SYS_SDRAM_BASE + gd->ram_size - sp);
+}
+
+static void boot_prep_linux_legacy(bootm_headers_t *images)
 {
 	char *commandline = getenv("bootargs");
 	char env_buf[12];
@@ -83,9 +115,90 @@ static void boot_prep_linux(bootm_headers_t *images)
 		linux_env_set("eth1addr", cp);
 }
 
+#ifdef CONFIG_OF_LIBFDT
+static int boot_get_ft_len(bootm_headers_t *images)
+{
+	return images->ft_len;
+}
+
+static char *boot_get_ft_addr(bootm_headers_t *images)
+{
+	return images->ft_addr;
+}
+
+static int create_fdt(bootm_headers_t *images)
+{
+	ulong of_size = images->ft_len;
+	char **of_flat_tree = &images->ft_addr;
+	ulong *initrd_start = &images->initrd_start;
+	ulong *initrd_end = &images->initrd_end;
+	struct lmb *lmb = &images->lmb;
+	ulong rd_len;
+	int ret;
+
+	boot_fdt_add_mem_rsv_regions(lmb, *of_flat_tree);
+
+	ret = boot_relocate_fdt(lmb, of_flat_tree, &of_size);
+	if (ret)
+		return ret;
+
+	fdt_chosen(*of_flat_tree, 1);
+	fdt_fixup_memory(*of_flat_tree, CONFIG_SYS_SDRAM_BASE, gd->ram_size);
+	fdt_fixup_ethernet(*of_flat_tree);
+	fdt_initrd(*of_flat_tree, *initrd_start, *initrd_end, 1);
+
+#ifdef CONFIG_OF_BOARD_SETUP
+	ft_board_setup(*of_flat_tree, gd->bd);
+#endif
+
+	return 0;
+}
+
+static int boot_prep_linux_fdt(bootm_headers_t *images)
+{
+	if (!images->ft_len)
+		return -1;
+
+	debug("using: FDT\n");
+	if (create_fdt(images)) {
+		printf("FDT creation failed! hanging...");
+		hang();
+	}
+
+	return 0;
+}
+#else
+static inline int boot_get_ft_len(bootm_headers_t *images)
+{
+	return 0;
+}
+
+static inline char **boot_get_ft_addr(bootm_headers_t *images)
+{
+	return 0;
+}
+
+static inline int boot_prep_linux_fdt(bootm_headers_t *images)
+{
+	return -1;
+}
+#endif /* CONFIG_OF_LIBFDT */
+
+static void boot_prep_linux(bootm_headers_t *images)
+{
+	int ret;
+
+	ret = boot_prep_linux_fdt(images);
+	if (!ret)
+		return;
+
+	boot_prep_linux_legacy(images);
+}
+
 static void boot_jump_linux(bootm_headers_t *images)
 {
 	void (*theKernel) (int, char **, char **, int *);
+	ulong ft_len;
 
 	/* find kernel entry point */
 	theKernel = (void (*)(int, char **, char **, int *))images->ep;
@@ -98,7 +211,11 @@ static void boot_jump_linux(bootm_headers_t *images)
 	/* we assume that the kernel is in place */
 	printf("\nStarting kernel ...\n\n");
 
-	theKernel(linux_argc, linux_argv, linux_env, 0);
+	ft_len = boot_get_ft_len(images);
+	if (ft_len)
+		theKernel(FDT_MAGIC, boot_get_ft_addr(images), NULL, 0);
+	else
+		theKernel(linux_argc, linux_argv, linux_env, 0);
 }
 
 int do_bootm_linux(int flag, int argc, char * const argv[],
-- 
1.7.10



--------------090002030000070605090100--
