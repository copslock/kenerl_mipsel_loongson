Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:09:40 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:56309 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835167Ab3FGXD5Zejw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:57 +0200
Received: by mail-ie0-f177.google.com with SMTP id u16so12057485iet.22
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NknnjWDuc1jCUg4IsGCoZZlheIObvgFGMWBMnTcvOxg=;
        b=RdksMXG0048p3Wg50RDbbWJ2Ym0Zr/Hee5ru74ecw3wvLLBY8IOWzJ73rsyS6z3xwS
         dvQ6Fo9wglf5tou54+nSco4LJeE8M5v767lesiifD+3nce/gVBG0tEjztYyUmBClEkqz
         u+edEmuLuC019qeQvJIlNpVDBmF9ihQMYzqFde4yAjIgFoJSfsZyg9HDoY1tjFafbciK
         GW2YKI0vn58XzwDWGzz1BSr1Id4T5vloyijwNg4qtSe+KjD99OdHV1X1fWpdPH6vtCq7
         kwuJglxb8r51T9xbSTckh/nCDQHLViqgWQZ6vW5eayojiX0yaT7EQE+y1xsWTUFN/A9s
         Ljww==
X-Received: by 10.50.153.113 with SMTP id vf17mr2204078igb.101.1370646231319;
        Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ir8sm1175075igb.6.2013.06.07.16.03.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:50 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3mha006674;
        Fri, 7 Jun 2013 16:03:48 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3m5Q006673;
        Fri, 7 Jun 2013 16:03:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 16/31] mips/kvm: Add exception handler for MIPSVZ Guest exceptions.
Date:   Fri,  7 Jun 2013 16:03:20 -0700
Message-Id: <1370646215-6543-17-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36734
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/genex.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 163e299..ce0be96 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -486,6 +486,9 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
 	BUILD_HANDLER mt mt sti silent			/* #25 */
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
+#ifdef CONFIG_KVM_MIPSVZ
+	BUILD_HANDLER hypervisor hypervisor cli silent	/* #27 */
+#endif
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
 	.align	5
-- 
1.7.11.7
