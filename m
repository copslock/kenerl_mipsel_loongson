Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2010 11:20:26 +0200 (CEST)
Received: from mail.codesourcery.com ([38.113.113.100]:44680 "EHLO
        mail.codesourcery.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0G3JUW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jul 2010 11:20:22 +0200
Received: (qmail 18819 invoked from network); 30 Jul 2010 09:20:17 -0000
Received: from unknown (HELO dirichlet.schwinge.homeip.net) (thomas@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 30 Jul 2010 09:20:17 -0000
From:   Thomas Schwinge <thomas@codesourcery.com>
To:     linux-mips@linux-mips.org
Cc:     macro@codesourcery.com
Subject: PCI issues on Malta / 20Kc / Bonito64
X-Homepage: http://www.thomas.schwinge.homeip.net/
Date:   Fri, 30 Jul 2010 11:20:09 +0200
Message-ID: <8739v14986.fsf@dirichlet.schwinge.homeip.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-Path: <thomas@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@codesourcery.com
Precedence: bulk
X-list: linux-mips

--=-=-=

Hello!

I'm having difficulties getting a recent kernel (that is, first plain
Linux 2.6.34, then MIPS Linux master as of today) running on our 64-bit
Malta board.  These kernels do boot, but show the following problem:

    pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
    pcnet32: No access methods

I have not yet determinated exactly when this broke, but when booting a
kernel from 2.6.29-based sources (March 2009), it works fine:

    pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
    pcnet32: PCnet/FAST III 79C973 at 0x1060, 00 d0 a0 00 04 d9 assigned IRQ 10.
    eth0: registered as PCnet/FAST III 79C973
    pcnet32: 1 cards_found.

Our 20Kc Malta core card uses the Algorithmics Bonito64 system
controller, which is not in widespread use, as I'm told by Maciej, and
thus perhaps may have missed some PCI subsystem updates?


Regards,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxSmUkACgkQC9ZuxbdEiFiGmgCfYFD1neUSQJoCvYDV7XR8Wo7z
DWAAoIYln5OBLwGaOvTZq24QdL3cg9u0
=oeYE
-----END PGP SIGNATURE-----
--=-=-=--
