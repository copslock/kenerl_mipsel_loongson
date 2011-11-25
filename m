Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2011 09:41:48 +0100 (CET)
Received: from ra.se.axis.com ([195.60.68.13]:38209 "EHLO ra.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903650Ab1KYIll (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Nov 2011 09:41:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by ra.se.axis.com (Postfix) with ESMTP id 4FCF557375;
        Fri, 25 Nov 2011 09:41:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
        by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1H9HQNQRM3al; Fri, 25 Nov 2011 09:41:34 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by ra.se.axis.com (Postfix) with ESMTP id BB75E57370;
        Fri, 25 Nov 2011 09:41:27 +0100 (CET)
Received: from silver.se.axis.com (silver.se.axis.com [10.88.4.3])
        by thoth.se.axis.com (Postfix) with ESMTP id 99DB334108;
        Fri, 25 Nov 2011 09:41:27 +0100 (CET)
Received: from silver.se.axis.com (localhost [127.0.0.1])
        by silver.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id pAP8fRKf010458;
        Fri, 25 Nov 2011 09:41:27 +0100
Received: (from jespern@localhost)
        by silver.se.axis.com (8.14.3/8.14.3/Submit) id pAP8f9K6010452;
        Fri, 25 Nov 2011 09:41:09 +0100
Date:   Fri, 25 Nov 2011 09:41:09 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <rob.herring@calxeda.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        "John W. Linville" <linville@tuxdriver.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Arend van Spriel <arend@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-cris-kernel <linux-cris-kernel@axis.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux@openrisc.net" <linux@openrisc.net>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH-RFC 01/10] lib: move GENERIC_IOMAP to lib/Kconfig
Message-ID: <20111125084109.GS13937@axis.com>
References: <cover.1322163031.git.mst@redhat.com> <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 31993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21281


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2011 at 09:15:42PM +0100, Michael S. Tsirkin wrote:
> define GENERIC_IOMAP in a central location
> instead of all architectures. This will be helpful
> for the follow-up patch which makes it select
> other configs. Code is also a bit shorter this way.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
--=20
               Jesper Nilsson -- jesper.nilsson@axis.com

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk7PVKUACgkQ31LbvUHyf1e75ACePpPqRaa0/hcY5Pc6jHLp11KX
g3oAn37y5BAjmjOjjeqo5aGJkxBrHR5C
=GpXx
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
