Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 17:54:18 +0200 (CEST)
Received: from vrout30.yaziba.net ([185.56.204.33]:42535 "EHLO
        vrout30.yaziba.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992482AbeH1PyPfigFG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 17:54:15 +0200
Received: from mtaout20.int.yaziba.net (mtaout20.int.yaziba.net [10.4.20.37])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by vrout30.yaziba.net (mx10.yaziba.net) with ESMTPS id BB284520F6;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaout20.int.yaziba.net (Postfix) with ESMTP id B0F6216043D;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mtaout20.int.yaziba.net
Received: from mtaout20.int.yaziba.net ([127.0.0.1])
        by localhost (mtaout20.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xqaux8cbxp4W; Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
Received: from sahnlpt0333.softathome.com (unknown [149.6.166.170])
        by mtaout20.int.yaziba.net (Postfix) with ESMTPSA id 9112A1603C0;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH] MIPS: Fix computation on entry point
Date:   Tue, 28 Aug 2018 17:52:50 +0200
Message-Id: <1535471570-19033-1-git-send-email-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-DRWEB-SCAN: ok
X-VRSPAM-SCORE: 0
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgeeggdelhecutefuodetggdotefrucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtqhertdertdejnecuhfhrohhmpefrhhhilhhiphhpvgcutfgvhihnvghsuceophhhihhlihhpphgvrdhrvgihnhgvshesshhofhhtrghthhhomhgvrdgtohhmqeenucfkphepudegledriedrudeiiedrudejtdenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Return-Path: <philippe.reynes@softathome.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe.reynes@softathome.com
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

Since commit 27c524d17430 ("MIPS: Use the entry point from the ELF
file header"), the kernel entry point is computed with a grep on
"start address" on the output of objdump. It works fine when the
default language is english but it may fail on other language (for
example in French, the grep should be done on "adresse de départ").
To fix this computation on most machine, I propose to force the
language to english with "LC_ALL=C".

Fixes: 27c524d17430 ("MIPS: Use the entry point from the ELF file header")

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b374..835aa8f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -258,7 +258,7 @@ load-y					= $(CONFIG_PHYSICAL_START)
 endif
 
 # Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
-entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+entry-y		= $(shell LC_ALL=C $(OBJDUMP) -f vmlinux 2>/dev/null \
 			| sed -n '/^start address / { \
 				s/^.* //; \
 				s/0x\([0-7].......\)$$/0x00000000\1/; \
-- 
2.7.4
