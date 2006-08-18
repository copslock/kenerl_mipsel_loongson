Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 23:59:34 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:44211 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037867AbWHRW7c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2006 23:59:32 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 382583EF4; Fri, 18 Aug 2006 15:59:11 -0700 (PDT)
Message-ID: <44E64687.7000704@ru.mvista.com>
Date:	Sat, 19 Aug 2006 03:00:23 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] TX49 has write buffer
Content-Type: multipart/mixed;
 boundary="------------010204000609040901070909"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010204000609040901070909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

TX49 CPUs have a write buffer, so we need to select CPU_HAS_WB -- otherwise 
all Toshiba RBTX49xx kernels fail to build.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------010204000609040901070909
Content-Type: text/plain;
 name="TX49-has-write-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TX49-has-write-buffer.patch"

Index: linux-mips/arch/mips/Kconfig
===================================================================
--- linux-mips.orig/arch/mips/Kconfig
+++ linux-mips/arch/mips/Kconfig
@@ -1225,6 +1225,7 @@ config CPU_TX49XX
 	bool "R49XX"
 	depends on SYS_HAS_CPU_TX49XX
 	select CPU_HAS_LLSC
+	select CPU_HAS_WB
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL


--------------010204000609040901070909--
