Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 21:55:51 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:42798
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLYUzWnaFlN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 21:55:22 +0100
Received: by mail-wr0-x242.google.com with SMTP id w107so7604454wrb.9
        for <linux-mips@linux-mips.org>; Mon, 25 Dec 2017 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hET4AABNBeNsSpkOZUI8roSkdCikZPdlup845D/iO+8=;
        b=MUa6lfj1xmy9NUHTWfgLTx9dIhxXCvBfTiW6vaCxnjzQr9QQ4phDFsNkedXUMJ1IBb
         OF5hdF2K5BhlWykOs1Kln5hjij+9prS1y/WjcxJznYcJvtNPTi1PekFCuaFsCI9uWaC5
         Fv+tC4vkFl4/kP7Uw/nGUMmDM7mVZWK7fTOz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hET4AABNBeNsSpkOZUI8roSkdCikZPdlup845D/iO+8=;
        b=uVaXSpOZqRrwcpL8Ij3mR1NffzKyTKp8kAw9w+i0P0ACRu7F7AYIa2Bn5uuCzCGCTn
         VOSGfmC3k9A3efbZobErSXQk/0kKbGTBf4Vl8RtnGJllpQLyLF3G5upo9nNI/sWBSRc/
         XrcsFOK0tQcHCaQ/7qVyy06u7oEMTEVMeXoEhrp4Ye/M8+fUzo8Mh0KrpTN4WFoZlK6o
         sOmR0OsnAGNWOSBBuygmMtIsVZIwWgIFkY7U6gkjWd3ZlnHFNzxsSdbaZ3oBaLgrNebN
         lF79YVZL7PihingNWnNfC5Hp82NriGG73GdoHzeONPDBLcmjm8KJ+3D6o0V5ZP9cMzNM
         KGQA==
X-Gm-Message-State: AKGB3mKQlQilXRnhneWj2x7mSCTEbLa2dZDIjg/FefTVtzLfj31vuCBB
        JZzeoG7XJqkaJLEkDTZQYfA6gA==
X-Google-Smtp-Source: ACJfBovCKlKdprtm7RJvrq1hpwvhi2iXL9FOntSjt586+6PO9VfSVoeUJ5HCtMSRYDdaDWg5wj1N6Q==
X-Received: by 10.223.175.50 with SMTP id z47mr23740531wrc.12.1514235317375;
        Mon, 25 Dec 2017 12:55:17 -0800 (PST)
Received: from localhost.localdomain ([160.171.216.245])
        by smtp.gmail.com with ESMTPSA id y42sm39552441wrc.96.2017.12.25.12.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 12:55:16 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v5 1/8] arch: enable relative relocations for arm64, power, x86, s390 and x86
Date:   Mon, 25 Dec 2017 20:54:33 +0000
Message-Id: <20171225205440.14575-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

Before updating certain subsystems to use place relative 32-bit
relocations in special sections, to save space  and reduce the
number of absolute relocations that need to be processed at runtime
by relocatable kernels, introduce the Kconfig symbol and define it
for some architectures that should be able to support and benefit
from it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig                    | 10 ++++++++++
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/Kconfig            |  1 +
 arch/s390/Kconfig               |  1 +
 arch/x86/Kconfig                |  1 +
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 400b9e1b2f27..dbc036a7bd1b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -959,4 +959,14 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_ARCH_PREL32_RELOCATIONS
+	bool
+	help
+	  May be selected by an architecture if it supports place-relative
+	  32-bit relocations, both in the toolchain and in the module loader,
+	  in which case relative references can be used in special sections
+	  for PCI fixup, initcalls etc which are only half the size on 64 bit
+	  architectures, and don't require runtime relocation on relocatable
+	  kernels.
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e1414f..66c7b9ab2a3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7da3e5c366a0..49ae5b43fe2b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
-		*(.init.rodata.* .init.bss)	/* from the EFI stub */
+		*(.init.rodata.* .init.bss .init.discard.*)	/* EFI stub */
 	}
 	.exit.data : {
 		ARM_EXIT_KEEP(EXIT_DATA)
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c51e6ce42e7a..e172478e2ae7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,6 +177,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 829c67986db7..ed29d1ebecd9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -129,6 +129,7 @@ config S390
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d4fc98c50378..9f2bb853aedb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -115,6 +115,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
-- 
2.11.0
