Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 12:50:59 +0100 (BST)
Received: from courier.cs.helsinki.fi ([128.214.9.1]:24001 "EHLO
	mail.cs.helsinki.fi") by ftp.linux-mips.org with ESMTP
	id S20024546AbYEMLuz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 12:50:55 +0100
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Tue, 13 May 2008 14:50:50 +0300
  id 00087C1E.4829809A.00006FA4
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id 5F8ABA0098; Tue, 13 May 2008 14:50:50 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id 5D1B9A0097;
	Tue, 13 May 2008 14:50:50 +0300 (EEST)
Date:	Tue, 13 May 2008 14:50:50 +0300 (EEST)
From:	"=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] [MIPS]: multi-statement if() seems to be missing
 braces
Message-ID: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="-696208474-1437875614-1210679193=:15369"
Content-ID: <Pine.LNX.4.64.0805131446570.15369@wrl-59.cs.helsinki.fi>
Return-Path: <ilpo.jarvinen@helsinki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilpo.jarvinen@helsinki.fi
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1437875614-1210679193=:15369
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0805131446571.15369@wrl-59.cs.helsinki.fi>

In case this is a genuine bug, somebody else more familiar
with that stuff should evaluate it's effects (I just found it
by some shell pipeline and it seems suspicious looking).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---

...Added Cc Andrew as I didn't get any response last time.

 include/asm-mips/pgtable.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 2f597ee..6a0edf7 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -239,9 +239,10 @@ static inline pte_t pte_mkdirty(pte_t pte)
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
---696208474-1437875614-1210679193=:15369--
