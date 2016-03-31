Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:09:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025649AbcCaJGZDnMnq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:25 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C919DB195EB74;
        Thu, 31 Mar 2016 10:06:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:18 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:18 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 11/11] MIPS: KASLR: Print relocation Information on boot
Date:   Thu, 31 Mar 2016 10:05:42 +0100
Message-ID: <1459415142-3412-12-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When debugging a relocated kernel, the addresses of the relocated
symbols and the offset applied is essential information. If the kernel
is compiled with debugging information, then print this information
during bootup using the same function as the panic notifer.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 arch/mips/kernel/setup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d8376d7b3345..ae71f8d9b555 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -477,9 +477,18 @@ static void __init bootmem_init(void)
 	 */
 	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
 		unsigned long offset;
+		extern void show_kernel_relocation(const char *level);
 
 		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
 		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
+
+#if (defined CONFIG_DEBUG_KERNEL) && (defined CONFIG_DEBUG_INFO)
+		/*
+		 * This information is necessary when debugging the kernel
+		 * But is a security vulnerability otherwise!
+		 */
+		show_kernel_relocation(KERN_INFO);
+#endif
 	}
 #endif
 
-- 
2.5.0
