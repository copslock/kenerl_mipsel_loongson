Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 22:37:17 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:36225 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013203AbbEKUhPvy7yJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 22:37:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 8EBF45A73A1;
        Mon, 11 May 2015 23:37:04 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id ZwNZ3eziadH1; Mon, 11 May 2015 23:36:59 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id D594B5BC002;
        Mon, 11 May 2015 23:37:11 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: fix wrong CHECKFLAGS (sparse builds) with GCC 5.1
Date:   Mon, 11 May 2015 23:37:05 +0300
Message-Id: <1431376625-14927-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

GCC 5.1 defines __REGISTER_PREFIX__ to $. This will break sparse
command line (and build fails with: /bin/sh: syntax error:
unexpected "(") since make tries to expand starting with the dollar
sign with a make variable. Prevent that by using double dollar sign.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5200f64..ae2dd59 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -277,7 +277,7 @@ LDFLAGS			+= -m $(ld-emul)
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
-	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/")
+	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
 endif
-- 
2.4.0
