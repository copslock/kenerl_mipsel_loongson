Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 05:06:20 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62691 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855138AbaHTDGKSiik1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2014 05:06:10 +0200
Received: by mail-pa0-f41.google.com with SMTP id rd3so11091580pab.0
        for <multiple recipients>; Tue, 19 Aug 2014 20:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cSa41YgeBX8vxqDrMg8C4tEMe547YuhDZquXBBKj6Q=;
        b=bYR+73EIpuvxeTso9H0RSg6xcRxYRPvBeAPBgrZ9xpFY9hlebzi3mgjU67kkvvoS9x
         oT9LkbLl3vbps68Yn/bVUyctQTCZJnmepqwTvoCXTolA7wn2SuGyoB5Ta+0iVzzD/KFd
         j0zT5bqk4Mifo/vU5D8ce2z/WdeTB+RjgDqZ7lPU8GQVOW3ieqUbDgIYnqhMZEDqQ3ZY
         Ah4miomluLHyiDGXnvxV2EGOJvdK4+3F/tRi9UwZEVFh8ma2CghwqJVw9s+ztO07ndYC
         ntiudtcaxv6scke5T5I/QL7J3iDX8lBugPHqZyqZIiCNCT5W4eQciWzHTMbbODs2+1J6
         3c0w==
X-Received: by 10.66.129.139 with SMTP id nw11mr49226307pab.16.1408503956409;
        Tue, 19 Aug 2014 20:05:56 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id kh6sm33888091pad.0.2014.08.19.20.05.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 20:05:55 -0700 (PDT)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenhc@lemote.com, ralf@linux-mips.org, chenj <chenj@lemote.com>
Subject: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
Date:   Wed, 20 Aug 2014 11:14:48 +0800
Message-Id: <1408504488-12319-2-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1408504488-12319-1-git-send-email-chenj@lemote.com>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

commit "mips: use wsbh/dsbh/dshd on Loongson 3A"
(http://patchwork.linux-mips.org/patch/7542/) forgot to define this
switch, hence the optimized path in arch/mips/include/uapi/asm/swab.h
is not enabled on Loongson3.

Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson/Platform | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 0ac20eb..5f527d1 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -22,6 +22,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
   endif
 endif
 
+# Define _MIPS_ARCH_LOONGSON3A for Loongson3
+cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A
+
 #
 # Loongson Machines' Support
 #
-- 
1.9.0
