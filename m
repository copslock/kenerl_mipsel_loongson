Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 19:57:23 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:36558
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991923AbeKQS5Uk1yNO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2018 19:57:20 +0100
Received: by mail-pg1-x541.google.com with SMTP id n2so4852630pgm.3
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2018 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
        b=UORXOUKYewxZBY9q60veahrHkEtPpR9GSai6HV7K7LIRYSUmveL4hgphwWKykjezr5
         5aJslRjRd5lwcVzGm/diuVIZt/WHst6O5IT8qVuNmMEHGGC3uCNjKCW4U/6UPunf//Ri
         Yog90RJJIsfBEnEswOgbukRNoDii/RYXBxk8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
        b=Kuh7wRI25hl6rdY3NDYUSCZorDmBNXLRyZGc8dgGU6Afnhflnk/mKm0xsPrNE/1EDB
         UiXo3NMjxby5suNKbf0R1uwuMlaKfpCbLsh83dGVo/fPWSByz7er2IxkZV/IdacduLjn
         nNB7WCbIH6f3L1niaHAy65DKPxmtdhxM4aue7CwyK9JDz0ywJSpgsG1msOTlVBBo7qeS
         xHAC71zsYjs64kC2ODhJYo2KQTiKMZAZ3Sf+ntaMUt7/lA36tfhjFjh3pl5zKB6DLncI
         lnf5Fr2cnZ3DB88skErVIZODZtNhGZ+gVQFbwXl2K4JYeURnkkYc9Ps6lJQqPO+1VokA
         D33w==
X-Gm-Message-State: AGRZ1gJ2t4iEwcfhPzpjm8KPqO8zTxWmZQDs10EvUAOwYRqb6/9aNT46
        v47y7SlyeH6Fsc3wnqiOiFa8ZA==
X-Google-Smtp-Source: AJdET5dcu85Awa0hWemuaG/qBca5+pUPD7vYP+djiZMTtvFzptSWkQPdpArsamMNJVlWr5986121ww==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr14292473pgn.286.1542481039552;
        Sat, 17 Nov 2018 10:57:19 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:18 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 0/4] bpf: permit JIT allocations to be served outside the module region
Date:   Sat, 17 Nov 2018 10:57:11 -0800
Message-Id: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67337
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

On arm64, modules are allocated from a 128 MB window which is close to
the core kernel, so that relative direct branches are guaranteed to be
in range (except in some KASLR configurations). Also, module_alloc()
is in charge of allocating KASAN shadow memory when running with KASAN
enabled.

This means that the way BPF reuses module_alloc()/module_memfree() is
undesirable on arm64 (and potentially other architectures as well),
and so this series refactors BPF's use of those functions to permit
architectures to change this behavior.

Patch #1 fixes a bug introduced during the merge window, where the new
alloc/free tracking does not account for memory that is freed by some
arch code.

Patch #2 refactors the freeing path so that architectures can switch to
something other than module_memfree().

Patch #3 does the same for module_alloc().

Patch #4 implements the new alloc/free overrides for arm64

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org

Ard Biesheuvel (4):
  bpf: account for freed JIT allocations in arch code
  net/bpf: refactor freeing of executable allocations
  bpf: add __weak hook for allocating executable memory
  arm64/bpf: don't allocate BPF JIT programs in module memory

 arch/arm64/net/bpf_jit_comp.c     | 11 ++++++++++
 arch/mips/net/bpf_jit.c           |  7 ++-----
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
 arch/powerpc/net/bpf_jit_comp64.c | 12 +++--------
 arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
 kernel/bpf/core.c                 | 22 ++++++++++----------
 6 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.17.1
