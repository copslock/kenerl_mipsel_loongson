Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 14:20:41 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:38438 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992262AbdIFMUd4j1j2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Sep 2017 14:20:33 +0200
Received: from avionic-0141 (unknown [80.187.112.39])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 04D01780396;
        Wed,  6 Sep 2017 14:20:13 +0200 (CEST)
Date:   Wed, 6 Sep 2017 14:20:05 +0200
From:   Alban <albeu@free.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rocco Folino <rocco.folino@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906142005.67586253@avionic-0141>
In-Reply-To: <20170906111435.GA1856@linux-mips.org>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
        <20170906111435.GA1856@linux-mips.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nd3vumMaUNjHQFp.SuYcp1b"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/nd3vumMaUNjHQFp.SuYcp1b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Sep 2017 13:14:35 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:
>=20
> > Allow to choose devicetrees from Kconfig.
> >=20
> > Signed-off-by: Rocco Folino <rocco.folino@gmail.com>

I don't really see the point of this patch. Building the dtb doesn't
take any significant time, so why add this extra complexity?

Alban

--Sig_/nd3vumMaUNjHQFp.SuYcp1b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZr+f1AAoJEHSUmkuduC28u3wP/22JVWYsobIfzp53onycqX4Z
+95PCOASEajOP4VnvSCTBehpR5cdgSmTvIxj7XMvhIJTc7hdkn+ON9dd7W/Puj6a
hTj48GiBxvUiuwutzGO+wQqU92njkE7ctchlaLEKNauxy6rhAfgW4n0oTG1NuiwJ
OsQOet5qjjmbLOj6NMt/0SNlH5hc6l7RQN7c5EM7c6GWvXqookvR5wvx/1Yh3VDw
/eRxjW23ijBHZ7EaMf/a/7U7dP805aoooEUDTx8zngBrFK7byBO0tu/DytH9AdRx
a6cR1m7s5vEYjqL/VvniKQSgZA7IDuobeJhLHej73Za/BgsjLJwv/5Mf3Pv6bfD1
lL1j0Z3tz/JDqqv4nfOZLaek8t5SPOyPlECQ3MdEevftGLijtqGRMRCK8a0yp7hZ
mmEanpynF5wS2yz28I1Xc0JtnjmCB3eZd/Oe+3GYmJGP5Z8OL0PucYlh5MtYokfd
tkzdPNjyJbhlyjrcjsV5p57asjxvth5Xq39fIjWbQmrMEVRsvgkQsAXha9gz1H7Y
GhkueBbeTrBctYVnskqR+0pAaZIzrqzOn3QjwJLl6ca9kbv+TrmulA8tIjE3rHWR
9rz0ijBT8Yvf43IabghuOJzR9/m0d4RFA62ZeUWlBtAll2Uh7eCHT3ectdIVt8cn
aRlkLR0FEEp9kUzyrGIt
=nQcJ
-----END PGP SIGNATURE-----

--Sig_/nd3vumMaUNjHQFp.SuYcp1b--
