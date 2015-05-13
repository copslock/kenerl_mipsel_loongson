Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 17:00:43 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:53628 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013241AbbEMPAmDeNEy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 17:00:42 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 8B6042855D;
        Wed, 13 May 2015 15:00:36 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 69C942861F;
        Wed, 13 May 2015 15:00:36 +0000 (GMT)
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 5CF1380079;
        Wed, 13 May 2015 15:00:36 +0000 (GMT)
Date:   Wed, 13 May 2015 11:00:36 -0400
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
Message-ID: <20150513150036.GG1227@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150511180631.GA1227@akamai.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <20150511180631.GA1227@akamai.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47374
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


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2015, Eric B Munson wrote:

> On Fri, 08 May 2015, Andrew Morton wrote:
>=20
> > On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.com> w=
rote:
> >=20
> > > mlock() allows a user to control page out of program memory, but this
> > > comes at the cost of faulting in the entire mapping when it is
> > > allocated.  For large mappings where the entire area is not necessary
> > > this is not ideal.
> > >=20
> > > This series introduces new flags for mmap() and mlockall() that allow=
 a
> > > user to specify that the covered are should not be paged out, but only
> > > after the memory has been used the first time.
> >=20
> > Please tell us much much more about the value of these changes: the use
> > cases, the behavioural improvements and performance results which the
> > patchset brings to those use cases, etc.
> >=20
>=20
> To illustrate the proposed use case I wrote a quick program that mmaps
> a 5GB file which is filled with random data and accesses 150,000 pages
> from that mapping.  Setup and processing were timed separately to
> illustrate the differences between the three tested approaches.  the
> setup portion is simply the call to mmap, the processing is the
> accessing of the various locations in  that mapping.  The following
> values are in milliseconds and are the averages of 20 runs each with a
> call to echo 3 > /proc/sys/vm/drop_caches between each run.
>=20
> The first mapping was made with MAP_PRIVATE | MAP_LOCKED as a baseline:
> Startup average:    9476.506
> Processing average: 3.573
>=20
> The second mapping was simply MAP_PRIVATE but each page was passed to
> mlock() before being read:
> Startup average:    0.051
> Processing average: 721.859
>=20
> The final mapping was MAP_PRIVATE | MAP_LOCKONFAULT:
> Startup average:    0.084
> Processing average: 42.125
>=20

Michal's suggestion of changing protections and locking in a signal
handler was better than the locking as needed, but still significantly
more work required than the LOCKONFAULT case.

Startup average:    0.047
Processing average: 86.431


--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU2cUAAoJELbVsDOpoOa9baQQANJIi9hDC0B5PmZg1n740+8X
5w7lzvAiDqRYi4/xYMjtx55l9M/YpTlnEuCPHUjEUvQvpxALWGSTYmcJ6cNx47Gh
/BHWrTr4oedPg23icayje+QC/DKF10OT/qBx/ep/+J4nEEZnbBQmk5Ce2EbjVCDm
4Xs3RjSeD9cWAOoHTsN2oqerZSM+DlqGU0Q2mWu10VM6usItc1oWk6U/gpD/26tE
lfMslp8jsECGvLmd4Zkj44HifD36pI0InaSKeBLrUCAe8W6qvhCuIaKRdOn00lgZ
CcUfQsK0c/7aYOZDm5CM4EUm+F8ee0mJV19qDMOm5rU9IrFZ4zj6rzRUHQ5OHcFH
mLxWm6wtqxYSapbWkYhiMei6lzDeMi0aL9BHKnzktgABBO1rwgNwPTlmwIWZcyPz
GWtxOw2oQZ6NqfGp9p3s677z2yicYQEJtEsvGrj5RVCUiXOwcRbQ0qNn8hF/6DrV
Xpk/cL6Zr9g8Klh/tLSN1CTXkcvGU6Poc83MLqf7DWmoKB86izb6MLoV4l5ckfyQ
s3nDQ6IJHOM3LaHIxeHj3FjHABx/lzwN22sKeRhsDduqiYUq3Y0i2J39ujXbZeUl
VlZ37T447uyO+nDgvg27P4MVsQlYYqt/vMmZ/a1NJdDXkzQU5RYpEmIeX/Z1Rifz
2Mean0e41gkDsd0BkxJb
=mszX
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
