Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 18:43:42 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:55015 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008145AbbFSQnkIxa03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 18:43:40 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 3BA494917E;
        Fri, 19 Jun 2015 16:43:34 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 24D084917B;
        Fri, 19 Jun 2015 16:43:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1434732214; bh=Tat37RSf9eJRP6yzK2490Wy+xb5GculFlf7vM/vAUyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxcNeeemAtFs+PXtuDKGsfvLEWMW6Li8Z4Uje4nEsRgjivwv3H7ofzH1nROhKZTN6
         DYDxKIY9UivpasgvTzgZG/qhOvfuR4gQbu1UfsdKpX1buRoCDjwXHmF/BDh3/Fe2dY
         DXBg6Usaf3Wx0OtjHfSc/qeb5/QI5rQwCSFOa05U=
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 1D8A480084;
        Fri, 19 Jun 2015 16:43:34 +0000 (GMT)
Date:   Fri, 19 Jun 2015 12:43:33 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 1/3] Add mmap flag to request pages are locked
 after page fault
Message-ID: <20150619164333.GD2329@akamai.com>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <1433942810-7852-2-git-send-email-emunson@akamai.com>
 <20150618152907.GG5858@dhcp22.suse.cz>
 <20150618203048.GB2329@akamai.com>
 <20150619145708.GG4913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <20150619145708.GG4913@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47981
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


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2015, Michal Hocko wrote:

> On Thu 18-06-15 16:30:48, Eric B Munson wrote:
> > On Thu, 18 Jun 2015, Michal Hocko wrote:
> [...]
> > > Wouldn't it be much more reasonable and straightforward to have
> > > MAP_FAULTPOPULATE as a counterpart for MAP_POPULATE which would
> > > explicitly disallow any form of pre-faulting? It would be usable for
> > > other usecases than with MAP_LOCKED combination.
> >=20
> > I don't see a clear case for it being more reasonable, it is one
> > possible way to solve the problem.
>=20
> MAP_FAULTPOPULATE would be usable for other cases as well. E.g. fault
> around is all or nothing feature. Either all mappings (which support
> this) fault around or none. There is no way to tell the kernel that
> this particular mapping shouldn't fault around. I haven't seen such a
> request yet but we have seen requests to have a way to opt out from
> a global policy in the past (e.g. per-process opt out from THP). So
> I can imagine somebody will come with a request to opt out from any
> speculative operations on the mapped area in the future.
>=20
> > But I think it leaves us in an even
> > more akward state WRT VMA flags.  As you noted in your fix for the
> > mmap() man page, one can get into a state where a VMA is VM_LOCKED, but
> > not present.  Having VM_LOCKONFAULT states that this was intentional, if
> > we go to using MAP_FAULTPOPULATE instead of MAP_LOCKONFAULT, we no
> > longer set VM_LOCKONFAULT (unless we want to start mapping it to the
> > presence of two MAP_ flags).  This can make detecting the MAP_LOCKED +
> > populate failure state harder.
>=20
> I am not sure I understand your point here. Could you be more specific
> how would you check for that and what for?

My thought on detecting was that someone might want to know if they had
a VMA that was VM_LOCKED but had not been made present becuase of a
failure in mmap.  We don't have a way today, but adding VM_LOCKONFAULT
is at least explicit about what is happening which would make detecting
the VM_LOCKED but not present state easier.  This assumes that
MAP_FAULTPOPULATE does not translate to a VMA flag, but it sounds like
it would have to.

>=20
> From my understanding MAP_LOCKONFAULT is essentially
> MAP_FAULTPOPULATE|MAP_LOCKED with a quite obvious semantic (unlike
> single MAP_LOCKED unfortunately). I would love to also have
> MAP_LOCKED|MAP_POPULATE (aka full mlock semantic) but I am really
> skeptical considering how my previous attempt to make MAP_POPULATE
> reasonable went.

Are you objecting to the addition of the VMA flag VM_LOCKONFAULT, or the
new MAP_LOCKONFAULT flag (or both)?  If you prefer that MAP_LOCKED |
MAP_FAULTPOPULATE means that VM_LOCKONFAULT is set, I am fine with that
instead of introducing MAP_LOCKONFAULT.  I went with the new flag
because to date, we have a one to one mapping of MAP_* to VM_* flags.

>=20
> > If this is the preferred path for mmap(), I am fine with that.=20
>=20
> > However,
> > I would like to see the new system calls that Andrew mentioned (and that
> > I am testing patches for) go in as well.=20
>=20
> mlock with flags sounds like a good step but I am not sure it will make
> sense in the future. POSIX has screwed that and I am not sure how many
> applications would use it. This ship has sailed long time ago.

I don't know either, but the code is the question, right?  I know that
we have at least one team that wants it here.

>=20
> > That way we give users the
> > ability to request VM_LOCKONFAULT for memory allocated using something
> > other than mmap.
>=20
> mmap(MAP_FAULTPOPULATE); mlock() would have the same semantic even
> without changing mlock syscall.

That is true as long as MAP_FAULTPOPULATE set a flag in the VMA(s).  It
doesn't cover the actual case I was asking about, which is how do I get
lock on fault on malloc'd memory?

> =20
> > > > This patch introduces the ability to request that pages are not
> > > > pre-faulted, but are placed on the unevictable LRU when they are fi=
nally
> > > > faulted in.
> > > >=20
> > > > To keep accounting checks out of the page fault path, users are bil=
led
> > > > for the entire mapping lock as if MAP_LOCKED was used.
> > > >=20
> > > > Signed-off-by: Eric B Munson <emunson@akamai.com>
> > > > Cc: Michal Hocko <mhocko@suse.cz>
> > > > Cc: linux-alpha@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-mips@linux-mips.org
> > > > Cc: linux-parisc@vger.kernel.org
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Cc: sparclinux@vger.kernel.org
> > > > Cc: linux-xtensa@linux-xtensa.org
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-arch@vger.kernel.org
> > > > Cc: linux-api@vger.kernel.org
> > > > ---
> [...]
> --=20
> Michal Hocko
> SUSE Labs

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVhEa1AAoJELbVsDOpoOa9G9AQAIFwslEVTMGceV83OYvdwX89
JQHGpfvXIZh/BbujjzOFKIFk4BcZhVxGlkvrA9vg/0H3xbXyVg5DXK9hXwKAuGBn
HquXUVb7DtDgLoEbJgBi/LLfJ2ADfIVeiIsUM3fGb/DBTiMqX3QOCM2x63JT9iG1
xtg8hHQ/Ee2PAtR4GO6N4/PCbPWjOEJgdYjSp5avR57h2Keu8xTsHbYUK8CKA496
Pf5SusNzWqwBewdMfr+bLYbs3U9njdLUeLaRGqQuYwETUaALEeL3CIzyyFpDtQjv
WbCBng8aR8Mquz3ogYjz+FPrdftF90abox4yqb8o4V9qF5VW/JotgS/D/H327Lat
SlwKimGCvvOisB01VPNQ03P5x6cwa1Ld2MPltOaTxIjxoSz5lIY8KEkXca37kFj8
fzkR2fFcdb0RLSDWhk3vLNaZj7lcFkBTtx7YLoWLkj9/s3xiVtPmIC9vaMUvI3JZ
QPcX6gENRnDDT+SMZP5giAM4yyJjc50ILXFXkhY4iJuRgK6i4iu61+LASLTqsjeu
UqOfualtpXqLz1oaAgPOtwWxaGm6yr2SWMDuioRZ4oKjMZgPpnk5Yhshvos31MPa
L4pp2SSSKfkFyyIyyD/3tFMFh70xtN5oG1h9IvUi563aMbPZ9pjQq1me6c0ItUxW
tzFfJHu6+Vfws6lONsKF
=6RVh
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
