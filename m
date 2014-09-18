Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:52:18 +0200 (CEST)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:37422 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009249AbaIRVruMPR8K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:50 +0200
Received: by mail-ob0-f202.google.com with SMTP id vb8so310644obc.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QaeXfTZgftkyFpwwo2/eOsqg3u8oLv/0QxGBrXcoju0=;
        b=kpuobWpJstA/4Nt3pUwPaDlpIk+0NE+Dis/0qthBkaB3sMLXOUaO0ArQVvZVeL45Rk
         G9ec47tUr8Tmj9dHnTwAkGraeEbZWiaVXquVh9N0D/YGuzXOrKzHravTDl4QfGA2kz3q
         FU92VYwfCdA5kawn75hsFYYG2GLHNNyT1yGaCeyNE64GCgOgerk5zafbGQkzmMk1z0yi
         eN7y9Q59xxsZb1q4BIpaQhm/cAG0gMJtbXQmD5lDxflayDN3ckOOBB6d54uzVliq+3hu
         uTXMBVpltD2mpD++4GuR9OYB9zH5KWrPPU5GKfDX1oxnFKu8onP0fkWKbhTDy6YvpKPg
         wcGw==
X-Gm-Message-State: ALoCoQkutQpYy6KtAqgSJY5iVQuBgKc37zJQZvfg+iifYpZT2vd+9xd7HWtO9vZHlmlgWJN0Qj71
X-Received: by 10.182.191.36 with SMTP id gv4mr1119112obc.50.1411076860819;
        Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si1750yha.6.2014.09.18.14.47.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:40 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.3; Thu, 18 Sep 2014 14:47:40 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B273F220B91; Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/24] MIPS: sead3: Do not overlap CPU/GIC IRQ ranges
Date:   Thu, 18 Sep 2014 14:47:16 -0700
Message-Id: <1411076851-28242-11-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

In preparation for GIC IRQ domain support, assign a GIC IRQ base
that does not overlap with the CPU IRQs.

Note that this breaks SEAD-3 when the GIC is in EIC mode, though
I'm not convinced it was working before either.  It will be fixed
in the following patches.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/include/asm/mips-boards/sead3int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index 6b17aaf..2320331 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -14,6 +14,6 @@
 #define GIC_BASE_ADDR		0x1b1c0000
 #define GIC_ADDRSPACE_SZ	(128 * 1024)
 
-#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 0)
+#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
 
 #endif /* !(_MIPS_SEAD3INT_H) */
-- 
2.1.0.rc2.206.gedb03e5
