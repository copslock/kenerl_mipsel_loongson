Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:20:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13887 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993949AbdHNST5HdfMp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 20:19:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0B6669033502E;
        Mon, 14 Aug 2017 19:19:47 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug 2017 19:19:50
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH v2 4/8] MIPS: NI 169445: Only include in suitable kernels
Date:   Mon, 14 Aug 2017 11:18:15 -0700
Message-ID: <20170814181819.7376-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170814181819.7376-1-paul.burton@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59574
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
little endian CPUs & architecture revisions prior to MIPSr6.

For example, NI 169445 support will be included when configuring using
32r2el_defconfig but not when using 64r6_defconfig.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Nathan Sullivan <nathan.sullivan@ni.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Nathan Sullivan <nathan.sullivan@ni.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- Use CONFIG_CPU_ISA_GE_R6 to allow inclusion in pre-R2 kernels

 arch/mips/configs/generic/board-ni169445.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
index 0bae1f861a5b..a8afd0950da1 100644
--- a/arch/mips/configs/generic/board-ni169445.config
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -1,3 +1,6 @@
+# require CONFIG_CPU_ISA_GE_R6=n
+# require CONFIG_CPU_LITTLE_ENDIAN=y
+
 CONFIG_FIT_IMAGE_FDT_NI169445=y
 
 CONFIG_SERIAL_8250=y
-- 
2.14.0
