Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 23:19:15 +0100 (CET)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:39984
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994427AbeJ3WTJqxo29 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 23:19:09 +0100
Received: by mail-pf1-x444.google.com with SMTP id g21-v6so6556391pfi.7
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
        b=F5MtIjUSmfPSLlRLUcvlxb8bgwO944Vzlwsrb+STW1m9SKp+FbIUnhKepFgX1d/6zY
         WFEsTME5GAO3fNxqCMjL5qf9DfZtUWW/0eu+pQx31M+moNIAPuITstIM3gP6+QCFd8p4
         spMZEp8n6pfvs7QIBWD5+GLOMia4bijBqXNww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
        b=AdxF7H0Afl25GFpVg9HL8uDrtHNtMgYzknWHUS3GQbC1V+3YaVzA+mpSrs1Z5oPsoK
         rcSAmjE+YQLOLAeREhRldURDPJev/+6ofdo8SzU4RuIgNw9surXfrEnsVdwJQdzTJjp4
         1e7OVC8vXW5ZfEIhzmRTwaKo9ohdjNMDZJsDqXhlVT6TQCwYBEb8fHNQCVJhSBbQnfbV
         Pm2opLh/8rg4PdAKA4AZBSxmtHl/PhkiRvD/fN7xNFL0TTiF69edqTI1zX0faZNSEsWp
         Zhy4qNpwwxeA4QoOGQezq1ijgeuNvPQL+R+9sRz+IvF2NiHJOBKCjMxN22K5zItLhcJa
         ncyw==
X-Gm-Message-State: AGRZ1gKXX5B5CrHkHD70clcrpG+injxyIecDT6R6rHO5IIqxSaFwIsi4
        KmFkv5pJzu3rgSeHG1ZhAZIl3Q==
X-Google-Smtp-Source: AJdET5c8VEq72Qy0GxQVPtDW46vA6aevXpwki6KHW4SNnqLPDwpMxBbEkvTAqWJGZKK3oeUkFc+Anw==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr521667pfb.209.1540937943074;
        Tue, 30 Oct 2018 15:19:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id c70-v6sm2889774pfe.93.2018.10.30.15.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:19:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Paul Burton <paul.burton@mips.com>, sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] kgdb: Fix kgdb_roundup_cpus()
Date:   Tue, 30 Oct 2018 15:18:41 -0700
Message-Id: <20181030221843.121254-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66995
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

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (2):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 32 --------------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  6 +++---
 arch/sh/kernel/kgdb.c      | 12 ------------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       | 22 ++++++++++++++--------
 kernel/debug/debug_core.c  | 38 +++++++++++++++++++++++++++++++++++++-
 11 files changed, 60 insertions(+), 104 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
