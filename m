Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2015 16:39:42 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:40874 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008230AbbFOOjky7BSs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jun 2015 16:39:40 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E7B6348896;
        Mon, 15 Jun 2015 14:39:34 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id D1B5A4882B;
        Mon, 15 Jun 2015 14:39:34 +0000 (GMT)
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id CBA1B8008D;
        Mon, 15 Jun 2015 14:39:34 +0000 (GMT)
Date:   Mon, 15 Jun 2015 10:39:34 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked
 on page fault
Message-ID: <20150615143934.GA12300@akamai.com>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
 <5579DFBA.80809@akamai.com>
 <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47944
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2015, Andrew Morton wrote:

> On Thu, 11 Jun 2015 15:21:30 -0400 Eric B Munson <emunson@akamai.com> wro=
te:
>=20
> > > Ditto mlockall(MCL_ONFAULT) followed by munlock().  I'm not sure
> > > that even makes sense but the behaviour should be understood and
> > > tested.
> >
> > I have extended the kselftest for lock-on-fault to try both of these
> > scenarios and they work as expected.  The VMA is split and the VM
> > flags are set appropriately for the resulting VMAs.
>=20
> munlock() should do vma merging as well.  I *think* we implemented
> that.  More tests for you to add ;)
>=20
> How are you testing the vma merging and splitting, btw?  Parsing
> the profcs files?

The lock-on-fault test now covers VMA splitting and merging by parsing
/proc/self/maps.  VMA splitting and merging works as it should with both
MAP_LOCKONFAULT and MCL_ONFAULT.

>=20
> > > What's missing here is a syscall to set VM_LOCKONFAULT on an
> > > arbitrary range of memory - mlock() for lock-on-fault.  It's a
> > > shame that mlock() didn't take a `mode' argument.  Perhaps we
> > > should add such a syscall - that would make the mmap flag unneeded
> > > but I suppose it should be kept for symmetry.
> >=20
> > Do you want such a system call as part of this set?  I would need some
> > time to make sure I had thought through all the possible corners one
> > could get into with such a call, so it would delay a V3 quite a bit.
> > Otherwise I can send a V3 out immediately.
>=20
> I think the way to look at this is to pretend that mm/mlock.c doesn't
> exist and ask "how should we design these features".
>=20
> And that would be:
>=20
> - mmap() takes a `flags' argument: MAP_LOCKED|MAP_LOCKONFAULT.
>=20
> - mlock() takes a `flags' argument.  Presently that's
>   MLOCK_LOCKED|MLOCK_LOCKONFAULT.
>=20
> - munlock() takes a `flags' arument.  MLOCK_LOCKED|MLOCK_LOCKONFAULT
>   to specify which flags are being cleared.
>=20
> - mlockall() and munlockall() ditto.
>=20
>=20
> IOW, LOCKED and LOCKEDONFAULT are treated identically and independently.
>=20
> Now, that's how we would have designed all this on day one.  And I
> think we can do this now, by adding new mlock2() and munlock2()
> syscalls.  And we may as well deprecate the old mlock() and munlock(),
> not that this matters much.
>=20
> *should* we do this?  I'm thinking "yes" - it's all pretty simple
> boilerplate and wrappers and such, and it gets the interface correct,
> and extensible.
>=20
> What do others think?

I am working on V3 which will introduce the new system calls.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVfuOmAAoJELbVsDOpoOa9s3IP/3PHZ6S5YUFkxUlalwmhJoDD
YtCVtwakGJ0GjPMI4iM+H1TsCym6AYH/Kv0dxfnTbFMTqClzHq7V3QZt9IHJH7Pb
Z8gBH247JOk7opOsB3Cb3gLvAkQ4bfgXObSsgvPLCID2GumlUOINBpXwYBpNLh00
+4blC/0gdEp0C8xAPbJIzguSEI5wAwmOISlSQipb2ptEl+aAFjxRLARl47pD6EES
N6pYgeVfNZ/F63Ywoley/s2RE7pvm3ofCVcrNC8AH1lolbbEZgrQBJKB/Sq5RC2W
pcO4Z6Y3UOziTyNuWcHRVOGjK/gpoFnncdFJzmjMubx8N+8dus1Wl3xwvXidYT8e
bLqc3acsUy2zLFQJRZIxuR9PPXVpKLCc0GF5Ufqa6ej5PKEsMJ2Baqy7x5Ujgyts
ceNH2d1JRtkxdVw+WqBetjatM2icb+Yf/e3hOzr85thaAVGyoNJtlyhAciY4aIbW
JhCpFuhvCuUcag2nNrrN5Ry3noGv3pm2AuqmUVSEZjorLsQnN5/3FxntVSb4YWkg
VSLD4QHMiE0UeWnhCzKN7I5e/QhrnJ+HABx0GfTgjcXt1VQiKwxEp9A8+JsRmGiF
G0oOTWsE/oUx+KCluuIRPpKuuiX0Nc50IEH3vklCIAkAWriMfh/jZvDTIeR1Wtci
3BTlJ2Z0erX8IPh+BVnI
=jO18
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
