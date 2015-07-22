Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 16:15:09 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:42721 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010688AbbGVOPIDIHTv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 16:15:08 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 15E8528D96;
        Wed, 22 Jul 2015 14:15:02 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id DF0D828D26;
        Wed, 22 Jul 2015 14:15:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437574501; bh=W+jWuzsX0MkuZqHtLyppJiVQut54uiuJLDPR/36c6+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQXatuwnNXtFz1wqwPeuZ3gUw2/jiKuMLsohc8oHK9/VTv5BY2HEY6+RLpuGCl5R0
         /JICf+G8uIUEz1lWV9GnEgw3mprWmID0eRfDHzP4lSVjQI4vmei5LKDr+z2X/ud6vK
         rfjNSJp37YXPy6i6058RhkiP16lh6fGV0/50UVGI=
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id CD3428008A;
        Wed, 22 Jul 2015 14:15:01 +0000 (GMT)
Date:   Wed, 22 Jul 2015 10:15:01 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-am33-list@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150722141501.GA3203@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1437528316.16792.7.camel@ellerman.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2015, Michael Ellerman wrote:

> On Tue, 2015-07-21 at 13:44 -0700, Andrew Morton wrote:
> > On Tue, 21 Jul 2015 15:59:37 -0400 Eric B Munson <emunson@akamai.com> w=
rote:
> >=20
> > > With the refactored mlock code, introduce new system calls for mlock,
> > > munlock, and munlockall.  The new calls will allow the user to specify
> > > what lock states are being added or cleared.  mlock2 and munlock2 are
> > > trivial at the moment, but a follow on patch will add a new mlock sta=
te
> > > making them useful.
> > >=20
> > > munlock2 addresses a limitation of the current implementation.  If a
> > > user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> > > that MCL_FUTURE should be removed, they would have to call munlockall=
()
> > > followed by mlockall(MCL_CURRENT) which could potentially be very
> > > expensive.  The new munlockall2 system call allows a user to simply
> > > clear the MCL_FUTURE flag.
> >=20
> > This is hard.  Maybe we shouldn't have wired up anything other than
> > x86.  That's what we usually do with new syscalls.
>=20
> Yeah I think so.
>=20
> You haven't wired it up properly on powerpc, but I haven't mentioned it b=
ecause
> I'd rather we did it.
>=20
> cheers

It looks like I will be spinning a V5, so I will drop all but the x86
system calls additions in that version.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVr6VlAAoJELbVsDOpoOa95lcP/09wvimQwXtTG/OgMLsgEPaz
FVL4uSMeiSaPdcdYp1Qp+ie80X/Ve92le8uJ9pcRKV3+cK2xP8OiOQQQwz57cBU8
MIzkJPycm2gww6DRwYVjXhUJH2FMb1KK1vQALVWwh0mUAkRvpi4T7mtxSzmRUD+V
TEw4dIBmK3dEorWA7duy9L/8juLu/j2kd3GzFnd5vp7q5HDb+tJrBD+I1jos2dlQ
KqYzU5vCmPC11pc2TzzFkXx6hGux1Rj4y/7jUMID14Hi+Ql0dQGwMo6kcMmdxS+P
kULToMPhnlDZIAfNOpfanHUsnzLPy4UVJ2ecYHXte7Yj4uxU9NXf6Dli47/iZK4H
lp+MUwmXEQsoQTqwUWO36Hcpu5aKHQzbmz3qeNwLe37ZauHahT7GSYR8ZrntQo2v
oQs9zdeLt2enFwC0QSubvRtIAEbpvnWvup0lD89fEFMubri6IFKFFMuSIr9kNBS0
6jcxjzbH03cDgnrlAEb0k54nblsgCRoagmHpqZH+TzAKlLqUXpIeqVUnkjXrclkg
XBlxVwh2m0LvFFWnTZ/AoXmZif91GBNQw+ZPkju+iRs8r3YtjH3Pv2aZL4tjDFzA
/Gyv+WSvZ3NjakBejr+qzZiET/MSEmX1agUJo/2sd0QUL/z0Jk1gConPgmjaoFCO
UoTgStn2fZdwMTcy6Lyt
=nv7P
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
