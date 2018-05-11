Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 07:56:47 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990402AbeENFzSULHXO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 07:55:18 +0200
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CE221836;
        Fri, 11 May 2018 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526075245;
        bh=rw1hNf7v6L1vf7kBqU2XhxPygC7Fr62l9Gz+d+5z48g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZgzrPtEZSmTPJH5+JtPDyBao+W4o3vXm46W1VUSpgaWRdf1wybU1jamVSlyBmJbVJ
         kpcpMFCGpT9d9wPFpG5C040BosO4BSriE48gQ1fNIPKfObIG4HoSNRM/Mg6kEqp+qC
         RXieY0sFi7n10woRDfYX6gslySn9uzx7w8QtT7hU=
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Cc:     James Hogan <jhogan@kernel.org>
Subject: [PATCH v4 2/4] um: Add generated/ to MODE_INCLUDE
Date:   Fri, 11 May 2018 22:47:00 +0100
Message-Id: <d820cbb19a333cdfc4a24d0c6b2c3f09def1f3e5.1526074770.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
References: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
References: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Add the um specific generated includes directory to MODE_INCLUDE so that
asm/compiler.h can be used for overriding linux/compiler*.h which is
included automatically, with um using a generated asm-generic wrapper at
arch/um/include/generated/asm/compiler.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
Changes in v4 (James):
- New patch in v4.
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..543d12d230ab 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -30,6 +30,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/os-$(OS)/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/generated
 
 HEADER_ARCH 	:= $(SUBARCH)
 
-- 
git-series 0.9.1
