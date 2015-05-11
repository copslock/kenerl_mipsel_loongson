Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 16:36:26 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:42684 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026912AbbEKOgY3qWTi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 16:36:24 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 0B623285DF;
        Mon, 11 May 2015 14:36:19 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id E1560285D8;
        Mon, 11 May 2015 14:36:18 +0000 (GMT)
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id A76B08004A;
        Mon, 11 May 2015 14:36:18 +0000 (GMT)
Date:   Mon, 11 May 2015 10:36:18 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-ID: <20150511143618.GA30570@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150508200610.GB29933@akamai.com>
 <20150508131523.f970d13a213bca63bd6f2619@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20150508131523.f970d13a213bca63bd6f2619@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47309
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


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 08 May 2015, Andrew Morton wrote:

> On Fri, 8 May 2015 16:06:10 -0400 Eric B Munson <emunson@akamai.com> wrot=
e:
>=20
> > On Fri, 08 May 2015, Andrew Morton wrote:
> >=20
> > > On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.com>=
 wrote:
> > >=20
> > > > mlock() allows a user to control page out of program memory, but th=
is
> > > > comes at the cost of faulting in the entire mapping when it is
> > > > allocated.  For large mappings where the entire area is not necessa=
ry
> > > > this is not ideal.
> > > >=20
> > > > This series introduces new flags for mmap() and mlockall() that all=
ow a
> > > > user to specify that the covered are should not be paged out, but o=
nly
> > > > after the memory has been used the first time.
> > >=20
> > > Please tell us much much more about the value of these changes: the u=
se
> > > cases, the behavioural improvements and performance results which the
> > > patchset brings to those use cases, etc.
> > >=20
> >=20
> > The primary use case is for mmaping large files read only.  The process
> > knows that some of the data is necessary, but it is unlikely that the
> > entire file will be needed.  The developer only wants to pay the cost to
> > read the data in once.  Unfortunately developer must choose between
> > allowing the kernel to page in the memory as needed and guaranteeing
> > that the data will only be read from disk once.  The first option runs
> > the risk of having the memory reclaimed if the system is under memory
> > pressure, the second forces the memory usage and startup delay when
> > faulting in the entire file.
>=20
> Why can't the application mmap only those parts of the file which it
> wants and mlock those?

There are a number of problems with this approach.  The first is it
presumes the program will know what portions are needed a head of time.
In many cases this is simply not true.  The second problem is the number
of syscalls required.  With my patches, a single mmap() or mlockall()
call is needed to setup the required locking.  Without it, a separate
mmap call must be made for each piece of data that is needed.  This also
opens up problems for data that is arranged assuming it is contiguous in
memory.  With the single mmap call, the user gets a contiguous VMA
without having to know about it.  mmap() with MAP_FIXED could address
the problem, but this introduces a new failure mode of your map
colliding with another that was placed by the kernel.

Another use case for the LOCKONFAULT flag is the security use of
mlock().  If an application will be using data that cannot be written
to swap, but the exact size is unknown until run time (all we have a
build time is the maximum size the buffer can be).  The LOCKONFAULT flag
allows the developer to create the buffer and guarantee that the
contents are never written to swap without ever consuming more memory
than is actually needed.

>=20
> > I am working on getting startup times with and without this change for
> > an application, I will post them as soon as I have them.
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUL5iAAoJELbVsDOpoOa9+rIP/AtdiaAVRSAXFkS8FoN053Gp
X9V3dAR/tJhrcsK0YFQcYBdG/e2doGqbJq6ni9iHdiABQ/dWmC6LZIRugSGltzGw
WN3WSPpzLAHLS6TbH5KPydvrbne32pCI02McxTCSJ+IKARHZvUz3JWaq0z1/Tuqa
U6pKp0qOo+1CD/YYgew2vyVWTZozPG379QhIkolLAtd4/FnL1DL8tW9gwgP6/pSF
lfKNZNc2RFTRBnONckDDctDVbV8MZJCzPbPk4lBvhqc8VS11GWPylocZFB76C/w4
Jcj5+JRUXgqGuIb+hwnQcnv/jAn2yjXW//6vB8qG0r1oXfCF7QwAVQegbjV7VAyT
iQj3785JaeFIWUy8WLIk+BqP8tTzB/hphDTiV4dqTeHDSZGYw1ioFbzXcqkrapdm
Ycqq4oTBxl7OkqDW5UQvvAWv4q9YP/E1KJK7O/HccybRcofVNGyO4hH+lgeFazMw
5Id9Ptd/+qLxHP7jX0G53facKx5M8xtUT1DfsHi/nmCLD/uFdFOueaHKzQiVVGcp
C8SgvCWcBQrHtgcn/JOyKH211sKOszOHFxg3TkglDl6s3th5zd+SAjYGRjKYizPe
FoZ1FWhjyvsuybV8KFs5LRZ6et3kD06bCZrGS8JMrNo6R4BA4z7o88EVUxkSXx+z
s7IIi8UpQrCbKJra0ucm
=R9vZ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
