Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 17:33:59 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992227AbdDJPdvGzq1Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 17:33:51 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72F17AC21;
        Mon, 10 Apr 2017 15:33:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 009/142] MIPS: ip22: Fix ip28 build for modern gcc
Date:   Mon, 10 Apr 2017 17:31:30 +0200
Message-Id: <90a5fa3ef7b3c7e0c1a196bff0fc8f0630afef5e.1491838390.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
References: <d4b83d12d815bafc24064e91de353edb2478d8f7.1491838390.git.jslaby@suse.cz>
In-Reply-To: <cover.1491838390.git.jslaby@suse.cz>
References: <cover.1491838390.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Arnd Bergmann <arnd@arndb.de>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 23ca9b522383d3b9b7991d8586db30118992af4a upstream.

kernelci reports a failure of the ip28_defconfig build after upgrading its
gcc version:

arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.

The problem apparently is that the -mr10k-cache-barrier=store option is now
rejected for CPUs other than r10k. Explicitly including the CPU in the
check fixes this and is safe because both options were introduced in
gcc-4.4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15049/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/sgi-ip22/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index b7a4b7e04c38..e8f6b3a42a48 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -25,7 +25,7 @@ endif
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
 ifdef CONFIG_SGI_IP28
-  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
+  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
 endif
-- 
2.12.2
