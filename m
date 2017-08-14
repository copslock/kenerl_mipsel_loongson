Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 21:02:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48226 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994820AbdHNTCLcnqYQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 21:02:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6642CCCE0B41E;
        Mon, 14 Aug 2017 20:02:01 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug
 2017 20:02:05 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 14 Aug
 2017 12:02:03 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 1/8] MIPS: Introduce CPU_ISA_GE_* Kconfig entries
Date:   Mon, 14 Aug 2017 12:01:57 -0700
Message-ID: <2061792.OTvtPzySQH@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <86ddc490-dabd-66b5-ebd7-aed6535d3966@cavium.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com> <20170814181819.7376-2-paul.burton@imgtec.com> <86ddc490-dabd-66b5-ebd7-aed6535d3966@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2252923.pX9aZH3JNT";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart2252923.pX9aZH3JNT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Steven,

On Monday, 14 August 2017 11:56:46 PDT Steven J. Hill wrote:
> On 08/14/2017 01:18 PM, Paul Burton wrote:
> 
> [...]
> 
> > With the new Kconfig entries introduced by this patch this can be
> > 
> > simplified to:
> >   default y if CPU_ISA_GE_R1
> 
> The idea for the patch is solid.

Thanks.

> Can we not just use CPU_ISA_R1,
> and so on? GE immediately makes me think "Graphics Engine" and
> there are the GE7 ASICs from old SGI hardware. Maybe it's just
> me and it doesn't confuse anyone else.

I went with "GE" because that matches what the MIPS instruction set uses in 
branch-compare instructions. I think leaving it out would make it unclear what 
the difference from the existing CPU_MIPSR1 etc entries is, but if something 
else would be clearer to people I'm open to suggestions.

Thanks,
    Paul
--nextPart2252923.pX9aZH3JNT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmR86UACgkQgiDZ+mk8
HGVIpw//apA1gNBz6veOYdGqYfpmmL9OKPhBQ2uPb2l2fszfPK/UVnHMLMrkseuT
wjdf2rONLGxjzE6tAlCAJM6MPeDZk94wdtRSOvI6eKo7Y6BP22soF918HlmHcw7S
i00O9BcaRZcOQALnpkyR+y20KS9alUY72eEMgNPYELSQClYJbONevQ37vc6udlO4
el7tZ1ez8ivcCBhX7yF4n9/ASrprFWEbg38CR5aUwSOc8tAA/KN+sNSdLIHbH9Sn
xgw59DJ1r8luH2lxfthEoZFEv4qU4AtCh+WC/9Mqv2i1g9crZ7Q0v0LR0NXJDg+8
lWUIbDeLn7Os5K5dh9TMs75rmYnML/IxsT4AtAPjz9VzckjN1w++1YpvnZvR2hXl
vxkiOQ5raOuM6xQJ4qKs0n9FfgPrbuyengV8EW1/+VAgUn5PQO4t47X0wC9HQoP7
YMmPLD13clal3MkRSNJ//NvN6aOcGr7N/gNJn0QuMWd+byObPOxT+z6lfgWcvoaP
pouKuYdeoTP7dXw+82+qZd6QWHaW+xCCzezgreSWUG0L6QMuj1pYkV6l6/GA3ga2
VFsuxcXe3mLsqfVK4Y2e8BGeJXXa+xDXOAgOH5M2VGdKfqthShO05ilAwkfRnCh3
jY22eF5qUoKSmUxRNpvWFLjCQqKHbbksCJxa2SazfxiHZ2iZwic=
=01i1
-----END PGP SIGNATURE-----

--nextPart2252923.pX9aZH3JNT--
