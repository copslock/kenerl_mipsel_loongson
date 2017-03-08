Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 02:47:50 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:36122
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993900AbdCHBq4YZHqG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 02:46:56 +0100
Received: by mail-qk0-x241.google.com with SMTP id n141so6581776qke.3;
        Tue, 07 Mar 2017 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Zn4LCpPog9O/bDnF0RR4ZnCx9wMGmIfucyns7szNm0=;
        b=eDb0LWNNotMbZliiD7/15izEyz9nsNej9HKdwy828iN96ZG1PkpGQFoxSbNlfmr5ZT
         f6PEVMD0wgzql6JM9KQbmaQft45GdGAyKMSmBMBtcTtSkO/gW98kAr5yL/0RGElsoOiF
         R+IPIWhNatm7mBn0sMt7gCNaOzj36egl1cR1UCl8W8C+mybSkmsQ4Lfq86Qf5oGIcAvc
         jOPQEOaaHv5GRVrNkOUeExwisN1bnYx3O0yg84uXYNyEc2NKQhRmpvhHL0A32xWER4PF
         tdvH6PZcEceirSEVtcIex0RBuvxvGoWttUHQ/5bCKTfvBVMZBaBdiM9c3ZsmDiw96atf
         O57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Zn4LCpPog9O/bDnF0RR4ZnCx9wMGmIfucyns7szNm0=;
        b=t0DtT+PVYUOoTOOmUaBTSrJotmhGlXksVF6084Nbdwe42Q/KJuDqgV4xNlhFL9ov5d
         TrGBQRskr4Nw8YbMa9XnmIZbtLANejIe215jWoz3A6t8GnvYgWQMjKQPoguYnKw5XZAD
         /UdrAbktJ65PUK4rHIcN5NVmvO+6Cfv76W6TAuGx87n2qHFqS4YZVQu2uOf1sgNBW4FX
         8BGqeu+1eEigVLyjZr8aJ7yhHhkXRm8ENfD7F4YksOhHicjJICY499a6Cg13X6E3kDV/
         l4bYXc27QCyPK9xqmREhGQeNAcDfwzvL6LJbHO+Rl27api4340QO+tyZQt564h7WzpET
         ayYA==
X-Gm-Message-State: AFeK/H2PJBjFWhi+Za9G0CMHZIQXsC1oitQkUHo8yuQZlVISAnrUPCd33CTQscXPP++PJw==
X-Received: by 10.55.190.69 with SMTP id o66mr4372125qkf.0.1488937610861;
        Tue, 07 Mar 2017 17:46:50 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id h27sm1198892qtf.24.2017.03.07.17.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 17:46:50 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, marcin.nowakowski@imgtec.com,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: c-r4k: Do not SMP function call during kexec
Date:   Tue,  7 Mar 2017 17:46:41 -0800
Message-Id: <20170308014641.16267-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308014641.16267-1-f.fainelli@gmail.com>
References: <20170308014641.16267-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57078
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

On SMP r4k cache style systems, we cannot issue a
smp_function_call_many() like what __flush_cache_all() does *after* we
have disabled interrupts for the calling CPU. Add a special check, and
do a local cache operation instead.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e7f798d55fbc..ea2998f1f5c5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/bitops.h>
+#include <linux/kexec.h>
 
 #include <asm/bcache.h>
 #include <asm/bootinfo.h>
@@ -494,7 +495,10 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
-	r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
+	if (!kexec_in_progress)
+		r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
+	else
+		local_r4k___flush_cache_all(NULL);
 }
 
 /**
-- 
2.9.3
