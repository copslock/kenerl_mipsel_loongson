Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:57:38 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:16003 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225229AbTC0Czt>;
	Thu, 27 Mar 2003 02:55:49 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 263C846A59; Thu, 27 Mar 2003 03:54:23 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 5/7: remove test_done (unused variable)
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:23 +0100
Message-ID: <m23cl9ecyo.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

test_done is not used in the code.


 build/drivers/sgi/char/sgiserial.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial_remove_test_done build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial_remove_test_done	2003-03-22 02:07:19.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-22 02:07:25.000000000 +0100
@@ -1845,8 +1845,6 @@ rs_cons_check(struct sgi_serial *ss, int
 	}
 }
 
-volatile int test_done;
-
 /* rs_init inits the driver */
 int rs_init(void)
 {

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
