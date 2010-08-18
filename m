Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 17:19:11 +0200 (CEST)
Received: from chilli.pcug.org.au ([203.10.76.44]:34290 "EHLO smtps.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491189Ab0HRPTF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 17:19:05 +0200
Received: from canb.auug.org.au (ta-1-1.tip.net.au [203.11.71.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtps.tip.net.au (Postfix) with ESMTPSA id 6BD02144001;
        Thu, 19 Aug 2010 01:19:01 +1000 (EST)
Date:   Thu, 19 Aug 2010 01:18:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        David Daney <ddaney@caviumnetworks.com>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Message-Id: <20100819011856.bfef5f65.sfr@canb.auug.org.au>
In-Reply-To: <20100818143926.GB2849@linux-mips.org>
References: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
        <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
        <20100816204211.GA17571@angua.secretlab.ca>
        <20100817134039.fc1108c7.sfr@canb.auug.org.au>
        <20100818143926.GB2849@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__19_Aug_2010_01_18_56_+1000_j7Y8IpmBi+6UQ0n9"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Thu__19_Aug_2010_01_18_56_+1000_j7Y8IpmBi+6UQ0n9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On Wed, 18 Aug 2010 15:39:26 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Kconfig will pick the default machine which is an IP22 for allyesconfig
> and allmodconfig.  The makefile will then pick the right flags for the
> compiler based on machine, processor and endian selection.  so it'll
> happily build a big endian kernel with a little endian compiler.  All
> that's really different between those compilers are the defaults.  Buildi=
ng
> more different defconfigs is a better investments of CPU cycles.
>=20
> An issue with very large functionss for which I've posted a patch earlier
> today used to break makeallconfig / makeallmodconfig on MIPS.  I'll sort
> those out but right now I just don't have the CPU cycles to regularly
> build such monster kernel configs.
>=20
> A suggested set of kernel defconfigs to test:
>=20
> bigsur_defconfig
> cavium-octeon_defconfig
> ip22_defconfig
> ip27_defconfig
> ip32_defconfig
> malta_defconfig
> allmodconfig
>=20
> These cover a huge variety of features, UP, SMP & weirdo SMP, flatmem & N=
UMA,
> 32-bit, 64-bit, little and big endian.

OK, I will adjust the MIPS builds tomorrow.  Thanks for the suggestions.
Just be clear, I only need to build with one compiler (presumably what
gcc/binutils produces when I ask for a "mips" toolchain) and can drop the
other ("mipsel"), correct?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__19_Aug_2010_01_18_56_+1000_j7Y8IpmBi+6UQ0n9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMa/ngAAoJEDMEi1NhKgbsiXMH/2bOR2K7i9XtpX6mPxzDxame
8CCWt95rYo1+b2e8bKRvHn8gAnjDPVfrXtOMISaodcLdwuvO8PtbD1uOMO93YUej
dK1krXMUYf1GMHkyeydTM5KrLOALfY2QpOCmGg3oC0h+WERe5REXw4uNHxYZ3jD8
okNUbMQMT9y+6VodbpfnLK7sksAkJn//F5gdEe+UZCejMzUyLFG4vGpXwpEcvfpQ
LFCT+mzlIdW7kEIiwBICQXq8N/D6sFIzavx+E43mt+zxRz7YXlTuJMTMVp8gJqaO
v8HAtkGwhzGsQBDFJkbjqOMqRzUDNvmRsuLEl31qFBzqz45+xbCjwt9ykP4SP/k=
=FjZK
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Aug_2010_01_18_56_+1000_j7Y8IpmBi+6UQ0n9--
