Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 12:35:38 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:3454 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822429Ab3IKKfaV535S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Sep 2013 12:35:30 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 11 Sep 2013 03:28:40 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 11 Sep 2013 03:35:02 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 11 Sep 2013 03:35:01 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7176B1A4B; Wed, 11
 Sep 2013 03:35:00 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, james.hogan@imgtec.com,
        richard@nod.at, "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH v2] MIPS: do not allow building vmlinuz when !ZBOOT
Date:   Wed, 11 Sep 2013 11:34:48 +0100
Message-ID: <1378895688-16641-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E2E9A521R089625723-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37782
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
Changes since v1:
- rebased on top of James Hogan changes in mips-for-linux-next
- ensure that vmlinuz depends on FORCE
- use /bin/false to properly report an error

 arch/mips/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 75a36ad..55af9d7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -305,10 +305,16 @@ $(boot-y): $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
 		$(bootvars-y) arch/mips/boot/$@
 
+ifdef CONFIG_SYS_SUPPORTS_ZBOOT
 # boot/compressed
 $(bootz-y): $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 		$(bootvars-y) 32bit-bfd=$(32bit-bfd) $@
+else
+vmlinuz: FORCE
+	@echo '   CONFIG_SYS_SUPPORTS_ZBOOT is not enabled'; \
+	/bin/false
+endif
 
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
-- 
1.8.1.2
