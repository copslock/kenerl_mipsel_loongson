Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 16:42:35 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:3476 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818323Ab3ILOmdEXOna (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 16:42:33 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 12 Sep 2013 07:35:57 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Thu, 12 Sep 2013 07:42:19 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Thu, 12 Sep 2013 07:42:19 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A799D1A48; Thu, 12
 Sep 2013 07:42:18 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, james.hogan@imgtec.com,
        "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: ZBOOT: define program header for text loadable
 segment
Date:   Thu, 12 Sep 2013 15:42:05 +0100
Message-ID: <1378996925-6338-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E2F0EC71R090098692-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37803
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

There is currently no corresponding ELF program header for the "text"
loadable segment which is confusing for some bootloader out there such
as CFE because it expects to find a program header matching the segment
it is trying to load. The Linux kernel ELF binary "vmlinux" has a
similar program header for the text segment so we just mimic this here
too.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/compressed/ld.script | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
index 8e6b07c..5a33409 100644
--- a/arch/mips/boot/compressed/ld.script
+++ b/arch/mips/boot/compressed/ld.script
@@ -8,6 +8,9 @@
 
 OUTPUT_ARCH(mips)
 ENTRY(start)
+PHDRS {
+	text PT_LOAD FLAGS(7); /* RWX */
+}
 SECTIONS
 {
 	/* Text and read-only data */
@@ -15,7 +18,7 @@ SECTIONS
 	.text : {
 		*(.text)
 		*(.rodata)
-	}
+	}: text
 	/* End of text section */
 
 	/* Writable data */
-- 
1.8.1.2
