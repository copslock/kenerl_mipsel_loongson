Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2008 12:08:28 +0100 (BST)
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59268 "EHLO
	mail.cs.helsinki.fi") by ftp.linux-mips.org with ESMTP
	id S62082810AbYEBLI0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 May 2008 12:08:26 +0100
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Fri, 02 May 2008 14:08:22 +0300
  id 000680FA.481AF626.00000986
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id 98E1EA0098; Fri,  2 May 2008 14:08:22 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id 967BAA0097;
	Fri,  2 May 2008 14:08:22 +0300 (EEST)
Date:	Fri, 2 May 2008 14:08:20 +0300 (EEST)
From:	"=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS]: if() in pte_mkyoung seems to be missing braces
Message-ID: <Pine.LNX.4.64.0805021400481.30402@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-1766178569-1209726500=:30402"
Return-Path: <ilpo.jarvinen@helsinki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilpo.jarvinen@helsinki.fi
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1766178569-1209726500=:30402
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

In case this is a genuine bug, somebody else more familiar
with that stuff should evaluate it's effects (I just found it
by some shell pipeline and it seems suspicious looking).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 include/asm-mips/pgtable.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 17a7703..fc6e98b 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -232,9 +232,10 @@ static inline pte_t pte_mkdirty(pte_t pte)
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte.pte_low |= _PAGE_ACCESSED;
-	if (pte.pte_low & _PAGE_READ)
+	if (pte.pte_low & _PAGE_READ) {
 		pte.pte_low  |= _PAGE_SILENT_READ;
 		pte.pte_high |= _PAGE_SILENT_READ;
+	}
 	return pte;
 }
 #else
-- 
1.5.2.2

---696208474-1766178569-1209726500=:30402--
