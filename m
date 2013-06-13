Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 22:55:58 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:58489 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835278Ab3FMUzUPmPXN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 22:55:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UnEY6-0005JR-6R; Thu, 13 Jun 2013 15:55:14 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 2/3] MIPS: malta: Move defines of reset registers and values.
Date:   Thu, 13 Jun 2013 15:55:05 -0500
Message-Id: <1371156906-31563-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
References: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Remove usage of 'include/asm/mips-boards/generic.h' header file.
Instead, move the defines for SOFTRES_REG and GORESET local to
the platform file.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mti-malta/malta-reset.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 3294205..7911012 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -27,7 +27,9 @@
 
 #include <asm/io.h>
 #include <asm/reboot.h>
-#include <asm/mips-boards/generic.h>
+
+#define SOFTRES_REG	0x1f000500
+#define GORESET		0x42
 
 static void mips_machine_restart(char *command)
 {
-- 
1.7.2.5
