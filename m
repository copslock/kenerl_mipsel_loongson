Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 16:11:39 +0200 (CEST)
Received: from a23-79-238-175.deploy.static.akamaitechnologies.com ([23.79.238.175]:20602
        "EHLO prod-mail-xrelay07.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011309AbbG0OLh67AUd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 16:11:37 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id C8BC547FA3;
        Mon, 27 Jul 2015 14:11:31 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id A298247F7E;
        Mon, 27 Jul 2015 14:11:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1438006291; bh=ve6Wy1C18OUKWdLDfZTbZXLDIviZduESYpbxJMT4FIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKNIOI7MBuAUUq3sjHXO7MzztZ7IqNwBaV3Ud3Jnk4UFZI6qJwuIb7HuNtlsRF9wE
         Ee2kndLTuUf1B+rEdc5qT0jz7yEbdCMGvyk0vfLS2hMXLWXmk2YfTTn4UwmGNzEqxG
         Q/5thnIg5w9p0P9kGwoetzjWW2KMPWqlZFD79ddw=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 9A76A8008B;
        Mon, 27 Jul 2015 14:11:31 +0000 (GMT)
Date:   Mon, 27 Jul 2015 10:11:31 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V5 5/7] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-ID: <20150727141131.GA21664@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-6-git-send-email-emunson@akamai.com>
 <20150727073129.GE11657@node.dhcp.inet.fi>
 <20150727134126.GB17133@akamai.com>
 <20150727140355.GA11360@node.dhcp.inet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20150727140355.GA11360@node.dhcp.inet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48447
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2015, Kirill A. Shutemov wrote:

> On Mon, Jul 27, 2015 at 09:41:26AM -0400, Eric B Munson wrote:
> > On Mon, 27 Jul 2015, Kirill A. Shutemov wrote:
> >=20
> > > On Fri, Jul 24, 2015 at 05:28:43PM -0400, Eric B Munson wrote:
> > > > The cost of faulting in all memory to be locked can be very high wh=
en
> > > > working with large mappings.  If only portions of the mapping will =
be
> > > > used this can incur a high penalty for locking.
> > > >=20
> > > > Now that we have the new VMA flag for the locked but not present st=
ate,
> > > > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
> > >=20
> > > As I mentioned before, I don't think this interface is justified.
> > >=20
> > > MAP_LOCKED has known issues[1]. The MAP_LOCKED problem is not necessa=
ry
> > > affects MAP_LOCKONFAULT, but still.
> > >=20
> > > Let's not add new interface unless it's demonstrably useful.
> > >=20
> > > [1] http://lkml.kernel.org/g/20150114095019.GC4706@dhcp22.suse.cz
> >=20
> > I understand and should have been more explicit.  This patch is still
> > included becuase I have an internal user that wants to see it added.
> > The problem discussed in the thread you point out does not affect
> > MAP_LOCKONFAULT because we do not attempt to populate the region with
> > MAP_LOCKONFAULT.
> >=20
> > As I told Vlastimil, if this is a hard NAK with the patch I can work
> > with that.  Otherwise I prefer it stays.
>=20
> That's not how it works.

I am not sure what you mean here.  I have a user that will find this
useful and MAP_LOCKONFAULT does not suffer from the problem you point
out.  I do not understand your NAK but thank you for explicit about it.

>=20
> Once an ABI added to the kernel it stays there practically forever.
> Therefore it must be useful to justify maintenance cost. I don't see it
> demonstrated.

I understand this, and I get that you do not like MAP_LOCKED, but I do
not see how your dislike for MAP_LOCKED means that this would not be
useful.

>=20
> So, NAK.
>=20

V6 will not have the new mmap flag unless there is someone else that
speaks up in favor of keeping it.


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtjwTAAoJELbVsDOpoOa9cywQAMOd32FQcpI15XIUZk3SBUeg
/oa/5375ZFZqvbJHZn4iTFt4FxbvYUJPsAkWxH92nUQjdWBleVEUKhUs+K3tEz85
yNtsDJFuMlR07fY75oqz5LqorrMwHw1CNDXj32ADaPg+hxdPwMH9HUC2AeKIwv4E
lOhyZdUqfgLn0uYnJNhoDSqoFENCiFvX3jZsGszbfsEljPe/PfgwIJVCZP+R9p0X
oQ/u0MXGHLLOagPVFlXh3lkj8Q/C+/PiT8ubQUIdcsz//0E9mB+X7M+Za2hWtU6A
QUclnufc6+D7FGwq6zVKb5AEyDg2WVuGK/jWO44a9bAlZxVpttsGaobdQoz2Xs8r
mWZ0VQxSJIPoXFJ3ggCgJQYCQtZWOiHPfotP3w4ba6rMEP1M/AG5F7aTFEEkxPdv
wVCDab4asBJMZHRKxlyK2KX2sXclOc9eJ1BqC1EZmNjDcrxxAwoeb1+8ZjOkeOH5
S1bPWdotTfQemH6iJulJP+GVtjo0fUw1S+tpiapJu16NfiUvS2bjAczwjgu9pE1Y
LW3JC/MVfD13DVSDwHEmuIelWOlRyqsiFm86FZz2pXkocSISzESCk3otqJv8f3iN
M3xYGJIlyFxPgelUcPbkqh/G4g3+tVC4d3zhxLVfUJMUhWHZlKYr2pgNhii4Yty8
HUDKoUVYKSp1f5/jOB+f
=vq9F
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
