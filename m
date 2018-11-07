Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 02:06:11 +0100 (CET)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:45082
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991112AbeKGBENL2vA3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 02:04:13 +0100
Received: by mail-pl1-x642.google.com with SMTP id o19-v6so7033689pll.12
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 17:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
        b=W7j4p7n6cVnICxU3fNbrsRLIna/24le2c2DHgzKLMFf5CQnUYOE2mZUtt2Rw7cFgi6
         K1v0NjXfenWwuPfGX4TL/6/Henxpcn35IpbF7yXLn6/NLFzfnwdGwXNL7gL4KSJTVfu4
         3gwDRe5HZSKr3bULeqf4DdS9aSwrikmCeHVEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
        b=RusAQEfvMJuPQbB9wZ3Tx7wJdHo3L4sxNzJiaqx6Y8f7qN9t61n2AyM6r1VBiHPpI8
         tX9h95jOvJgHVvcN92ojFMpm3tBEsmw3pjLo23mk6tPXzYj4HyVVShtEm3us5gmiKdTM
         y4odN8Z2WeajKRqmkDQReJDeF3tvthK5GZGYPJO8JUAgEzQ9PgfOT4pyWRoGlFWzLItb
         gLUNkUtU13D9/yK678DJsbkxdxqhTxziT2Z2FaLSGTl4+zYG+vcFyKgLswS+zRqAAUbt
         N53eJ6RjAmTPWOtgesTz3N6rABMTKX3szeMoLsTHk6TBsS1OzvPEe+HwALXPDvecsmD8
         QqnA==
X-Gm-Message-State: AGRZ1gIs0Kgi2J8HaMqEJCm7X/T85FwmNcpqA09P15xvOmRkpHqzgkcp
        qmqU0DjNOHcE69wTWfeshZmxSw==
X-Google-Smtp-Source: AJdET5fgJULXvtUFPnFq52slokQNN7z81I0D9HZsdKxVHZdxgHrZEi4Cy7djJVVncN5rD1H9qJsdhA==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr29324872pla.178.1541552652131;
        Tue, 06 Nov 2018 17:04:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:04:11 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Tue,  6 Nov 2018 17:00:24 -0800
Message-Id: <20181107010028.184543-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Patch #3 and #4 are new.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c     | 10 ++-----
 arch/arm/kernel/kgdb.c     | 12 ---------
 arch/arm64/kernel/kgdb.c   | 12 ---------
 arch/hexagon/kernel/kgdb.c | 32 ----------------------
 arch/mips/kernel/kgdb.c    |  9 +------
 arch/powerpc/kernel/kgdb.c |  6 ++---
 arch/sh/kernel/kgdb.c      | 12 ---------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-----
 include/linux/kgdb.h       | 22 +++++++++------
 kernel/debug/debug_core.c  | 55 +++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h  |  1 +
 kernel/debug/kdb/kdb_bt.c  | 11 +++++++-
 13 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
