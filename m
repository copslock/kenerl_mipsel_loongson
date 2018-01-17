Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:29:31 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:43752
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994709AbeAQWXntEvnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:43 +0100
Received: by mail-lf0-x242.google.com with SMTP id o89so19873654lfg.10;
        Wed, 17 Jan 2018 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIoHly5CZcj8thz+1JzoIQ1MOffbGF581jPe7JjVNfI=;
        b=Iwm6A9IgVkBqdC4s+kfx8uqnuR12WULUrJRPog5BXOErzo8OULh9PXEisy1Yv1cy2D
         XQsTLSq5F/58aPLrYI8Sxl2IAIr8q3jujnmpDm/dOSOQvyXar8imkIOMEyiS8L681Y5k
         6M+xlOwXX+v9itw4nSJbU5+Wy2Vpzn/Xo4dcoAby0dYv2EnrXd8SAukjovz10p9o2/Dy
         jE1qfNPPEMPMid6iH3P/zeRjkaL4sRpsXzc77oMJY0REJ/qcU71F9j7CcVkrZeE6AhNY
         qS9X2wBvkcK+zkUVbh9IZRLKcLTTOjFgpj8FaO+NVrvXT2w8B7i6BXAEwAuXuY/0R+Dn
         z1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIoHly5CZcj8thz+1JzoIQ1MOffbGF581jPe7JjVNfI=;
        b=Vh0Wm2dhM3dgSkRXipLIS347eXhyLzAARaBBD4VbICPE6RvX9cUEuwu0J9VJfEX8Bo
         yiBaG1nRearvO83Fk23pISHRS8H7i1rI5+zruLPZQB84uSgOUKpeeRRSkJm7NlKpBHI/
         F2y0aKIDAvlUBt5bMHofEgF6ALtLhbSbEFuCrrcHS37+ZJuK/iQOp2jkUW2gn2O3WCDP
         J2StpAiEmNgbg+cfumi1I99qbdMgYR3dOUF3fnChnM0nsYaqkRJ3dzQac149CK+M+Xqm
         VqXlVZU+Cq5gW5b4V22JUMx1gqsQO9uFsvEYkgwnBPO0BcFs2+sx6tmdK7UKdcM4y8qQ
         cUHw==
X-Gm-Message-State: AKwxytd6u/GEPhU4Mqw26etedRyG8P5gD188F0+/W7zSDiLLdu4nbqCg
        pAVHEUpEKxkIvrMhWUuDdZnSFaVD
X-Google-Smtp-Source: ACJfBou03fTK6Xsz7w4ec7o17OmQtJPUXDDg061hmLo6vM6lhwh36h9r6vWFUCAqYfTS+HKm7PH7fg==
X-Received: by 10.46.32.216 with SMTP id g85mr8430143lji.133.1516227818122;
        Wed, 17 Jan 2018 14:23:38 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:37 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 14/14] MIPS: memblock: Deactivate bootmem allocator
Date:   Thu, 18 Jan 2018 01:23:12 +0300
Message-Id: <20180117222312.14763-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Memblock allocator can be successfully used from now for early
memory management

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 725b5ece7..a6c4fb6b6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,6 @@ config MIPS
 	default y
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
-	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
@@ -57,6 +57,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select NO_BOOTMEM
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
-- 
2.12.0
