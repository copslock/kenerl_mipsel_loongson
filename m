Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 10:39:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37546 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990720AbdCGJi41mSjH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 10:38:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E9D7041F8EC3;
        Tue,  7 Mar 2017 10:43:44 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 07 Mar 2017 10:43:44 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 07 Mar 2017 10:43:44 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8F9A110F7FED8;
        Tue,  7 Mar 2017 09:38:48 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 7 Mar
 2017 09:38:50 +0000
Date:   Tue, 7 Mar 2017 09:38:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170307093850.GD996@jhogan-linux.le.imgtec.org>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
 <20170307073805.GB15693@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J9fO++IT6debZ01Z"
Content-Disposition: inline
In-Reply-To: <20170307073805.GB15693@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57068
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

--J9fO++IT6debZ01Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Tue, Mar 07, 2017 at 08:38:05AM +0100, Ingo Molnar wrote:
> Just a quick question: is your MIPS build fix going to be merged and sent=
 to=20
> Linus? I can apply it too, and send it to Linus later today, together wit=
h a few=20
> other sched.h header related build fixes.

One for Ralf...

> Assuming it's all properly tested - my limited MIPS defconfig builds work=
ed fine -=20
> but MIPS has a lot of build variations.

If you have a branch with other generic fixes I'm happy to push it to
our MIPS buildbot too to double check.

Cheers
James

--J9fO++IT6debZ01Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvn+qAAoJEGwLaZPeOHZ6jhYQAIazmb5KUyKwsPHaUuCEm5vr
WIkKsp/4qUBHEpeJguEv38g9BPfbboUP8Z/xx6eIGGY+zktFOaS9ur5z4kSEETHR
cLdu09CRTT2QJoI3vbh7r5HofYMctN+vx/mBEHB/WsMlLEQFB0+PxH2+fZ5ixaUk
HOuVCSs/dCWJpxZ4mbIHPcNFP8ugCgrdPF30xN91eMGaYF5juMRbzUxScReWjERY
nqhnp+PriaBPXJ3zTIIf462lX1SdvmzLF6fHC7VeCZZpKcuS9XP2UENg4QFwXgjW
UhYdrkuJ65Sg1tvvIN+4asp5cPiFpTxrAotIbcI9w4aDcKW6bGHcaYfrzwOKJRgI
Pe6zh04FVPek6gnCjVAZrhnGuCgDdp7csloz9AvCTDCARqCQ/4OUG5nzofsbN0d4
lUjS/AS3giBXOTH/ce05i82dnfJuli4ZVgEYDqt6XxMhVO6fVXNjgcjS8UNoeHme
JpRP67p4i17Lhfcr6FC5vFsfP6U3PrlmWeM7ik/bl1D4P8kCCHm9hbt5DrekQHRv
AUnmjFm4xZeQW7qmIF2dcdJ+zyPgUMMRYl9N4bilKZHtblpxHEe6HLsTMH+gWMox
sax6f9uDWQzvc6G4VEd7SXFo1bUxLaBVcmu/bLcu4q6yefD6a6CXICgHCvyV8Jn9
P3z1CCYJ0FeJZa6K2brY
=8YSQ
-----END PGP SIGNATURE-----

--J9fO++IT6debZ01Z--
