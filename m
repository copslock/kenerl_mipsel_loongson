Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Apr 2004 12:52:11 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:16544 "EHLO
	natsmtp00.webmailer.de") by linux-mips.org with ESMTP
	id <S8225554AbUDDLwK>; Sun, 4 Apr 2004 12:52:10 +0100
Received: from excalibur.cologne.de (pD9E40B40.dip.t-dialin.net [217.228.11.64])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i34Bq5vZ016645;
	Sun, 4 Apr 2004 13:52:05 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1BA6Af-0007Vp-00; Sun, 04 Apr 2004 13:52:13 +0200
Date: Sun, 4 Apr 2004 13:52:12 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Kernel vs. glibc problems
Message-ID: <20040404115212.GA22445@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

Hallo everybody,

I am experiencing problems with current kernels depending on which glibc
version I have installed and on which machine I run my tests.

On a DECstation 5000/150, having an R4000SC, everything works fine,
regardless which combination of kernel and glibc I use. Tested
combinations:
- Debian 2.4.19 plus Debian/Woody glibc (2.2.5)
- Debian 2.4.19 plus Debian/Sarge glibc (2.3.2)
- CVS 2.4.25 from 2004/03/25 plus Debian/Sarge glibc (2.3.2)

On a DECstation 5000/20, having an R3000, the following combinations work:
- Debian 2.4.19 plus Debian/Woody glibc (2.2.5)
- Debian 2.4.19 plus Debian/Sarge glibc (2.3.2)
- CVS 2.4.25 from 2004/03/25 plus Debian/Woody glibc (2.2.5)
But running the same CVS 2.4.25 with the Debian/Sarge glibc (2.3.2)
causes (at least) ls, sleep and tar to die with "illegal instruction".

Similar behavior regarding 2.4.25 plus Debian/Sid glibc (2.3.2) has
been reported for a DECstation 5000/133 (also R3k).

Besides, there has been a report on debian-mips in
<599FD8BDB7FBD511A4D10008C7CFB6DC06FB93DA@dfwex02.allegiancetelecom.com>
that similar behaviour also happened on a Cobalt box, which
has an R5k-compatible core. Quotation from that email:
"Last time I tried it, it broke tar, ls -l, gcc, and just about everything
else that called the gettimeofday() system call.", which fits
to my experiences on the R3k DECstations.

All this seems to point to some kernel-vs-glibc mismatch. The only
thing I could dig out in this regard was the change in struct msqid_ds
(see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=200215), but
that does not explain why this happens on an R3k DECstation but
not on an R4k DECstation while it happens on an R5k Cobalt, 
and the change done there should not affect ls and sleep.
Strangely the CVS kernel works fine with the _old_ glibc on the
R3k DECstations, but not with the new one, even though it should
be the other way round as the CVS kernel AFAICS has the fixes
listes in the aforementioned bugreport. 
Some problem with instruction emulation (ll/sc) on R3k came to
my mind, but that does not explain the problems on the Cobalt.

Any ideas what could cause this behaviour?

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
