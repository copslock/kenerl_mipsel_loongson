Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:07:09 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34213 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008833AbaLOSGaxOo90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:30 +0100
Received: by mail-lb0-f170.google.com with SMTP id 10so9681241lbg.15
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sIcY2vLnDvkdFJjCIjxEB4r1B2ikHxWwqhycp++oOso=;
        b=S6w2kbbCKV3hd1a4gA/6T3tIumTZ63XQ4eUChojPWgVWytedv8uhv2bpMoztkTg+XJ
         1ZWu4pSUHpA0/CNZ7LKR8HTnL+f9QmlBL39/DpyBtvjH9CWyngt42JuKXerp9FP8toFu
         u95JptKyvaFNAIRSnObQAmQ116Iegkd5uJ+Iml+I1M5PSC8I0pQl876lxzARfYgMX/Nw
         /rEsK8hbvbCIQ6PlxyVNZy/YYUjkXUqV61gCCs9AQ0S7sE1SrxBk+DzcRK5CsFtangEo
         XWQtFYqBehcCY+WNjXd7oLbo5KaaP5epNIpptjRXM0p2DI8sceyfbmDXKBlCcx/MdwXQ
         wNeA==
X-Received: by 10.152.29.6 with SMTP id f6mr11223793lah.32.1418666785535;
        Mon, 15 Dec 2014 10:06:25 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:24 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 04/14] MIPS: OCTEON: Use correct instruction to read 64-bit COP0 register
Date:   Mon, 15 Dec 2014 21:03:10 +0300
Message-Id: <1418666603-15159-5-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

Use dmfc0/dmtc0 instructions for reading CvmMemCtl COP0 register,
its a 64-bit wide.

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/kernel/octeon_switch.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 590ca2d..f0a699d 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -80,7 +80,7 @@
 1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
-	mfc0	t0, $11,7	/* CvmMemCtl */
+	dmfc0	t0, $11,7	/* CvmMemCtl */
 	bbit0	t0, 6, 3f	/* Is user access enabled? */
 
 	/* Store the CVMSEG state */
@@ -104,9 +104,9 @@
 	.set reorder
 
 	/* Disable access to CVMSEG */
-	mfc0	t0, $11,7	/* CvmMemCtl */
+	dmfc0	t0, $11,7	/* CvmMemCtl */
 	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
-	mtc0	t0, $11,7	/* CvmMemCtl */
+	dmtc0	t0, $11,7	/* CvmMemCtl */
 #endif
 3:
 
-- 
2.1.3
