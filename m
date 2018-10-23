Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 01:41:15 +0200 (CEST)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:33813
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeJWXlMw7xkx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 01:41:12 +0200
Received: by mail-pl1-x641.google.com with SMTP id f10-v6so1366334plr.1;
        Tue, 23 Oct 2018 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7OS2r3euy1TczlyR46QbFm62nalquqEBBOjTowUcAkM=;
        b=JZ1FQW2sjznoZVhwKxRvzGXbACgNDowsPsyxlWZVVG7INAURVS5jcxx915CmrAtFRB
         8hWt+dLKEAVaszN//gmUjAYoT7FDyiMui97wYDmRNVObbg407myVHSOQQZ2tzM6HKXjZ
         mHfpSVcF4JVoAjUiAlqOz8+OgLkgiyNTMN4slZ2nQdl2qnD25v68X/twk29GWgHctS5W
         xnYbKMErl9Jjcz+rWWWrl4jqwHUvFwF5J4+jg0wCCfi+5wfY10suO+glJ/huiOk8gQQR
         VFWKT2AnmDQl75D4iT3d+hUeGJI3o/5MTq/bf6m/xNvsxIAEvup7H34zIhNHpVjgjKte
         er4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7OS2r3euy1TczlyR46QbFm62nalquqEBBOjTowUcAkM=;
        b=DtF/sGhmS3iRfsRgoaIsjLljXqqxlXKuZ3ZW3zC0Ik4QKMYpmH0vy0R1yPNOIAmq7o
         XoyPuM1u6mwnpk4IP58coHs21ZXMUZzIXMpzkZinCfcPcYV8gei4HyN33QHor4DQOPYk
         6Rok9J943oyJlJrHAIWQQECUu9z90KgfSbNfL3ysztQDX26pIaKs7jLhuQfBWrmP4RfD
         1KgwxgZSIDFX4iWlHXXX1mRFgIITBr0aE0fiwwmzcuAS3pERXHoB4HT3MH8YAbYSbCIy
         rwybR9TSmOPkzDoUowcfD5J1DkOjt0yyiQTJITJTJtNSyXiqTSVQ333KPsWd22IKT9tO
         gCEQ==
X-Gm-Message-State: AGRZ1gKfxm+MxqSXqHpy9Y5SmZNgrrBNSf7MYD8Xr3D3u7SF9wO4b2OK
        Y3Ob3KZzwIdutjWE6VUr6iU=
X-Google-Smtp-Source: AJdET5fBJhLb6MQXskYp1eO10D2a24G6cKuepRaM3H/nhlH771jer1HqF14MUwzRYB/YVHWQB+Kq3Q==
X-Received: by 2002:a17:902:6e08:: with SMTP id u8-v6mr162695plk.64.1540338065703;
        Tue, 23 Oct 2018 16:41:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a5-v6sm3041223pfo.53.2018.10.23.16.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 16:41:04 -0700 (PDT)
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
Subject: [PATCH 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
Date:   Tue, 23 Oct 2018 16:40:41 -0700
Message-Id: <20181023234044.1138-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66911
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

Hi all,

While investigating why ARM64 required a ton of objects to be rebuilt
when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
because we define __early_init_dt_declare_initrd() differently and we do
that in arch/arm64/include/asm/memory.h which gets included by a fair
amount of other header files, and translation units as well.

This patch series proposes adding an empty initrd.h to satisfy the need
for drivers/of/fdt.c to unconditionally include that file, and moves the
custom __early_init_dt_declare_initrd() definition away from
asm/memory.h

This cuts the number of objects rebuilds from 1920 down to 26, so a
factor 73 approximately.

Apologies for the long CC list, please let me know how you would go
about merging that and if another approach would be preferable, e.g:
introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
something like that.

Florian Fainelli (2):
  arch: Add asm-generic/initrd.h and make use of it for most
    architectures
  arm64: Create asm/initrd.h

 arch/alpha/include/asm/Kbuild      |  1 +
 arch/arc/include/asm/Kbuild        |  1 +
 arch/arm/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/initrd.h    | 13 +++++++++++++
 arch/arm64/include/asm/memory.h    |  8 --------
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/Kbuild       |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 drivers/of/fdt.c                   |  1 +
 include/asm-generic/initrd.h       |  1 +
 27 files changed, 38 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h
 create mode 100644 include/asm-generic/initrd.h

-- 
2.17.1
