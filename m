Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:54:32 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:54785 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008997AbaIOXvp3CgbJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:45 +0200
Received: by mail-pa0-f73.google.com with SMTP id kx10so1030090pab.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCYL9UzLKz/4V2LFltSyfzrndtOx8ahqoJ+QZCGO/FI=;
        b=Z/1S9s6ljNp3cFaA7zLoFBiRQz4jXPqrAZhZlvTA/mN5/CfBYp/OvW5FkseGodA3f9
         Zp/kH+NkGyIL+Efr1kn7hdWiVeQQn5F9fx4DZWdrymgV0v3y/VgXaVqHaJIa7qwRySj0
         Gwqo9r3e8ZBjpTZyaFKR3FpcVaItZ3We+f6yzGR9mDVzv3pY6dhv80BsSt6prz3v16lv
         36C6Bt3azKtMMsQRy5ny4nXpqNZRZotoColj9gmXv46YlW4eXEUzoA7MpQJ45YhXOv2d
         sdC8sjnsXjpXnFhVEzCK5cpHu2uqxp1h5dQJDlWZJTAje8o7oGbeZPDnA4ScBIaIfUXd
         eAiw==
X-Gm-Message-State: ALoCoQk5cmbkyS6U9YschbIIzylus73FHivq8sELe/+Y5ZQXzyh4OKwZdM/AM7TRCq3BaWhtk7cm
X-Received: by 10.66.156.232 with SMTP id wh8mr17218626pab.27.1410825099565;
        Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id l45si631133yha.2.2014.09.15.16.51.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:39 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id cogZdeeo.3; Mon, 15 Sep 2014 16:51:39 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 6BEB322093F; Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
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
Subject: [PATCH 10/24] MIPS: sead3: Do not overlap CPU/GIC IRQ ranges
Date:   Mon, 15 Sep 2014 16:51:13 -0700
Message-Id: <1410825087-5497-11-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42628
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
