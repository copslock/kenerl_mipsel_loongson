Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:58:56 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36106 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025915AbcDDR5vjlPEW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:51 +0200
Received: by mail-pa0-f41.google.com with SMTP id tt10so148725579pab.3;
        Mon, 04 Apr 2016 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2mrTPCrTWjytL7VrHUHuSW8qgm2TxnOWgf6Ag4YozEQ=;
        b=RMRchzLLMo07Yvbr+IpPu7ABfNTsBKO3E+Hoz7lWXVBc+KsyA2by7wBOYpQ+UZTr+K
         ahvLhUMzX98KVoriqhN05hReZI6DOFUYeX8CWDQ5/4jqX+q3KVPOjY9asVLDwp5LwfFy
         SaveVMiL9WqYUgi0eewJm76c+C1mztwXFRg3i+jz8KybWQTA51ZUP4xT6G3XbBJfAchB
         O0hc1bE9GcEj/yaBVlpUgKIsRRJ0S+/G3Xoj+r3mlTgVFLPwGooWcxvQV59ZQeBvUqVg
         TWt5PCF7RrTaHUTDXm5jG8yjhkTzF1wZdKmrFH4w+pw8yXFSQINCDKLE0gAPHfsOK2ro
         nTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2mrTPCrTWjytL7VrHUHuSW8qgm2TxnOWgf6Ag4YozEQ=;
        b=QxjkXXI7Y3aQoT30thBViHn4EiJ+68DvZa5Nx10vawJFB+Q9Pc7S6sWldQoM1o688P
         6tqWrFocZ1kAPNr4Z956pgmR0RfyYKaFYvDjHEjl3qS1MwKV/c7jAX1pMnDvRS/DDT5w
         4dsGvCfqwb7l5EzElC0P68mg6pHfWjGsR1DHUYWM7NXYss/0A0f6QyRAbZEOs92Lmptj
         Zpca7uqxQ0s9Q35Yiwa4rPxoVmNYyD+3vw1aC6TwSDgDyXSM2fg4cMNdhoTX2WQqyDSv
         R2x3yXoxFE9yLQWtEEgaLlSKClvLLzAYSDn1xmF2j8VZ3UQUo9rGLznWkN5L4IcI6tBX
         d0vA==
X-Gm-Message-State: AD7BkJLY6zyPHG6laEfE+Vh0xqr9425v8c+4RGSsia74wTnH/yK3gUaPb0g0MnaJdHNVzA==
X-Received: by 10.66.55.39 with SMTP id o7mr54547288pap.13.1459792665949;
        Mon, 04 Apr 2016 10:57:45 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 4/5] MIPS: BMIPS: Add cpu-feature-overrides.h
Date:   Mon,  4 Apr 2016 10:55:37 -0700
Message-Id: <1459792538-19854-5-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
References: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

BMIPS_GENERIC being multiplatform and intended to support BMIPS3200,
BMIPS3300, BMIPS4350, BMIPS4380 and BMIPS5000-class processors, there is
not much more we can put in there since they do not share the same I and
D cache line sizes at all (doubled for every new generation
essentially), some processors have a S-cache, some don't, some have a
FPU, some don't.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
new file mode 100644
index 000000000000..fa0583e1ce0d
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H
+
+/* Invariants across all BMIPS processors */
+#define cpu_has_vtag_icache		0
+#define cpu_icache_snoops_remote_store	1
+
+/* Processor ISA compatibility is MIPS32R1 */
+#define cpu_has_mips32r1		1
+#define cpu_has_mips32r2		0
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+
+#endif /* __ASM_MACH_BMIPS_CPU_FEATURE_OVERRIDES_H */
-- 
2.1.0
