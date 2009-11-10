Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 12:45:32 +0100 (CET)
Received: from krynn.se.axis.com ([193.13.178.10]:44365 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492376AbZKJLpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 12:45:24 +0100
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAABjI6u018880
	for <linux-mips@linux-mips.org>; Tue, 10 Nov 2009 12:45:18 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 10 Nov 2009 12:45:18 +0100
From:	Mikael Starvik <mikael.starvik@axis.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:	Jesper Nilsson <Jesper.Nilsson@axis.com>
Date:	Tue, 10 Nov 2009 12:45:17 +0100
Subject: RE: SMTC lookup in smtc_distribute_timer
Thread-Topic: SMTC lookup in smtc_distribute_timer
Thread-Index: Acph4gXOS/S88Vv4SZWXqV+QJhpHfwAEkyuw
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E7EA@xmail3.se.axis.com>
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
X-archive-position: 24811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

Ok, my guess is something like this:

1. At the end of smtc_distribute_timer, nextstamp is valid and has already 
passed so we goto repeat. 
2. Nothing updates nextstamp (only updated if the timeout is in the future 
And we just decided it is in the past)
3. At the end nextstamp still has the same value so it is still valid and
in the past.
4. This repeats until read_c0_count has a value which causes nextstamp to
be in the future.

One possible patch that seams to solve it for me below. This is probably 
not the correct solution so I'll need help from the SMTC experts to review
it and come up with the correct solution.

Best Regards
/Mikael

Index: cevt-smtc.c
===================================================================
RCS file: /usr/local/cvs/linux/os/linux-2.6/arch/mips/kernel/cevt-smtc.c,v
retrieving revision 1.2
diff -u -r1.2 cevt-smtc.c
--- cevt-smtc.c	2 Sep 2009 10:07:51 -0000	1.2
+++ cevt-smtc.c	10 Nov 2009 11:40:31 -0000
@@ -223,8 +223,10 @@
 		write_c0_compare(nextstamp);
 		ehb();
 		if ((nextstamp - (unsigned long)read_c0_count())
-			> (unsigned long)LONG_MAX)
+			> (unsigned long)LONG_MAX) {
+				nextstamp = 0L;  
 				goto repeat;
+			}
 	}
 }
