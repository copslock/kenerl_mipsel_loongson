Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 10:24:47 +0200 (CEST)
Received: from pax.zz.de ([88.198.69.77]:36829 "EHLO pax.zz.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819445AbaDIIYqE4IiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Apr 2014 10:24:46 +0200
Received: by pax.zz.de (Postfix, from userid 1000)
        id 653A3D009B; Wed,  9 Apr 2014 10:24:45 +0200 (CEST)
Date:   Wed, 9 Apr 2014 10:24:45 +0200
From:   Florian Lohoff <f@zz.de>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Michal Marek <mmarek@suse.cz>, kbuild-all@01.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140409082445.GC1438@pax.zz.de>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20140409051929.GA29246@localhost>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <flo@pax.zz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f@zz.de
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


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 09, 2014 at 01:19:29PM +0800, Fengguang Wu wrote:
> b9dbdce1 Ralf Baechle 2010-08-05  27  ifdef CONFIG_SGI_IP28
> b9dbdce1 Ralf Baechle 2010-08-05  28    ifeq ($(call cc-option-yn,-mr10k-=
cache-barrier=3Dstore), n)
> b9dbdce1 Ralf Baechle 2010-08-05 @29        $(error gcc doesn't support n=
eeded option -mr10k-cache-barrier=3Dstore)
> b9dbdce1 Ralf Baechle 2010-08-05  30    endif
> b9dbdce1 Ralf Baechle 2010-08-05  31  endif
> b9dbdce1 Ralf Baechle 2010-08-05  32  platform-$(CONFIG_SGI_IP28)		+=3D s=
gi-ip22/
> b9dbdce1 Ralf Baechle 2010-08-05  33  cflags-$(CONFIG_SGI_IP28)	+=3D -mr1=
0k-cache-barrier=3Dstore -I$(srctree)/arch/mips/include/asm/mach-ip28
> b9dbdce1 Ralf Baechle 2010-08-05  34  load-$(CONFIG_SGI_IP28)		+=3D 0xa80=
0000020004000

Its IP28 only fixes in gcc see here:

http://gcc.gnu.org/ml/gcc-patches/2008-09/msg00041.html

Most likely they never made it into gcc upstream but they are
necessary working around the r10k speculative stores on non
cache coherent machines like the IP28.

Flo
--=20
Florian Lohoff                                                 f@zz.de

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBU0UDzZDdQSDLCfIvAQglqg//e3eA+lZE+TLqUvIGNrcf+YqpqcA3LlFr
xA+EsfeGlrK22/iBFm5WCMdxz9K7plkfIxLG0zZpCbJ8f4bQ5N2GSFaYxhaxRFhD
+q5HTYjPUYjhJ2eeRvRRy7R8v4qSD4klxAh6ClfxEam83Abm27o2eFxP4Pkf5cH6
sS68BKf3jS4QgcNSVsDXRfnMMfqDTj7rJPgwLhZVeRnv87NRYMlQsFjQqeSty+VP
VflFqEonjMv2wUM5oxu+eqk7fom+j27xXQpjWuF05UfzcrwQOKjBUETjykHXepkX
tAo1YDzNuqYZWu54dOLOVOamISdYHGBzwwJK1zOIhW+IfSqO9AOcvc6auTg+6Zv7
05Dcr5EjEFZPyNYjp1lmsJ1ewWmAzUaYUVMfZ9WIOqSMgqcChtni0SKox95Xrd7p
Dh6t+sjWq3LYN7O0NOF1nGnQCBXEpehp/4De4TZZJVjFxW/99ib848ILZyyJc6rG
7bDdatWaN83fX4of/RbCS9QqzNtcFjrAuRiWmJQER0cMBsnPS5U9u7MUhkNSVUfh
f2z00dX6psv/BvBAmJLYwqSlfqLTAhkLD2ruglg3WMZL/E4f9rSRP1IBqQuElGj2
s+tNQdNa75pa1Gs6wxjvasPcGbbUddtxHV/Mv0AGYsJCGLfkeFjETMiEAUatHTYA
5zm+0X8/v7I=
=24d0
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
