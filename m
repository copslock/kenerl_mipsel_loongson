Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 17:27:15 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994554AbeCLQ1GFaNBB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 17:27:06 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B42204EE;
        Mon, 12 Mar 2018 16:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B42204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 12 Mar 2018 16:26:34 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/14] Enable SD/MMC on JZ4780 SoCs
Message-ID: <20180312162633.GA21642@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <CA+7wUsxuavjaVOpoOEVJp4gSd+J_FQ37JuRE_N2BhEqOx7G1yA@mail.gmail.com>
 <CAAEAJfDmQBShUVXupVMdcPSiu5t2i7VdF_1LM9Syu_Qiq6PsKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <CAAEAJfDmQBShUVXupVMdcPSiu5t2i7VdF_1LM9Syu_Qiq6PsKg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 10, 2018 at 07:17:43PM -0300, Ezequiel Garcia wrote:
> Hi Mathieu,
>=20
> On 10 March 2018 at 14:02, Mathieu Malaterre <malat@debian.org> wrote:
> > On Fri, Mar 9, 2018 at 4:12 PM, Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> >> This patchset adds support for SD/MMC on JZ4780 based
> >> platforms, such as the MIPS Creator CI20 board.
> >>
> >> Most of the work has been done by Alex, Paul and Zubair,
> >> while I've only prepared the upstream submission, cleaned
> >> some patches, and written some commit logs where needed.
> >>
> >> All praises should go to them, all rants to me.
> >>
> >> The series is based on v4.16-rc4.
> >>
> >> Alex Smith (3):
> >>   mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
> >>   mmc: jz4740: Add support for the JZ4780
> >>   mmc: jz4740: Fix race condition in IRQ mask update
> >>
> >> Ezequiel Garcia (9):
> >>   mmc: jz4780: Order headers alphabetically
> >>   mmc: jz4740: Use dev_get_platdata
> >>   mmc: jz4740: Introduce devicetree probe
> >>   mmc: dt-bindings: add MMC support to JZ4740 SoC
> >>   mmc: jz4740: Use dma_request_chan()
> >>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
> >>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
> >>   MIPS: dts: ci20: Enable DMA and MMC in the devicetree
> >>   MIPS: configs: ci20: Enable DMA and MMC support
> >>
> >> Paul Cercueil (1):
> >>   mmc: jz4740: Fix error exit path in driver's probe
> >>
> >> Zubair Lutfullah Kakakhel (1):
> >>   mmc: jz4740: Reset the device requesting the interrupt
> >
> > Nice work. Entire series works just fine on my MIPS Creator CI20 (v1).
> >
>=20
> Cool. This means a Tested-by for the entire series?
>=20
> > Nitpick: could you update the email addresses:
> >
> > s/imgtec/mips/
> >
>=20
> You sure that is appropriate? First of all, the work has done
> under Imagination Technologies umbrella (even if now the
> developers work for MIPS).

Yeh, I don't think there's much to be gained. And Alex would have been
on a university placement at IMG (before MIPS was sold) to use that
email address anyway.

Cheers
James

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqmqjkACgkQbAtpk944
dnrDrw/9HpK05NhS2ln9Ob1+4TBvDjuOKn99PtWRPeTjiJZNnnxje0GrQbPkTZZr
5bHpTb0cMDH4MNbj7jMC2T0R9EVBpyux83ZGwftogl/lAsSgAxx5MZWsMJKywOA+
TehAx+EhyCbI30gIkyftjNicBGVvjUiYYSy4qllfQ3Qd5sQgJ1UYq75T/G9ib1pe
/8lgwvyjm1gRAbDJ7/UQBryab5gQBBPPgZICu8TWtX41EQPMlOEqXwml/uI2B0nV
lPcHudpwy8HGq9GSJnSQp8pEefiY3XorszWd2I0zzhZhU68fuCc6O9ApFzewjBXr
WxHqdtpHyfZ5CRIkSb8JdsncEoVtXVg3OrulBTGqP05XHVKcVdYwsovEkSWcQZE6
ymwhs29+Ut8hUCKn2Cw0+Zl0oLjVrhEzYp5BDBulGY79JDT+MsIv3nk54/tEb8F2
AXBMBWjeCie1v+khJHPDNpJn4l+FDul0UgAXoTxkjgZTedkPAaThOP3nziu2a0Jc
dveoUq6i770VHkzvmSxGxx10PD8OwpXszHQ08WyUasDvsk1hws1JAwx86HCoWQoI
5lnvX52qtXd7kgAeBpOdynpBrAD26gfS1a3JVTBK7qeE6HjUjD1VSu31+ssr/C+u
q44CFO3K02DsBPuZdDuJBMM1Cv4SYPQ7Se0IURixLZitIM7RGLI=
=2YFs
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
