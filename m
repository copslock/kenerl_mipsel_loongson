Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:17:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16025 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011616AbbD1KR4R0YMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:17:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AB26C41F8D82;
        Tue, 28 Apr 2015 11:17:52 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 28 Apr 2015 11:17:52 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 28 Apr 2015 11:17:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 49C46FA267CD2;
        Tue, 28 Apr 2015 11:17:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 28 Apr 2015 11:17:52 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 28 Apr
 2015 11:17:51 +0100
Message-ID: <553F5E48.1090905@imgtec.com>
Date:   Tue, 28 Apr 2015 11:17:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 25/37] clk: ingenic: add driver for Ingenic SoC CGU
 clocks
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com> <1429881457-16016-26-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1429881457-16016-26-git-send-email-paul.burton@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="V3MKO262lO1Wu1ca2A2HWSoAv3KT1K739"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--V3MKO262lO1Wu1ca2A2HWSoAv3KT1K739
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 24/04/15 14:17, Paul Burton wrote:
> +static int register_clock(struct ingenic_cgu *cgu, unsigned idx)
> +{
> +	const struct ingenic_cgu_clk_info *clk_info =3D &cgu->clock_info[idx]=
;
> +	struct clk_init_data clk_init;
> +	struct ingenic_clk *ingenic_clk =3D NULL;
> +	struct clk *clk, *parent;
> +	const char *parent_names[4];
> +	unsigned caps, i, num_possible;
> +	int err =3D -EINVAL;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(clk_info->parents) > ARRAY_SIZE(parent_names)=
);
> +
> +	if (clk_info->type =3D=3D CGU_CLK_EXT) {
> +		clk =3D of_clk_get_by_name(cgu->np, clk_info->name);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: no external clock '%s' provided\n",
> +			       __func__, clk_info->name);
> +			err =3D -ENODEV;
> +			goto out;
> +		}
> +		err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> +		if (err) {
> +			clk_put(clk);
> +			goto out;
> +		}
> +		cgu->clocks.clks[idx] =3D clk;
> +		return 0;
> +	}
> +
> +	if (!clk_info->type) {
> +		pr_err("%s: no clock type specified for '%s'\n", __func__,
> +		       clk_info->name);
> +		goto out;
> +	}
> +
> +	ingenic_clk =3D kzalloc(sizeof(*ingenic_clk), GFP_KERNEL);
> +	if (!ingenic_clk) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ingenic_clk->hw.init =3D &clk_init;
> +	ingenic_clk->cgu =3D cgu;
> +	ingenic_clk->idx =3D idx;
> +
> +	clk_init.name =3D clk_info->name;
> +	clk_init.flags =3D 0;
> +	clk_init.parent_names =3D parent_names;
> +
> +	caps =3D clk_info->type;
> +
> +	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
> +		clk_init.num_parents =3D 0;
> +
> +		if (caps & CGU_CLK_MUX)
> +			num_possible =3D 1 << clk_info->mux.bits;
> +		else
> +			num_possible =3D ARRAY_SIZE(clk_info->parents);
> +
> +		for (i =3D 0; i < num_possible; i++) {
> +			if (clk_info->parents[i] =3D=3D -1)
> +				continue;
> +
> +			parent =3D cgu->clocks.clks[clk_info->parents[i]];
> +			parent_names[clk_init.num_parents] =3D
> +				__clk_get_name(parent);
> +			clk_init.num_parents++;
> +		}
> +
> +		BUG_ON(!clk_init.num_parents);
> +		BUG_ON(clk_init.num_parents > ARRAY_SIZE(parent_names));
> +	} else {
> +		BUG_ON(clk_info->parents[0] =3D=3D -1);
> +		clk_init.num_parents =3D 1;
> +		parent =3D cgu->clocks.clks[clk_info->parents[0]];
> +		parent_names[0] =3D __clk_get_name(parent);
> +	}
> +
> +	if (caps & CGU_CLK_CUSTOM) {
> +		clk_init.ops =3D clk_info->custom.clk_ops;
> +
> +		caps &=3D ~CGU_CLK_CUSTOM;
> +
> +		if (caps) {
> +			pr_err("%s: custom clock may not be combined with type 0x%x\n",
> +			       __func__, caps);
> +			goto out;
> +		}
> +	} else if (caps & CGU_CLK_PLL) {
> +		clk_init.ops =3D &ingenic_pll_ops;
> +
> +		caps &=3D ~CGU_CLK_PLL;
> +
> +		if (caps) {
> +			pr_err("%s: PLL may not be combined with type 0x%x\n",
> +			       __func__, caps);
> +			goto out;
> +		}
> +	} else {
> +		clk_init.ops =3D &ingenic_clk_ops;
> +	}
> +
> +	/* nothing to do for gates or fixed dividers */
> +	caps &=3D ~(CGU_CLK_GATE | CGU_CLK_FIXDIV);
> +
> +	if (caps & CGU_CLK_MUX) {
> +		if (!(caps & CGU_CLK_MUX_GLITCHFREE))
> +			clk_init.flags |=3D CLK_SET_PARENT_GATE;
> +
> +		caps &=3D ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
> +	}
> +
> +	if (caps & CGU_CLK_DIV) {
> +		caps &=3D ~CGU_CLK_DIV;
> +	} else {
> +		/* pass rate changes to the parent clock */
> +		clk_init.flags |=3D CLK_SET_RATE_PARENT;
> +	}
> +
> +	if (caps) {
> +		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
> +		goto out;
> +	}
> +
> +	clk =3D clk_register(NULL, &ingenic_clk->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register clock '%s'\n", __func__,
> +		       clk_info->name);
> +		err =3D PTR_ERR(clk);
> +		goto out;
> +	}
> +
> +	err =3D clk_register_clkdev(clk, clk_info->name, NULL);
> +	if (err)
> +		goto out;

Again, should this unregister the clock in the event of failure?

> +
> +	cgu->clocks.clks[idx] =3D clk;
> +out:
> +	if (err)
> +		kfree(ingenic_clk);
> +	return err;
> +}

Cheers
James


--V3MKO262lO1Wu1ca2A2HWSoAv3KT1K739
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVP15PAAoJEGwLaZPeOHZ6MZkP/02jD4YrrJcGeMDEUAH6d+O/
6EE1rXtGzzjiRUM34WE4ySC2X5SSuWrgc3v9STZAk386/YoGoMgT13eLDu9uMEcO
jq5rRXGXUQmH2y5Yx0P+VlEtht3nsWM5uawMBZk0WSB/AgY9jE7msJFjxhJ+ZoDV
I9/WcdeWTUvk4xiWKwwqqijurc/dEeKwveyJkunSIPGT13E8rTSxgzPj9zauu7Fx
8KhH+MMO8MprRYkAIS8cOy7ok7yosMF9CROmWzi26FzxufgyVJKRD2nWnzyuzyTB
sc44+gY5UxyuRDSfp3fRdw7/cquOB97AWVm+W27U3UTe2/Y4gxlLrcrXDsg3I9ZM
/lb/hpcmeWEbdw+5OsL68QrXDKTdhOGWJMyB0rzjgWm/I1te9+Enx4cJbEKqlOJt
xLDwU9kXC0t6rY3l4P9Y5/T89MfNWg0+j59RVldbm8di1btRwe5B0GUs01niIPW2
mYZwNeIgHwc71oV9G18CLjp2NQdOJExxOayV53m/4+7KWsK3AWiqfic+fu6hyuAi
4nbKKPwhn9kTIu+L4VNUU+C1NM7Qq9iB8OYCp2cpgqI/fAdUvmS0k7e1S8nRNCiF
chA34eSM6ZSV1MFPXUZqYjywjLEgBpgJtDBnCGoJWaGhSH3U8Q2QgaXrZnZJmjPh
otkvINzOzUtjQXPP77iu
=ew2k
-----END PGP SIGNATURE-----

--V3MKO262lO1Wu1ca2A2HWSoAv3KT1K739--
