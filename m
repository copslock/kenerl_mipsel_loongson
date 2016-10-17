Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 11:09:57 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:57716 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990864AbcJQJJu15iMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 11:09:50 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 3F36FCC9AB66A;
        Mon, 17 Oct 2016 10:09:41 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 10:09:44 +0100
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 10:09:43 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Fix build of compressed image
Date:   Mon, 17 Oct 2016 10:09:39 +0100
Message-ID: <1476695379-1808-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55443
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

Changes introduced to arch/mips/Makefile for the generic kernel resulted
in build errors when making a compressed image if platform-y has multiple
values, like this:

make[2]: *** No rule to make target `alchemy/'.
make[1]: *** [vmlinuz] Error 2
make[1]: Target `_all' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `_all' not remade because of errors.

Fix this by quoting $(platform-y) as it is passed to the Makefile in
arch/mips/boot/compressed/Makefile

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://storage.kernelci.org/next/next-20161017/mips-gpr_defconfig/build.log
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index fbf40d3c8123..1a6bac7b076f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -263,7 +263,7 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
 		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
-		  PLATFORM=$(platform-y)
+		  PLATFORM="$(platform-y)"
 ifdef CONFIG_32BIT
 bootvars-y	+= ADDR_BITS=32
 endif
-- 
2.7.4
