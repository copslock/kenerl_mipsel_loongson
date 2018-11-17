Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 19:57:44 +0100 (CET)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:43193
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991923AbeKQS5Z3lYsO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2018 19:57:25 +0100
Received: by mail-pg1-x544.google.com with SMTP id v28so1526187pgk.10
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2018 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
        b=KAW8uS2esdTjeBcDfFodpTuBiPuzrfOgpEvhmkdmizzqp7CMEjaFC2ORlF9MeL+yeA
         stdwlyxwK9cJAK+MAYm3DEfW4lRgMCiJRj3yewaXsrtQx5DmclC4R/K9qjVetVNcal+H
         pjN2zNK/65b6+lBFp6r24jInRxn3xDvrMAU8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
        b=K26DCA6G1z86FtP7PL4AXO0qo3ZR8SHH00s7vjZMVu+CVSP0nxlBx33NiNlIABIPHd
         LQBztz2UUWZwI2PowUsmPa8a7SdBcNK02PIXOorh4StgSwEyhi3cCa3f9RrOBK5Mw8pT
         tEEtmQKk0fwaS9Xqo/vfuwmcnkvXS9AooSmErxD/G9dZ5RVC5RYHalxXiwQ2YcFVhF/T
         pMzOVrvI1XIwZz/YIDFc+IjlkK5bJLtKlYcg2AKKIQ4nNgsrwbPE7Yu8092MnTs8v3hi
         V15iiH9MT3pCT5wnuSylOHGc2TSbf2mQbofC74guyLZGbUeC2TOaBrTWnoMlfNGYofNm
         bkBg==
X-Gm-Message-State: AGRZ1gIteK6CiTC6muk6sctmj9V/3E92MU1VMM0iEy07/UWHbBZeQVNV
        0Q3p+3qUQ+cp6J2cuvvFVS4Img==
X-Google-Smtp-Source: AJdET5epwL8opIfWAHhuSBY1hNn/GKz9erLG44ejL6V5gIz84eLRbi+P5B/LB3RozshYttdcdgtQpg==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr16036733pfh.188.1542481044594;
        Sat, 17 Nov 2018 10:57:24 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:23 -0800 (PST)
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
Subject: [PATCH 4/4] arm64/bpf: don't allocate BPF JIT programs in module memory
Date:   Sat, 17 Nov 2018 10:57:15 -0800
Message-Id: <20181117185715.25198-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67341
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

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..e0c702c2f682 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+{
+	bpf_jit_binary_unlock_ro(hdr);
+	vfree(hdr);
+}
-- 
2.17.1
