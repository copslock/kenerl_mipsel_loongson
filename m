Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 17:43:30 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4021 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818712Ab3H1PnRv1auf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 17:43:17 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 28 Aug 2013 08:32:39 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 28 Aug 2013 08:42:54 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 28 Aug 2013 08:42:54 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-10-9-247-38.broadcom.com [10.9.247.38]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7BBFEF2D73; Wed, 28
 Aug 2013 08:42:52 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, richard@nod.at,
        james.hogan@imgtec.com, "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: do not allow building vmlinuz when !ZBOOT
Date:   Wed, 28 Aug 2013 16:42:49 +0100
Message-ID: <1377704569-21331-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E00C79D2L879022892-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

When CONFIG_SYS_SUPPORTS_ZBOOT is not enabled, we will still try to
build the decompressor code in arch/mips/boot/compressed as a
dependency for producing the vmlinuz target and this will result in
the following build failure:

  OBJCOPY arch/mips/boot/compressed/vmlinux.bin
arch/mips/boot/compressed/decompress.c: In function 'decompress_kernel':
arch/mips/boot/compressed/decompress.c:105:2: error: implicit
declaration of function 'decompress'
make[1]: *** [arch/mips/boot/compressed/decompress.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [vmlinuz] Error 2

This is a genuine build failure because we have no implementation for
the decompress() function body since no kernel compression method
defined in CONFIG_KERNEL_(GZIP,BZIP2...) has been enabled.

arch/mips/Makefile already guards the install target for the "vmlinuz"
binary with a proper ifdef CONFIG_SYS_SUPPORTS_ZBOOT, we now also do the
same if we attempt to do a "make vmlinuz" and show that
CONFIG_SYS_SUPPORTS_ZBOOT is not enabled.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 37f9ef3..8e67a32 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -283,10 +283,15 @@ all:	$(all-y)
 vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
 
+ifdef CONFIG_SYS_SUPPORTS_ZBOOT
 # boot/compressed
 vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
+else
+vmlinuz:
+	@echo '   CONFIG_SYS_SUPPORTS_ZBOOT is not enabled'
+endif
 
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
-- 
1.8.1.2
