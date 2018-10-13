Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:33:01 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:38168
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994599AbeJMBccM0t-y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:32:32 +0200
Received: by mail-pf1-x444.google.com with SMTP id f29-v6so7016228pff.5
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjYTsH4Iq69Ub7N2c7p2HOCfpyLGuHcm9WhDWE1Dnwg=;
        b=pvEfVikziMJRWxtTRTm3WwDM1z7pcXybcAtnjCIyQdfWN8O5jRGdCgjUlGTjsMAT/F
         saWeGlI2HK0vC3ro6vBYXn3xIZY1BMwuP8djzpt6M+eKMtkHqPqZ+mldfVclfk22srUA
         b5EsPUgxygKFL8hgKZ6UMDusfAYxbbW7exB4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjYTsH4Iq69Ub7N2c7p2HOCfpyLGuHcm9WhDWE1Dnwg=;
        b=HL0noLwzdVnraEWP3iInZdUdBvGdEREy/CkEH+Ktp88PlXvMNTWYCoXxGMibbh8/Xr
         lcKDKD9q960339NGA1Hg8wvaRFF1ZmxD9bwVsP3rFBkvvLQqX2ZgLX8GG5oHsegvmf0H
         F1Kk4+vM+F1hMHcs0PgWgohf/Lv9Un5welUB23xXxpv59fWC7mwAI2WIs6AybM7DgNWm
         d+7bI6jayKJ3MJrsQ95UvWshprOCF+7NMbEjWXR6KouqVyyg4SYX8wDxIBdteqFIF22T
         0mMFDG16mwCC9neglRNbaPqDRL4JvDzkTvt7K2AZLjamGD382Lx3hv4ilofIcIuNfLDR
         KDdQ==
X-Gm-Message-State: ABuFfogllR37MlbgfWL+AoCeijwsAUNTWHywGja33xJmaWJuL8PS07aA
        aqKVzf4jra+ss8EbvlbXZYgD1A==
X-Google-Smtp-Source: ACcGV60ecPJwErRYv7rdeDNNhheUXmreqwFNvyYIFQM0w7YuygsKhKKgtC5tCiolpW/Ws3yIGetyhA==
X-Received: by 2002:a63:2a11:: with SMTP id q17-v6mr7630469pgq.374.1539394345842;
        Fri, 12 Oct 2018 18:32:25 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q7-v6sm6507828pfd.164.2018.10.12.18.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:32:24 -0700 (PDT)
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
Subject: [PATCH 3/4] arm64: select HAVE_MOVE_PMD for faster mremap (v1)
Date:   Fri, 12 Oct 2018 18:31:59 -0700
Message-Id: <20181013013200.206928-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181013013200.206928-1-joel@joelfernandes.org>
References: <20181013013200.206928-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66806
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

Moving page-tables at the PMD-level on arm64 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..5d7c35c6f90c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
-- 
2.19.0.605.g01d371f741-goog
