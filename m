Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 09:46:21 +0100 (CET)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:34347
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994550AbeK2Io26jIfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 09:44:28 +0100
Received: by mail-pg1-x541.google.com with SMTP id 17so624016pgg.1
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1oTkPJ6qrXNeDh6ydGScbRxC5yjbuUQ1NYPCDxj/lM=;
        b=g+t3zy6I97eqy6vXR1JgC0qJ4uRNIfYaFSMilJh7FKjhFf3VZoYJBep1Skw2y6+tFM
         /+sIUg2r6S1/A01sJd17/FZYr8Egc3yVztjJO2hk2hAChZr/hiZfsO4109BRiqCybxA+
         Est1cQyutH3gwPgABQBC+uWQjGrLSm5lqGJEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O1oTkPJ6qrXNeDh6ydGScbRxC5yjbuUQ1NYPCDxj/lM=;
        b=rMu8BwBpmzGYEKEVYAyET08EaT0dQInhVIfWUZMQ8/a+XMiafr1KvTvbued4/R1/9x
         FNYJ+ZKA5qSC0XYmtjiyxgTiTpE3/JQy3ll79Q2uvQUUFzNAjxmmsxmiNfBEUxkkatZ9
         9M0VYcvUf3C73y7jfs2BU7Tb57+IZEv1nzV3vRJcQoemArTSaSgwkefqLF+EGm/s6QUd
         ESfTyYGFQOrpi8AXd7ALgCD0Vzl8M3lHXKyh/MCkTgfu3vE+sn4IHyQtvp9F63PdjcD4
         3jZ3dG5PmV0BqWsIGDy8mB1PFhOllGRynrDwLc5KrxoI6BnPQMeTTTqQWQ2Na0qBnObx
         vf/w==
X-Gm-Message-State: AA+aEWZSEsGbV6BZemZUh0Tjcn61SDwd77AHGSet+8FwFDqFNywSLT2G
        3bD1n6AK8oQKGJVW/W/P2W5XHM9IWl4=
X-Google-Smtp-Source: AFSGD/UECveWtMxOKiCQHDFoCzdBFt592KuxWOFfs5ClJ08kAUVtenkqlNepJc2UujYJKmv+TN2pVA==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr456110pgc.139.1543481068123;
        Thu, 29 Nov 2018 00:44:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:27 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 2/6] mips: remove unused macros
Date:   Thu, 29 Nov 2018 14:13:32 +0530
Message-Id: <1543481016-18500-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

Remove NR_syscalls from asm/unistd.h as there is no
users to use NR_syscalls macro in mips kernel.

MAX_SYSCALL_NO can also remove as there is commit
2957c9e61ee9 ("[MIPS] IRIX: Goodbye and thanks for
all the fish"), eight years ago.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h | 8 --------
 arch/mips/kernel/scall32-o32.S | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..d7ee846 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -14,14 +14,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
-#elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
-#else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..fea6edb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -22,9 +22,6 @@
 #include <asm/war.h>
 #include <asm/asm-offsets.h>
 
-/* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
-
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
-- 
1.9.1
