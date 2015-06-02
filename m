Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 00:47:03 +0200 (CEST)
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34256 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026906AbbFBWrBeYo0C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 00:47:01 +0200
Received: by qkoo18 with SMTP id o18so110061851qko.1;
        Tue, 02 Jun 2015 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KAJdLrffVXop1/OXjQ1+pCWZqgwowqjgGfNOvEO+Ly4=;
        b=KJDBM51mWvIVWtN+3WEYMBapz6qs4FoMvH+80CNxIirRx9sSdxlIpsoV1UkptVUre0
         R2MuyGnz3ovhojfJkMOT46kEItnu0QX4mlsAhtzdwtlngrCkoReeUlLofrOJtRh/4jXK
         SnOSVW35ORM2DHYzp5pTZHyg4KzzF65e9yV9KvuRCShjVxVV+Xsz0DZkI1jkreZV+62q
         57mojX2LaWHXIAva1ODPNvgKj3bW5q8GV4hEdOIgGSppbWnl8CvNwHNCZFjZOIIFXcOe
         8Qgby/wPeFcKbf3NOHg2x+qlpYQ2wzmBVqY5NEBBz+94Kw2gjM1D3vsWgxtjhl3Aq50A
         vMyw==
X-Received: by 10.55.18.144 with SMTP id 16mr51649842qks.17.1433285215667;
        Tue, 02 Jun 2015 15:46:55 -0700 (PDT)
Received: from rob-hp-laptop.corp.google.com ([2620:0:1000:fd86:99a5:7f6a:c368:4023])
        by mx.google.com with ESMTPSA id c20sm8169085qka.21.2015.06.02.15.46.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 15:46:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: prepare for user enabling of CONFIG_OF
Date:   Tue,  2 Jun 2015 17:46:42 -0500
Message-Id: <1433285204-4307-2-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1433285204-4307-1-git-send-email-robh@kernel.org>
References: <1433285204-4307-1-git-send-email-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

In preparation to allow users to enable DeviceTree without arch or
machine selecting it, we need to fix build errors on MIPS. When
CONFIG_OF is enabled, device_tree_init cannot be resolved. This is
trivially fixed by using CONFIG_USE_OF instead of CONFIG_OF for prom.h.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/prom.h | 2 +-
 arch/mips/kernel/prom.c      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index 8ebc2aa..0b4b668 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_PROM_H
 #define __ASM_PROM_H
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 #include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/types.h>
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index e303cb1..b130033 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -18,6 +18,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 
+#include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/prom.h>
 
-- 
2.1.0
