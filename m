Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:11:43 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:50249 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835173Ab3FGXD7Nnexp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:59 +0200
Received: by mail-ie0-f171.google.com with SMTP id s9so12126696iec.2
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aZ1XDNQoGzrg4LRkDzgrLGSCrBOVjExggtg9/Dyb+yU=;
        b=rvmX1dq426PGxDzTFAPjwehYMq7MvANiAHJGJsAVWXbuGVlV2zQeCs3PVRDkEEXeC0
         cVS34y5YhtLDsfYeD0rq49qmPGtL/eRznTcvMZ8uiom82gH90k1m87Td96kpMOvNbhbY
         irK8GAnagZiGV208YU0/Pn3/dD9ZaLZ1GUojvMi/eqv5t7jEfKH6LTG/eHxl+s9YHoLZ
         UPK/fnfF6p9pQYljsJBsyvUlvUru+AmIIQQ9Flt36yHU2XR3c9/DI0im8wNkBMBTUurF
         9QYc1RztqYqAdTPCasOt0QEcaK6Tw7/sKpsGPTjOi+xunZwYScrWrVttbqMqLXJEnqsJ
         tQOw==
X-Received: by 10.50.8.10 with SMTP id n10mr466003iga.20.1370646233112;
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lr5sm225603igb.1.2013.06.07.16.03.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3oej006694;
        Fri, 7 Jun 2013 16:03:50 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3odj006693;
        Fri, 7 Jun 2013 16:03:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 21/31] mips/kvm: Allow set_except_vector() to be used from MIPSVZ code.
Date:   Fri,  7 Jun 2013 16:03:25 -0700
Message-Id: <1370646215-6543-22-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

We need to move it out of __init so we don't have section mismatch problems.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uasm.h | 2 +-
 arch/mips/kernel/traps.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 370d967..90b4f5e 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_EXPORT_UASM
+#if defined(CONFIG_EXPORT_UASM) || IS_ENABLED(CONFIG_KVM_MIPSVZ)
 #include <linux/export.h>
 #define __uasminit
 #define __uasminitdata
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f008795..fca0a2f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1457,7 +1457,7 @@ unsigned long ebase;
 unsigned long exception_handlers[32];
 unsigned long vi_handlers[64];
 
-void __init *set_except_vector(int n, void *addr)
+void __uasminit *set_except_vector(int n, void *addr)
 {
 	unsigned long handler = (unsigned long) addr;
 	unsigned long old_handler;
-- 
1.7.11.7
