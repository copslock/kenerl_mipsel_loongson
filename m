Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 09:21:02 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.227]:45621 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039051AbXBMJUC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 09:20:02 +0000
Received: by hu-out-0506.google.com with SMTP id 22so1062368hug
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 01:19:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=poWLTNYSO/RAdSB5p00e+dbVS++c15WNQCQXcJdFoMowNJOs+VTML9ffhax72jhxkYyaFMBeQw4cG9q9upy4b2ptY6HO4CazBdxYwT/wget10oIsNZZI7XzhXBBXYtcjhAxo10MYd2TzraRAxa0LWoX0KcdDob7HW7nEiGPXtPg=
Received: by 10.49.93.4 with SMTP id v4mr516513nfl.1171358341058;
        Tue, 13 Feb 2007 01:19:01 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l21sm1886432nfc.2007.02.13.01.18.59;
        Tue, 13 Feb 2007 01:18:59 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5EEC323F76A; Tue, 13 Feb 2007 10:18:10 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	macro@linux-mips.org
Subject: [PATCH 1/3] Remove '-mno-explicit-relocs' option when CONFIG_BUILD_ELF64
Date:	Tue, 13 Feb 2007 10:18:07 +0100
Message-Id: <11713582891191-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171358289786-git-send-email-fbuihuu@gmail.com>
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14061
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
