Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2006 19:39:21 +0100 (BST)
Received: from web86301.mail.ukl.yahoo.com ([217.12.12.60]:34126 "HELO
	web86301.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133541AbWDASjL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Apr 2006 19:39:11 +0100
Received: (qmail 35185 invoked by uid 60001); 1 Apr 2006 18:50:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=talk21.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FL4eC7FqU1pJ2jIBYHA74o8xmcP9qlefmz4QorGy012f95tTPgmnPKmmKYYz2puiSmH++5lrE2CNcfF5XiW1i9/bX+5pyWtqwAc+RUbkmvgv5Pto6VU4E0euJT7hJFKY2/9NweSTr///Q662f6OQ/1nUUY2pSlRpqI26Wjm2t0M=  ;
Message-ID: <20060401185003.35183.qmail@web86301.mail.ukl.yahoo.com>
Received: from [62.190.246.49] by web86301.mail.ukl.yahoo.com via HTTP; Sat, 01 Apr 2006 19:50:03 BST
Date:	Sat, 1 Apr 2006 19:50:03 +0100 (BST)
From:	Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: [PATCH] Typo in arch/mips/Makefile breaks build on Cobalt
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-6929233-1143917403=:33506"
Content-Transfer-Encoding: 8bit
Return-Path: <scott.ashcroft@talk21.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scott.ashcroft@talk21.com
Precedence: bulk
X-list: linux-mips

--0-6929233-1143917403=:33506
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

There appears to be a couple of typos in the clean up
of the Makefile.

The cflags lines for NEVADA and R5432 have
'cc-options' rather than 'cc-option'.
Attached patch fixes it up.

Signed-Off-by: scott.ashcroft@talk21.com
--0-6929233-1143917403=:33506
Content-Type: text/plain; name="Makefile.diff"
Content-Description: 3766969591-Makefile.diff
Content-Disposition: inline; filename="Makefile.diff"

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7bb0296..c254f4f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -114,9 +114,9 @@ cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips2 -mtune=r4600 ) \
 			-Wa,-mips64r2 -Wa,--trap
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
-cflags-$(CONFIG_CPU_R5432)	+= $(call cc-options,-march=r5400,-march=r5000) \
+cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-options,-march=rm5200,-march=r5000) \
+cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc-option,-march=rm5200,-march=r5000) \
 			-Wa,--trap
 cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=r5000) \
 			-Wa,--trap

--0-6929233-1143917403=:33506--
