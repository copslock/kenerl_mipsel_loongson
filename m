Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 16:32:28 +0200 (CEST)
Received: from a23-79-238-175.deploy.static.akamaitechnologies.com ([23.79.238.175]:49040
        "EHLO prod-mail-xrelay07.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011028AbbGVOc0gt0h9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 16:32:26 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id CFB1E4D76A;
        Wed, 22 Jul 2015 14:33:01 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id B64184D476;
        Wed, 22 Jul 2015 14:33:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437575581; bh=HLB3XgVghmfpn1TAvUbKuS6UQ0jnF/0hqgYWlvjsRAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfVbrEAR7O1fxeeBxWcej8n/4VlJtVEPgNfeCUQSbtC2V2Q2NhU45eBDuvgKtiEqM
         nK4gLslKPJY8uoN0miLUbxQeFU2K7XAZd/1ZgivRfNLKZqrkPaMChMiLOd3dG1f/te
         RQ+dwhNQFwc+qfu+cKgVQ3ox4unOk5Awry2mYnl4=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 5C1BB2027;
        Wed, 22 Jul 2015 14:32:20 +0000 (GMT)
Date:   Wed, 22 Jul 2015 10:32:20 -0400
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
Subject: Re: [PATCH V4 5/6] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-ID: <20150722143220.GB3203@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
 <20150722112558.GC8630@node.dhcp.inet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <20150722112558.GC8630@node.dhcp.inet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48383
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


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2015, Kirill A. Shutemov wrote:

> On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> > The cost of faulting in all memory to be locked can be very high when
> > working with large mappings.  If only portions of the mapping will be
> > used this can incur a high penalty for locking.
> >=20
> > Now that we have the new VMA flag for the locked but not present state,
> > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
>=20
> What is advantage over mmap() + mlock(MLOCK_ONFAULT)?

There isn't one, it was added to maintain parity with the
mlock(MLOCK_LOCK) -> mmap(MAP_LOCKED) set.  I think not having will lead
to confusion because we have MAP_LOCKED so why don't we support
LOCKONFAULT from mmap as well.


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVr6l0AAoJELbVsDOpoOa98fUQANDd9dNcrulIgLSf+ajZqiUo
50UtNRMATvsiEBAEyJ8CwGzwUBQIYwHDU9LU28NUSZCgYJpGiN+PmJ61ZaU3f63x
Wps5ZlPg1MvY/IbHLmYTMD6UiXPa7zsAjTFNA6Fi0MwCjyLphtK6jqf8EhsoOLSo
YFsTccyuOfqJrbk/fXi3ioNPFVIkHpwNcdL1+sYOJf3Wkf8FBBnlvEMnOSmtw7GC
Uont1PBKFNeUNmk/sxxLDgJ0vwMx09sjfjYX+8ZOxS0E1JjeflHTSITsPeWt2/AI
0Qm0lxu0bZ62nnt8zvBVcCAoImIjFNgNnqxQwfKfb5kYgiR0c8ZSyOOuiGxugwI/
TKBkVU/e34Xc43UkmnseBl8SFUW1tF5eLLIvFt1apJ8ygrr4M4uIJIQV4UMSNVLG
VEV5c08dN91BRjDesU3EJ1vtPXK6avkZokkbNWmeoIQ70wOD2KSJurs0t5dFLtBw
t8t27CTYo/Fpg9kyLsgHzTqf4cH+L0FqVHJ4oQNU2OZvwvW5odyztgDdQV9KhEvf
k/MNlOTNpD8idmgCBSpVeReKAWkQEwRaB5QZWP9X4axdR6r7HwGvV3lWbwBpwa5i
LksIegF8VdBCnD8SibMXl37buy8oPlop5arIjvRHi8VMz6AhRK9OH1T/Mn0+yAIy
yBmHM0EALawWdDffUN1r
=GpJe
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
