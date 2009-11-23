Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 07:31:44 +0100 (CET)
Received: from krynn.se.axis.com ([193.13.178.10]:39864 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492129AbZKWGbh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 07:31:37 +0100
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAN6VUuE031106
	for <linux-mips@linux-mips.org>; Mon, 23 Nov 2009 07:31:30 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 23 Nov 2009 07:31:30 +0100
From:	Mikael Starvik <mikael.starvik@axis.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:	Mon, 23 Nov 2009 07:31:28 +0100
Subject: COP2 unaligned -> SIGBUS
Thread-Topic: COP2 unaligned -> SIGBUS
Thread-Index: AcpsBpbSFxv5b1bcRcijCkkfZ+dzaw==
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

Since there are now at least two users of cop2 I propose the following:

Regards
/Mikael

Index: unaligned.c
===================================================================
RCS file: /usr/local/cvs/linux/os/linux-2.6/arch/mips/kernel/unaligned.c,v
retrieving revision 1.12
retrieving revision 1.13
diff -u -r1.12 -r1.13
--- unaligned.c	15 Jun 2009 16:00:57 -0000	1.12
+++ unaligned.c	23 Nov 2009 06:26:04 -0000	1.13
@@ -446,22 +446,15 @@
 	case ldc1_op:
 	case swc1_op:
 	case sdc1_op:
-		/*
-		 * I herewith declare: this does not happen.  So send SIGBUS.
-		 */
-		goto sigbus;
-
 	case lwc2_op:
 	case ldc2_op:
 	case swc2_op:
 	case sdc2_op:
 		/*
-		 * These are the coprocessor 2 load/stores.  The current
-		 * implementations don't use cp2 and cp2 should always be
-		 * disabled in c0_status.  So send SIGILL.
-                 * (No longer true: The Sony Praystation uses cp2 for
-                 * 3D matrix operations.  Dunno if that thingy has a MMU ...)
+		 * I herewith declare: this does not happen.  So send SIGBUS.
 		 */
+		goto sigbus;
+
 	default:
 		/*
 		 * Pheeee...  We encountered an yet unknown instruction or
