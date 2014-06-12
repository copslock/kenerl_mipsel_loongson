Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 22:21:53 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44979 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834695AbaFLUVvZafdD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 22:21:51 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249])
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1WvBVN-0004C5-G1; Thu, 12 Jun 2014 21:21:49 +0100
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <ben@decadent.org.uk>)
        id 1WvBVK-0004it-Mt; Thu, 12 Jun 2014 21:21:46 +0100
Message-ID: <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#751417: linux-image-3.2.0-4-5kc-malta: no SIGKILL after
 prctl(PR_SET_SECCOMP, 1, ...) on MIPS
From:   Ben Hutchings <ben@decadent.org.uk>
To:     stable <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     751417@bugs.debian.org, team@security.debian.org,
        Plamen Alexandrov <plamen@aomeda.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Date:   Thu, 12 Jun 2014 21:21:41 +0100
In-Reply-To: <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
References: <20140612161903.32229.20589.reportbug@debian-mips."">
         <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4y4VZH3lxh6RGQnf40y8"
X-Mailer: Evolution 3.12.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--=-4y4VZH3lxh6RGQnf40y8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-06-12 at 20:36 +0100, Ben Hutchings wrote:
> Control: tag -1 security upstream patch moreinfo
> Control: severity -1 grave
> Control: found -1 3.14.5-1

Aurelien Jarno pointed out this appears to be fixed upstream in 3.15:

commit 137f7df8cead00688524c82360930845396b8a21
Author: Markos Chandras <markos.chandras@imgtec.com>
Date:   Wed Jan 22 14:40:00 2014 +0000

    MIPS: asm: thread_info: Add _TIF_SECCOMP flag

It looks like this can be cherry-picked cleanly onto stable branches for
3.13 and 3.14.  For 3.11 and 3.12, it will need trivial adjustment.

For branches older than 3.11, this needs to be cherry-picked first:

commit e7f3b48af7be9f8007a224663a5b91340626fed5
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Wed May 29 01:02:18 2013 +0200

    MIPS: Cleanup flags in syscall flags handlers.

Ben.

> On Thu, 2014-06-12 at 16:19 +0000, Plamen Alexandrov wrote:
> > Package: src:linux
> > Version: 3.2.51-1
> > Severity: normal
> >=20
> > Under MIPS the system call prctl(PR_SET_SECCOMP, 1, ...) does not behav=
e as expected.
> > According to the manual page, after calling it with 1 as a second argum=
ent, any consecutive system calls other than read(), write(), _exit() and s=
igreturn() should result in the delivery of SIGKILL. However, under MIPS an=
y consecutive system call behaves as if prctl(PR_SET_SECCOMP, 1, ...) was n=
ever called.
> >=20
> > Here is a simple example that can be used to reproduce the bug:
> >=20
> > plamen@debian-mips:/tmp$ id
> > uid=3D1000(plamen) gid=3D1000(user) groups=3D1000(user)
> > plamen@debian-mips:/tmp$ cat prctl.c=20
> > #include <unistd.h>
> > #include <sys/prctl.h>
> > #include <stdio.h>
> >=20
> > int main(void)
> > {
> > 	if (prctl(PR_SET_SECCOMP, 1, 0, 0, 0) !=3D 0)
> > 		return 0;
> > 	uid_t uid =3D getuid();
> > 	printf("%u\n", (unsigned)uid);
> > 	return 0;
> > }
> > plamen@debian-mips:/tmp$ gcc prctl.c -o prctl
> > plamen@debian-mips:/tmp$ ./prctl=20
> > 1000
> >=20
> > There is no change if I replace
> > 	if (prctl(PR_SET_SECCOMP, 1, 0, 0, 0) !=3D 0)
> > with
> > 	if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, 0, 0) !=3D 0)
> > and I add #include <linux/seccomp.h>
>=20
> Indeed, I see no check for seccomp on the MIPS syscall 'fast path'.  The
> seccomp check appears to be done on the 'slow path' which is used only
> if tracing or audit is also enabled for the task.  If I run the above
> program under strace, it is killed as expected.
>=20
> Could you test whether the attached patches fix this?  (Instructions for
> rebuilding the Debian kernel package with patches can be found at
> <http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-o=
fficial>.  These patches apply to 'wheezy'.)
>=20
> Ben.
>=20

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-4y4VZH3lxh6RGQnf40y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAU5oL2ue/yOyVhhEJAQrhgBAAm7rsfJq5HuIrffdD+/B5qmRbZegUZfRp
bmGL9RJAvZTIvbI1QscuGUCan4eCAvPA0dKWvFkXDSZGVl0TtQL4I9Unbab8ukM6
WqpODuVDVUsX/OS12mYhgRHMSd6YzuO0Tkr6v9GevO96N+6/f8WwaVkJPIczLFM/
XFiiKTi3PCddC9ujqVpU7PohGN2K71evb8S3UlXCRWTJt57+cNQJrCFqqLTjObt6
Rqs64mC7IprDDvf+TXBTdnzmDMEbOzb4bU2LKzNlj0m8q/3hfMgFZGQScHApAr0J
s1Sg/qIdLaWtLLjXUp1oNwHXNMrijxKfY1U8J4rAyzw+ssHumBVNw9LMOfQkuPZL
1ZPJC5uwRfs8uR5TPBS7pX60aFNmBNHP2IVomJnMrjIU4dXUdQ+1Z8YAWe+o1utU
CoxSQv/Mm0jh40T1vx2Bp0gzQvAgt0xBQ72mddId9pkV868oqtFI8jCzaRuvpcqs
8IiEVxSotohzf9g9fbfSkrLVC2abyAsQ/dfwV4d+AqTmqfRcaeTV5LOaqjERm2mV
l0qUMcCmeSzBYG4hxpZYp8goiv3R5F8kwGilCNprryPVQatEFn09dMY+A108WgFJ
wwoOlKuF06sPUdR/hcjCF+oTxkn2GUY5YNvXt4ZMuAw0zKRqCKMtmq+iEbolMGSw
GJhaRvHJUmU=
=NiYu
-----END PGP SIGNATURE-----

--=-4y4VZH3lxh6RGQnf40y8--
