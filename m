Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:01:48 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:26348 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225416AbSLSLBr>;
	Thu, 19 Dec 2002 11:01:47 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 958D0D657; Thu, 19 Dec 2002 12:07:50 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: remove warnings on promlib
References: <Pine.GSO.3.96.1021218174743.5977E-100000@delta.ds2.pg.gda.pl>
	<m2r8cemhxt.fsf@demo.mitica>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <m2r8cemhxt.fsf@demo.mitica>
Date: 19 Dec 2002 12:07:50 +0100
Message-ID: <m2u1hajmgp.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "juan" == Juan Quintela <quintela@mandrakesoft.com> writes:

You also want that bit:

Index: drivers/sgi/char/sgiserial.c
===================================================================
RCS file: /home/cvs/linux/drivers/sgi/char/Attic/sgiserial.c,v
retrieving revision 1.33.2.6
diff -u -r1.33.2.6 sgiserial.c
--- drivers/sgi/char/sgiserial.c	7 Nov 2002 01:47:46 -0000	1.33.2.6
+++ drivers/sgi/char/sgiserial.c	19 Dec 2002 10:38:07 -0000
@@ -40,6 +40,7 @@
 #include <asm/sgialib.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
+#include <asm/prom.h>
 #include <asm/sgi/sgihpc.h>
 #include <asm/sgi/sgint23.h>
 #include <asm/uaccess.h>



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
