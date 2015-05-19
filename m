Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 22:30:11 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:39326 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013091AbbESUaJm-AJy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 22:30:09 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 4940747F5C;
        Tue, 19 May 2015 20:30:06 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id 393C947F5B;
        Tue, 19 May 2015 20:30:06 +0000 (GMT)
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 2042A80085;
        Tue, 19 May 2015 20:30:06 +0000 (GMT)
Date:   Tue, 19 May 2015 16:30:05 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-ID: <20150519203005.GB2454@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150511180631.GA1227@akamai.com>
 <20150513150036.GG1227@akamai.com>
 <20150514080812.GC6433@dhcp22.suse.cz>
 <20150515153550.GA2454@akamai.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20150515153550.GA2454@akamai.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47479
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


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2015, Eric B Munson wrote:

> On Thu, 14 May 2015, Michal Hocko wrote:
>=20
> > On Wed 13-05-15 11:00:36, Eric B Munson wrote:
> > > On Mon, 11 May 2015, Eric B Munson wrote:
> > >=20
> > > > On Fri, 08 May 2015, Andrew Morton wrote:
> > > >=20
> > > > > On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.=
com> wrote:
> > > > >=20
> > > > > > mlock() allows a user to control page out of program memory, bu=
t this
> > > > > > comes at the cost of faulting in the entire mapping when it is
> > > > > > allocated.  For large mappings where the entire area is not nec=
essary
> > > > > > this is not ideal.
> > > > > >=20
> > > > > > This series introduces new flags for mmap() and mlockall() that=
 allow a
> > > > > > user to specify that the covered are should not be paged out, b=
ut only
> > > > > > after the memory has been used the first time.
> > > > >=20
> > > > > Please tell us much much more about the value of these changes: t=
he use
> > > > > cases, the behavioural improvements and performance results which=
 the
> > > > > patchset brings to those use cases, etc.
> > > > >=20
> > > >=20
> > > > To illustrate the proposed use case I wrote a quick program that mm=
aps
> > > > a 5GB file which is filled with random data and accesses 150,000 pa=
ges
> > > > from that mapping.  Setup and processing were timed separately to
> > > > illustrate the differences between the three tested approaches.  the
> > > > setup portion is simply the call to mmap, the processing is the
> > > > accessing of the various locations in  that mapping.  The following
> > > > values are in milliseconds and are the averages of 20 runs each wit=
h a
> > > > call to echo 3 > /proc/sys/vm/drop_caches between each run.
> > > >=20
> > > > The first mapping was made with MAP_PRIVATE | MAP_LOCKED as a basel=
ine:
> > > > Startup average:    9476.506
> > > > Processing average: 3.573
> > > >=20
> > > > The second mapping was simply MAP_PRIVATE but each page was passed =
to
> > > > mlock() before being read:
> > > > Startup average:    0.051
> > > > Processing average: 721.859
> > > >=20
> > > > The final mapping was MAP_PRIVATE | MAP_LOCKONFAULT:
> > > > Startup average:    0.084
> > > > Processing average: 42.125
> > > >=20
> > >=20
> > > Michal's suggestion of changing protections and locking in a signal
> > > handler was better than the locking as needed, but still significantly
> > > more work required than the LOCKONFAULT case.
> > >=20
> > > Startup average:    0.047
> > > Processing average: 86.431
> >=20
> > Have you played with batching? Has it helped? Anyway it is to be
> > expected that the overhead will be higher than a single mmap call. The
> > question is whether you can live with it because adding a new semantic
> > to mlock sounds trickier and MAP_LOCKED is tricky enough already...
> >=20
>=20
> I reworked the experiment to better cover the batching solution.  The
> same 5GB data file is used, however instead of 150,000 accesses at
> regular intervals, the test program now does 15,000,000 accesses to
> random pages in the mapping.  The rest of the setup remains the same.
>=20
> mmap with MAP_LOCKED:
> Setup avg:      11821.193
> Processing avg: 3404.286
>=20
> mmap with mlock() before each access:
> Setup avg:      0.054
> Processing avg: 34263.201
>=20
> mmap with PROT_NONE and signal handler and batch size of 1 page:
> With the default value in max_map_count, this gets ENOMEM as I attempt
> to change the permissions, after upping the sysctl significantly I get:
> Setup avg:      0.050
> Processing avg: 67690.625
>=20
> mmap with PROT_NONE and signal handler and batch size of 8 pages:
> Setup avg:      0.098
> Processing avg: 37344.197
>=20
> mmap with PROT_NONE and signal handler and batch size of 16 pages:
> Setup avg:      0.0548
> Processing avg: 29295.669
>=20
> mmap with MAP_LOCKONFAULT:
> Setup avg:      0.073
> Processing avg: 18392.136
>=20
> The signal handler in the batch cases faulted in memory in two steps to
> avoid having to know the start and end of the faulting mapping.  The
> first step covers the page that caused the fault as we know that it will
> be possible to lock.  The second step speculatively tries to mlock and
> mprotect the batch size - 1 pages that follow.  There may be a clever
> way to avoid this without having the program track each mapping to be
> covered by this handeler in a globally accessible structure, but I could
> not find it.
>=20
> These results show that if the developer knows that a majority of the
> mapping will be used, it is better to try and fault it in at once,
> otherwise MAP_LOCKONFAULT is significantly faster.
>=20
> Eric

Is there anything else I can add to the discussion here?


--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVW51NAAoJELbVsDOpoOa9PQIQAJYsWV/aTxT1NeePEHXXzgc2
mZLqLo0f1XF66qBn4eFO8mSy3CD+MKTqxMxF5dtRJhHkelz7s6JJqwRjfQgr6IT6
bsGSERcshD3rpNdJQnfkGd3mTmq6FmfvTeaUYPopZrN1zkZU/SmrAvm6GpPhjnH2
TrXEVm2MEcESl3Q7mNZfNDeduI1sKSw03BaBj2uSVMY7EllwpnvlO4pujmAC9ZBY
fb+lNttd0wTErNUHvHrUtBT7dCqLuOjAqANT78k+aXROCuIIkmnHjJctVRjRz9Bh
KFCY9JQTTZ3llNFdO6w/EYGD+u8qVN+8NnGYlR31rQUgVQ9EkLkaoCTdWVl/4dlF
GklDSDyG7ICUly7lTRSE59Zbph+8SiLPAd9YnGI/Tv5QUTrKRtv2sBD7ahU39eF0
XLFB02ZX9nzOTTYxKp4UO8iFcRhIkVrefIB467HeW1k15jOoY9Js8Wv1DMcGuUcb
6iETzFsnYhi/+vQq27rUGNq8MVN0dEsqlI80hfUdmhuSZeeHefmWSPIA7fsROdYk
zx11IRSbEVzSkcLTKn3Y15futwTl6oAHg3uKcfehxSiY3HmLm7w1EWJ64XKLpWry
5Dr4G78pWTLTm+Z9TqpBtg5sAcPPnMZwzJybMGHBaNAJqB6ZW83oDM5ght/kStpT
n6kIODdplDv+SdRLA+3k
=Cgdc
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
