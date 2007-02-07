Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 17:39:47 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:49035 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039488AbXBGRjm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 17:39:42 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4DA8A3EC9; Wed,  7 Feb 2007 09:39:09 -0800 (PST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
To:	ralf@linux-mips.org
Subject: [PATCH] (2.6.20) Toshiba JMR3927 and RBTX49x7 do support LE
Date:	Wed, 7 Feb 2007 20:39:05 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: MontaVista Software Inc.
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200702072039.05901.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Toshiba JMR3927 (RBHMA3100) and RBTX49[23]7 (RBHMA4[24]00) do support both
little and big endian mode (if you flash the right PMON).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -747,6 +747,7 @@ config TOSHIBA_JMR3927
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX39XX
 	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
 
@@ -761,6 +762,7 @@ config TOSHIBA_RBTX4927
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
 	select GENERIC_HARDIRQS_NO__DO_IRQ
