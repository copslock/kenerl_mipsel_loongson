Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 05:06:01 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42003 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842299AbaHTDFyW4ms8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2014 05:05:54 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so11095691pad.8
        for <multiple recipients>; Tue, 19 Aug 2014 20:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=YrYsIrW04XMk6RVYVxlH4VsBXtIszGqEZzJ1QBedU60=;
        b=kQI05Iuw9/fvWuChqCUTJsiJmjhQhoiPWBLh3+Vobl+7hwuHZKzVVf5d8qYDMnLSJ8
         5S9T3nAE0VPOpZHePaffzBmW6csyamswFSPAy9zUrT4sEaPQfHreSe0WccqaaI+SIuA1
         tQDZjBi0T2iDx5IVywP0O4CRJgF1cgiXVedHjveCWxeDClGfMpHT63uzEs58ERKS43Gt
         aSkiNc3LQIxHsyItCR8LisEVsU/3nwVw7u0Lfgh6wJa7cdyYvm8BGdT4Ta/6/mR4GyXr
         KDu66Dx1sZa6KhgUzDQTJX5rwMLvFQpjTJJPN8UuHcuW132crSKVy62nlTAYJvewwK7+
         5IuQ==
X-Received: by 10.66.235.1 with SMTP id ui1mr49397252pac.28.1408503945729;
        Tue, 19 Aug 2014 20:05:45 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id kh6sm33888091pad.0.2014.08.19.20.05.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 20:05:44 -0700 (PDT)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenhc@lemote.com, ralf@linux-mips.org, chenj <chenj@lemote.com>
Subject: [PATCH 1/2] mips: .../swab.h: fix a compiling failure
Date:   Wed, 20 Aug 2014 11:14:47 +0800
Message-Id: <1408504488-12319-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42154
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

It was introduced in commit
"mips: use wsbh/dsbh/dshd on Loongson3A"
(http://patchwork.linux-mips.org/patch/7542/)

Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/uapi/asm/swab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 20b884a..8f2d184 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -55,8 +55,8 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips64r2		\n"
-	"	dsbh	%0, %1\n"
-	"	dshd	%0, %0"
+	"	dsbh	%0, %1			\n"
+	"	dshd	%0, %0			\n"
 	"	.set	pop			\n"
 	: "=r" (x)
 	: "r" (x));
-- 
1.9.0
