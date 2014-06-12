Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 23:11:14 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45136 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816886AbaFLVLMMD8U8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 23:11:12 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249])
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1WvCH6-00072R-AW; Thu, 12 Jun 2014 22:11:08 +0100
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <ben@decadent.org.uk>)
        id 1WvCH3-0007Bs-Dx; Thu, 12 Jun 2014 22:11:05 +0100
Message-ID: <1402607459.31756.58.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#751417: linux-image-3.2.0-4-5kc-malta: no SIGKILL after
 prctl(PR_SET_SECCOMP, 1, ...) on MIPS
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     stable <stable@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, 751417@bugs.debian.org,
        team@security.debian.org, Plamen Alexandrov <plamen@aomeda.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Date:   Thu, 12 Jun 2014 22:10:59 +0100
In-Reply-To: <20140612210531.GB30046@kroah.com>
References: <20140612161903.32229.20589.reportbug@debian-mips."">
         <1402601767.31756.38.camel@deadeye.wl.decadent.org.uk>
         <1402604501.31756.50.camel@deadeye.wl.decadent.org.uk>
         <20140612210323.GA30046@kroah.com> <20140612210531.GB30046@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-co+I4pmlbw9hQcUxpJqF"
X-Mailer: Evolution 3.12.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40508
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


--=-co+I4pmlbw9hQcUxpJqF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-06-12 at 14:05 -0700, Greg KH wrote:
> On Thu, Jun 12, 2014 at 02:03:23PM -0700, Greg KH wrote:
> > On Thu, Jun 12, 2014 at 09:21:41PM +0100, Ben Hutchings wrote:
> > > On Thu, 2014-06-12 at 20:36 +0100, Ben Hutchings wrote:
> > > > Control: tag -1 security upstream patch moreinfo
> > > > Control: severity -1 grave
> > > > Control: found -1 3.14.5-1
> > >=20
> > > Aurelien Jarno pointed out this appears to be fixed upstream in 3.15:
> > >=20
> > > commit 137f7df8cead00688524c82360930845396b8a21
> > > Author: Markos Chandras <markos.chandras@imgtec.com>
> > > Date:   Wed Jan 22 14:40:00 2014 +0000
> > >=20
> > >     MIPS: asm: thread_info: Add _TIF_SECCOMP flag
> > >=20
> > > It looks like this can be cherry-picked cleanly onto stable branches =
for
> > > 3.13 and 3.14.  For 3.11 and 3.12, it will need trivial adjustment.
> > >=20
> > > For branches older than 3.11, this needs to be cherry-picked first:
> > >=20
> > > commit e7f3b48af7be9f8007a224663a5b91340626fed5
> > > Author: Ralf Baechle <ralf@linux-mips.org>
> > > Date:   Wed May 29 01:02:18 2013 +0200
> > >=20
> > >     MIPS: Cleanup flags in syscall flags handlers.
> >=20
> > It also needs parts of 1d7bf993e0731b4ac790667c196b2a2d787f95c3 (MIPS:
> > ftrace: Add support for syscall tracepoints.) to apply properly to stuf=
f
> > older than 3.11.  But, I'm not so sure that is good to apply as that is
> > a whole new feature.
> >=20
> > So I think I'll just do this "by hand" to get it to work properly...
>=20
> Wait, no, SECCOMP for MIPS isn't even in 3.10 or older kernels, so why
> is this a 3.2 issue?  Did you add it there to your kernel for some
> reason?

Seccomp mode 2 (i.e. filtering with BPF) was only just implenented for
MIPS in 3.15.  Mode 1 (fixed set of syscalls) was implemented long ago.

(If prctl(PR_SET_SECCOMP) could return success when CONFIG_SECCOMP is
not enabled, that would be even worse!)

Ben.

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-co+I4pmlbw9hQcUxpJqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAU5oXaee/yOyVhhEJAQrIHBAAmC3LLC+4pHTflfXybHfw9gFd7fLBAau2
ATeRAIAw75ag/FZ+p2YOw4cD11fIbHBKXePzg1ST0E1a6PK/svkWyw5vfUqM5S/2
KUUEZOmzub3tQ/TNSKzpyEEOvyyQtgq8JHka28rLmDOd17n/kKb29Oj8Cc6NPw05
oEEOuNksEfcULrF474HIYQaF5XYlDLhpMyU1gtQh3O2/f6iUOJwan5NvPiJtCbPv
2M+H2zSRVQIY2SZZGIjIiwLZgfNx9VOP/Q64voJc87/7bsle39pskANGFavk2jA/
DdTVvdRk4934OQRxqw0CmwMK0bjtTAuATxoQuhwAJbKGxqYlnVGLfSnt7i8IAzaj
tOnIz3lgbUfdArfqFMjPEPAxVZyoBvW75GVw5LZjppu+XLK2DDSsUOd8RsV0CgBc
vdD4YuNYBfJ8+wD03tbm255QGog40KJ7s1cR3Ljg03b2Q/B2lOnAl89gIMcY+Apr
B0MqV5hT5oDu8id+dQzUwg5kmlJst/SC7teZ4Liw/jHxNKbqpGGIjhfND9ML9glB
WgAG9fhOZwUVIhlRkwhtZgECVo7lO39fmr7cCWqiXEQx1K1Crddf0UIewPVIIOtL
H6yR+tRmAP7Bt6WAGADGfzAn4BI2dQcjZ/BlzsD5aHpkA3QqPAHRlXHckISmcPfz
lveBMbMSw5I=
=T59U
-----END PGP SIGNATURE-----

--=-co+I4pmlbw9hQcUxpJqF--
