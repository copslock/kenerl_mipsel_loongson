Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 15:38:37 +0200 (CEST)
Received: from hall.aurel32.net ([88.191.116.210]:54544 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817387Ab3F1Nigfb7x3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 15:38:36 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1UsYsl-0006NL-T4
        for linux-mips@linux-mips.org; Fri, 28 Jun 2013 15:38:35 +0200
Date:   Fri, 28 Jun 2013 15:38:35 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Subject: prlimit64: inconsistencies between kernel and userland
Message-ID: <20130628133835.GA21839@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37203
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

There is an inconsistency in the definition of RLIM64_INFINITY between
kernel and userland for the O32 and N32 ABI:

On the kernel side, the value is defined for all architectures as
include/uapi/linux/resource.h:

| #define RLIM64_INFINITY           (~0ULL)

On the GNU libc side, the value is defined in
ports/sysdeps/unix/sysv/linux/mips/bits/resource.h:

For the O32 and N32 ABI:

| #  define RLIM64_INFINITY 0x7fffffffffffffffULL

and for the N64 ABI:

|=A0#  define RLIM64_INFINITY 0xffffffffffffffffUL

This was not a problem until the prlimit64 syscall was wired in the
2.6.36 kernel. Since then, on a 64-bit kernel and an O32 or N32
userland, but not on a 32-bit kernel, this causes some issues for
example it's not possible to set "ulimit -c unlimited" using dash as a
non-priviledged user.

This is due to the fact that when available the glibc uses the prlimit64
syscall to implement setrlimit64, which is called from called from
pam_limits.so. Instead of setting the limit to infinity (according to
the userland), it is set to a very big value but still lower than
infinity (according to the kernel). When later the setrlimit syscall is
used to set the value to infinity, it gets an EPERM value as the kernel
consider that as an increase of the limit (from a big value to
infinity).

I don't know where the issue should be fixed. The GNU libc has this
value for more than 7 years, and as it is defined in a header file, it
means a lot of binaries are broken when used with a 2.6.36+ kernel.
Fixing that on the kernel side means that MIPS would have a different
value than other architectures.

How do you think the issue should be fixed?

Regards,
Aurelien

--=20
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFRzZHbw3ao2vG823MRAjhnAJ4+wH+LcVC/NHF8VmGqLwHZ5NzRlgCeKDSV
lsWlIshZDsye2rGGPPZ5Yjs=
=J+Uc
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
