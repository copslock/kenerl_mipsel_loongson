Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2009 08:24:56 +0100 (BST)
Received: from chilli.pcug.org.au ([203.10.76.44]:6529 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20024593AbZDSHYu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2009 08:24:50 +0100
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id 39847144063;
	Sun, 19 Apr 2009 17:24:40 +1000 (EST)
Date:	Sun, 19 Apr 2009 17:24:36 +1000
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	"Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Ingo Molnar <mingo@elte.hu>
Subject: mips build failure
Message-Id: <20090419172436.6d0e741a.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.14.7; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__19_Apr_2009_17_24_36_+1000_P.qBmo6YX6D.ipq0"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Sun__19_Apr_2009_17_24_36_+1000_P.qBmo6YX6D.ipq0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

You probably already now about this, but our build (mips ip32_defconfig)
of Linus' tree (commit aefe6475720bd5eb8aacbc881488f3aa65618562 "Merge
branch 'upstream-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev") gets
these errors (we have actually been getting these errors since 2.6.30-rc1):

In file included from arch/mips/include/asm/compat.h:7,
                 from include/linux/compat.h:15,
                 from arch/mips/kernel/asm-offsets.c:12:
include/linux/seccomp.h: In function 'prctl_get_seccomp':
include/linux/seccomp.h:30: error: 'EINVAL' undeclared (first use in this f=
unction)
include/linux/seccomp.h:30: error: (Each undeclared identifier is reported =
only once
include/linux/seccomp.h:30: error: for each function it appears in.)
include/linux/seccomp.h: In function 'prctl_set_seccomp':
include/linux/seccomp.h:35: error: 'EINVAL' undeclared (first use in this f=
unction)

Bisected down to commit ac44021fccd8f1f2b267b004f23a2e8d7ef05f7b
"kmemtrace, rcu: don't include unnecessary headers, allow kmemtrace w/
tracepoints".

http://kisskb.ellerman.id.au/kisskb/buildresult/330240/
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__19_Apr_2009_17_24_36_+1000_P.qBmo6YX6D.ipq0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknq0bQACgkQjjKRsyhoI8yPyACgvM2RG8LekwRKKrz1issoqozl
rzwAoJH3Zo9zZpFTraxbCIvFPO+pfJJw
=AUJx
-----END PGP SIGNATURE-----

--Signature=_Sun__19_Apr_2009_17_24_36_+1000_P.qBmo6YX6D.ipq0--
