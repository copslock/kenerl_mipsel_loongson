Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 02:41:39 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:51477
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225205AbTFPBlg>; Mon, 16 Jun 2003 02:41:36 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 16 Jun 2003 01:41:34 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h5G1fQiY019490;
	Mon, 16 Jun 2003 10:41:27 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Mon, 16 Jun 2003 10:42:24 +0900 (JST)
Message-Id: <20030616.104224.92590182.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030616.101911.07647456.nemoto@toshiba-tops.co.jp>
References: <20030615004718Z8225220-1272+2582@linux-mips.org>
	<20030616.101911.07647456.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 16 Jun 2003 10:19:11 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
>>>>> On Sun, 15 Jun 2003 01:47:13 +0100, ralf@linux-mips.org said:
>> Modified files:
>> arch/mips64    : Tag: linux_2_4 Makefile 
>> include/asm-mips64: Tag: linux_2_4 processor.h r4kcache.h 

>> Log message:
>> Support GT64120 boards with 64-bit kernels also.

nemoto> This corrupts mips64/mm/c-r4k.c.  Please apply this patch also.

And I doubt that 'unsigned short' is enough for the 'waysize'
(especially for scache).  How about this?

diff -u linux-mips-cvs/include/asm-mips64/processor.h linux.new/include/asm-mips64/processor.h
--- linux-mips-cvs/include/asm-mips64/processor.h	Mon Jun 16 09:33:42 2003
+++ linux.new/include/asm-mips64/processor.h	Mon Jun 16 10:40:19 2003
@@ -50,8 +50,8 @@
 	unsigned short linesz;	/* Size of line in bytes */
 	unsigned short ways;	/* Number of ways */
 	unsigned short sets;	/* Number of lines per set */
-	unsigned short waysize;	/* Bytes per way */
-	unsigned int waybit;	/* Bits to select in a cache set */
+	unsigned short waybit;	/* Bits to select in a cache set */
+	unsigned int waysize;	/* Bytes per way */
 	unsigned int flags;	/* Flags describing cache properties */
 };
 
---
Atsushi Nemoto
