Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:01:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53111 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006775AbbEXPBU6NLnp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:01:20 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DDFD841F8E07;
        Sun, 24 May 2015 16:01:12 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sun, 24 May 2015 16:01:12 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sun, 24 May 2015 16:01:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C66B6DB59AA83;
        Sun, 24 May 2015 16:01:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:01:12 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:01:10 +0100
Date:   Sun, 24 May 2015 16:01:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Michael Turquette <mturquette@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 26/37] MIPS,clk: migrate JZ4740 to common clock
 framework
Message-ID: <20150524150104.GP13811@NP-P-BURTON>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-27-git-send-email-paul.burton@imgtec.com>
 <20150513025204.20636.10155@quantum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20150513025204.20636.10155@quantum>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.140]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 07:52:04PM -0700, Michael Turquette wrote:
> Hi Paul,
>=20
> Quoting Paul Burton (2015-04-24 06:17:26)
> > +static void __init jz4740_cgu_init(struct device_node *np)
> > +{
> > +       int retval;
> > +
> > +       cgu =3D ingenic_cgu_new(jz4740_cgu_clocks,
> > +                             ARRAY_SIZE(jz4740_cgu_clocks), np);
> > +       if (!cgu) {
> > +               pr_err("%s: failed to initialise CGU\n", __func__);
> > +               return;
> > +       }
> > +
> > +       retval =3D ingenic_cgu_register_clocks(cgu);
> > +       if (retval)
> > +               pr_err("%s: failed to register CGU Clocks\n", __func__);
> > +}
> > +CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
> > --=20
> > 2.3.5
> >=20
>=20
> Patch looks good to me, but I have one question. Is it possible for you
> to have a proper platform_device for the cgu instead of relying on
> CLK_OF_DECLARE?
>=20
> For an example of a clock driver that does this, check out the bottom of
> drivers/clk/qcom/gcc-msm8660.c.
>=20
> Regards,
> Mike

Hi Mike,

Thanks for your review. I gave that a try but unfortunately it didn't
work out because the code in plat_time_init (arch/mips/jz4740/time.c)
needs to obtain the rate of the ext clock at a point before any
initcalls have been run, and therefore before the platform device has
been registered.

Thanks,
    Paul

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVYeerAAoJENzvn0paErs5t10P/0s4aPrB2JGQryExBDaqHNRI
pPpuIBfNBL8/V9Uk4FCMMi77dymvZuAxnBigych187DazTCxLvyejzXwooWz8zxo
/IbObdbdpeNw5s8yoUPUlC3d1Yhhw2un9zhk9n1mdj+b3ZPfjvyIuwWIzorewpC5
oHGffD15WBjQZvE6H16pc9YHinO+YkwRJJAd+qdSuzxVvZ9FPJW5JvNJ6JrwSEL7
HCEbTYyN3j2BuOHGnO0l1ZcDzgCFC3mbh8z+De11h9XFc/9gst/W3Qn+9HnYy6a5
jk3+baDPUa0TjAi7IftqG1nLLAQ+17JbhfWiTXjmEMkT5Pd3z68h6FHZJaH/WsK+
0TPFPp5grq4zawHc4DgVjUr3RLnzFtxiI7CrEEpf3IfC5CzfWSB4nuAAxxy/N05n
/O1+xBxYaspEDDn9xdFLdTJN1aHLfnW9whdzIwworoU1bzdVEo3Tiwh4us3fozCx
dtaOoTrGtWbN5sf2/YGKbsqKbf2CDoHMPEriAS2NHBErWUZPsLN9J48RhoUqvnZ+
X1xsAFD3OdaaCNnKlAEHcy/Bzu4D9917nCxy7l42LkasG6/HP7yLNdafkQ1kjJoN
U5EDTZNuuZ3El31XWUu7m+fQ+/qStAIZ5eAOY6bzPK7zmu3R3On8Dzp1Mde54xL2
dun5LozGE89ug1KsWobr
=Kgev
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
