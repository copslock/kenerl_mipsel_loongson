Received:  by oss.sgi.com id <S553799AbRAIXn1>;
	Tue, 9 Jan 2001 15:43:27 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:6155 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553770AbRAIXnM>; Tue, 9 Jan 2001 15:43:12 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14G8Py-0008R6-00; Wed, 10 Jan 2001 00:43:06 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14G8Px-0001m4-00; Wed, 10 Jan 2001 00:43:05 +0100
Date:   Wed, 10 Jan 2001 00:43:05 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Ralf Baechle <ralf@uni-koblenz.de>
Cc:     linux-mips@oss.sgi.com
Subject: sgialib.h
Message-ID: <20010110004305.A6815@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Building of latest cvs kernel for IP22 fails for me in 
arch/mips/arc/init.c and arch/mips/kernel/setup.c 
due to a typemismatch in the declaration of prom_init in the above 
mentioned files and sgialib.h. The attached patch fixes this.
 -- Guido

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sgialib.diff"

--- include/asm-mips/sgialib.h.orig	Wed Jan 10 00:24:13 2001
+++ include/asm-mips/sgialib.h	Wed Jan 10 00:26:55 2001
@@ -20,7 +20,7 @@
  * Init the PROM library and it's internal data structures.  Called
  * at boot time from head.S before start_kernel is invoked.
  */
-extern int prom_init(int argc, char **argv, char **envp, int *prom_vec);
+extern void prom_init(int argc, char **argv, char **envp, int *prom_vec);
 
 /* Simple char-by-char console I/O. */
 extern void prom_putchar(char c);

--zhXaljGHf11kAtnf--
