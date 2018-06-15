Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 08:03:24 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:44779
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992735AbeFOGDJn4kSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 08:03:09 +0200
Received: by mail-pg0-x241.google.com with SMTP id p21-v6so3958492pgd.11;
        Thu, 14 Jun 2018 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cQ0Zr39z12QlG7X4WdP0T/aW8LUlkv7qUejQgQI/fFE=;
        b=DDGEIt5xO6IigUF/OQIb5mZFMGo9uk13sJOtR2sQ9LKM2wfnhnBYn6n2ED58gZsgnx
         H1TY//uRV2TEx4SoypO3HK7tCvnOni5+ypXQmN13HgtjiK0woTPBCkTel/1tCEWW75GK
         NjNM3Z2rjf4PRdH8Fv4MJ79f/PWGo5lTzsx4nf/Vi1dxRqSedc1DZpEZkXjJ3toMQH30
         BcYp5KbuDZR6MIHBuVCp1xFm9bhCMPdHtTReqokm9H0wptmuM0cjWM0PJAy/0kmlNe1z
         YVmVj99zDAuhL6KPxFr8u+PTI0JeRxG7RrHMY0oC2GBYal1siEUQC7i+jWXfynesxrK6
         0Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cQ0Zr39z12QlG7X4WdP0T/aW8LUlkv7qUejQgQI/fFE=;
        b=BugI5JyYjwtBifUcTcbBB5Fjnn59mnpr7UttaKLyh2FBHi9bj9bB+U2BzbFd/017ha
         4y9qFMpv3LGnJHDmuRWnZcWOJ2DsoLF0iflEkSDkZvXaMEJkO3Mx7N3/F/9UxW6YgrYa
         TMjo3e/8yk1WtWPIEEpgEAkU7RW+C2OEXXSx15ukkNJSA4VPnKLIyyLe5ifP5fnOMGW+
         zJQtIo0fXOnF2l1Xyl0Tf/Hv3N/NBcaVJQWNCb3xSeNOw8aSSjcp/4ZkUpED6Ovacvq5
         E4ll9HHNqzxYLi82qpp7Knx/GCociIM0df4gAJho9S/QZyUju8/DNCzF59cr39Tltt58
         3iCQ==
X-Gm-Message-State: APt69E2EfHHLCwF/eMdkU/8a4CBhl7MHcT6q8NNcAo89/jm2Upbm0djF
        dyDGoc0XuONIQRNWyN/3V/UnTQ==
X-Google-Smtp-Source: ADUXVKIHlj99W116t+Pod258aDiClvbEvMu6VxLBzhOL8bD3CuJcZDiz6lYJDYuoKgtOw+tRS1PJOg==
X-Received: by 2002:a63:7255:: with SMTP id c21-v6mr290118pgn.99.1529042582309;
        Thu, 14 Jun 2018 23:03:02 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id a27-v6sm11737476pfc.18.2018.06.14.23.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:03:01 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Date:   Fri, 15 Jun 2018 14:07:38 +0800
Message-Id: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
has SFB (Store Fill Buffer) and READ_ONCE() may get an old value in a
tight loop. So in smp_cond_load_acquire() we need a __smp_mb() after
every READ_ONCE().

This patch introduce a Loongson-specific smp_cond_load_acquire(). And
it should be backported to as early as linux-4.5, in which release the
smp_cond_acquire() is introduced.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/barrier.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a5eb1bb..4ea384d 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -222,6 +222,23 @@
 #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
 #define __smp_mb__after_atomic()	smp_llsc_mb()
 
+#ifdef CONFIG_CPU_LOONGSON3
+/* Loongson-3 need a __smp_mb() after READ_ONCE() here */
+#define smp_cond_load_acquire(ptr, cond_expr)			\
+({								\
+	typeof(ptr) __PTR = (ptr);				\
+	typeof(*ptr) VAL;					\
+	for (;;) {						\
+		VAL = READ_ONCE(*__PTR);			\
+		__smp_mb();					\
+		if (cond_expr)					\
+			break;					\
+		cpu_relax();					\
+	}							\
+	VAL;							\
+})
+#endif	/* CONFIG_CPU_LOONGSON3 */
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
2.7.0
