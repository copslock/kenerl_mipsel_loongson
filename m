Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 19:57:37 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:46660
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeKQS5YNbilO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2018 19:57:24 +0100
Received: by mail-pg1-x541.google.com with SMTP id w7so12012457pgp.13
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2018 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
        b=XYLhyO5mN3FVA4ReKitsYfMKGuHNDNlOhuo5CX3m1WdOPZeKdKBplc4oZZ6V6yFg5A
         hQ83SmcdvQq6M0spjr5rwWJUh9QdiW39oPX0Z2kNZVWF+j0XU6sZnr/m82angEa1AG65
         GQ2t7WMlRjYOWyc5If1zGyUDez/kBmIctb+b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
        b=IRteXku6/2utTUDrvFZpNziDVfCDJnIscnnVmPCgM2PUuQ+H1e4iq+hR049ap9A70q
         Ecaru96xEQFp95iQd76wyVJzpZiTHLuxnccJA+xQJIdtMFjuqwpaZXbRf3I+kDUb6mfx
         ya2rS23ZHxjR60Zb3gyj7Ds7MB6rM4HOg0uLsZWPMC/sI7DXoqgZPqKh+djZOe/mEWzr
         E8UZLvwuT1VoalD0L9rQRsTC873AXJn/CDjfGcM4zadje1tT3Gn+UPVHVDyf6SYrH91y
         9rxMc56ZdohKQEsilrU/xHz/EdYY8HBA86vAsYuSu2dZTrB6b8NAZ+Tt7Q5c7E59aH3t
         CRHA==
X-Gm-Message-State: AGRZ1gIPNK2Tiy0RJQdCeJ5jMaxvB0HSHPeguwSCQcKTe+mJSXw18tpW
        MmPyQLZQU8uYkaapfM/2elS5hg==
X-Google-Smtp-Source: AJdET5dbJskaau0oeh2D+j2r5+z2XCOLI6qC1Gpj92MrCzlhVrhcUg2kk12XFX1xpT0h9FiUT1nBcw==
X-Received: by 2002:a63:f241:: with SMTP id d1mr14569834pgk.2.1542481043353;
        Sat, 17 Nov 2018 10:57:23 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:22 -0800 (PST)
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
Subject: [PATCH 3/4] bpf: add __weak hook for allocating executable memory
Date:   Sat, 17 Nov 2018 10:57:14 -0800
Message-Id: <20181117185715.25198-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67340
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

By default, BPF uses module_alloc() to allocate executable memory,
but this is not necessary on all arches and potentially undesirable
on some of them.

So break out the module_alloc() call into a __weak function to allow
it to be overridden in arch code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 29f766dac203..156d6b96ac6c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -609,6 +609,11 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
+void *__weak bpf_jit_alloc_exec(unsigned long size)
+{
+	return module_alloc(size);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -626,7 +631,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = module_alloc(size);
+	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
-- 
2.17.1
