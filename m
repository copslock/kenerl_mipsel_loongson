Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 20:39:32 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:64769 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904144Ab1KRTiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 20:38:12 +0100
Received: by ggnb1 with SMTP id b1so3418347ggn.36
        for <multiple recipients>; Fri, 18 Nov 2011 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NNp2WWMB6TPLoXfP2DLUu9TIuxy8zY9y1tjlPZUeH0s=;
        b=h1CkD+oKmwh5Fj2UgSmEN8x0ABFbJiyQe+Yl3tXUDwAIXfGfx4XDOzgve02j5qkFoN
         nsn7wCAeYtP7ci/i6sgCBS+zH5eJ76zKYrfYOwT7USx6XEj1JViJAxckpXD3L0eiz3v2
         Bz3CyIuFL/Gr8omFBV8IDDrFw/ZvP2zcmSC+o=
Received: by 10.236.139.197 with SMTP id c45mr7442180yhj.64.1321645085450;
        Fri, 18 Nov 2011 11:38:05 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d5sm2117903yhl.19.2011.11.18.11.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 11:38:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAIJc31w020529;
        Fri, 18 Nov 2011 11:38:03 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAIJc31F020528;
        Fri, 18 Nov 2011 11:38:03 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 4/5] MIPS:  Select BUILDTIME_EXTABLE_SORT
Date:   Fri, 18 Nov 2011 11:37:47 -0800
Message-Id: <1321645068-20475-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15871

From: David Daney <david.daney@cavium.com>

We can sort the exeception table at build time for MIPS, so let's do
it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0c55582..adfe083 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
+	select BUILDTIME_EXTABLE_SORT
 
 menu "Machine selection"
 
-- 
1.7.2.3
