Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 17:12:51 +0200 (CEST)
Received: from mail-bk0-f44.google.com ([209.85.214.44]:40512 "EHLO
        mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868729Ab3JGPMpT66m8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 17:12:45 +0200
Received: by mail-bk0-f44.google.com with SMTP id mz10so2738443bkb.3
        for <multiple recipients>; Mon, 07 Oct 2013 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=k4hR0ttyb8kXWKkGgZFOwdhnBpcCrLaI5OCcmSdDOb4=;
        b=d8EMv7Kg7QmiOsVTRKMedmwEV3rYyPw3YGkWx0BDCuFEh04SZcz80MQ0ERi+2ANdm4
         4jVgXeSyT+vG1WBDWyo8zris2OrEEB0w4PVpFx0L8KUIIF7jw7ssGg7qolXy/ZoZ5qoY
         M3bXX5/9pw7oUEELTeTrc1LLMp6r5NqYE0siuO+/AE+BYmdZh4gISgBV1zVkAk2GZSrV
         zGN5D7/tevma4biZ/mb4eYjyYZuwIussf0GnAWVo4PePJODQOWZRrfydvWUgMyKgyeF1
         f7yXo0dxXngLANTQtE0a2InqMbQ1F5H7S4DgWZkK/VyGrnABHhfwbGsJGrYlGrukMX9K
         vgsw==
X-Received: by 10.205.65.17 with SMTP id xk17mr27160745bkb.19.1381158759712;
        Mon, 07 Oct 2013 08:12:39 -0700 (PDT)
Received: from localhost (port-46445.pppoe.wtnet.de. [46.59.230.36])
        by mx.google.com with ESMTPSA id jt14sm17506214bkb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 08:12:38 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: SmartMIPS: Fix build
Date:   Mon,  7 Oct 2013 17:10:42 +0200
Message-Id: <1381158642-10598-1-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

All CONFIG_CPU_HAS_SMARTMIPS #ifdefs have been removed from code, but
the ACX register declaration in struct pt_regs is still protected by it,
causing builds to fail. Remove the #ifdef protection and always declare
the register.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/mips/include/asm/ptrace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 7bba9da..d47bdce 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -33,9 +33,7 @@ struct pt_regs {
 	unsigned long cp0_status;
 	unsigned long hi;
 	unsigned long lo;
-#ifdef CONFIG_CPU_HAS_SMARTMIPS
 	unsigned long acx;
-#endif
 	unsigned long cp0_badvaddr;
 	unsigned long cp0_cause;
 	unsigned long cp0_epc;
-- 
1.8.4
