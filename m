Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:08:01 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47211 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008835AbaLOSGmZ2NeB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:42 +0100
Received: by mail-lb0-f173.google.com with SMTP id z12so9510930lbi.32
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVWLyg3vCxxieo+v+XLPSpx4MG3Yx/4DIr/BGFSbUGc=;
        b=m0o+tUmf1c2OEuf7Bm3Fx3XL8UNQdHcpcqilfwHOOPWDdm3bb65D4tq66nHk5iGZ6C
         FGYB4q4RB2d2LpHriymnh3DvuQmQdJyJweHRuLY1VWZjTIpqBFT7sTNWFVR5vxutCaWx
         Ik0poqYeE1UhtHCy3ZYlyKZ2j9jbA0D3Pw1XA027Oc/D6BeaRGMGbCpWy2um99IUwfmH
         y/Y8XtyM2jgeitIUupKELOhFFRhu0SBrLv4HF7H5WHadxcVTjO3hG8Xx3x024BX79GTe
         LrfKQVBSrNHEoV6SQ9UT2j2dkOMR3rCkRK6d72aGkpwbgY4Bg64PQyw8YfvkKd7FabSY
         Agfw==
X-Received: by 10.112.205.65 with SMTP id le1mr31478425lbc.54.1418666796401;
        Mon, 15 Dec 2014 10:06:36 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:35 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 07/14] MIPS: OCTEON: Implement the core-16057 workaround
Date:   Mon, 15 Dec 2014 21:03:13 +0300
Message-Id: <1418666603-15159-8-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44689
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

From: David Daney <david.daney@cavium.com>

Disable ICache prefetch for certian Octeon II processors.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index 1668ee5..21732c3 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -63,6 +63,28 @@ skip:
 	li	v1, ~(7 << 7)
 	and	v0, v0, v1
 	ori	v0, v0, (6 << 7)
+
+	mfc0	v1, CP0_PRID_REG
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9000		# 63-P1
+	beqz	t1, 4f
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9008		# 63-P2
+	beqz	t1, 4f
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9100		# 68-P1
+	beqz	t1, 4f
+	and	t1, v1, 0xff00
+	xor	t1, t1, 0x9200		# 66-PX
+	bnez	t1, 5f			# Skip WAR for others.
+	and	t1, v1, 0x00ff
+	slti	t1, t1, 2		# 66-P1.2 and later good.
+	beqz	t1, 5f
+
+4:	# core-16057 work around
+	or	v0, v0, 0x2000		# Set IPREF bit.
+
+5:	# No core-16057 work around
 	# Write the cavium control register
 	dmtc0	v0, CP0_CVMCTL_REG
 	sync
-- 
2.1.3
