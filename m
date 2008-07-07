Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 17:13:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53753 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28583630AbYGGQNI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2008 17:13:08 +0100
Received: from localhost (p7140-ipad206funabasi.chiba.ocn.ne.jp [222.145.81.140])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A3E85A05C; Tue,  8 Jul 2008 01:13:03 +0900 (JST)
Date:	Tue, 08 Jul 2008 01:14:47 +0900 (JST)
Message-Id: <20080708.011447.130240273.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Make pcibios_setup weak
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080419.003733.48796522.anemo@mba.ocn.ne.jp>
References: <20080419.003733.48796522.anemo@mba.ocn.ne.jp>
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
X-archive-position: 19731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make pcibios_setup weak so that platform code can overwrite it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Revised against current linux-queue tree.

 arch/mips/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index a3dcfd4..b8f382e 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -329,7 +329,7 @@ EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
 
-char *pcibios_setup(char *str)
+char *__weak pcibios_setup(char *str)
 {
 	return str;
 }
