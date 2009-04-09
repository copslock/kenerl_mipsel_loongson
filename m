Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 05:57:52 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:60868 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S28639650AbZDIEyz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 05:54:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id B51363412F;
	Thu,  9 Apr 2009 12:51:56 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7aD4ubvH8p+k; Thu,  9 Apr 2009 12:51:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id DF5B734129;
	Thu,  9 Apr 2009 12:51:50 +0800 (CST)
Message-ID: <49DD7F8F.6010800@lemote.com>
Date:	Thu, 09 Apr 2009 12:54:39 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 4/14] lemote: Flush RAS and BTB for CPU predictively execution
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

 arch/mips/include/asm/stackframe.h | 18 ++++++++++++++++++
1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h
b/arch/mips/include/asm/stackframe.h
index db0fa7b..204286e 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -117,6 +117,24 @@
.endm
#else
.macro get_saved_sp /* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2
+ move k0,ra
+ jal 2008f
+ nop
+ 2008:
+ jal 2008f
+ nop
+ 2008:
+ jal 2008f
+ nop
+ 2008:
+ jal 2008f
+ nop
+ 2008:
+ move ra,k0
+ li k0,3
+ mtc0 k0,$22
+#endif
#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
lui k1, %hi(kernelsp)
#else
-- 
1.5.6.5
