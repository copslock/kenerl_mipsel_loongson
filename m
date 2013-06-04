Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:33:26 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:57770 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835105Ab3FDVb7yL3uF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:31:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 11E3C21B9BA;
        Wed,  5 Jun 2013 00:31:59 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id XY+4yICQkDMn; Wed,  5 Jun 2013 00:31:54 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id E440A5BC010;
        Wed,  5 Jun 2013 00:31:53 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/6] staging: octeon-usb: cvmx-usbcx-defs.h: avoid long lines in CVMX_USBCX macros
Date:   Wed,  5 Jun 2013 00:31:32 +0300
Message-Id: <1370381495-3358-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Avoid long lines in CVMX_USBCX macros.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon-usb/cvmx-usbcx-defs.h |  208 +++++++++++++++++++-------
 1 file changed, 156 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
index 2769d4e..56cc373 100644
--- a/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
+++ b/drivers/staging/octeon-usb/cvmx-usbcx-defs.h
@@ -51,58 +51,162 @@
 #ifndef __CVMX_USBCX_TYPEDEFS_H__
 #define __CVMX_USBCX_TYPEDEFS_H__
 
-#define CVMX_USBCX_DAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000818ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DAINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F001000081Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000800ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000804ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DIEPCTLX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000900ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DIEPINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000908ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DIEPMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000810ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DIEPTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000910ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DOEPCTLX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B00ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DOEPINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B08ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DOEPMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000814ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DOEPTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000B10ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_DPTXFSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000100ull) + (((offset) & 7) + ((block_id) & 1) * 0x40000000000ull) * 4)
-#define CVMX_USBCX_DSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000808ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DTKNQR1(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000820ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DTKNQR2(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000824ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DTKNQR3(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000830ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_DTKNQR4(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000834ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GAHBCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000008ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GHWCFG1(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000044ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GHWCFG2(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000048ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GHWCFG3(block_id) (CVMX_ADD_IO_SEG(0x00016F001000004Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GHWCFG4(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000050ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000018ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GINTSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000014ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GNPTXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000028ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GNPTXSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F001000002Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GOTGCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000000ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GOTGINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000004ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRSTCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000010ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000024ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRXSTSPD(block_id) (CVMX_ADD_IO_SEG(0x00016F0010040020ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRXSTSPH(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000020ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRXSTSRD(block_id) (CVMX_ADD_IO_SEG(0x00016F001004001Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GRXSTSRH(block_id) (CVMX_ADD_IO_SEG(0x00016F001000001Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GSNPSID(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000040ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_GUSBCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F001000000Cull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000414ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HAINTMSK(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000418ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HCCHARX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000500ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_HCFG(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000400ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HCINTMSKX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F001000050Cull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_HCINTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000508ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_HCSPLTX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000504ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_HCTSIZX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010000510ull) + (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
-#define CVMX_USBCX_HFIR(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000404ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HFNUM(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000408ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HPRT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000440ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HPTXFSIZ(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000100ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_HPTXSTS(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000410ull) + ((block_id) & 1) * 0x100000000000ull)
-#define CVMX_USBCX_NPTXDFIFOX(offset, block_id) (CVMX_ADD_IO_SEG(0x00016F0010001000ull) + (((offset) & 7) + ((block_id) & 1) * 0x100000000ull) * 4096)
-#define CVMX_USBCX_PCGCCTL(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000E00ull) + ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DAINT(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000818ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DAINTMSK(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000081Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DCFG(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000800ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DCTL(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000804ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DIEPCTLX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000900ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DIEPINTX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000908ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DIEPMSK(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000810ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DIEPTSIZX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000910ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPCTLX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000B00ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPINTX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000B08ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DOEPMSK(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000814ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DOEPTSIZX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000B10ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_DPTXFSIZX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000100ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x40000000000ull) * 4)
+#define CVMX_USBCX_DSTS(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000808ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR1(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000820ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR2(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000824ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR3(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000830ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_DTKNQR4(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000834ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GAHBCFG(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000008ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG1(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000044ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG2(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000048ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG3(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000004Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GHWCFG4(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000050ull) + \
+	((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GINTMSK(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000018ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GINTSTS(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000014ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GNPTXFSIZ(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000028ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GNPTXSTS(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000002Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GOTGCTL(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000000ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GOTGINT(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000004ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRSTCTL(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000010ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXFSIZ(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000024ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSPD(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010040020ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSPH(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000020ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSRD(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001004001Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GRXSTSRH(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000001Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GSNPSID(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000040ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_GUSBCFG(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000000Cull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HAINT(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000414ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HAINTMSK(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000418ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HCCHARX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000500ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCFG(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000400ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HCINTMSKX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F001000050Cull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCINTX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000508ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCSPLTX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000504ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HCTSIZX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000510ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x8000000000ull) * 32)
+#define CVMX_USBCX_HFIR(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000404ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HFNUM(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000408ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPRT(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000440ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPTXFSIZ(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000100ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_HPTXSTS(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000410ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
+#define CVMX_USBCX_NPTXDFIFOX(offset, block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010001000ull) + \
+	 (((offset) & 7) + ((block_id) & 1) * 0x100000000ull) * 4096)
+#define CVMX_USBCX_PCGCCTL(block_id) \
+	(CVMX_ADD_IO_SEG(0x00016F0010000E00ull) + \
+	 ((block_id) & 1) * 0x100000000000ull)
 
 /**
  * cvmx_usbc#_daint
-- 
1.7.10.4
