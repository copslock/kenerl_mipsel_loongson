Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 20:28:45 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:62831 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225322AbVDET23>; Tue, 5 Apr 2005 20:28:29 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 5 Apr 2005 15:24:23 -0400
Message-ID: <4252E6DB.7050307@timesys.com>
Date:	Tue, 05 Apr 2005 15:28:27 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [patch] malta bus error
Content-Type: multipart/mixed;
 boundary="------------000908010005020703080706"
X-OriginalArrivalTime: 05 Apr 2005 19:24:23.0359 (UTC) FILETIME=[12C594F0:01C53A15]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000908010005020703080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's the ugly hack I used to get around the bus error on the malta 
board because of the memcpy prefetch bug. I'm still looking at the 
memcpy.S code to figure out how to get it to stop prefetching past the 
end of the copy.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com>



--------------000908010005020703080706
Content-Type: text/x-patch;
 name="malta.memcpy.prefetch.hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.memcpy.prefetch.hack.patch"

--- mips/arch/mips/Kconfig-orig
+++ mips/arch/mips/Kconfig

@@ -46,6 +46,7 @@
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+        select BOARD_HAS_MEMCPY_PREFETCH_BUG
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
@@ -777,6 +778,10 @@
 config CPU_HAS_PREFETCH
 	bool
 
+config BOARD_HAS_MEMCPY_PREFETCH_BUG
+	bool
+	default n
+
 config SB1_PASS_1_WORKAROUNDS
 	bool
 	depends on CPU_SB1_PASS_1

--- mips/arch/mips/lib/memcpy.S-orig
+++ mips/arch/mips/lib/memcpy.S

@@ -17,6 +17,11 @@
 #include <asm/offset.h>
 #include <asm/regdef.h>
 
+#ifdef CONFIG_BOARD_HAS_MEMCPY_PREFETCH_BUG
+#undef PREF
+#define PREF(hint,addr)
+#endif
+	
 #define dst a0
 #define src a1
 #define len a2

--------------000908010005020703080706--
