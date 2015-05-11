Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:58:43 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35759 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027476AbbEKRzuuTEsQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF424BC0;
        Mon, 11 May 2015 17:55:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Crispin <blogic@openwrt.org>,
        Paul Bolle <pebolle@tiscali.nl>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 24/72] MIPS: ralink: add missing symbol for RALINK_ILL_ACC
Date:   Mon, 11 May 2015 10:54:30 -0700
Message-Id: <20150511175437.840456154@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47321
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: John Crispin <blogic@openwrt.org>

Commit a7b7aad383c5dd9221a06e378197350dd27c1163 upstream.

A driver was added in commit 5433acd81e87 ("MIPS: ralink: add illegal access
driver") without the Kconfig section being added. Fix this by adding the symbol
to the Kconfig file.

Signed-off-by: John Crispin <blogic@openwrt.org>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9299/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/ralink/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -7,6 +7,11 @@ config CLKEVT_RT3352
 	select CLKSRC_OF
 	select CLKSRC_MMIO
 
+config RALINK_ILL_ACC
+	bool
+	depends on SOC_RT305X
+	default y
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
