Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2018 05:01:02 +0100 (CET)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:44192
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeKCEA5Oor8H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Nov 2018 05:00:57 +0100
Received: by mail-pf1-x444.google.com with SMTP id j13-v6so1869152pff.11
        for <linux-mips@linux-mips.org>; Fri, 02 Nov 2018 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HkIf26O8EXe1py4I/eqZ1OjBmokbTLMF6ur7yoT6bA=;
        b=jrGY5nHXhhy3bkMSfMNLEHiciHloHxFKJ4aKR9IYI3sMm4SLNqyCuZkxA1Ou2fv5Eb
         LcgIqDLqRcuJQYRuuB6UAcFJ7ufl/3CYO1JXJIb4o1fmCxpYb6V2z23vry7jhOX1HOwS
         BcJfpo/bXQrK4mzzOg5dJYw8ZFSef/P3g+8jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HkIf26O8EXe1py4I/eqZ1OjBmokbTLMF6ur7yoT6bA=;
        b=AMeIkPvyUg7inAgE6xfYqkeQgQ0wg3FXy3z9ybXzcfDJxm6Z1bdW8yjBQSkvt0Nxt7
         5G9PseYVn5qx4efxaFGXQ8Bm8qdeQJM/lrVen0KAAgoNjOzembIU7sqbA8K1BL5ArEAM
         Unv7aGolw0qJYhTRhPpqVhJ1iudQxBuJbOdvItsCCpZE0+1xPi+8/uzKVMHCCFJ7gfxV
         NWn7Bx0ygjY6UoNLv3UfRhjOGeSSeNsx/ajG+6C3HeeTrl2zsbA/K3J7s5cxZkaUfcU9
         nlG6DhFwSBJkiLwad1+krLVfqcyUvSKAfM9N0aZzv83Bj7X7p5I7bIoQVz1UICg0JlZ7
         LOsA==
X-Gm-Message-State: AGRZ1gLxt/7nGIcrAUqHBsdAqauWB7ebnOI4J+uTa4xIrpVSzGTeg4XI
        KqnHluw0+fZn2bbDPT8lSJjmqw==
X-Google-Smtp-Source: AJdET5fu2OzYfiTyZl33qiii7V2shb8ruxRKcR+KaDeH4D4fynaZZ4zUx7EMsJk+RfMx/9zdh6SdFA==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr13745084pfc.87.1541217656208;
        Fri, 02 Nov 2018 21:00:56 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x36-v6sm35836232pgl.43.2018.11.02.21.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 21:00:55 -0700 (PDT)
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
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
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
Subject: [PATCH -next 3/3] mm: select HAVE_MOVE_PMD in x86 for faster mremap
Date:   Fri,  2 Nov 2018 21:00:41 -0700
Message-Id: <20181103040041.7085-4-joelaf@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181103040041.7085-1-joelaf@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67057
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
index ba7e3464ee92..48aef01a0bd1 100644
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
