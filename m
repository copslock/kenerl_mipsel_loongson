Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 04:20:11 +0000 (GMT)
Received: from amdext2.amd.com ([IPv6:::ffff:163.181.251.1]:46749 "EHLO
	amdext2.amd.com") by linux-mips.org with ESMTP id <S8225200AbTBEEUK>;
	Wed, 5 Feb 2003 04:20:10 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id WAA03923
	for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 22:20:02 -0600 (CST)
Received: from 163.181.250.1SAUSGW01.amd.com with ESMTP (AMD SMTP Relay
 (MMS v5.0)); Tue, 04 Feb 2003 22:19:53 -0600
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Received: from pcsmail.amd.com (pcsmail.amd.com [163.181.41.222]) by
 amdint2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id WAA14336 for
 <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 22:19:52 -0600 (CST)
Received: from yeager.amd.com (yeager.amd.com [163.181.32.130]) by
 pcsmail.amd.com (8.11.6/8.11.6) with ESMTP id h154Jpa19408 for
 <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 22:19:51 -0600
Received: from yeager.amd.com (localhost [127.0.0.1]) by yeager.amd.com
 (8.12.3/8.12.3/Debian -4) with ESMTP id h154JpRN014519 for
 <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 22:19:51 -0600
Received: (from hopper@localhost) by yeager.amd.com (
 8.12.3/8.12.3/Debian -4) id h154JpJo014517 for
 linux-mips@linux-mips.org; Tue, 4 Feb 2003 22:19:51 -0600
Date: Tue, 4 Feb 2003 22:19:50 -0600
From: "Dan Hopper" <hopper@pcsmail.amd.com>
To: linux-mips@linux-mips.org
Subject: [patch 2.4] au1x00 prom.c hw addr case insensitivity fix
Message-ID: <20030205041950.GA14502@yeager.amd.com>
Mail-Followup-To: Dan Hopper <hopper@pcsmail.amd.com>,
 linux-mips@linux-mips.org
MIME-Version: 1.0
User-Agent: Mutt/1.3.28i
X-WSS-ID: 125E4F63948807-01-01
Content-Type: multipart/mixed;
 boundary=wRRV7LY7NUeQGEoC
Content-Disposition: inline
Return-Path: <hopper@pcsmail.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hopper@pcsmail.amd.com
Precedence: bulk
X-list: linux-mips


--wRRV7LY7NUeQGEoC
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi folks,

Attached please find a short fix to str2hexnum() in
arch/mips/au1000/common/prom.c of the 2.4 branch.  With this fix,
the contents of the "ethaddr" entry in the environment table passed
by the bootloader to the kernel can have upper case hexadecimal
digits.  

Without the patch, an address such as ethaddr =
"00:50:C2:0C:20:4f" is silently converted to "00:50:02:00:20:4f",
making for some serious head scratching if you're trying to bootp
the kernel.

Dan

--wRRV7LY7NUeQGEoC
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: attachment;
 filename=prom.c.uppercase_macaddr.patch
Content-Transfer-Encoding: 7bit

--- arch/mips/au1000/common/prom.c.orig	Tue Feb  4 20:38:28 2003
+++ arch/mips/au1000/common/prom.c	Tue Feb  4 22:09:17 2003
@@ -105,9 +105,11 @@
 inline unsigned char str2hexnum(unsigned char c)
 {
 	if(c >= '0' && c <= '9')
-	return c - '0';
+		return c - '0';
 	if(c >= 'a' && c <= 'f')
-	return c - 'a' + 10;
+		return c - 'a' + 10;
+	if(c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
 	return 0; /* foo */
 }
 

--wRRV7LY7NUeQGEoC--
