Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 13:30:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20468 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030739AbYHZMaF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 13:30:05 +0100
Received: from localhost (p1241-ipad305funabasi.chiba.ocn.ne.jp [123.217.163.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8EB2CA967; Tue, 26 Aug 2008 21:29:57 +0900 (JST)
Date:	Tue, 26 Aug 2008 21:29:58 +0900 (JST)
Message-Id: <20080826.212958.128619116.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Fix txx9_pcode initialization
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
X-archive-position: 20352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The txx9_pcode variable was introduced in commit
fe1c2bc64f65003b39f331a8e4b0d15b235a4afd ("TXx9: Add 64-bit support")
but was not initialized properly.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This patch is against current linux-mips.org main tree.

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 0afe94c..fe6bee0 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -53,6 +53,7 @@ txx9_reg_res_init(unsigned int pcode, unsigned long base, unsigned long size)
 		txx9_ce_res[i].name = txx9_ce_res_name[i];
 	}
 
+	txx9_pcode = pcode;
 	sprintf(txx9_pcode_str, "TX%x", pcode);
 	if (base) {
 		txx9_reg_res.start = base & 0xfffffffffULL;
