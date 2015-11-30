Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:25:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008058AbbK3QYqjEXXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:24:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 34E5CE34137B2;
        Mon, 30 Nov 2015 16:24:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:24:40 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:24:40 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/28] misc: pch_phub: allow build on MIPS platforms
Date:   Mon, 30 Nov 2015 16:21:35 +0000
Message-ID: <1448900513-20856-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow the pch_phub driver to be build on MIPS platforms, in preparation
for its use on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 22892c7..cad146b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -469,7 +469,7 @@ config BMP085_SPI
 config PCH_PHUB
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) PHUB"
 	select GENERIC_NET_UTILS
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
 	help
 	  This driver is for PCH(Platform controller Hub) PHUB(Packet Hub) of
 	  Intel Topcliff which is an IOH(Input/Output Hub) for x86 embedded
-- 
2.6.2
