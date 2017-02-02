Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 11:49:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7478 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993883AbdBBKs4cwO2L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 11:48:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6FA6A41F8E9C;
        Thu,  2 Feb 2017 11:52:15 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 02 Feb 2017 11:52:15 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 02 Feb 2017 11:52:15 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EA98F51BCBB97;
        Thu,  2 Feb 2017 10:48:47 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 2 Feb
 2017 10:48:50 +0000
Date:   Thu, 2 Feb 2017 10:48:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Replace printk calls in cpu-bugs64.c with
 pr_info/pr_cont
Message-ID: <20170202104850.GI13049@jhogan-linux.le.imgtec.org>
References: <29b7fc69-97f4-6a3a-0e65-2678f9c30cef@gentoo.org>
 <20170202100041.GA13058@jhogan-linux.le.imgtec.org>
 <f0edc411-178c-7f18-9be6-9d40892c54b5@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <f0edc411-178c-7f18-9be6-9d40892c54b5@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56588
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

--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 05:41:48AM -0500, Joshua Kinard wrote:
> On 02/02/2017 05:00, James Hogan wrote:
> > Hi Joshua,
> >=20
> > On Thu, Feb 02, 2017 at 03:56:26AM -0500, Joshua Kinard wrote:
> >> From: Joshua Kinard <kumba@gentoo.org>
> >>
> >> In arch/mips/kernel/cpu-bugs64.c, replace initial printk's in three
> >> bug-checking functions with pr_info and replace several continuation
> >> printk's with pr_info/pr_cont calls to avoid kernel log output like
> >> this:
> >>
> >>     [    0.899065] Checking for the daddi bug...
> >>     [    0.899098] no.
> >>
> >> This makes the output appear correctly:
> >>
> >>     [    0.898643] Checking for the daddi bug... no.
> >>
> >> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> >=20
> > A variation of this patch is already applied, but without the change of
> > printk -> pr_info:
> >=20
> > https://patchwork.linux-mips.org/patch/14916/
> >=20
> > https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=3D35e7=
f7885e1b1b272a73c0de3227fc9a3e95a7e3
>=20
> Oh, thanks for that.  I keep forgetting to go look at the upstream git qu=
eue.
> I noticed the issue when trying to boot my Onyx2 back up and only checked=
 the
> main tree to see if it was fixed.
>=20
> Shouldn't the printk's have a log level, though?  I thought that was the
> motivation behind using the various pr_* calls.

Yes probably. I'd consider that a separate change to fixing the
continuations though (according to a quick git grep there are 422
printks without log levels remaining in mips-for-linux-next arch/mips).

Cheers
James

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkw57AAoJEGwLaZPeOHZ6I5cQALdnN0SbZFsSB1NchVO9Ttpm
EfduLlBen4yPn6e8SqXT9NsoXhaxhT+oZAjtqoB/xo8jIxLzMHQO71zskClVsHBs
60higEXnrNr89+LJfX+E9xQspJ4H0GKHBldkaPoLu8rvQ7MxT/BEksa9lj8EQeoK
oflD8VWBX/STJ/scTL73K3mYX03U+jFcl1PxCt1WFAvp3ydWvN1rK/JEHEWjHTk+
R2JYfJx1Jdj7h+Xo3HuqP/33Io6EGRNyu1g4FAJhNEI7NNmodT55h6me3VPEIMGJ
DLakfe3LY1EWySGIJDPwrNsHcpsJ/Wwp2X/jhkdrME31uDibsgwbGwVEn16HC8nb
K3n3CC8KQdSJiUV2RziSn8h6XXMFuVoSC2SgJXJePklePlp+sY+9MjuD6O/x/jMX
89joUtEQIjTG65CCRwgeoRngSxIAF0uLerBo1PHc5ifbiqVCUu1blSRF1VVR8Gaj
OO7qQk39+z9EQHAOKN1jU/4+bFeqyf+0jsP/ah8882cEPgUc4jsShCsuDgUVkG9A
pLegYBaqDMj7+BfeKCu4/xQOxfFFL5da5lvnqf174IeX3QRHMEn3hEqj3k9GHnsk
RtDkr/DPtj3FMR66c5fiIRdjFV/SJXjZ5RL/+q1BI5rurU4y8VrYgHjO8at0/sQH
1M1nvKsz3O1LAQ0vcIIC
=6iFY
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--
