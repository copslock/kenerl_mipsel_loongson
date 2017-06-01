Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:48:46 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37260 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993990AbdFAPosmFqd- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:44:48 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHC-000506-Va; Thu, 01 Jun 2017 16:44:43 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHA-0007lq-NO; Thu, 01 Jun 2017 16:44:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Huacai Chen" <chenhc@lemote.com>, "Arnd Bergmann" <arnd@arndb.de>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Maarten ter Huurne" <maarten@treewalker.org>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>
Date:   Thu, 01 Jun 2017 16:43:16 +0100
Message-ID: <lsq.1496331796.999115181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/212] MIPS: 'make -s' should be silent
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.44-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 8c9b23ffb3f92ffa4cbe37b1bab4542586e0bfd1 upstream.

A clean mips64 build produces no output except for two lines:

  Checking missing-syscalls for N32
  Checking missing-syscalls for O32

On other architectures, there is no output at all, so let's do the
same here for the sake of build testing. The 'kecho' macro is used
to print the message on a normal build but skip it with 'make -s'.

Fixes: e48ce6b8df5b ("[MIPS] Simplify missing-syscalls for N32 and O32")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Maarten ter Huurne <maarten@treewalker.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15040/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -333,11 +333,11 @@ CLEAN_FILES += vmlinux.32 vmlinux.64
 
 archprepare:
 ifdef CONFIG_MIPS32_N32
-	@echo '  Checking missing-syscalls for N32'
+	@$(kecho) '  Checking missing-syscalls for N32'
 	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
-	@echo '  Checking missing-syscalls for O32'
+	@$(kecho) '  Checking missing-syscalls for O32'
 	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=32"
 endif
 
