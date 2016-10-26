Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2016 14:33:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44669 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992562AbcJZMdKHyA-n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2016 14:33:10 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 66717A7C;
        Wed, 26 Oct 2016 12:33:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 052/112] MIPS: Fix -mabi=64 build of vdso.lds
Date:   Wed, 26 Oct 2016 14:22:35 +0200
Message-Id: <20161026122307.005195197@linuxfoundation.org>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161026122304.797016625@linuxfoundation.org>
References: <20161026122304.797016625@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55584
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

commit 034827c727f7f3946a18355b63995b402c226c82 upstream.

The native ABI vDSO linker script vdso.lds is built by preprocessing
vdso.lds.S, with the native -mabi flag passed in to get the correct ABI
definitions. Unfortunately however certain toolchains choke on -mabi=64
without a corresponding compatible -march flag, for example:

cc1: error: ‘-march=mips32r2’ is not compatible with the selected ABI
scripts/Makefile.build:338: recipe for target 'arch/mips/vdso/vdso.lds' failed

Fix this by including ccflags-vdso in the KBUILD_CPPFLAGS for vdso.lds,
which includes the appropriate -march flag.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14368/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/vdso/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -75,7 +75,7 @@ obj-vdso := $(obj-vdso-y:%.o=$(obj)/%.o)
 $(obj-vdso): KBUILD_CFLAGS := $(cflags-vdso) $(native-abi)
 $(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
 
-$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(native-abi)
+$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
