Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 22:38:00 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:39727 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3KDVh6jTKve (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Nov 2013 22:37:58 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1VdRqP-0000nQ-0d; Mon, 04 Nov 2013 22:37:57 +0100
Date:   Mon, 4 Nov 2013 22:37:56 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
Message-ID: <20131104213756.GD18700@hall.aurel32.net>
References: <20130628133835.GA21839@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20130628133835.GA21839@hall.aurel32.net>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Any news about this issue? It really starts to causes a lot of issues in
Debian. I have added a Cc: to libc people so that we can also hear their
opinion.

Thanks,
Aurelien

On Fri, Jun 28, 2013 at 03:38:35PM +0200, Aurelien Jarno wrote:
> Hi,
>=20
> There is an inconsistency in the definition of RLIM64_INFINITY between
> kernel and userland for the O32 and N32 ABI:
>=20
> On the kernel side, the value is defined for all architectures as
> include/uapi/linux/resource.h:
>=20
> | #define RLIM64_INFINITY           (~0ULL)
>=20
> On the GNU libc side, the value is defined in
> ports/sysdeps/unix/sysv/linux/mips/bits/resource.h:
>=20
> For the O32 and N32 ABI:
>=20
> | #  define RLIM64_INFINITY 0x7fffffffffffffffULL
>=20
> and for the N64 ABI:
>=20
> |=A0#  define RLIM64_INFINITY 0xffffffffffffffffUL
>=20
> This was not a problem until the prlimit64 syscall was wired in the
> 2.6.36 kernel. Since then, on a 64-bit kernel and an O32 or N32
> userland, but not on a 32-bit kernel, this causes some issues for
> example it's not possible to set "ulimit -c unlimited" using dash as a
> non-priviledged user.
>=20
> This is due to the fact that when available the glibc uses the prlimit64
> syscall to implement setrlimit64, which is called from called from
> pam_limits.so. Instead of setting the limit to infinity (according to
> the userland), it is set to a very big value but still lower than
> infinity (according to the kernel). When later the setrlimit syscall is
> used to set the value to infinity, it gets an EPERM value as the kernel
> consider that as an increase of the limit (from a big value to
> infinity).
>=20
> I don't know where the issue should be fixed. The GNU libc has this
> value for more than 7 years, and as it is defined in a header file, it
> means a lot of binaries are broken when used with a 2.6.36+ kernel.
> Fixing that on the kernel side means that MIPS would have a different
> value than other architectures.
>=20
> How do you think the issue should be fixed?
>=20
> Regards,
> Aurelien
>=20
> --=20
> Aurelien Jarno	                        GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net



--=20
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFSeBO0w3ao2vG823MRAn75AJ9eqY/AtmtdsFdC4VI0koF8924jpgCffehc
LUi7GNLnzpGH9dDQfpHOpAU=
=vHdV
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
