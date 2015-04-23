Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 03:36:17 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:34082 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011342AbbDWBgPuMV11 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Apr 2015 03:36:15 +0200
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 334EE340B27;
        Thu, 23 Apr 2015 01:36:06 +0000 (UTC)
Date:   Wed, 22 Apr 2015 21:36:06 -0400
From:   Mike Frysinger <vapier@gentoo.org>
To:     Petr Malat <oss@malat.biz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH] Revert "MIPS: Provide correct siginfo_t.si_stime"
Message-ID: <20150423013606.GQ12496@vapier>
References: <1429641183-15873-1-git-send-email-vapier@gentoo.org>
 <20150422123045.GA5428@bordel.klfree.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fu8LepSeDvpxVgv6"
Content-Disposition: inline
In-Reply-To: <20150422123045.GA5428@bordel.klfree.net>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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


--fu8LepSeDvpxVgv6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22 Apr 2015 14:30, Petr Malat wrote:
> On Tue, Apr 21, 2015 at 02:33:03PM -0400, Mike Frysinger wrote:
> > From: Mike Frysinger <vapier@chromium.org>
> >=20
> > This reverts commit 8cb48fe169dd682b6c29a3b7ef18333e4f577890.
> >=20
> > UAPI headers cannot use "uapi/" in their paths by design -- when they're
> > installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
> > userland badly:
> > $ printf '#include <stddef.h>\n#include <linux/signal.h>\n' > test.c
> > $ mips64-unknown-linux-gnu-gcc -c test.c
> > In file included from /usr/mips64-unknown-linux-gnu/usr/include/linux/s=
ignal.h:5:0,
> >                  from test.c:2:
> > /usr/mips64-unknown-linux-gnu/usr/include/asm/siginfo.h:31:38: fatal er=
ror: uapi/asm-generic/siginfo.h: No such file or directory
> > compilation terminated.
>=20
> I will look how to fix the include issue without delivering stack content
> instead of stime. By the way hexagon arch does the same :-/

i sent them a patch to let them know.  hexagon isn't that common unlike mip=
s so=20
no one noticed ;).
-mike

--fu8LepSeDvpxVgv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVOEyGAAoJEEFjO5/oN/WBYgAQAK7lVwBPLMA93qERhQ9zJ6qc
V8UXBYYmSydLvC2krs0Dq9Zu8aJoUE3KRibhZX/csJilkBDQHeq4nJQFyjxcHhnm
jid80CA38XSWaswUBUJP/O4r9YMQU7VYE2hX0hkwB70yaoQ4u7pQ4NZLuuxJNE92
Pc1yzIdzuwuZc4zBFiMvRDJISq5r/eBtAjZXdwLno2/ZIxHQHG1Kr4r4iYNZJsTe
Zz5zDayzX0VGrQEeJ36FSZvDcTRHbWHRHdHRAeACmzsUrS5xQftBONfjPnKr9lws
Hx6F1hw4JfTpYAYUWUze3xF8ZZZoRD62wg/feArQC3VDErZ24sF+mnF9kfUWicKO
tUn8NG1YImRjpYr6hQNXfb61GUmeB6vob+Rp/LeWXDsgLewk+p8KsNE2AeTdc3FR
Ds5TwcYAStYFH+DOk6YipLN7GCCWZmagixxGnBmXhKjUVABXOes77qmAkycfAqbQ
FlmV3f8ZKuPRyIcELyRk7cO3u9+oBVx2X4mr2JneU2U2bRuaWt2WeKhDrdQi9tb1
sANDY4IrQgw6d7UAPRpNQnGJmX3IHsquHkzghl4CHJCFpT//mFA9kUsWk7PBLulG
EbJNfohnXekWZyeMWjx04bCdqCDYpwL/hQSMfftY3cYYH0g1TkaDyPkZrLfcagLV
2+5EECgg6h68NUd5aOO1
=Um5h
-----END PGP SIGNATURE-----

--fu8LepSeDvpxVgv6--
