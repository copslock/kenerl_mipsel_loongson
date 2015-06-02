Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 16:25:33 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:39989 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007016AbbFBOZbm3-54 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 16:25:31 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 37DD348391;
        Tue,  2 Jun 2015 14:25:21 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 122B64838A;
        Tue,  2 Jun 2015 14:25:21 +0000 (GMT)
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 0949D8008B;
        Tue,  2 Jun 2015 14:25:21 +0000 (GMT)
Date:   Tue, 2 Jun 2015 10:25:20 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH 0/3] Allow user to request memory to be locked on
 page fault
Message-ID: <20150602142520.GB2364@akamai.com>
References: <1432908808-31150-1-git-send-email-emunson@akamai.com>
 <20150601152746.abbbbb9d479c0e2dbdec2aaf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20150601152746.abbbbb9d479c0e2dbdec2aaf@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47792
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


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Jun 2015, Andrew Morton wrote:

> On Fri, 29 May 2015 10:13:25 -0400 Eric B Munson <emunson@akamai.com> wro=
te:
>=20
> > mlock() allows a user to control page out of program memory, but this
> > comes at the cost of faulting in the entire mapping when it is
> > allocated.  For large mappings where the entire area is not necessary
> > this is not ideal.
> >=20
> > This series introduces new flags for mmap() and mlockall() that allow a
> > user to specify that the covered are should not be paged out, but only
> > after the memory has been used the first time.
>=20
> I almost applied these, but the naming issue (below) stopped me.
>=20
> A few things...
>=20
> - The 0/n changelog should reveal how MAP_LOCKONFAULT interacts with
>   rlimit(RLIMIT_MEMLOCK).
>=20
>   I see the implementation is "as if the entire mapping will be
>   faulted in" (for mmap) and "as if it was MCL_FUTURE" (for mlockall)
>   which seems fine.  Please include changelog text explaining and
>   justifying these decisions.  This stuff will need to be in the
>   manpage updates as well.

Change logs are updated, and this will be included in the man page
update as well.

>=20
> - I think I already asked "why not just use MCL_FUTURE" but I forget
>   the answer ;) In general it is a good idea to update changelogs in
>   response to reviewer questions, because other people will be
>   wondering the same things.  Or maybe I forgot to ask.  Either way,
>   please address this in the changelogs.

I must have missed that question.  Here is the text from the updated
mlockall changelog:

MCL_ONFAULT is preferrable to MCL_FUTURE for the use cases enumerated
in the previous patch becuase MCL_FUTURE will behave as if each mapping
was made with MAP_LOCKED, causing the entire mapping to be faulted in
when new space is allocated or mapped.  MCL_ONFAULT allows the user to
delay the fault in cost of any given page until it is actually needed,
but then guarantees that that page will always be resident.

>=20
> - I can perhaps see the point in mmap(MAP_LOCKONFAULT) (other
>   mappings don't get lock-in-memory treatment), but what's the benefit
>   in mlockall(MCL_ON_FAULT) over MCL_FUTURE?  (Add to changelog also,
>   please).
>=20
> - Is there a manpage update?

I will send one out when I post V2

>=20
> - Can we rename patch 1/3 from "add flag to ..." to "add mmap flag to
>   ...", to distinguish from 2/3 "add mlockall flag ..."?

Done

>=20
> - The MAP_LOCKONFAULT versus MCL_ON_FAULT inconsistency is
>   irritating!  Can we get these consistent please: switch to either
>   MAP_LOCK_ON_FAULT or MCL_ONFAULT.

Yes, will do for V2.

>=20

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbbzQAAoJELbVsDOpoOa9EtAP+wamgfoxHetODtEfMUqzYJgN
GxcPBHPjo32fPtFoQu+IvDCqI48ySC4Syx0DqjzZJah+Uo8ngxUDQz3U9dTFrZq+
wv18PEj5CV4ejsEPn6pPuFYpQk/s6UvaexGCXONeHD8Zp20zoPpa4foUMyOvvUnC
tTA+fUJNsinYLGmzidV/1ebXUZYA2ur8Keur7e/kVqzZUWCkClpEVa7ZWnclral9
8mcvrgnI0Z7HnXlZzgUzncUt/OpVwp6jH8Cg4l2qGvSN0q4w77LWhac4n+ut7ogZ
XUIZiem41vBBzWuRjI9TiikFv83wQUPgFrlazWaScEl1Ht5N6HBs20EwHS86sBHe
cMk6SdwUhhCi7rRsZQPcYq+Re6XKXMZPUhfoMqU09TMIpN0t01XGdkAQehgHoyvY
N2hI4zuLIiFNYouXQKLwp+a7++tzI7XxfIo67CmdzCEb/Buxalhd+rSOQWF28Sos
F4vRxeyhzE0CjWPcp9qDt4EIJci1TNwvQpOzT0HbX1PXJEJM44cRZxvLIYq9Almy
g0rQ2LSYZP1gf9ngo/zh02ghenboKwYAMVOZDbOOjUMvtw5RS97voJ5ZOX+/fK95
AQAEPZnJICFKmP/yNGtWpKuK3yfeYxDL0mAopbzXe2SGgk9eS6Dgsg0gVI4hyu33
uQVVmWf17Owqb8CI9gAt
=Aoeb
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
