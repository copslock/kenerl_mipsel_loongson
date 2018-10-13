Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:33:10 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:39103
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeJMBcfKNkuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:32:35 +0200
Received: by mail-pl1-x644.google.com with SMTP id w14-v6so6676397plp.6
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtAK3pAlFMeOO6SUm8Lh3Bmb29tPAciRzUtn881iM5M=;
        b=hu1RRoD4zGFkh1NvswXMY0Mcf7RReZIxK6TbDCgMDMi1xCXvjQWNtmb8jA6UW1Q5ZI
         bybcFeJfratqjTeqEb7mRWAGReU9tL9VCuSkWsUqyCZbL3y+XtXFIKgHbMuC6INYU+VH
         z4FmPqYFb3J2yvvfenwn9pAR6sobi8QuQFyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtAK3pAlFMeOO6SUm8Lh3Bmb29tPAciRzUtn881iM5M=;
        b=iQYDh/Jmv94SZ2W8RgvJbpQem/tdBNeNmZCkuIaxOUs4ohf4DdmBBaVSDqeBlid+MP
         H98C22dJFmbNe0hpYHPnLbKppIqkMDWaPxbDmQ+9JQfIOTod1fYmzAg7m4pYA9p63wAZ
         dXNu/n8y3sS5rJ10EkjO1Ih4ESYrcYMl1YKW6uZ3RT5FUkcfey6fbqpaHzYVWTbJ9YK/
         K3V7EkMlt9RVIE3G3FKQAsoCKd5rwwHIumZw9ptEEl/JJHGRtAAGg5YzGqARV1lXxc0F
         WtFBm167sWreT3rZFHNw3z9eflghb29Sugx5bIJliDORLMIot53/TGBOI6FXnxazWXEf
         I6BQ==
X-Gm-Message-State: ABuFfohlykd9spRgDMUnq6uBNAAyngUS7hSY6PB6S/8eyZaRXKHljd5Q
        Wq5omzsgAM97j+l40eMYST5hOA==
X-Google-Smtp-Source: ACcGV60cRgU0XyfJPBpItPjBh+EP7iRiHLZbhDbgbD69TJC4FgrTPRZLx9S2q81RSPgQ8LHOmiT4Xw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7-v6mr8297604plo.30.1539394348522;
        Fri, 12 Oct 2018 18:32:28 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q7-v6sm6507828pfd.164.2018.10.12.18.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:32:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        lokeshgidra@google.com, Max Filippov <jcmvbkbc@gmail.com>,
        mhocko@kernel.org, minchan@kernel.org,
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
Subject: [PATCH 4/4] x86: select HAVE_MOVE_PMD for faster mremap (v1)
Date:   Fri, 12 Oct 2018 18:32:00 -0700
Message-Id: <20181013013200.206928-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181013013200.206928-1-joel@joelfernandes.org>
References: <20181013013200.206928-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66807
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

Moving page-tables at the PMD-level on x86 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..01c02a9d7825 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -171,6 +171,7 @@ config X86
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.19.0.605.g01d371f741-goog
