Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 15:41:34 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:33484 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011267AbbG0Nlc4TKId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 15:41:32 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id D37632910A;
        Mon, 27 Jul 2015 13:41:26 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id B426729108;
        Mon, 27 Jul 2015 13:41:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1438004486; bh=6ZTcn0BlOfeP5Kg5kDjqMu1ahy3sj5ESSsFnXejQOt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgOnD3VFiXadnTiq7AixCjDZav2T5eJ31qbo9hdCNFhnWz8pyKQx3NlxYSD0rR+LB
         3czGbDGHax2npXzvXY2CMcKYm2aT3fUHV2+PuKbLDm1hrcbtUNuy9FEle0CVOB/kpK
         RD6N5eMlT/LTmmkJlG+ZRgDPQvpxTZcyygUygjqg=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id ACC868008B;
        Mon, 27 Jul 2015 13:41:26 +0000 (GMT)
Date:   Mon, 27 Jul 2015 09:41:26 -0400
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
Message-ID: <20150727134126.GB17133@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-6-git-send-email-emunson@akamai.com>
 <20150727073129.GE11657@node.dhcp.inet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20150727073129.GE11657@node.dhcp.inet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48437
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


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2015, Kirill A. Shutemov wrote:

> On Fri, Jul 24, 2015 at 05:28:43PM -0400, Eric B Munson wrote:
> > The cost of faulting in all memory to be locked can be very high when
> > working with large mappings.  If only portions of the mapping will be
> > used this can incur a high penalty for locking.
> >=20
> > Now that we have the new VMA flag for the locked but not present state,
> > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
>=20
> As I mentioned before, I don't think this interface is justified.
>=20
> MAP_LOCKED has known issues[1]. The MAP_LOCKED problem is not necessary
> affects MAP_LOCKONFAULT, but still.
>=20
> Let's not add new interface unless it's demonstrably useful.
>=20
> [1] http://lkml.kernel.org/g/20150114095019.GC4706@dhcp22.suse.cz

I understand and should have been more explicit.  This patch is still
included becuase I have an internal user that wants to see it added.
The problem discussed in the thread you point out does not affect
MAP_LOCKONFAULT because we do not attempt to populate the region with
MAP_LOCKONFAULT.

As I told Vlastimil, if this is a hard NAK with the patch I can work
with that.  Otherwise I prefer it stays.


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtjUGAAoJELbVsDOpoOa9FEQP/0tZqvE9r1cDWHP2fRNfVeMA
4SA6NwWvWAlS3Jyzwqin6jEPfTp5mp9XmBs2OSFCUtRM4gheS+V0qm4UMCoUUe8V
1biXRm6JAcqlQ9RaQsIleuwtu6rfq/VmPvyXfoh2VzHtHkfJH1es+IuzyMvN8rB2
+dMOrDXpr0TGzV2pUXmpqvJV9XCuJJqC2EUp3ygCjCsxtir7que+hBurNHk6V37o
SJPg+1fOfKlZC2JoH1e3nlaNa8E7Tgn3CcaS95PJGtjp3B3B/WFHyQsV7ICDCPph
p1DS8lNn1AHvC8Ia1b9q9k6iuPVpunFRthVyXLfDtb7UVDxyDBAbBArQMlSqdS98
7s+Am4nRAqQ4hyvCrfFbkXyplihX34uwmi263r7pAPizwJRx/ArnJk+EJK6Qclp+
aiL2BO8PJR2vPi7BfsPSBcgd68iEeCCsOpNGD3GyQ3C5tdtZK/MaDmZm2cCdzaZg
pWkEgj3oi8jiTD59NskpqqsmtWahucR6HVXAF6DNvZXypigq+uvnaqImEOxpOEQR
h1zR5O8L5jnZO1BYAHpJO1+16ZAPcNa2tF20OcxsAvcGvblbFNYG1jzAE6w9FGbz
Qr4VU8B1u/IiDGuHNroiwrTOlN7Tn7wYN0/bstOPk3UavEmg3wEuOaaQat2CU7pC
rLymWmGP9Rc0+NgO/vMz
=Leis
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
