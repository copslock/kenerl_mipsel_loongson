Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 19:14:25 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:35714
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeKHSMTwVO88 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 19:12:19 +0100
Received: by mail-pl1-x642.google.com with SMTP id n4-v6so9908996plp.2
        for <linux-mips@linux-mips.org>; Thu, 08 Nov 2018 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ba1SMLAqIgmFI6NH+RBLXEYzItBpgF4xQcT0H6ilVn4=;
        b=Sd/TmY9ueaUX+dApcoIPz7eAiunY6S8dWblAnYCegng0zsspcZ/BAyYvXqKHGnfFnr
         jrW93Eh4p6ZETBfFvU23lIxT3wP6dIvp1WSxOZnUAcSq8Wm9nP/e0Wijn/ien3UEVX4p
         QX1eigA/kEAUmS4Qut12n2rTOw/aGSwvEtyjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ba1SMLAqIgmFI6NH+RBLXEYzItBpgF4xQcT0H6ilVn4=;
        b=FRXmk7H+Ax9dTPha/PCN4G678SxqixVV1nHcEzauuZ0IXFwJ+o7GBM/6XmwW8N49Jc
         tPY2RlVGEzq2Gel77hJe4GfMzppCkMBEYAPW8GXtK3/nJ5wvcApE+cBdknYPEndmItPv
         PF5Dw7mdAxdgYJFInL2SBvC8lXX1EkKw0AfA2H6ED4kDgQ8CSZ452Hz0le1EFytYyhuY
         m/665v6zVoovRE8ARagVUvbiNxXUfP6smFVX441Pgcasg+769WpN/29J8+bsEFcmP38E
         yTiUuhGmgn+L/LTPhTHej8MGju6Upa18aDxeRsx0mnh5ysIO2bWpgsAzqArtXh8yeXfA
         SfGg==
X-Gm-Message-State: AGRZ1gJZoJ1xCx7RLwwZS8kozOvZSMIZj8KJO1B1Cw/bFDafSgDPfqXe
        xMRM9nTZgFjvRSbzBnZ2hg4d3g==
X-Google-Smtp-Source: AJdET5cPtwjdexdNUSWnBuJxUWSGB/XTgOSIdhsSZPRZi1sLcBzLKRVef9eLSkElUego3TiJVYqalg==
X-Received: by 2002:a17:902:6686:: with SMTP id e6-v6mr5476470plk.173.1541700738810;
        Thu, 08 Nov 2018 10:12:18 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 64-v6sm10028533pfa.120.2018.11.08.10.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:12:17 -0800 (PST)
From:   Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelaf@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH -next-akpm 3/3] mm: select HAVE_MOVE_PMD in x86 for faster mremap
Date:   Thu,  8 Nov 2018 10:12:01 -0800
Message-Id: <20181108181201.88826-4-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108181201.88826-1-joelaf@google.com>
References: <20181108181201.88826-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@joelfernandes.org
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Moving page-tables at the PMD-level on x86 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 605bec0c228f..05f3667de0d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,6 +173,7 @@ config X86
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.19.1.930.g4563a0d9d0-goog
