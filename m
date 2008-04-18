Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2008 16:36:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52197 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029196AbYDRPgk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Apr 2008 16:36:40 +0100
Received: from localhost (p1047-ipad304funabasi.chiba.ocn.ne.jp [123.217.155.47])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4423FB25A; Sat, 19 Apr 2008 00:36:36 +0900 (JST)
Date:	Sat, 19 Apr 2008 00:37:33 +0900 (JST)
Message-Id: <20080419.003733.48796522.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make pcibios_setup weak
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make pcibios_setup weak so that platform code can overwrite it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 7533e3f..0987144 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
 
-char *pcibios_setup(char *str)
+char *__weak pcibios_setup(char *str)
 {
 	return str;
 }
