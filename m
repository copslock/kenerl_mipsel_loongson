Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:41:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40763 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992517AbdEaPlRGxq8n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:41:17 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5304741F8DA5;
        Wed, 31 May 2017 17:49:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 31 May 2017 17:49:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 31 May 2017 17:49:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CD4C45B394F0A;
        Wed, 31 May 2017 16:41:07 +0100 (IST)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 May
 2017 16:41:11 +0100
Date:   Wed, 31 May 2017 16:41:11 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Sort MIPS Kconfig Alphabetically.
Message-ID: <20170531154110.GA15577@jhogan-linux.le.imgtec.org>
References: <1494841595-8954-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1494841595-8954-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58095
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

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, May 15, 2017 at 10:46:35AM +0100, Matt Redfearn wrote:
> +	select HAVE_SYSCALL_TRACEPOINTS
> +	select HAVE_SYSCALL_TRACEPOINTS

Maybe we could remove duplicates while we're at it?

Cheers
James

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlku5BMACgkQbAtpk944
dnqz8w/7BZXpJYZduSe7RbaVhk9/cJy/QKOK2sJ19Y8KktzrGF2vpTVYPkG0eF/y
LgwbMJMCO9GLNlgPtyvKLGtRalqVHwJHgU5HykFmQ2Im08jl0D4FNXhH8BD3Jnp0
18d9HOhhyBBCCZ1b0EiTUwwhnp8fRpf7Zol0ZsgreVJpeyjd6gzaLpIiX+0yJmDw
dWaPlnP3NxP/TXaaPvdEEHz2UWW1jNGsggLjfDvldh5G3MR7BVbxrnTL83xx6pSN
dSceOfMC6U5lhVuOhMz+kzR1HdIbERHLmct3qwN3Gx8Vyd5FeNElWzh2T6GkqfN6
VRFNWIxR2RsYW7yHxCUUatFX1Le7SIaPLUvxGDBw3S2uZuhiHCqHf2vk4+jj8/BZ
rnz2Hi1tQGuzFEToMAZLOgkX+PZRUpik01EjlB/VwYL7/+9gAnNQV7ufyIDraQw0
En27rOpZPZwxPQAm9NmdvFjDwhP/NM+b2IhBxt1OMiP5c1TqwwOryDI9mfuFfeZ0
4j4vFz3lVQ2gzAg/ZIfBHDoLFENB8S0xsKBGX+Hwg4zKYUS2uqpJLnHhpg2bH6iz
w6DPF2UMD+oFkmv8tGRDQgOxcbGe32CVFl34Hy621FaEAvRXBDV6LRgPi3YZVo4s
1dNdItCoaM0Ciii0b2Yh/Qmd7jhJHM1zWAySTNftumTdGuzVSCo=
=qAbn
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
