Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 19:58:07 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:13184 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225473AbSLST6H>;
	Thu, 19 Dec 2002 19:58:07 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id C7BB9D657; Thu, 19 Dec 2002 21:04:12 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: for poor sools with old I2 & 64 bits kernel
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 19 Dec 2002 21:04:12 +0100
Message-ID: <m2el8dixmr.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        this small patch made possible to compile a 64bit kernel for
        people that have old proms that only accept ecoff.  As usual
        stolen from the 32 bits version.

        The easiest way is creating the file in arch/mips/boot,
        otherwise we need to copy elf2ecoff.c to mips64.

Later, Juan.

Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.20
diff -u -r1.22.2.20 Makefile
--- arch/mips64/Makefile	26 Nov 2002 11:19:52 -0000	1.22.2.20
+++ arch/mips64/Makefile	19 Dec 2002 19:48:43 -0000
@@ -255,6 +255,9 @@
 	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo --change-addresses=0xa800000080000000 $< $@
 endif
 
+vmlinux.ecoff: vmlinux
+	$(MAKE) -C arch/mips/boot $@
+
 zImage: vmlinux
 	@$(MAKEBOOT) zImage
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
