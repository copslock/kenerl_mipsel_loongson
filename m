Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 May 2013 16:08:19 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1342 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834873Ab3EaOIOoG23H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 May 2013 16:08:14 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 31 May 2013 07:04:20 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 31 May 2013 07:07:57 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 31 May 2013 07:07:57 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-98.bri.broadcom.com [10.178.5.98]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 55F0BF2D72; Fri, 31
 May 2013 07:07:54 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        blogic@openwrt.org, "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: define write{b,w,l,q}_relaxed
Date:   Fri, 31 May 2013 15:07:44 +0100
Message-ID: <1370009264-22018-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7DB6726E31W29330350-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36658
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

MIPS does define read{b,w,l,q}_relaxed but does not define their write
counterparts: write{b,w,l,q}_relaxed. This patch adds the missing
definitions for the write*_relaxed I/O accessors.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index b7e5985..ca42c68 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -449,6 +449,11 @@ __BUILDIO(q, u64)
 #define readl_relaxed			readl
 #define readq_relaxed			readq
 
+#define writeb_relaxed			writeb
+#define writew_relaxed			writew
+#define writel_relaxed			writel
+#define writeq_relaxed			writeq
+
 #define readb_be(addr)							\
 	__raw_readb((__force unsigned *)(addr))
 #define readw_be(addr)							\
-- 
1.8.1.2
