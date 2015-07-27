Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 15:36:06 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:59756 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011267AbbG0NgDycp6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 15:36:03 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id F2DB3290F5;
        Mon, 27 Jul 2015 13:35:55 +0000 (GMT)
Received: from prod-mail-relay07.akamai.com (prod-mail-relay07.akamai.com [172.17.121.112])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id C5079290F3;
        Mon, 27 Jul 2015 13:35:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1438004155; bh=lOawACYZDnr1kh2vrL0o8U1xH4vb42Xdvg4l1Hazzug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGQrYqrbgP4ONi+2nIkNiDRh0QRWdnaaSEVCS8cM925nqCwXqYwI47DccKugsL46x
         /XWn21bib37lY8sbkj3o7Typ9o3cR/r2kgHIcuvD0sW80H0pfTOOdTdpVnEzUFA/69
         /Yj92F1R+QD+0aJyrB6ggzfcPcqF3trw6GXocSUQ=
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay07.akamai.com (Postfix) with ESMTP id BDF6D8008B;
        Mon, 27 Jul 2015 13:35:55 +0000 (GMT)
Date:   Mon, 27 Jul 2015 09:35:55 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
Message-ID: <20150727133555.GA17133@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <55B5F4FF.9070604@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48436
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2015, Vlastimil Babka wrote:

> On 07/24/2015 11:28 PM, Eric B Munson wrote:
>=20
> ...
>=20
> >Changes from V4:
> >Drop all architectures for new sys call entries except x86[_64] and MIPS
> >Drop munlock2 and munlockall2
> >Make VM_LOCKONFAULT a modifier to VM_LOCKED only to simplify book keeping
> >Adjust tests to match
>=20
> Hi, thanks for considering my suggestions. Well, I do hope there
> were correct as API's are hard and I'm no API expert. But since
> API's are also impossible to change after merging, I'm sorry but
> I'll keep pestering for one last thing. Thanks again for persisting,
> I do believe it's for the good thing!
>=20
> The thing is that I still don't like that one has to call
> mlock2(MLOCK_LOCKED) to get the equivalent of the old mlock(). Why
> is that flag needed? We have two modes of locking now, and v5 no
> longer treats them separately in vma flags. But having two flags
> gives us four possible combinations, so two of them would serve
> nothing but to confuse the programmer IMHO. What will mlock2()
> without flags do? What will mlock2(MLOCK_LOCKED | MLOCK_ONFAULT) do?
> (Note I haven't studied the code yet, as having agreed on the API
> should come first. But I did suggest documenting these things more
> thoroughly too...)
> OK I checked now and both cases above seem to return EINVAL.
>=20
> So about the only point I see in MLOCK_LOCKED flag is parity with
> MAP_LOCKED for mmap(). But as Kirill said (and me before as well)
> MAP_LOCKED is broken anyway so we shouldn't twist the rest just of
> the API to keep the poor thing happier in its misery.
>=20
> Also note that AFAICS you don't have MCL_LOCKED for mlockall() so
> there's no full parity anyway. But please don't fix that by adding
> MCL_LOCKED :)
>=20
> Thanks!


I have an MLOCK_LOCKED flag because I prefer an interface to be
explicit.  The caller of mlock2() will be required to fill in the flags
argument regardless.  I can drop the MLOCK_LOCKED flag with 0 being the
value for LOCKED, but I thought it easier to make clear what was going
on at any call to mlock2().  If user space defines a MLOCK_LOCKED that
happens to be 0, I suppose that would be okay.

We do actually have an MCL_LOCKED, we just call it MCL_CURRENT.  Would
you prefer that I match the name in mlock2() (add MLOCK_CURRENT
instead)?

Finally, on the question of MAP_LOCKONFAULT, do you just dislike
MAP_LOCKED and do not want to see it extended, or is this a NAK on the
set if that patch is included.  I ask because I have to spin a V6 to get
the MLOCK flag declarations right, but I would prefer not to do a V7+.
If this is a NAK with, I can drop that patch and rework the tests to
cover without the mmap flag.  Otherwise I want to keep it, I have an
internal user that would like to see it added.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtjO7AAoJELbVsDOpoOa9TNAQAIfRrQ4rp3LViJe+X+UdnFJ7
BFJUSHiM7IjUdM+WZyf7s+giHKSybtEIuoX5961wGuUvd777r+83I41Lc0XLR94g
kquJMYCL+WkIIqyor2Me6FNMnQwUs8EegFgRcJXcy0j+1zaxgkBRUzeYP30ecd39
ZYdjGfwn2Cyc4vsb/ze/rQ9R24DgQBT8xI4+3XzGwq5ViteaAFuUgY3bZ3gkxgI1
jFMAiyOCUGp0LBPMMTMOQ52o2xsWHAfADfCy9v3xalA7Rl8s8lX0DfirCoTnRj8f
27SMJ/kU/RBSCTemsqp4osDnO6cYATAQUk/00w5B8zwUG//syjb8a139izyS8UhU
arBzKRJR6eZARqtW8IauNTJ6IW8uyp8QNrni7At9hc+rcFgG3+hGt7+H8bugENb8
VSuydDJoris+H4ysj175AK6Xh2gN2cYxiAxzbeIwnwyn+9uL7A0UpFavyaYjUx2K
/M1bFELVo/LzAg0tZBNi+nyboZSmAzMoF2RkTPmEK0+5taWqCmYPke0ST4zKAxsA
z2CpFTxmoKHo8ksPHzQUlTF2KcRl2FlIe2uxUwQ0WAXVqcOJUUo8/OK+knvDPJ7A
S8jXh2XMpEHh0EQTFvUYrQ+ZxT/nkzITFv33zBGhxryq0ve/AYRbSC87H8RBLHrd
dqVY5/pEceCOYg9+DxnG
=1hv9
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
