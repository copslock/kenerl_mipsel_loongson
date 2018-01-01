Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 00:12:52 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:32893 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992105AbeAAXMou0nxt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jan 2018 00:12:44 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E01CAAF1;
        Mon,  1 Jan 2018 23:12:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Date:   Tue, 02 Jan 2018 10:12:25 +1100
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix early CM probing
In-Reply-To: <1454953591-19491-1-git-send-email-paul.burton@imgtec.com>
References: <1454953591-19491-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <87fu7pfa1y.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <neilb@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: neilb@suse.com
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08 2016, Paul Burton wrote:

> Commit c014d164f21d ("MIPS: Add platform callback before initializing
> the L2 cache") added a platform_early_l2_init function in order to allow
> platforms to probe for the CM before L2 initialisation is performed, so
> that CM GCRs are available to mips_sc_probe.
>
> That commit actually fails to do anything useful, since it checks
> mips_cm_revision to determine whether it should call mips_cm_probe but
> the result of mips_cm_revision will always be 0 until mips_cm_probe has
> been called. Thus the "early" mips_cm_probe call never occurs.
>
> Fix this & drop the useless weak platform_early_l2_init function by
> simply calling mips_cm_probe from setup_arch. For platforms that don't
> select CONFIG_MIPS_CM this will be a no-op, and for those that do it
> removes the requirement for them to call mips_cm_probe manually
> (although doing so isn't harmful for now).
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Hi,
 this change breaks the "gnubee" open-hardware NAS board (gnubee.org),
 which is based on a mediatek mt7621 SOC (which admittedly needs a bunch
 of other patches to work at all).

 I forward ported the patches from a mostly-working 4.4-based release to
 upstream and it didn't even print anything to the console.   "git
 bisect" led me to this patch.
 Reverting the change to setup_arch() means my mainline-based kernel
 gets a lot further.

 Based on the description above, I thought that maybe I should just
 disabled CONFIG_MIPS_CM, but that is selected automatically by
 CONFIG_MIPS_GIC, and I suspect that I need that.

 Can you suggest anything I might try to isolate why mips_cm_probe()
 might be causing a problem on this hardware?

Thanks,
NeilBrown


> ---
>
>  arch/mips/kernel/setup.c         |  1 +
>  arch/mips/mm/sc-mips.c           | 10 ----------
>  arch/mips/mti-malta/malta-init.c |  8 --------
>  3 files changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 569a7d5..5fdaf8b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -782,6 +782,7 @@ static inline void prefill_possible_map(void) {}
>  void __init setup_arch(char **cmdline_p)
>  {
>  	cpu_probe();
> +	mips_cm_probe();
>  	prom_init();
>=20=20
>  	setup_early_fdc_console();
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 3bd0597..2496475 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -181,10 +181,6 @@ static int __init mips_sc_probe_cm3(void)
>  	return 1;
>  }
>=20=20
> -void __weak platform_early_l2_init(void)
> -{
> -}
> -
>  static inline int __init mips_sc_probe(void)
>  {
>  	struct cpuinfo_mips *c =3D &current_cpu_data;
> @@ -194,12 +190,6 @@ static inline int __init mips_sc_probe(void)
>  	/* Mark as not present until probe completed */
>  	c->scache.flags |=3D MIPS_CACHE_NOT_PRESENT;
>=20=20
> -	/*
> -	 * Do we need some platform specific probing before
> -	 * we configure L2?
> -	 */
> -	platform_early_l2_init();
> -
>  	if (mips_cm_revision() >=3D CM_REV_CM3)
>  		return mips_sc_probe_cm3();
>=20=20
> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta=
-init.c
> index 571148c..dc2c521 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c
> @@ -293,7 +293,6 @@ mips_pci_controller:
>  	console_config();
>  #endif
>  	/* Early detection of CMP support */
> -	mips_cm_probe();
>  	mips_cpc_probe();
>=20=20
>  	if (!register_cps_smp_ops())
> @@ -304,10 +303,3 @@ mips_pci_controller:
>  		return;
>  	register_up_smp_ops();
>  }
> -
> -void platform_early_l2_init(void)
> -{
> -	/* L2 configuration lives in the CM3 */
> -	if (mips_cm_revision() >=3D CM_REV_CM3)
> -		mips_cm_probe();
> -}
> --=20
> 2.7.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlpKwFkACgkQOeye3VZi
gbm6cBAAmtsL4pvZ9MMU3xFoGj7empwNbLTuylauasX60Yabp84r153AY8g5aBRw
OkAzFL2/jAEcYS7+hOz4AIsdzyH4kuSpQdyRs5somsyw5prvb0K+m/syPI4eg/Au
v9pK2HJ2QwoE3hnVbxbwfVTW7G5xFavPxRJkke5R65CMiUVnsxXHG9HuGgEFeUgi
ISL6siOcAVWYpWXSH5AxghUk52YRDvoe7kC+RK9PxfWB90guU7zhoABb6tRdVOpp
8+NSrnQ8BacLt+LMHWsxBCntVNPpi7UxxBWEUrEWhJaiBQfxz57MrPVO/PG5UFMm
87P/nKC7xhCENkc//vQyZXYR/HnGIVjXwm0qc3KzZ/3tiq5aSSaE+ENPNcCpMuCS
87q7CG2qw7iPznVwP6wnyx+ST4E8Qx+3XUoQUJH1VQtzQLBzsDTGxPG67pQrkZnU
RzqS9uOO++1j+ghNJsLxKoX/BKYZyfpITdAQuNVxFJljwD6x15P/a5SbwriAeD2y
1FCQQFZlbAoZKXbNcMvz7UeLHmJ77TChb5lQlUE1z4/67wHjkUrASkviq30DThQv
kK7DqU7IgMDW2w7JqCYOFIOn3uxqrnWrrlLz2Vl9gsdod7adGjMcO6xRamzRKR+4
J7G/do6235G7Pc+nj/0ggrjqKZHNLLx53MCHKj7iTJT0XHi4+38=
=HLWU
-----END PGP SIGNATURE-----
--=-=-=--
