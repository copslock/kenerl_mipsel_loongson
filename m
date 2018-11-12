Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 19:28:11 +0100 (CET)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:39615
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992773AbeKLS1RAHD1p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 19:27:17 +0100
Received: by mail-pg1-x543.google.com with SMTP id r9-v6so4431355pgv.6
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+fNEzOvGtu7UZFhCEIQ8uoVjOxFwpPILN5pzazqNYk=;
        b=eXr6js0mdxBQXDsYoP+dpGM05tDLjEqyHTGRhiOIULp8cnhmCXXktIgW8uezqg9ePK
         wVabda9zlcNHOXnd4xrUL7y/qGPvD3LORin0hioaX/oYI39lrop8fAjEQALwFCK9UNaM
         Enw29nwR5bw1mTGJXMldXQvFe9C5yvoDao0KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+fNEzOvGtu7UZFhCEIQ8uoVjOxFwpPILN5pzazqNYk=;
        b=UUUH8aHS4fQCsiV7B151/dY1QV+Zh/zpRDnxTTTHzKSHeEi8BvBHizwfxTMoGcyG0m
         rWKm69DmxrNIRNM9BiAwCO4RG5ROH5p4SBr4nvU3hrYnjKQ1Dpjdsjse65Ua24cnvIE8
         olbRZG0kwtwM5WBywMjDINLrwrgeCRibhSKogpHI0JpYSi0ZX4YcWDw9INbRRAKSFNNb
         EEAoVrzbj4xoCQp/3jCvHOGB4I3eTE8MDORmxkD1aVLncj4Dp8UvlkWP9rmL7oTP3+Lx
         UH1O5s/dz1weA4ulXSm1C/DsN+L+OhMo50juTRsTmLc3wrf1pofKbeu+/D4E56NiKkez
         Kdqg==
X-Gm-Message-State: AGRZ1gIdxEEOgNVTGMSFO3dC7MC9urba80Bb1hQ7yLnTckVZvyRFuDOn
        HF1N7zV3I4Ghsk/3UeYAvY4XQw==
X-Google-Smtp-Source: AJdET5e5/WkAuI8mTOdhvf1T6zEObtJHy7y0EHk3Q6guTcO9BgOxiHnQib5SZuhWLZjVMV7KN5Oidg==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr1679288pgk.406.1542047236123;
        Mon, 12 Nov 2018 10:27:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id o86-v6sm18813100pfk.8.2018.11.12.10.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:27:15 -0800 (PST)
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
Subject: [PATCH v4 0/4] kgdb: Fix kgdb_roundup_cpus()
Date:   Mon, 12 Nov 2018 10:26:54 -0800
Message-Id: <20181112182659.245726-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67254
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

Changes in v4:
- Removed smp_mb() calls.
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Don't round up a CPU that failed rounding up before new for v3.
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c          | 10 ++----
 arch/arm/kernel/kgdb.c          | 12 -------
 arch/arm64/kernel/kgdb.c        | 12 -------
 arch/hexagon/kernel/kgdb.c      | 32 -------------------
 arch/mips/kernel/kgdb.c         |  9 +-----
 arch/powerpc/kernel/kgdb.c      |  6 ++--
 arch/sh/kernel/kgdb.c           | 12 -------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 ++----
 include/linux/kgdb.h            | 22 ++++++++-----
 kernel/debug/debug_core.c       | 56 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -----
 14 files changed, 89 insertions(+), 112 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
