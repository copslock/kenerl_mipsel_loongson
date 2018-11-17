Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 19:57:28 +0100 (CET)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:45458
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992811AbeKQS5VoTvWO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2018 19:57:21 +0100
Received: by mail-pg1-x543.google.com with SMTP id y4so12019458pgc.12
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2018 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vKtcwajq6uet7RwpHABNJRRfvhJ5RLh+7DwnrP6tkoU=;
        b=HCrZnyJKCfFnJaZK1DpCvziEmRstnj4rwYTbT92UFXz73rvqQ9ZSjTGDU8wRnGgNJ+
         ExMscyjZDgE+uBnbk94MoYbWGi/Ppcc1XZG5FsvUrcfYFnni03qp7O8Pw8kD/mV3EtA8
         4qJ0sf0q5nq3snS/fKcmV1/2jIO7ddsYaFvVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vKtcwajq6uet7RwpHABNJRRfvhJ5RLh+7DwnrP6tkoU=;
        b=P8Msj1Hu1dTfUHbcyD+Rco0IBY1zb4u0+e8p9wnbxIk3EGoy3b4b6yKvtxwCuCBBSh
         1lv5gl9XXNoWE97pla0TVVutHy7JkWaSUTgMQ0prPON9HO7lk3FAqDFZHRTA/o5lI6R7
         yWh8ADNu40dpi+j+JxoaWRctxiuC7rMxdWFPba+llOKBnYz61/nq0WW+dBwwBpuz/LjQ
         kpuRGglBBHf0e4JJjAb+CGmDyFJNn44+XhyraaYynRfQWmHuJ5DvlN58dvslmahG6rr1
         rxyL1hEBsnJ6yKJKaltS3UWEcd2EiB54N9mUB4vQ4h/S01EQm8lBnDtPOutJCIkhCcpU
         nJaA==
X-Gm-Message-State: AGRZ1gJuVKENQDErya0NPcB2W/jQmx1koH9spLbRwmhDwXwlENSz0sds
        uoc2t/Xpa2O76BYinjAz1IsEmw==
X-Google-Smtp-Source: AJdET5ctCscFODEPbn/yoyf1Ns6z0NZ0bHOkoDOM6hIBx8Sdy8wtnp67zeIE7sjr1zu/AsWtPwDO4g==
X-Received: by 2002:a62:cac4:: with SMTP id y65-v6mr16264821pfk.27.1542481040868;
        Sat, 17 Nov 2018 10:57:20 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:20 -0800 (PST)
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
Subject: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
Date:   Sat, 17 Nov 2018 10:57:12 -0800
Message-Id: <20181117185715.25198-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67338
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

Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
allocations") added a call to bpf_jit_uncharge_modmem() to the routine
bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
This function is overridden by arches, some of which do not call
bpf_jit_binary_free() to release the memory, and so the released
memory is not accounted for, potentially leading to spurious allocation
failures.

So replace the direct calls to module_memfree() in the arch code with
calls to bpf_jit_binary_free().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/net/bpf_jit.c           | 2 +-
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 5 +----
 arch/sparc/net/bpf_jit_comp_32.c  | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 4d8cb9bb8365..1b69897274a1 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1264,7 +1264,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d5bfe24bb3b5..a1ea1ea6b40d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -683,7 +683,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 50b129785aee..84c8f013a6c6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1024,11 +1024,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 /* Overriding bpf_jit_free() as we don't set images read-only. */
 void bpf_jit_free(struct bpf_prog *fp)
 {
-	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
-	struct bpf_binary_header *bpf_hdr = (void *)addr;
-
 	if (fp->jited)
-		bpf_jit_binary_free(bpf_hdr);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a5ff88643d5c..01bda6bc9e7f 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -759,7 +759,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
-- 
2.17.1
