Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:40:39 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:16876 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225406AbSLSKkj>;
	Thu, 19 Dec 2002 10:40:39 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 7791ED68F; Thu, 19 Dec 2002 11:46:42 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: fix unknown value of page mask
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 11:46:42 +0100
Message-ID: <m2y96ml20d.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        here we don't do anything if we don't know the size :(
        returning a sensical value.

Later, Juan.
        

Index: arch/mips/lib/dump_tlb.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/dump_tlb.c,v
retrieving revision 1.8.2.6
diff -u -r1.8.2.6 dump_tlb.c
--- arch/mips/lib/dump_tlb.c	18 Dec 2002 22:47:37 -0000	1.8.2.6
+++ arch/mips/lib/dump_tlb.c	19 Dec 2002 10:38:02 -0000
@@ -31,6 +31,7 @@
 	case PM_64M:	return "64Mb";
 	case PM_256M:	return "256Mb";
 #endif
+	default:	return "unknown size";
 	}
 }
 
-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
