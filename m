Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:55:56 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:13443 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225220AbTC0Cy6>;
	Thu, 27 Mar 2003 02:54:58 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 0229746A59; Thu, 27 Mar 2003 03:53:31 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: prototypes are already on hearder
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:53:30 +0100
Message-ID: <m2d6kded05.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

This prototypes are already in gconsole.h.

Later, Juan.


 build/drivers/sgi/char/graphics.c |    6 ------
 1 files changed, 6 deletions(-)

diff -puN build/drivers/sgi/char/graphics.c~remove_unused_prototypes build/drivers/sgi/char/graphics.c
--- 24/build/drivers/sgi/char/graphics.c~remove_unused_prototypes	2003-03-22 00:51:19.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/graphics.c	2003-03-22 00:51:32.000000000 +0100
@@ -53,12 +53,6 @@ static int boards;
 
 #define GRAPHICS_CARD(inode) 0
 
-/*
-void enable_gconsole(void) {};
-void disable_gconsole(void) {};
-*/
-
-
 int
 sgi_graphics_open (struct inode *inode, struct file *file)
 {

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
