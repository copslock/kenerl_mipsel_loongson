Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2015 17:53:22 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:52688 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010548AbbGXPxTmfzex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2015 17:53:19 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 83CD429250;
        Fri, 24 Jul 2015 15:53:13 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 589192920E;
        Fri, 24 Jul 2015 15:53:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1437753193; bh=YrqvdTMhyV6/ZHTtE7486Ouq5yvEwkGkzJWMFEfli4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzPkpmo8LhRwqBfb4gxeqYPqG1c5t12YajyeeK/YoHJxQ4Uykdsj06NMH9zEVP4OB
         ZYkyBbwm+C7GLGAS2TWAzOY98CvRbruioeN9xYVkcP8OI1FWuXoRbf76zZFkcoEDyF
         1tvL9FDXkyazWSPEzjCQokna2Vofy8mvsX02EHSE=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 5164E202A;
        Fri, 24 Jul 2015 15:53:13 +0000 (GMT)
Date:   Fri, 24 Jul 2015 11:53:13 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150724155313.GF9203@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
 <20150722141501.GA3203@akamai.com>
 <20150723065830.GA5919@linux-mips.org>
 <20150724143936.GE9203@akamai.com>
 <55B25DDE.8090107@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <55B25DDE.8090107@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48417
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


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2015, Guenter Roeck wrote:

> On 07/24/2015 07:39 AM, Eric B Munson wrote:
> >On Thu, 23 Jul 2015, Ralf Baechle wrote:
> >
> >>On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:
> >>
> >>>>
> >>>>You haven't wired it up properly on powerpc, but I haven't mentioned =
it because
> >>>>I'd rather we did it.
> >>>>
> >>>>cheers
> >>>
> >>>It looks like I will be spinning a V5, so I will drop all but the x86
> >>>system calls additions in that version.
> >>
> >>The MIPS bits are looking good however, so
> >>
> >>Acked-by: Ralf Baechle <ralf@linux-mips.org>
> >>
> >>With my ack, will you keep them or maybe carry them as a separate patch?
> >
> >I will keep the MIPS additions as a separate patch in the series, though
> >I have dropped two of the new syscalls after some discussion.  So I will
> >not include your ack on the new patch.
> >
> >Eric
> >
>=20
> Hi Eric,
>=20
> next-20150724 still has some failures due to this patch set. Are those
> being looked at (I know parisc builds fail, but there may be others) ?
>=20
> Thanks,
> Guenter

Guenter,

Yes, the next respin will drop all new arch syscall entries except
x86[_64] and MIPS.  I will leave it up to arch maintainers to add the
entries.

Eric

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVsl9pAAoJELbVsDOpoOa9EEUP/2M1Xsm8+njDOkkKbV0gBjBz
b3xOA+mBrdWvRUHtbhky0XhLX9AQkuolm5Lqel2ldbkHMF2DQtqvQxMCpWJ25dJW
oR5fnuh+arfoOsnEJAJ4Z47Qs/jiVAWHB3jupCxexg5zVZL2BIomII5Ewk00waGw
zHjUYeLYPTn6IE1MWV1Mlbbx+kGCDRz8HgFq8b3WbrgH4pPzqaeSf3wxMnIYVKuL
D/vyOdBOE0dW0Co4GdA3iqZ0JGSKknZUP/F3xB/z67wCkIjh133cUI3oDL/4MKbU
vSac0mG99uhmMPii1kWKyF3OVx3flbHo4IPFDAaUfU1O1OAXHvjezBgL3eLEV3xl
M/BZQZMEGNZjs6+c8oIrFuEvKDc424HRj7bKbBRvv7rXp3oaksyvuJ3mpEJyEhep
O+pSxjZc5J9QaXer+Rdh3yX/hjM/dpnTsUPXTIgPlJcIS8gSc5GxrCOe1hQD7u08
lIxdAs3sI5Tn6iwrjDRq1ySz2NZ2LkfBlliZ41xxt8/kzHvPoieeep2DRDJnpqJG
nyQItitQpzs0vB7UMJV+yrbfSAR+lupvVdfyXjk8fsYPMNPBhWHQKZ6Ky6euTkYs
/BWwZ2nvEjopIBEdrXJ97jJcjsAstFCnCm8V75JOX9KznfD0OUNCB6bg9UpUYQfX
IV8UQYGPDzfVm060LKYD
=SPSa
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
