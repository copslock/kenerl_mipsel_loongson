Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 15:07:29 +0100 (WEST)
Received: from office.altell.ru ([80.246.246.162]:60136 "EHLO office.altell.ru"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022047AbZFJOHV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 15:07:21 +0100
Received: from bzz.altell.local (unknown [192.168.1.129])
	by mail.altell.local (Postfix) with ESMTP id A25746867E;
	Wed, 10 Jun 2009 18:07:08 +0400 (MSD)
Subject: [PATCH] Make it compile.
To:	Ralf Baechle <ralf@linux-mips.org>
From:	Alexey Zaytsev <zaytsev@altell.ru>
Cc:	linux-mips@linux-mips.org
Date:	Wed, 10 Jun 2009 18:00:15 +0400
Message-ID: <20090610140002.17913.33485.stgit@bzz.altell.local>
User-Agent: StGit/0.14.3.328.gd3b3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Altell-MailScanner: Found to be clean
X-Altell-MailScanner-From: zaytsev@altell.ru
Return-Path: <zaytsev@altell.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zaytsev@altell.ru
Precedence: bulk
X-list: linux-mips

Signed-off-by: Alexey Zaytsev <zaytsev@altell.ru>
---
 arch/mips/lib/delay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
index f69c6b5..222bed0 100644
--- a/arch/mips/lib/delay.c
+++ b/arch/mips/lib/delay.c
@@ -51,6 +51,6 @@ void __ndelay(unsigned long ns)
 {
 	unsigned int lpj = current_cpu_data.udelay_val;
 
-	__delay((us * 0x00000005 * HZ * lpj) >> 32);
+	__delay((ns * 0x00000005 * HZ * lpj) >> 32);
 }
 EXPORT_SYMBOL(__ndelay);


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
