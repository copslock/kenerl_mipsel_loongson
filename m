Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 01:19:41 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:33183
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225213AbUIPATg>; Thu, 16 Sep 2004 01:19:36 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 15 Sep 2004 17:12:24 -0700
Message-ID: <4148DBFE.4020600@pantasys.com>
Date: Wed, 15 Sep 2004 17:19:10 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2.6] fix duart locking
Content-Type: multipart/mixed;
 boundary="------------050604060904010404070500"
X-OriginalArrivalTime: 16 Sep 2004 00:12:24.0687 (UTC) FILETIME=[D7CD77F0:01C49B81]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050604060904010404070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,

the duart code tries to hold a spin lock across a call to 
copy_from_user(). This patch releases the spin lock before the call and 
reacquires it afterwards.

peter

Signed-off-by: Peter Buckingham <peter@pantasys.com>

--------------050604060904010404070500
Content-Type: text/plain;
 name="p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p"

? drivers/i2c/algos/.built-in.o.cmd
? drivers/i2c/algos/.i2c-algo-bit.o.cmd
? drivers/i2c/busses/.built-in.o.cmd
? drivers/i2c/chips/.built-in.o.cmd
? drivers/input/misc/.built-in.o.cmd
? drivers/input/misc/.pcspkr.o.cmd
? drivers/input/misc/.uinput.o.cmd
Index: drivers/char/sb1250_duart.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/sb1250_duart.c,v
retrieving revision 1.23
diff -u -r1.23 sb1250_duart.c
--- drivers/char/sb1250_duart.c	15 Oct 2003 16:19:12 -0000	1.23
+++ drivers/char/sb1250_duart.c	16 Sep 2004 00:10:31 -0000
@@ -326,10 +326,11 @@
 		if (c <= 0) break;
 
 		if (from_user) {
+			spin_unlock_irqrestore(&us->outp_lock, flags);
 			if (copy_from_user(us->outp_buf + us->outp_tail, buf, c)) {
-				spin_unlock_irqrestore(&us->outp_lock, flags);
 				return -EFAULT;
 			}
+			spin_lock_irqsave(&us->outp_lock, flags);
 		} else {
 			memcpy(us->outp_buf + us->outp_tail, buf, c);
 		}

--------------050604060904010404070500--
