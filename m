Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:40:50 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdDJQkkRiiiJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:40:40 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 70F20B80;
        Mon, 10 Apr 2017 16:40:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 27/32] MIPS: Force o32 fp64 support on 32bit MIPS64r6 kernels
Date:   Mon, 10 Apr 2017 18:39:17 +0200
Message-Id: <20170410163843.079809660@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410163839.055472822@linuxfoundation.org>
References: <20170410163839.055472822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57638
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 2e6c7747730296a6d4fd700894286db1132598c4 upstream.

When a 32-bit kernel is configured to support MIPS64r6 (CPU_MIPS64_R6),
MIPS_O32_FP64_SUPPORT won't be selected as it should be because
MIPS32_O32 is disabled (o32 is already the default ABI available on
32-bit kernels).

This results in userland FP breakage as CP0_Status.FR is read-only 1
since r6 (when an FPU is present) so __enable_fpu() will fail to clear
FR. This causes the FPU emulator to get used which will incorrectly
emulate 32-bit FPU registers.

Force o32 fp64 support in this case by also selecting
MIPS_O32_FP64_SUPPORT from CPU_MIPS64_R6 if 32BIT.

Fixes: 4e9d324d4288 ("MIPS: Require O32 FP64 support for MIPS64 with O32 compat")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15310/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1412,7 +1412,7 @@ config CPU_MIPS32_R6
 	select CPU_SUPPORTS_MSA
 	select GENERIC_CSUM
 	select HAVE_KVM
-	select MIPS_O32_FP64_SUPPORT
+	select MIPS_O32_FP64_SUPPORT if 32BIT
 	help
 	  Choose this option to build a kernel for release 6 or later of the
 	  MIPS32 architecture.  New MIPS processors, starting with the Warrior
