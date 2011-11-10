Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 19:50:06 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:39878 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903566Ab1KJSuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 19:50:02 +0100
Received: by yenl9 with SMTP id l9so2744525yen.36
        for <multiple recipients>; Thu, 10 Nov 2011 10:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vy/gDek8POt2mp/YcikOdyYMdgIlG4FvCR2+SLUZYrs=;
        b=J7eHFdo474YZd+8lPDflTHH5Dvt6TQqwHdyuWoiSMxivOvy9YlhimKrMRaRBa5WmX3
         VACh9FxLm+Kb17dei3CzM1wraO6rL+xJPLoZN1/8BOp5mg/ymMiuC8XK+RmWgWqPsZMM
         ONRVCboP0WNJK0ywDy4jTZHn8kiwetCbokmOo=
Received: by 10.101.85.4 with SMTP id n4mr3809998anl.155.1320950996627;
        Thu, 10 Nov 2011 10:49:56 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i31sm4195046anm.19.2011.11.10.10.49.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 10:49:55 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAAInsRb010868;
        Thu, 10 Nov 2011 10:49:54 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAAInsgF010867;
        Thu, 10 Nov 2011 10:49:54 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH Resend 2/2] MIPS: Randomize PIE load address
Date:   Thu, 10 Nov 2011 10:49:50 -0800
Message-Id: <1320950990-10827-2-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1320950990-10827-1-git-send-email-david.daney@cavium.com>
References: <1320950990-10827-1-git-send-email-david.daney@cavium.com>
X-archive-position: 31503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9641

... by selecting ARCH_BINFMT_ELF_RANDOMIZE_PIE

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8f1b76a..64934ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
+	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 
 menu "Machine selection"
 
-- 
1.7.2.3
