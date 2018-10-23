Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 01:41:40 +0200 (CEST)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:44662
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeJWXlVg1Knx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 01:41:21 +0200
Received: by mail-pl1-x642.google.com with SMTP id d23-v6so1339783pls.11;
        Tue, 23 Oct 2018 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
        b=kr72YR3Z6fsjpNCQWKAq8biRV5Ky6WEsLzLAKNjvGEXzVo0OLzZj/axxUcLvMsJljv
         GAUecWqvxnSaid8cy+tamZPG6VAbzIplkizh2XlS5+LjIS+KIZ1qIL24fEwrjS9qrQUb
         EIrpmsjuQqewtt8fFJdBuF7YeJ4v/DEjRBMn+gRA3PAzMbtYHLpSYsorIdL2fqgRdb8C
         jErR59hy7OjxBnoL5lFmGHiO/fgShVOHMM1Opsl0Z0i099qHGHgcQjLIKmx57lbmB3GZ
         krgLeNTNlj6Hdsvo4Fwc2fmHtk++Ag4dtLCP4cPAzhB5giHxiZf/r9Wv8RZmhadPX5Ok
         Ab7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R7GnanBC/dUP1yUUX1JKpyThiE0iCRjX5YFPvjRZfCc=;
        b=jVzbGREYFXZDcrGrt90t7iyFJdlsxvz0vLUUQWVlyozgKcP1WXemtA+dUwvEEkvA1h
         j7FNawq11mzV2Q1BbVC2x8RJgEY/bVcb7PKzyhXTSNKxgXe6cVOkRzmmW3I3LtwyBDFj
         O0n2xxpo5bUdE42uTd+PbJnMN8a2AJUr60eN4QxeagDmgTGJUp/zBwMtyH/tL/zRBjec
         HAPn/oVG26XBv1JHZghabRox6B/THxTAdQj+HKXf55Q4K5gtmErD5qXMMMQuG9l9OEK9
         yzqM3D3/QAPtZCSFIw6C6lTIAA7OfSE2hJCu21qMST51b+V0U6m9CI+x9uRRIsGRxsun
         orRQ==
X-Gm-Message-State: AGRZ1gKxk/7SHmw6bDafytSw5B8tFSYmWjhBgOkFDJjkW0cJXgEvLScj
        cW90YOBfOgoGSVYHqoQgqco=
X-Google-Smtp-Source: AJdET5e9VIZyzA2DLtMJxPKaSvJZGY+8cFNaWYDcR0p+L+8OVN2SKkA/Vmncd/1gNmmLya56CR05hA==
X-Received: by 2002:a17:902:e81:: with SMTP id 1-v6mr295267plx.314.1540338075086;
        Tue, 23 Oct 2018 16:41:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a5-v6sm3041223pfo.53.2018.10.23.16.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 16:41:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
        Alan Kao <alankao@andestech.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-alpha@vger.kernel.org (open list:ALPHA PORT),
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
        linux-c6x-dev@linux-c6x.org (open list:C6X ARCHITECTURE),
        uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300
        ARCHITECTURE),
        linux-hexagon@vger.kernel.org (open list:QUALCOMM HEXAGON ARCHITECTURE),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-mips@linux-mips.org (open list:MIPS),
        nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE),
        openrisc@lists.librecores.org (open list:OPENRISC ARCHITECTURE),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-s390@vger.kernel.org (open list:S390),
        linux-sh@vger.kernel.org (open list:SUPERH),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)),
        linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH 2/2] arm64: Create asm/initrd.h
Date:   Tue, 23 Oct 2018 16:40:43 -0700
Message-Id: <20181023234044.1138-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023234044.1138-1-f.fainelli@gmail.com>
References: <20181023234044.1138-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1
