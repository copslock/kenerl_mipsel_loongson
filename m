Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3MKdlu21541
	for linux-mips-outgoing; Sun, 22 Apr 2001 13:39:47 -0700
Received: from fileserv2.Cologne.DE ([62.145.23.107])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3MKdfM21538
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 13:39:42 -0700
Received: from localhost (1840 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14rQdi-0007hjC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 22:39:26 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id WAA09033;
	Sun, 22 Apr 2001 22:40:18 +0200
Date: Sun, 22 Apr 2001 22:40:18 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: ls from fileutils-4.0.43 segfaults
Message-ID: <20010422224018.A9017@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hallo everyone,

I have tried to install fileutils_4.0.43-1_mipsel.deb from
source.rfc822.org and found that "ls" segfaults, the other binaries seem
to be ok. So I have tried compiling it myself against glibc-2.2.2 on
repeat.rfc822.org and also on my DECstation, but the effect stays the
same.

On repeat we have:
bash> ld -v
GNU ld version 2.11.90.0.1 (with BFD 2.11.90.0.1)
bash> gcc -v
gcc version 2.95.3 20010315 (Debian release)

On my DECstation I have:
bash> ld -v
GNU ld version 010330 (with BFD 010330)
bash> gcc -v
gcc version 2.95.3 20010315 (Debian release)

Has anybody successfully build fileutils-4.0.43 against glibc-2.2.2?

I had fileutils built ok against glibc-2.0.6 before with 
bash> gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-linux/egcs-2.90.29/specs
gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)
bash> ld -v
GNU ld version 2.8.1 (with BFD 2.8.1)
(these contain Ralf's patches).

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
