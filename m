Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:12:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46607 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992166AbcI1JL06V9sG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:11:26 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91A3B8A6;
        Wed, 28 Sep 2016 09:11:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 50/69] MIPS: paravirt: Fix undefined reference to smp_bootstrap
Date:   Wed, 28 Sep 2016 11:05:32 +0200
Message-Id: <20160928090447.201853726@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090445.054716307@linuxfoundation.org>
References: <20160928090445.054716307@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 951c39cd3bc0aedf67fbd8fb4b9380287e6205d1 upstream.

If the paravirt machine is compiles without CONFIG_SMP, the following
linker error occurs

arch/mips/kernel/head.o: In function `kernel_entry':
(.ref.text+0x10): undefined reference to `smp_bootstrap'

due to the kernel entry macro always including SMP startup code.
Wrap this code in CONFIG_SMP to fix the error.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14212/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mach-paravirt/kernel-entry-init.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-paravirt/kernel-entry-init.h
@@ -11,11 +11,13 @@
 #define CP0_EBASE $15, 1
 
 	.macro  kernel_entry_setup
+#ifdef CONFIG_SMP
 	mfc0	t0, CP0_EBASE
 	andi	t0, t0, 0x3ff		# CPUNum
 	beqz	t0, 1f
 	# CPUs other than zero goto smp_bootstrap
 	j	smp_bootstrap
+#endif /* CONFIG_SMP */
 
 1:
 	.endm
