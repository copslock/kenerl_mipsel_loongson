Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 04:01:09 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:38261 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeCUDA73GySJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Mar 2018 04:00:59 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B3A1AF04;
        Wed, 21 Mar 2018 03:00:52 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Matt Redfearn <matt.redfearn@mips.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date:   Wed, 21 Mar 2018 14:00:44 +1100
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: ralink: fix booting on mt7621
In-Reply-To: <cc33f000-16ed-b331-53b7-d767e20a4a9c@mips.com>
References: <87efkf9z0o.fsf@notabene.neil.brown.name> <87605r9mwf.fsf@notabene.neil.brown.name> <cc33f000-16ed-b331-53b7-d767e20a4a9c@mips.com>
Message-ID: <874lla874z.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <neil@brown.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: neil@brown.name
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

On Tue, Mar 20 2018, Matt Redfearn wrote:

> Hi Neil,
>
>
> On 20/03/18 08:22, NeilBrown wrote:
>>=20
>> Further testing showed that the original version of this
>> patch wasn't 100% reliable.  Very occasionally the read
>> of SYSC_REG_CHIP_NAME0 returns garbage.  Repeating the
>> read seems to be reliable, but it hasn't happened enough
>> for me to be completely confident.
>> So this version repeats that first read.
>
> You almost certainly need a sync() to ensure that the write to gcr_reg0=20
> has completed before attempting to read sysc + SYSC_REG_CHIP_NAME0.

That sound like exactly the right sort of thing to do, though
I assume you mean __sync().

I tried to reproduce the problem so I could test the fix, and of course
I failed. Over 700 reboot cycles and never read any garbage from
SYSC_REG_CHIP_NAME0.

So I cannot test that this works, but I have tested that it doesn't
cause any obvious regression.
I'll send the v3 patch separately.

Thanks a lot,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqxytwACgkQOeye3VZi
gbkt3g//QgA1xYVWLNNdRjCrDPZNqu3Xa1wc1b7nrCltNqQMK1w2B55ZOq5EdgPe
2apRzIBsepuNaxqdl3CpCLnqA26jriY7sROHwc3mcafdCcnQM8psAYEG5Y35X8up
Xwrp287Pvj/3LSHyuwVnQCuSVJhOdDQmeYNUjbyp1zfKwdQUFyY2qfs5SlT+Xby9
Gp+wfjUcIhs0UTUi87dqNc7XD1l8Sn/8faVrdcQ2BDMDkwXAj5oFOftfwg6k/+UG
JXyJ3BlNGFrTtuQsy2h+JE5PmFiJmfo/4jE+xcQBXYNKyHAT5Sc3K63+Appn+SDm
XxZtFqvWvGaYs52HS8NgvEnUXanTjcYP9/sHNrMGNUiqAbfidka/65xqqiCfyqtn
pj12rjtSNZ9D+V5lwvbGqhaRvLCLhgk66omCnDFqeka5hiUy58oZBILRVB/UAfaj
ercgSyZCSBcUKfjoJzpzGLsSw/Ne/uIRbzk1P7dnAHFaptq/QYBGvMa10nKZ05Sq
M97IGQqdVYnsvA6Va5Tz4anjNGZMopPnQthTT04+ph4tjN9nDYnzMEGGXA13S9XI
Bpl+2puCb+TakhPIt6yq7ihslniqPuI5/TpoG0TbJLLRk/9jblYNUBQ781nSSwjX
a07ygVr1sKuDFVwM372bs/Qs3Y11kD7S93DjJm2GQ9p8klhkJOg=
=KSSZ
-----END PGP SIGNATURE-----
--=-=-=--
