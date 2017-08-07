Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:03:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64808 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994850AbdHGXChYHNLI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:02:37 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 71947779D6ABA;
        Tue,  8 Aug 2017 00:02:26 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:02:31
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH 3/7] MIPS: NI 169445: Only include in 32r2el kernels
Date:   Mon, 7 Aug 2017 16:01:14 -0700
Message-ID: <20170807230119.10629-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807230119.10629-1-paul.burton@imgtec.com>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The NI 169445 board uses a little endian MIPS32r2 CPU, and therefore
including board support in kernels that are unable to run on such a CPU
is pointless.

Specify requirements in the board config fragment that cause the NI
169445 board support to only be included in generic kernels that target
little endian MIPS32r2 CPUs.

For example, NI 169445 support will be included when configuring using
32r2el_defconfig but not when using 64r6_defconfig.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Nathan Sullivan <nathan.sullivan@ni.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---
I'm basing this upon the Kconfig entries that were present in the
initial upstream submission of NI 169445 board support[1]. If this is
wrong at all please let me know :)

[1] https://www.linux-mips.org/archives/linux-mips/2016-12/msg00016.html

 arch/mips/configs/generic/board-ni169445.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
index 0bae1f861a5b..f72223b366ca 100644
--- a/arch/mips/configs/generic/board-ni169445.config
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -1,3 +1,6 @@
+# require CONFIG_CPU_MIPS32_R2=y
+# require CONFIG_CPU_LITTLE_ENDIAN=y
+
 CONFIG_FIT_IMAGE_FDT_NI169445=y
 
 CONFIG_SERIAL_8250=y
-- 
2.14.0
