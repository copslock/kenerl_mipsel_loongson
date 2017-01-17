Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:22:30 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:50385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993901AbdAQPVIyy-sd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:08 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M6JK7-1ceQgp32SZ-00yQ9m; Tue, 17 Jan 2017 16:19:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Alban Bedel <albeu@free.fr>, Paul Bolle <pebolle@tiscali.nl>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] MIPS: zboot: fix 'make clean' failure
Date:   Tue, 17 Jan 2017 16:18:38 +0100
Message-Id: <20170117151911.4109452-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:hx1BCt6Jr5owvIVSnNyOb3eqckbIhyQH1Ydp9lAHSplvsRbvfKI
 fiv8vp/Dy/y0t19m7Ruf0j718n45NteM3nlClzEIJIlMvEs0siazzgwlucK/LdQe1UJ3cjF
 hpToIqMdy/3lrzd1nk3WXxGOmC4I8IYlrvQZ6SNiMq13VWet9QGuTk2LSYLuyFhE6nddOYL
 mffd3fDsvltupIxFVg9UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pie7LLgf0a4=:Zy05oRGapIioOu5KcBsa6q
 odm0qR7m6TCyu69D5ynvSl0Yro1b99uiw7Mp6DaRpZRShOYvCCFbC8nntZ85dEe9hzZkKAtyT
 L7NG2SeDPeaayrUfA9BlKA1+1MgT2eBlPYSdy2tL+NSgh2U558He+SVUpPjI/FtkO8+491Nll
 +dZFZi1pacpErToBuyd4xZsHDib1XIU0aUt0zkynY5P2Jo6BBVbubNpQ5lAdOQtcTxaXsPkIP
 FZhrb9yxPX8eTjCotUZuNUkwae433D3rOuvZ7Aq/Zi1azHcLcxgrszHVdnSISg+ASxjRtFXEf
 ly+GZIylMiqQbYUgPmIz8RaKNYjzLmaJl4dfupcKWFFQ5UOiHoWOACg9s4qrwVb6MO9awwfuK
 2Ww0S5oofUAqDvQN3zJFPN/54MhrjsbrfzfGanLynP67nlJptBhwuKaNql/it6BWZJhbiBo1j
 64RiMEmkiDNNlAl10HrzDyyG/JABhc4oKWHTEdr0pt8eZwhmkWJlFfsEQt/VqmnowxEsngqtq
 5LixFtXrkpX3qPLjP7YeoP858hetN3EUl8WNOTV/H4MIjlp2U59OOS97H5yaSeEeN+KyAhso4
 ZGkCGBJ+pZifACiJDEBD5mrEKLGy7K/cK5AssNMySIbxDCwXdb9gexlIgU0yNSWtfpfATk3bk
 d/u2dW2ZbZWEieEa2/+H2Wpj92C66Jg8vZrYd5LPNYN4DShU1qLKAwR35LsyYvbxCfxA=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The filter-out macro needs two arguments, passing only one is
clearly the result of a typo that leads to 'make clean' failing
on MIPS:

arch/mips/boot/compressed/Makefile:21: *** insufficient number of arguments (1) to function 'filter-out'.  Stop.

Fixes: afca036d463c ("MIPS: zboot: Consolidate compiler flag filtering.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/boot/compressed/Makefile | 2 +-
 arch/mips/include/asm/uaccess.h    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 608389a4a418..c675eece389a 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
 BOOT_HEAP_SIZE := 0x400000
 
 # Disable Function Tracer
-KBUILD_CFLAGS := $(filter-out -pg $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
 
 KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
 
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 5347cfe15af2..c66db8169af9 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -80,6 +80,9 @@ extern u64 __ua_limit;
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
+extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
+extern size_t __copy_user(void *__to, const void *__from, size_t __n);
+
 /*
  * eva_kernel_access() - determine whether kernel memory access on an EVA system
  *
-- 
2.9.0
