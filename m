Received:  by oss.sgi.com id <S554209AbRBBDWA>;
	Thu, 1 Feb 2001 19:22:00 -0800
Received: from sovereign.org ([209.180.91.170]:8320 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554027AbRBBDVg>;
	Thu, 1 Feb 2001 19:21:36 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f123LT901126
	for linux-mips@oss.sgi.com; Thu, 1 Feb 2001 20:21:29 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Thu, 1 Feb 2001 20:21:29 -0700
To:     linux-mips@oss.sgi.com
Subject: mystery files in stock->mips diff
Message-ID: <20010201202129.A1107@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The following files are in the mips tree, and not in stock 2.4.1
- but they seem not to be mips-related.  Clues?


	arch/ppc/coffboot/main.c
	arch/ppc/configs/gemini_defconfig
	arch/ppc/kernel/gemini_pci.c
	arch/ppc/kernel/gemini_prom.S
	arch/ppc/kernel/gemini_setup.c
	arch/ppc/mbxboot/vmlinux.lds

	drivers/acpi/hardware/hwcpu32.c
	drivers/acpi/hardware/hwxface.c
	drivers/acpi/ksyms.c

	include/asm-ppc/gemini.h
	include/asm-ppc/gemini_serial.h


...jfree
