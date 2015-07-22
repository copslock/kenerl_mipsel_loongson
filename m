Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 16:05:10 +0200 (CEST)
Received: from a23-79-238-175.deploy.static.akamaitechnologies.com ([23.79.238.175]:43663
        "EHLO prod-mail-xrelay07.akamai.com" rhost-flags-OK-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006568AbbGVOFIlk0Jv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 16:05:08 +0200
Received: from prod-mail-xrelay07.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 047E94C03E;
        Wed, 22 Jul 2015 14:05:44 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay07.akamai.com (Postfix) with ESMTP id E00A84C012;
        Wed, 22 Jul 2015 14:05:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437573943; bh=pCuZlSjCgBkJX2FZ12NbT6LN1RiSZw1yQPJ9/ttMxPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBY7H5k1ZVvHOajj5MdZOITp344RD2z4eyX5ySwl/64gqaNfa73sGY+mqJqDiJEuL
         oAJ9qplYXf4UBqE5MKbdF3s1ufs7WNWxX1SEaOMRcIWXFAtgaRbt0heVu2yYZHUctQ
         tNuGGJPY+yR9HkuGSoLM6fs6qaCRuGrGYF6x6At4=
Received: from akamai.com (unknown [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id 8AF1F8008A;
        Wed, 22 Jul 2015 14:05:02 +0000 (GMT)
Date:   Wed, 22 Jul 2015 10:05:02 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150722140502.GB2859@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <55AF5F5A.3000707@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <55AF5F5A.3000707@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48381
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


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2015, Vlastimil Babka wrote:

> On 07/21/2015 09:59 PM, Eric B Munson wrote:
> >With the refactored mlock code, introduce new system calls for mlock,
> >munlock, and munlockall.  The new calls will allow the user to specify
> >what lock states are being added or cleared.  mlock2 and munlock2 are
> >trivial at the moment, but a follow on patch will add a new mlock state
> >making them useful.
> >
> >munlock2 addresses a limitation of the current implementation.  If a
>=20
>   ^ munlockall2?

Fixed, thanks.


--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVr6MOAAoJELbVsDOpoOa9s9sP/A7izRQp4uVnMpOwD0MxlFeD
XcaKq8V5n3o7/BMR992hOIWBEl5/HUrJR3sRtfi42uPUYK930Ofy+mckUN6D4iiH
EyIKyjBq6DIBcChWmlXqNBh86cb1gvkx1gTNjjOSXVIFkrjvstCRomfHd7FtDmBq
u37dhRe0VJLAVWRRn+GvV5IEJzv20RnEgdfSw8kf+M4nO9g/59z8qe+IC3g2xLD2
q8D1rEwwnDOeYZVSkP+dt7EVkoR/hHbDdgijEocWwpKTNih4NcH0xgfcfYFbT3j+
MNNt3EeYAjmgZNZOL/YRbxWbnol84EdQUAZ9lfkjL/n5Pd4A4/yKduK1692DAtzD
RDPGJ5xP9g8JHM6+xvMk66ZEMFfZpnGioXfrV+2emLq8q4P+N2zJ6PREPk7r00tO
cbFFd/RNnVLBcCjj/1aIHG2txHVB9GVkUzj7MbHID019oC2IcQU+vFfUJcs5gexr
ntuWehXpnANwZY+kUKZWPevnUNqWsll4ITtbG7/6L20NbBADB8EXRnIyj4MzdLMN
x/aAITZB0qq1ad9H1pH4eXp7tnzX2b3T3HZN8+PWWhhPNBFenRFiOC4VnNT6J4aS
pZ/DMiXv5h6h17dEX3UQK4aMUurZw7Ptaj/N16MOsxTWM0jIm4De79+TfARt58Zs
xqZ6XgkcJBiIIcnJXw4D
=NAcA
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
