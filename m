Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 22:06:18 +0200 (CEST)
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:59165 "EHLO
        prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026572AbbEHUGR3fUrG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 22:06:17 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id B5D1447A8A;
        Fri,  8 May 2015 20:06:13 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id A986647A84;
        Fri,  8 May 2015 20:06:13 +0000 (GMT)
Received: from akamai.com (caldecot.sanmateo.corp.akamai.com [172.22.186.166])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 86CBF2039;
        Fri,  8 May 2015 20:06:11 +0000 (GMT)
Date:   Fri, 8 May 2015 16:06:10 -0400
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
Message-ID: <20150508200610.GB29933@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47297
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


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 08 May 2015, Andrew Morton wrote:

> On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.com> wro=
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
> Please tell us much much more about the value of these changes: the use
> cases, the behavioural improvements and performance results which the
> patchset brings to those use cases, etc.
>=20

The primary use case is for mmaping large files read only.  The process
knows that some of the data is necessary, but it is unlikely that the
entire file will be needed.  The developer only wants to pay the cost to
read the data in once.  Unfortunately developer must choose between
allowing the kernel to page in the memory as needed and guaranteeing
that the data will only be read from disk once.  The first option runs
the risk of having the memory reclaimed if the system is under memory
pressure, the second forces the memory usage and startup delay when
faulting in the entire file.

I am working on getting startup times with and without this change for
an application, I will post them as soon as I have them.

Eric

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTRcyAAoJELbVsDOpoOa9ve0P/31hrYdpIkjcL8etZV7j1Amz
CbQNUV91heC9gS4zlE+Pkm/1OT+lPBx8qUXxoy1yvGtjh4Hy6dOfkrM/ysC60Xw3
GCLHqDfNm3GoRK4a4MfebDLlesAjLuRpk8n4dxjyZ8EbL6MeTaiAxDqyZ7YUqfNf
/OIxvT6zni/Tw1/JhTEE5G2qnjU7MLXJeALQEOISPmb+Fm59/sIOn5jcppYauPvW
8IieUQkD+BspBKu4L3UG66nhtEc67QX4IMyQCLe4asaZqz2rs4aI9R/YZeuXl+dK
JYcmsI3bX86XGvSKS0wWySw7/agkzOB/df+alVVtMB6iYFn46fwZ0wlMf051q8V1
aK9u/5/Fwp945kC0gnMa2qAirbHhDmhrxAJam+bPUaCz58EZq4ItZ6OmDkWVI/O9
332mvX26Wm5vzKZ9ki5qeh6CdFPBbPWvtxQHo7mx/BVEoJsKR322y73YHY6bsJ4x
eWSQQ+jNq5Oshogd3x73Fon4/8zjN+vBYFva5P9bSUH9Aq+TQtuc9zl3OD2nbe8x
j74wSLsyfrpBjBzSDG1lNiWN+3OZKsvxSFPX07SK4hkCOKf3jv/6g8PlftJaQNgJ
1hFJDRmz0Dr0OLbU8oAaC7A2BiSQLRBpqaW2tcN/igSu1B13adZVPA+WGcjOcqW2
detDdJZun8mNCxkguBtQ
=s0uu
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
