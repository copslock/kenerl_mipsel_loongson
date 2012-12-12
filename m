Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 11:54:23 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:4084 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6828015Ab2LLKyVhElkJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Dec 2012 11:54:21 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 12 Dec 2012 02:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,265,1355126400"; 
   d="asc'?scan'208";a="261054906"
Received: from blue.fi.intel.com ([10.237.72.156])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2012 02:54:10 -0800
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 828A2E0073; Wed, 12 Dec 2012 12:55:38 +0200 (EET)
Date:   Wed, 12 Dec 2012 12:55:38 +0200
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH, RESEND] asm-generic, mm: pgtable: consolidate zero page
 helpers
Message-ID: <20121212105538.GA14208@otc-wbsnb-06>
References: <1354881215-26257-1-git-send-email-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.00.1212111906270.18872@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212111906270.18872@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2012 at 07:07:14PM -0800, David Rientjes wrote:
> On Fri, 7 Dec 2012, Kirill A. Shutemov wrote:
>=20
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >=20
> > We have two different implementation of is_zero_pfn() and
> > my_zero_pfn() helpers: for architectures with and without zero page
> > coloring.
> >=20
> > Let's consolidate them in <asm-generic/pgtable.h>.
> >=20
>=20
> What's the benefit from doing this other than generalizing some per-arch=
=20
> code?  It simply adds on more layer of redirection to try to find the=20
> implementation that matters for the architecture you're hacking on.

The idea of asm-generic is consolidation arch code which can be re-used
for different arches. It also makes support of new arches easier.

Do you think have copy of the same code here and there is any better?

--=20
 Kirill A. Shutemov

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQyGKqAAoJEAd+omnVudOMyuEQAMemWRvnFt+7wByWD1jXWC2Z
nUe8yPig5B3W4uawzQNJXj7PS9xr+xHCi52KlJT5TLnpPAih8ozor0Ohj+hxWBG0
OssHOzZhk6z+/IEG1DB8UDOmVUK9z3k17yfqsZkx+YB9F/x5tSug1Qt5AHGYvzt8
LXYbtVBx5CJm21TlnnOfx7woy21Q6CgAWhA+wBm+MiUbTN1btI8xmapBAuzrE+vh
1EIFdZe+7uWJOqHNadmVhjFvhF/Bym9z3dY7+hCc6dKvqPVOm2Bd1KJ5Pw3kgXls
m1d2Z6LEdC7k7z1ZtU1T+mUSVSJbEMCc3F9x7FcP24sw/9zYWNX0zG6t2Iz0Mr5N
AQ7uZxWIn9OdEhmViJyoqHDUNBIP+k+fg5M57ZsgB42BR4orJvRgCEtV2Byts+sN
kn0AqJHU2n7v60liv/mzeKKK9z/c+Kjeg3Tp6vRSg7jSjl1Akk9M4urtuu9fFEBw
bNS0IsIdjMwMF5DVXJGR5fCW8wu4r20VvRv8ISjGTo+g7FngSphafmwEq5Fl0/Hh
2c0sZ+j9fpuuvwzzYBUPdulXji8frkHZ4WxMGJ1DINTq6kARaaxGkNFUS1IeteCG
Wpyj+chEnkL+1UwLLdrfGz7gbO/+fmeiuTOAnbS2qOe5zcRD8pcTCBhQ4W/IQXcG
5L9+tvjncCAEktFUZWvH
=6aAs
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
