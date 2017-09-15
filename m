Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:03:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58843 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991500AbdIORDcaRfAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 19:03:32 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 729A22ABFE6D6;
        Fri, 15 Sep 2017 18:03:22 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 15 Sep
 2017 18:03:26 +0100
Received: from np-p-burton.localnet (10.20.78.32) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Sep
 2017 10:03:23 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Mathieu Malaterre <malat@debian.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
Date:   Fri, 15 Sep 2017 10:03:18 -0700
Message-ID: <3096328.Gt2m8chjZN@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <7c4d02d8-3d96-3471-89b2-dba606367218@imgtec.com>
References: <20170914155051.8289-1-alexander.levin@verizon.com> <CA+7wUsy7X_3ST0hgnyxWMiC45ZeM8A_oafzn9PuufETkcKN+Xw@mail.gmail.com> <7c4d02d8-3d96-3471-89b2-dba606367218@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1947975.X4ZMmuJ0sv";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.78.32]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60010
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

--nextPart1947975.X4ZMmuJ0sv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marcin,

On Thursday, 14 September 2017 22:44:18 PDT Marcin Nowakowski wrote:
> >>> Does not work on MIPS Creator CI20. See:
> >> Hm, so upstream is actually broken right now?
> > 
> > Yes, at least on Creator CI20. You need to clear out all your mem=X@Y
> > from your boot command line, or apply the new patch I mentionned
> > above, or revert 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411.
> 
> Yes, there is this issue that Mathieu discovered that upstream suffers
> from. My patch that fixes it has not yet been merged - but hopefully
> will be included in the next release.
> Luckily the issue is only seen with a specific set of commandline
> arguments which are not even required - but are set as defaults by the
> CI20 bootloader.

FYI the mem= arguments were required for the older v3.0 kernels which derived 
from Ingenic's android kernels, and up until now have been harmless for newer 
kernels so they generally make sense for the bootloader to provide in case 
people want to run anything using the older kernels.

Thanks,
    Paul
--nextPart1947975.X4ZMmuJ0sv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlm8B9YACgkQgiDZ+mk8
HGXisw/+MgTFrvC0WKI9aLC7lpLfA8ejfsuwpoUSvt4h3cofrPmYdhK6WA5iqSWm
HhPdjCZE94X8a4RfZINdDk+WfP8JbYwRSbrKx+mJQGQwUf9HtfLYJOmADoaUoXon
WtYNjk6JzuSlMzPtcTWpbHKOb3dS9c33fsOCjrmSlmtXzLkw9bVQFXrl0dVL7pAq
GW37wVKHUq7HIqKo29s0MgE5oKS02YJnztOFhap2SOu9ab+LrUw4jsVSOuDsGrkm
yAEPRQU3W+XrofvevKnj0PjNzkx310ikXQz18BiKxTcUVi5xe4UnBP80zfME8jDw
lwVnjPj2JECTJcX/IyjV7nRHf0FLH3LeltC9kzn52SOHBka3fe51b18AcnASDtft
UbKs1zDasUABhcESIib7dGsDy8inYRii1hg/n1HAvj1uQUq/u3iJtbUvMILqj9fX
mrvMkd/hseYypygU6e+WoiVd8qR57h2BpuRiIzlQ6EMtI38DERnGJytjG76I2D4M
LXm5wdOaX5wfzHBmZPaksyjHWc4C98VfDNFbyM14ndhXzsZYQJgJ+h5PAf1ZGSui
xZsViUk3bGiwodr3pXakUFdNKsYDALfIbNudFmDhhMNNarJxxx1MyfLlpfQPDdpt
ozeqzBzmeWemIni4LTfRciC24YFwxdqdECUzyuiWfhKp9FxEXtA=
=SFw6
-----END PGP SIGNATURE-----

--nextPart1947975.X4ZMmuJ0sv--
