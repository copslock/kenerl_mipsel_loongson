Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:25:44 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:55088 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993890AbdAQPXVBCSEa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:23:21 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MMsGt-1cLWIM0kcp-008euo; Tue, 17 Jan 2017 16:21:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] MIPS: avoid old-style declaration
Date:   Tue, 17 Jan 2017 16:18:47 +0100
Message-Id: <20170117151911.4109452-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:YW8KRKJUlwV/3wts/X+n71hOeAKFkKC7IBMjTfZRmU+3B3J7E5G
 Ib2Lc3W6PbA/J4ZkxiaAh/jo3jDc3gj0MtklD9hdhyTka3lcnhB3uddfleNAhoQgwf7MVPp
 /esUzArQ9TUmiW42jRvlNqJ8QfCt5x6q6FVBRkvLAKv/hKtlgZQKdFyK5pIHkNQmSKSWW/P
 k7wy46BqwjzrfgNHv0/Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XTm91CjSmgg=:qkYHDJISLyN4SZXQ5xJqDC
 uUmApvyBT3P5uHUGdpFAJ1eoV0YC9aZVD+6je5mtgcUrC30qIymtQR/GNUSz9NLh/cp+GGN49
 tLuWbf91VQMADVr65qfw7JgJlFrbEL8coH9HHkjsmIjFXIiQaYlLO16wCJSAy5U6pKdicQD1z
 57FOZDQwIIf0qu9CjrM9MxWAZMLUGjalYgv0qkD4+fjDKldDSPKftOCNPQW4U2TjciSwXvEkN
 0PkA6gYs/hObuHHAqqdS/KTVEf7vk1xGfGjzhE6jxUeuPQnTwqVeBBVYd1CAwo6Fr+0fy4wxP
 S5a8/e1cDzUSQopJ8iWMQD7xu/ZmKRivdpo5eesvt9rI9187e4JghuzKS7qTmbTkustxlNCa7
 TOZk5bCQwK4KJfpwMqB+YdQoKlRjvlsivDFttZFXt1oRKEE+mt3U7ZMs7H3jPRyV+WLRGnJe5
 R3DoM2Rx6zC0sEM17NRewbHz8Q7Snn/VCDgJstWPDiMX5Gsn8EYN1faL8Ech7dhwne3wZHwju
 utjc5SHUw8o+hPL60QYdwHlnoF/MoKN7nAYDmjJ4qIo6X3iYZkJXcwVnDxCqCwsY4tGArU/rw
 Q7k6YbkxdNYi0UpCaz7Anrs3xP4mEIJ7x0dk8IksCP4EaGb4Oo6f+XO5dQBDK/U/+o+iKY30j
 Tf7FOnQg3DinreP8MnUkNOQ0LkCayV0XrV6Kl3D67TUf0PF2JHp+0DCZoOSTFlG/xw20=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56356
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

gcc warns about nonstandard declarations:

arch/mips/sgi-ip32/ip32-irq.c:31:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
arch/mips/sgi-ip32/ip32-irq.c:36:1: error: 'inline' is not at beginning of declaration [-Werror=old-style-declaration]
arch/mips/sgi-ip27/ip27-klnuma.c: In function 'replicate_kernel_text':
arch/mips/sgi-ip27/ip27-klnuma.c:85:116: error: old-style function definition [-Werror=old-style-definition]

Moving 'inline' before the return type, and adding argument types
shuts up the warning here. This patch affects several platforms,
but all in a trivial way. I'm fixing up all instances I found in
any of the 'defconfig' builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/emma/markeins/setup.c  | 2 +-
 arch/mips/netlogic/xlp/wakeup.c  | 2 +-
 arch/mips/sgi-ip27/ip27-klnuma.c | 2 +-
 arch/mips/sgi-ip32/ip32-irq.c    | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/emma/markeins/setup.c b/arch/mips/emma/markeins/setup.c
index 9100122e5cef..44ff64a80255 100644
--- a/arch/mips/emma/markeins/setup.c
+++ b/arch/mips/emma/markeins/setup.c
@@ -90,7 +90,7 @@ void __init plat_time_init(void)
 static void markeins_board_init(void);
 extern void markeins_irq_setup(void);
 
-static void inline __init markeins_sio_setup(void)
+static inline void __init markeins_sio_setup(void)
 {
 }
 
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 87d7846af2d0..d61004dd71b4 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -197,7 +197,7 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 	}
 }
 
-void xlp_wakeup_secondary_cpus()
+void xlp_wakeup_secondary_cpus(void)
 {
 	/*
 	 * In case of u-boot, the secondaries are in reset
diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-klnuma.c
index bda90cf87e8c..2beb03907d09 100644
--- a/arch/mips/sgi-ip27/ip27-klnuma.c
+++ b/arch/mips/sgi-ip27/ip27-klnuma.c
@@ -82,7 +82,7 @@ static __init void copy_kernel(nasid_t dest_nasid)
 	memcpy((void *)dest_kern_start, (void *)source_start, kern_size);
 }
 
-void __init replicate_kernel_text()
+void __init replicate_kernel_text(void)
 {
 	cnodeid_t cnode;
 	nasid_t client_nasid;
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index e0c7d9e142fa..838d8589a1c0 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -28,12 +28,12 @@
 #include <asm/ip32/ip32_ints.h>
 
 /* issue a PIO read to make sure no PIO writes are pending */
-static void inline flush_crime_bus(void)
+static inline void flush_crime_bus(void)
 {
 	crime->control;
 }
 
-static void inline flush_mace_bus(void)
+static inline void flush_mace_bus(void)
 {
 	mace->perif.ctrl.misc;
 }
-- 
2.9.0
