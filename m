Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 23:07:04 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34316 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27036595AbcE0VHCdnzB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 23:07:02 +0200
Received: by mail-pa0-f68.google.com with SMTP id yl2so13671010pac.1
        for <linux-mips@linux-mips.org>; Fri, 27 May 2016 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdPrAZ5fop7C6e1bXO/dllr4k9CXM7CiVGDouvHXLFk=;
        b=he7E108iQbSRfbdTPTD3dUk2fpKRuck99DG4KYjpXDd/2QGHmdWT2VUYn6MG4W/1rM
         ZWxufdUv4xJsiuiJ6dZAPOifAtPmReOS5LfOsFGHOXS5a6LmXnd39qcijWIsfwgqQdq2
         GzR3+TidR6u0X+UXgQzGht4tZJh/72PVOzyRUFO7q326vspOL/MoeOxS7Sg06SzxIqKU
         Qb66FWLGf9r+GCkl8s0KZJ+kKs0TluOJYmWPQcUDNHaGEQGE1bpSKKyFk4cT6Mxg+VAp
         gM486SPXc7M0PwJwoX5UMYtxmO7jCfacgL+gekdcJToj04wDOM7zM+DxYvHjwQJp43zp
         /NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdPrAZ5fop7C6e1bXO/dllr4k9CXM7CiVGDouvHXLFk=;
        b=F2Gi/vq1oVCqSzf+h0cMvS+tpNjx2kMLnUwSJcQkrQEXy6PoogmYrsPgHbbmEQ6RPx
         hTFSzWaoCDDU9xMGD5uB0V5ysk0U688ZctOVyw+/1P2+3xBIiA1/G/rA3ce8EIKGcehw
         9vQXf3NOENIuUTOJNHKcFjhhMySCFRGuLn1p4veMQu1xTtIXxlGeszrJmxNfBB8+SlWY
         V72jJN9f0t+5zg2h60ajN8vE5hMTrnV/+9lu/fH/6c0Q3ug+MTrn56p//ahqB2wpMkFN
         iICbmkQ93VZbeAsBmhS6PTbpU/rHuTAiGRI+WEdJzlGVmNL+Ki5ZUneU3fAcixWUCKQl
         pdHg==
X-Gm-Message-State: ALyK8tJX7Ctmfo6xLpJ977tnRdbfWUE2A5QEFERfR6aJqMe1EUnxPHzuCfh5fSx4d+j+2w==
X-Received: by 10.66.193.199 with SMTP id hq7mr25034691pac.6.1464383216193;
        Fri, 27 May 2016 14:06:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-209-179.hsd1.ca.comcast.net. [67.160.209.179])
        by smtp.gmail.com with ESMTPSA id p65sm15843444pfd.6.2016.05.27.14.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 May 2016 14:06:55 -0700 (PDT)
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     linux-mips@linux-mips.org
Cc:     hauke@hauke-m.de, jogo@openwrt.org, openwrt@kresin.me,
        antonynpavlov@gmail.com
Subject: [PATCH v2] Re: Adding support for device tree and command line
Date:   Fri, 27 May 2016 14:06:38 -0700
Message-Id: <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Mon, 23 May 2016 22:32:10 -0700
Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Mon, 2016-05-23 at 15:12 -0700, Daniel Gimpelevich wrote:
> > On Mon, 2016-05-23 at 23:34 +0200, Hauke Mehrtens wrote:
> > > On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
> > > > Section 3 of this document defines some interfaces how a boot loader
> > > > could forward a command line *or* a device tree to the kernel:
> > > > http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
> > > > This allows only a device tree *or* a command line, not both.
> > > >
> > > > The Linux kernel also supports an appended device tree. In this case the
> > > > early code overwrites the fw_args to look like the boot loader added a
> > > > device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
> > > >
> > > > The problem is when we use an appended device tree and the boot loader
> > > > adds some important information in the kernel command line. In this case
> > > > the command line gets overwritten and we do not get this information.
> > > > This is the case for some lantiq devices were the boot loader provides
> > > > the mac address to the kernel via the kernel command line.
> > > >
> > > > My proposal to solve this problem is to extend the interface and add a
> > > > option to provide the kernel command line *and* a device tree from the
> > > > boot loader to the kernel.
> > > >
> > > > a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
> > > > and fw_arg3 ($a3) with argv and envp.
> > > >
> > > > b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
> > > > and $a3 = envp.
> > >
> > > I just looked a little bit more closely and saw that the command line
> > > uses 3 args. One for the count, one argv and one envp.
> > >
> > > I would then only support device tree + count and argv, so the new
> > > interface would not support envp.
> > >
> > > >
> > > > I would prefer solution b).
> > > >
> > > > This way we would not loose the kernel command line when appending a
> > > > device tree and this could also be used by the boot loader if someone
> > > > wants to.
> > > >
> > > > Should I send a patch for this?
> > > >
> > > > Hauke
> >
> > It was because I looked through the above-linked UHI spec that I became
> > concerned about CONFIG_MIPS_RAW_APPENDED_DTB only mimicking, rather than
> > fully implementing, real UHI. In the upstream kernel, the new $a0 == -2
> > code can be a starting point for adding UHI argv/envp parsing for when a
> > UHI-compliant bootloader is used. However, on the head.S side, what I
> > propose for the lantiq target is to remove CONFIG_MIPS_RAW_APPENDED_DTB
> > from the kernel config, and reintroduce this as a platform patch:
> > https://github.com/openwrt/openwrt/blob/b3158f781f24ac2ec1c0da86479bfc156c52c80b/target/linux/lantiq/patches-4.4/0036-owrt-generic-dtb-image-hack.patch
> > The brcm63xx target could then retain CONFIG_MIPS_RAW_APPENDED_DTB, or
> > not, depending on bootloader specifics there, which I have not
> > investigated, and likewise the various other targets to which
> > CONFIG_MIPS_RAW_APPENDED_DTB has since been extended even though it was
> > apparently initially only an expedient hack only for brcm63xx.
> >
> > Using $a0 = -3 is expressly prohibited in the above UHI document, and
> > using $a2/$a3 "would risk becoming incompatible with existing UHI
> > compliant implementations."
>
> I have come up with a more elegant solution: Simply move the register
> substitution from head.S to just before it matters. You can still
> override the boot args using CONFIG_MIPS_CMDLINE_FROM_DTB.

Resending with only the changes Antonyn requested, since Hauke doesn't seem to
be following up on his concerns anymore. Thanks go to both of them.

Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
---
 arch/mips/bmips/setup.c          |  7 +++++++
 arch/mips/boot/compressed/head.S | 16 ----------------
 arch/mips/include/asm/prom.h     |  5 +++++
 arch/mips/kernel/head.S          | 16 ----------------
 arch/mips/lantiq/prom.c          |  7 +++++++
 5 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index f146d12..3a327d4 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -160,6 +160,13 @@ void __init plat_mem_setup(void)
 	ioport_resource.end = ~0;
 
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
+#if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB)) ||\
+		(IS_ENABLED(CONFIG_MIPS_ZBOOT_APPENDED_DTB))
+	if (be32_to_cpup((__be32 *)__appended_dtb) == OF_DT_HEADER) {
+		fw_arg0 = -2;
+		fw_arg1 = (unsigned long)__appended_dtb;
+	}
+#endif
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
 	else if (fw_arg0 == -2) /* UHI interface */
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index c580e85..409cb48 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -25,22 +25,6 @@ start:
 	move	s2, a2
 	move	s3, a3
 
-#ifdef CONFIG_MIPS_ZBOOT_APPENDED_DTB
-	PTR_LA	t0, __appended_dtb
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	li	t1, 0xd00dfeed
-#else
-	li	t1, 0xedfe0dd0
-#endif
-	lw	t2, (t0)
-	bne	t1, t2, not_found
-	 nop
-
-	move	s1, t0
-	PTR_LI	s0, -2
-not_found:
-#endif
-
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 0b4b668..6c29697 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -28,6 +28,11 @@ extern int __dt_register_buses(const char *bus0, const char *bus1);
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
 
+#if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB)) ||\
+		(IS_ENABLED(CONFIG_MIPS_ZBOOT_APPENDED_DTB))
+extern const char __appended_dtb[];
+#endif
+
 extern char *mips_get_machine_name(void);
 extern void mips_set_machine_name(const char *name);
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 56e8fed..766205c 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -93,22 +93,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	jr	t0
 0:
 
-#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
-	PTR_LA		t0, __appended_dtb
-
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	li		t1, 0xd00dfeed
-#else
-	li		t1, 0xedfe0dd0
-#endif
-	lw		t2, (t0)
-	bne		t1, t2, not_found
-	 nop
-
-	move		a1, t0
-	PTR_LI		a0, -2
-not_found:
-#endif
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 5f693ac..c355296 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -74,6 +74,13 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base((unsigned long) KSEG1);
 
+#if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB)) ||\
+		(IS_ENABLED(CONFIG_MIPS_ZBOOT_APPENDED_DTB))
+	if (be32_to_cpup((__be32 *)__appended_dtb) == OF_DT_HEADER) {
+		fw_arg0 = -2;
+		fw_arg1 = (unsigned long)__appended_dtb;
+	}
+#endif
 	if (fw_arg0 == -2) /* UHI interface */
 		dtb = (void *)fw_arg1;
 	else if (__dtb_start != __dtb_end)
-- 
1.9.1
