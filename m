Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 19:03:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5311 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993896AbdBPSD1sLzi4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 19:03:27 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 856DB41F8E6C;
        Thu, 16 Feb 2017 19:07:25 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 16 Feb 2017 19:07:25 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 16 Feb 2017 19:07:25 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CCBFF15A2B03C;
        Thu, 16 Feb 2017 18:03:17 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 16 Feb
 2017 18:03:21 +0000
Date:   Thu, 16 Feb 2017 18:03:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [GIT PULL] MIPS fixes for 4.10
Message-ID: <20170216180321.GW9246@jhogan-linux.le.imgtec.org>
References: <20170216130643.GV9246@jhogan-linux.le.imgtec.org>
 <CA+55aFz-4S-E5ebymwUCjqvi3_uWjF+XkqigfCOBq37gnzW3Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B8YbZbqleQryf2nq"
Content-Disposition: inline
In-Reply-To: <CA+55aFz-4S-E5ebymwUCjqvi3_uWjF+XkqigfCOBq37gnzW3Bw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56853
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

--B8YbZbqleQryf2nq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 08:49:19AM -0800, Linus Torvalds wrote:
> On Thu, Feb 16, 2017 at 5:06 AM, James Hogan <james.hogan@imgtec.com> wro=
te:
> >
> > I've gathered together some of the more important fixes that it'd be
> > good to get into 4.10. They're mostly build fixes, with a few runtime
> > fixes too.
>=20
> So quite frankly, I've been ignoring MIPS pull requests lately,
> because I got fed up with the "never honors the merge window" part.
>=20
> Not taking a pull request is the only way I can really show my
> displeasure with the fact that area consistently ignores all the
> release timing.
>=20
> I'll happily take a MIPS pull request during the next merge window.
> But it needs to actually do the right thing: not just coming in at a
> timely point (not at the last day of the merge window or some time
> very late in the rc series), but  also that it hasn't just been
> rebased, it's actually been in -next etc.
>=20
> Of course, sending pull requests for the merge window *early* is fine,
> so sending me stuff for the upcoming merge window for 4.11 this week
> is just showing that things are all lines up in time (still assuming
> the -next thing etc).
>=20
> But until I see that kind of "maintainer actually bothers to work with
> the right process", I'm going to continue to ignore MIPS pull
> requests.

Fair enough. I'm only applying fixes for 4.11 now anyway, and I was
already planning to send the pull request early in the merge window.

Cheers
James

--B8YbZbqleQryf2nq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYpeljAAoJEGwLaZPeOHZ6k1YQALYqaD6MgepgCfyx8E/VdlPt
aphN2SxTNfB4I7wzInLQdSAObT2+J+r4bJS21GychajNCJVM8TXnM+gi2EHgbRyY
x00VkjHOVhalHojFwsjxpmIqAqMVl0X7f3W+r5vkyXWF2uQ0/5ro2sEpluy+/trV
n+3bbSp9BG6J6glP1sumlMuIAlV49zu2K09nEqpXaXCZ29y8ESGsjJGkdWwiODMq
f0aSQv3cyTtAIMNnt77E5zFEiZh7JR5yhPX49dCwyzDrXccvhy5NtrG8KjYTeAhS
A0pl0NLGknIUaekS64niJx/D2o0L4leE4mWuN2FG4CEKo5Lpdn2BXvn69yd5S3Fx
abRZc6rwbVdBo9whQMrm9LstCXRzWOgqG0N7vhf2hEGuGFMQ4Vgu/GUh4P0i83en
w2NtQMshshuOHbfu/ASlOKceXML/ySuHfspcwOeaMGaB1P4BZwyK7+urhjyVggNB
YRcFFbKvFHk3ifTs8HAo1vzd6pUaVSGWfn13VIu3KN9PLnpTVU9q9dt8tFvT59gh
/0VnPl7HuBJIoPzTaiVrZTRPeE1/dhjmLaaj3ds/Sfj/ojmqMQf4/P9sxzTrFn4l
ubec2zBBBM6ezeFP6vhkw63HQSnRoUegDPe/r/svCQ0Yh3MHccC1Y9nTB7oxs1bt
HHlFj33EeVixAM3suJMy
=VLc3
-----END PGP SIGNATURE-----

--B8YbZbqleQryf2nq--
