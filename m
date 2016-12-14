Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 16:10:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7724 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992255AbcLNPJ5uwMw4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2016 16:09:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C572F732BF2FE;
        Wed, 14 Dec 2016 15:09:48 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 14 Dec 2016 15:09:51 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: Set defconfig target to a generic system for 32r2el
Date:   Wed, 14 Dec 2016 15:09:43 +0000
Message-ID: <1481728183-16776-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481728183-16776-1-git-send-email-matt.redfearn@imgtec.com>
References: <1481728183-16776-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56047
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

The default system type should be a MIPS generic kernel. In order to
include some level of board support, select a 32r2el generic defconfig
by default. The alternative would be to use "generic_defconfig" but
rather unintuitvely that is a bare bones configuration with no platform
support so is not usable in practice.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7b076f..51b0e7479f99 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -15,7 +15,7 @@
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
 
-KBUILD_DEFCONFIG := ip22_defconfig
+KBUILD_DEFCONFIG := 32r2el_defconfig
 
 #
 # Select the object file format to substitute into the linker script.
-- 
2.7.4
