Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2007 13:25:45 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:51198 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021638AbXDSMZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Apr 2007 13:25:43 +0100
Received: by ug-out-1314.google.com with SMTP id 40so575416uga
        for <linux-mips@linux-mips.org>; Thu, 19 Apr 2007 05:24:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=K+HG7Zshyu23o+xCZ+NDf5pkZH0erbAI3CFJdjH6qhgoYAsJkmhPP2PM2FDvOiksWMBwlk0d7XhgLTVWFpg+TzYSRbyrRwb1KoTTGILGOAf97dRHoNaMr3AH5/UM4KhDk5PSL/TuXBEcvjZUDbUtTnkoIsiXuEF12CaP49Xt2rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=SlhlqQkCcgAvJt4pIRKSmlZOtJqy8Hf4YRLqTdsb23RgcONJVXxSSO+xoTy0Q4Cl+eE0mseHoLWXVNni6keDwyhIY/lCKZdH/7EmP9pQLRdnYTEGAPIUHmKVskPLKEeKWjgewWvZmvLNOox2N3YkoLLPxVWDChbUowjGoOXQFoU=
Received: by 10.82.155.10 with SMTP id c10mr2697969bue.1176985481740;
        Thu, 19 Apr 2007 05:24:41 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id b36sm18647ika.2007.04.19.05.24.36;
        Thu, 19 Apr 2007 05:24:39 -0700 (PDT)
Message-ID: <46275F9D.4040408@innova-card.com>
Date:	Thu, 19 Apr 2007 14:25:01 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Don't force frame pointers for lockdep on MIPS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Stacktrace support on MIPS doesn't use frame pointers. Since this
option considerably increases the size of the kernel code, force
lockdep to not use it.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3f3e740..79afd00 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -261,7 +261,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !X86
+	select FRAME_POINTER if !X86 && !MIPS
 	select KALLSYMS
 	select KALLSYMS_ALL
 
-- 
1.5.1.1
