Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 06:17:57 +0100 (BST)
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:19933
	"EHLO QMTA07.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20190071AbYIQFRx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 06:17:53 +0100
Received: from OMTA12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by QMTA07.westchester.pa.mail.comcast.net with comcast
	id FNj51a0080xGWP857hHksc; Wed, 17 Sep 2008 05:17:45 +0000
Received: from darkforest.org ([24.17.204.71])
	by OMTA12.westchester.pa.mail.comcast.net with comcast
	id FhHj1a0021YweuG3YhHj8S; Wed, 17 Sep 2008 05:17:44 +0000
X-Authority-Analysis: v=1.0 c=1 a=OLL_FvSJAAAA:8 a=4_AENGDv_4zC2J2G15wA:9
 a=YvSwz898pcHg3aJ3g97XXqhDVCEA:4 a=b8hG5vVbyAkA:10
Received: from asteroid-254.terran (asteroid-254.terran [192.168.216.254])
	(authenticated bits=0)
	by darkforest.org (8.13.8/8.13.8) with ESMTP id m8H5Hg4v005787
	for <linux-mips@linux-mips.org>; Tue, 16 Sep 2008 22:17:42 -0700 (PDT)
Message-Id: <B45397E7-EBE4-497B-9055-42B604A909AA@terran.org>
From:	Bryan Phillippe <u1@terran.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v926)
Subject: MIPS checksum bug
Date:	Tue, 16 Sep 2008 22:15:41 -0700
References: <072748C6-07A9-4167-A8A5-80D0F7D9C784@darkforest.org>
X-Mailer: Apple Mail (2.926)
Return-Path: <u1@terran.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: u1@terran.org
Precedence: bulk
X-list: linux-mips

Hello,

It appears that the following problem once reported for Sparc64  
affects MIPS/64 as well:

original report: http://www.spinics.net/lists/sparclinux/msg00173.html
resolution: http://www.spinics.net/lists/sparclinux/msg00179.html

The net result is that when TCP fragments unacked segments due to PMTU  
discovery, the shortened segment can have a bad TCP csum.  I'm testing  
on Linux-2.6.26 (FWIW, on a Cavium CN3010).  My repro is fairly  
simple: MIPS/64 client behind a Linux router, where the Linux router  
has an outbound MTU of 1492.  When the client attempts to send  
segments of size 1460 (1500), the router sends back an ICMP  
unreachable/PMTU and the client resends the first portion of the  
segment reduced to 1452 (1492), and the segments *often* (but not  
always) have a bad TCP csum.  Note that you can't have hardware  
checksums enabled or the bug is masked.

I've experimented with the following change:

--- /home/bp/tmp/csum_partial.S.orig	2008-09-16 12:01:00.000000000 -0700
+++ arch/mips/lib/csum_partial.S	2008-09-16 11:51:44.000000000 -0700
@@ -281,6 +281,23 @@
	.set	reorder
	/* Add the passed partial csum.  */
	ADDC(sum, a2)
+
+	/* fold checksum again to clear the high bits before returning */
+	.set	push
+	.set	noat
+#ifdef USE_DOUBLE
+	dsll32	v1, sum, 0
+	daddu	sum, v1
+	sltu	v1, sum, v1
+	dsra32	sum, sum, 0
+	addu	sum, v1
+#endif
+	sll	v1, sum, 16
+	addu	sum, v1
+	sltu	v1, sum, v1
+	srl	sum, sum, 16
+	addu	sum, v1
+
	jr	ra
	.set	noreorder
	END(csum_partial)

and it seems to fix the problem for me.  Can you comment?

Thanks,
--
-bp
