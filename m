Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2011 01:59:37 +0100 (CET)
Received: from calzone.tip.net.au ([203.10.76.15]:56787 "EHLO
        calzone.tip.net.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904616Ab1KYA7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2011 01:59:33 +0100
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by calzone.tip.net.au (Postfix) with ESMTPSA id 611E012848C;
        Fri, 25 Nov 2011 11:59:26 +1100 (EST)
Date:   Fri, 25 Nov 2011 11:59:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux@openrisc.net,
        linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org, Arend van Spriel <arend@broadcom.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        microblaze-uclinux@itee.uq.edu.au, Paul Bolle <pebolle@tiscali.nl>,
        Rob Herring <rob.herring@calxeda.com>,
        Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Franky Lin <frankyl@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Michael Ellerman <michael@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Message-Id: <20111125115921.a3e642f06b24526dce6a96e8@canb.auug.org.au>
In-Reply-To: <20111125115455.9d5e18da6e683586d84ed9c8@canb.auug.org.au>
References: <cover.1322163031.git.mst@redhat.com>
        <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
        <20111125115455.9d5e18da6e683586d84ed9c8@canb.auug.org.au>
X-Mailer: Sylpheed 3.2.0beta3 (GTK+ 2.24.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__25_Nov_2011_11_59_21_+1100_q4XOooN5uoDKv_dZ"
X-archive-position: 31991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21175

--Signature=_Fri__25_Nov_2011_11_59_21_+1100_q4XOooN5uoDKv_dZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 25 Nov 2011 11:54:55 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Just wondering why you move pci_iomap but not pic_iounmap.

I figured this out.  Arches have their own.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Nov_2011_11_59_21_+1100_q4XOooN5uoDKv_dZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOzuhpAAoJEECxmPOUX5FESFYP/3CbBas7b+W+5nG4fSYO/XAY
YsVPpQ7wIGYtWbIpHt5fproH7C6zyXeXuhqhJWwYk7A2vM4WCIxHJKnPIP3E9AoK
EVaead1df7krZ29KJTLw0hEzhB2sftq8kotUfY7hhI0tIZ3vwPOCuTxbgaRIPAE8
rm+q0xrJVHZSZ0eM14kDP2GuHPch3WgHvNWrQUeIX94g3v3bfYOZsg4PjUnamVVg
ai5ulT6kqXdn5F1Q2G3Ftu8Cs/8CMw7wMSzYUvIr/F84t/4LZrbU6LHXAiGyEkXa
4UR8xTXMpUWpyXU7JjVqgPgS1/85DYemZrW6WBkaiHozciV6lDpgIvJ+JBhlzAY/
QUnzFjlKO6YeN0YzXF2VHaWJmtG/wnqouNHMbDvmt8RX6C4SpwiWP0w2tZhcSKmG
uYq9YyQBq6CqvzDg66xoZWigPShS6CXHZWmd2YH4tx90CwNIVZdMkisFgPTbwVsp
klTxE8gYst6ni0PoMI3xYqvVY034SaedFHRVx768gOuhNp1WaFGeWRveuRBYJiMw
noFu4kywDxJJ/s4sCQiCwzvX3JYpRMWbgtEckEW0msSquMDrPTjlBZFGwkf4/OGC
g83fXQr/YwgIJKMFyUqKabIAPX3uNfNUjzDcINzRK9mux4zrlWBzndLelIsti3FO
6V/pN4Jg3NPFIEylidUW
=sifz
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Nov_2011_11_59_21_+1100_q4XOooN5uoDKv_dZ--
