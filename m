Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jan 2005 04:27:54 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:30908
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8224802AbVAIE1s>; Sun, 9 Jan 2005 04:27:48 +0000
Received: (qmail 30955 invoked from network); 8 Jan 2005 11:11:42 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 8 Jan 2005 11:11:42 -0800
Message-ID: <41E0B2C2.7000909@total-knowledge.com>
Date: Sat, 08 Jan 2005 20:27:46 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: IP32 RTC fixlet
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

IP32 power button delivers interrupt throug RTC,
so we can't let generic RTC driver use this interrupt.
Following patchlet allows us to still use generic RTC driver
to read/write time, and yet support handling button presses.

Index: include/asm/mach-ip32/mc146818rtc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-ip32/mc146818rtc.h,v
retrieving revision 1.7
diff -u -r1.7 mc146818rtc.h
--- include/asm/mach-ip32/mc146818rtc.h 4 Dec 2004 21:14:12 -0000       1.7
+++ include/asm/mach-ip32/mc146818rtc.h 9 Jan 2005 04:24:28 -0000
@@ -16,7 +16,6 @@
 #include <asm/ip32/ip32_ints.h> /* For MACEISA_RTC_IRQ */

 #define RTC_PORT(x)    (0x70 + (x))
-#define RTC_IRQ                MACEISA_RTC_IRQ

 static unsigned char CMOS_READ(unsigned long addr)
 {
