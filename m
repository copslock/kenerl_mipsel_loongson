Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 13:06:13 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.239]:20368 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038832AbXBONGJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 13:06:09 +0000
Received: by hu-out-0506.google.com with SMTP id 22so215296hug
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 05:05:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=At1C+R8bfDFvViBLASjPBLrshu4lr/Klu3aYcNJHHOeEDqhxsEB3UefYB9xdKLGzruK9f4PADNB9CJHZdUvbqpu35M00/fQ9nXO8DDgvPA4BUskjaK3UA1RVbJVVprYiablYgtk/Duu4hQ8xyEKfpnWsPailnS2IZuIx04DvrGA=
Received: by 10.49.41.12 with SMTP id t12mr1342997nfj.1171544708392;
        Thu, 15 Feb 2007 05:05:08 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id p45sm10464472nfa.2007.02.15.05.05.07;
        Thu, 15 Feb 2007 05:05:07 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id C2CFF23F76E; Thu, 15 Feb 2007 14:04:20 +0100 (CET)
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/3] Remove '-mno-explicit-relocs' option when CONFIG_BUILD_ELF64
Date:	Thu, 15 Feb 2007 14:04:18 +0100
Message-Id: <11715446603241-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch removes '-mno-explicit-relocs' usage when
CONFIG_BUILD_ELF64 is set since this option was only required
with the old hack to truncate addresses at the assembly level
where "-mabi=64 -Wa,-mabi=32" was used.

This should yield a small code size improvement for inline
assembly, where the R constraint is used.

The idea is coming from Maciej <macro@linux-mips.org>.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c68b5d3..4240ca1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -60,9 +60,7 @@ vmlinux-32		= vmlinux.32
 vmlinux-64		= vmlinux
 
 cflags-y		+= -mabi=64
-ifdef CONFIG_BUILD_ELF64
-cflags-y		+= $(call cc-option,-mno-explicit-relocs)
-else
+ifndef CONFIG_BUILD_ELF64
 cflags-y		+= $(call cc-option,-msym32)
 endif
 endif
-- 
1.4.4.3.ge6d4
