Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 16:39:45 +0200 (CEST)
Received: from a23-79-238-175.deploy.static.akamaitechnologies.com ([23.79.238.175]:33243
        "EHLO prod-mail-xrelay07.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010045AbbGXOjmr8lOG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 16:39:42 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 3004D47F79;
        Fri, 24 Jul 2015 14:40:22 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 164C847F75;
        Fri, 24 Jul 2015 14:40:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437748822; bh=1Y8OL30feOatrroErMW/c7oeoTeQepmh1PZOZsOnngM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUM/fnGnReUrStF/5ABTAaKIg9uVkQWN6RlaXKrXOR+5dOGdBszpmJCkHnR7wIgwg
         9wJEIInogl0gwVz2Ri0jg5JODyAa3iNFpW8GSwWHWXqVgnQVHpUU7vLVhYF6dodJXg
         nv7ajeC4//J5yKSwLeNqseNUJxkCSJX+3q8GmMho=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 820772252;
        Fri, 24 Jul 2015 14:39:36 +0000 (GMT)
Date:   Fri, 24 Jul 2015 10:39:36 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20150724143936.GE9203@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
 <20150722141501.GA3203@akamai.com>
 <20150723065830.GA5919@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20150723065830.GA5919@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48410
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


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2015, Ralf Baechle wrote:

> On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:
>=20
> > >=20
> > > You haven't wired it up properly on powerpc, but I haven't mentioned =
it because
> > > I'd rather we did it.
> > >=20
> > > cheers
> >=20
> > It looks like I will be spinning a V5, so I will drop all but the x86
> > system calls additions in that version.
>=20
> The MIPS bits are looking good however, so
>=20
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>=20
> With my ack, will you keep them or maybe carry them as a separate patch?

I will keep the MIPS additions as a separate patch in the series, though
I have dropped two of the new syscalls after some discussion.  So I will
not include your ack on the new patch.

Eric

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsk4oAAoJELbVsDOpoOa9Eo0QAJ6eViChMf3Imw2HLUBOL+qS
B7hozSCTuKLHaqx8QBhkjX6yqn0FIa5+TUWk76Py3JA00geQAiSWGmmZidLmdkmL
QqZgrvi6B/hsDx4qhNk3wsTpeOtRL6JfpM0CI42Y5JO9nXvp/mpEJyHIRbrvlOtG
GdRPYjyf1gXqwFaOJel7/GvPhRxMh0vkIr78XqNZOQovWL9cfvaUGaZmLGcLJq78
PPYyuZ53AmNg83C8wDpgPfdgQ/L4ob+mZJIcP8purUXHpu7Xu7KbePkdoPqZ1EDT
zRias9nrfrQQTCYaga4MM6wMa2S+iDNPq6Ae+sI6eoDyMxhjuUEi4xxHZ9HGwSIm
Ii5cbD5//xbOHceAPuQ0lhvWH06ip6OVEXx68ACl7p46Ebi7B2jOeSyKH3UNpomS
37NdAdUk3PlC3r3CwoPS2XXYjthQr8rVLVqoZP1wC4KxHanglXzFv+AwyLwRCQJ3
6WevOpUmjVstR67EZBXmHMC4yVGxwF9TdC15G4coZEBw8wcLV6rC2TuK1KZw5JHR
1yIJtZIBQmNoFkGwNWggIFsDiOasKmgUjjHY/yPPrn0MTkCy69zrnkqzoKZQEIoE
MXYJiYfYFy7Ek7/K7u/lCjJI0X1bXk3QTmNrX5BuVzQPtV8jdzcBzl4SQhFGc7IH
4GNpeBolyRBy2p7wt0lO
=/Udu
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
