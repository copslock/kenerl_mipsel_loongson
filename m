Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 10:21:41 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9074 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6839072Ab3HUIT4l0Wvw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 10:19:56 +0200
Received: (qmail 11732 invoked by uid 89); 21 Aug 2013 08:19:56 -0000
Received: by simscan 1.3.1 ppid: 11570, pid: 11729, t: 0.1366s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO azrael.ibk.sigmapriv.at) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 21 Aug 2013 08:19:56 -0000
From:   Richard Weinberger <richard@nod.at>
To:     linux-arch@vger.kernel.org
Cc:     mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org,
        lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/8] mips: Do not use SUBARCH
Date:   Wed, 21 Aug 2013 10:19:30 +0200
Message-Id: <1377073172-3662-7-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/mips/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 37f9ef3..514fea6 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -42,12 +42,6 @@ tool-archpref		= $(64bit-tool-archpref)
 UTS_MACHINE		:= mips64
 endif
 
-ifneq ($(SUBARCH),$(ARCH))
-  ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
-  endif
-endif
-
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
   ifndef KBUILD_MCOUNT_RA_ADDRESS
     ifeq ($(call cc-option-yn,-mmcount-ra-address), y)
-- 
1.8.1.4
