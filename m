Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:41:05 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994767AbdGCNi3f8nvi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:38:29 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68E958FF;
        Mon,  3 Jul 2017 13:38:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, john@phrozen.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 044/101] MIPS: ralink: fix MT7628 wled_an pinmux gpio
Date:   Mon,  3 Jul 2017 15:34:44 +0200
Message-Id: <20170703133341.875344479@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133334.237346187@linuxfoundation.org>
References: <20170703133334.237346187@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58996
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

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit 07b50db6e685172a41b9978aebffb2438166d9b6 upstream.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13307/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7620.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -196,10 +196,10 @@ static struct rt2880_pmx_func wled_kn_gr
 };
 
 static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
-	FUNC("rsvd", 3, 35, 1),
-	FUNC("rsvd", 2, 35, 1),
-	FUNC("gpio", 1, 35, 1),
-	FUNC("wled_an", 0, 35, 1),
+	FUNC("rsvd", 3, 44, 1),
+	FUNC("rsvd", 2, 44, 1),
+	FUNC("gpio", 1, 44, 1),
+	FUNC("wled_an", 0, 44, 1),
 };
 
 #define MT7628_GPIO_MODE_MASK		0x3
