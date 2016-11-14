Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:08:06 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38197 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993041AbcKNCEcliNLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:32 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66dJ-0005pJ-3d; Mon, 14 Nov 2016 02:04:29 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66dA-0000mA-Px; Mon, 14 Nov 2016 02:04:20 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.892639814@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 270/346] MIPS: paravirt: Fix undefined reference to
 smp_bootstrap
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55803
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/mach-paravirt/kernel-entry-init.h | 2 ++
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
