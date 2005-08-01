Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 07:13:39 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:19675
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8224832AbVHAGNX>; Mon, 1 Aug 2005 07:13:23 +0100
Received: (qmail 14427 invoked from network); 31 Jul 2005 23:16:26 -0700
Received: from c-24-6-216-150.hsd1.ca.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 31 Jul 2005 23:16:26 -0700
Message-ID: <42EDBE3B.3010503@total-knowledge.com>
Date:	Sun, 31 Jul 2005 23:16:27 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Au1000 PCMCIA I/O space?
Content-Type: multipart/mixed;
 boundary="------------080208040607040508030902"
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080208040607040508030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is there any particular reason why Au1000 PCMCIA IO space is not 
included in 36-bit address fixup?
Attached patch fixes it for me, but I'm wondering if there is valid 
reason not to do that.

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com


--------------080208040607040508030902
Content-Type: text/x-patch;
 name="pcmcia.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia.diff"

Index: arch/mips/au1000/common/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/common/setup.c,v
retrieving revision 1.25
diff -u -r1.25 setup.c
--- arch/mips/au1000/common/setup.c	11 Jul 2005 10:03:23 -0000	1.25
+++ arch/mips/au1000/common/setup.c	1 Aug 2005 04:18:40 -0000
@@ -179,7 +179,7 @@
 	 * The pseudo address we use is 0xF400 0000. Any address over
 	 * 0xF400 0000 is a pcmcia pseudo address.
 	 */
-	if ((phys_addr >= 0xF4000000) && (phys_addr < 0xFFFFFFFF)) {
+	if ((phys_addr >= 0xF0000000) && (phys_addr < 0xFFFFFFFF)) {
 		return (phys_t)(phys_addr << 4);
 	}
 

--------------080208040607040508030902--
