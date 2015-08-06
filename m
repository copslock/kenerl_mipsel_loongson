Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 17:02:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6767 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012609AbbHFPCa3cIm8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 17:02:30 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CD0FD41F8E13;
        Thu,  6 Aug 2015 16:02:24 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Aug 2015 16:02:24 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Aug 2015 16:02:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DC01BAB500817;
        Thu,  6 Aug 2015 16:02:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 6 Aug 2015 16:02:24 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 6 Aug
 2015 16:02:23 +0100
Subject: Re: [PATCH 0/7] test_user_copy improvements
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Kees Cook <keescook@chromium.org>
From:   James Hogan <james.hogan@imgtec.com>
Message-ID: <55C376F3.4070907@imgtec.com>
Date:   Thu, 6 Aug 2015 16:02:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="jVbHoIG19HtkTtAts8n4SM5ltNSdaPnEj"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--jVbHoIG19HtkTtAts8n4SM5ltNSdaPnEj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 05/08/15 16:48, James Hogan wrote:
> These patches extend the test_user_copy test module to handle lots more=

> cases of user accessors which architectures can override separately, an=
d
> in particular those which are important for checking the MIPS Enhanced
> Virtual Addressing (EVA) implementations, which need to handle
> overlapping user and kernel address spaces, with special instructions
> for accessing user address space from kernel mode.
>=20
> - Checking that kernel pointers are accepted when user address limit is=

>   set to KERNEL_DS, as done by the kernel when it internally invokes
>   system calls with kernel pointers.
> - Checking of the unchecked accessors (which don't call access_ok()).
>   Some of the tests are special cased for EVA at the moment which has
>   stricter hardware guarantees for bad user accesses than other
>   configurations.
> - Checking of other sets of user accessors, including the inatomic user=

>   copies, copy_in_user, clear_user, the user string accessors, and the
>   user checksum functions, all of which need special handling in arch
>   code with EVA.
>=20
> Tested on MIPS with and without EVA, and on x86_64.

Could you drop these patches for -mm for the moment please. I'll get a
v2 to fix the build problems out tomorrow now.

Cheers
James

>=20
> James Hogan (7):
>   test_user_copy: Check legit kernel accesses
>   test_user_copy: Check unchecked accessors
>   test_user_copy: Check __clear_user()/clear_user()
>   test_user_copy: Check __copy_in_user()/copy_in_user()
>   test_user_copy: Check __copy_{to,from}_user_inatomic()
>   test_user_copy: Check user string accessors
>   test_user_copy: Check user checksum functions
>=20
>  lib/test_user_copy.c | 221 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 221 insertions(+)
>=20
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>=20


--jVbHoIG19HtkTtAts8n4SM5ltNSdaPnEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVw3bzAAoJEGwLaZPeOHZ6eR8P/jQMVAymZRXZWsXolh06E3SX
fcT96OEuBjA/cHI7SLdTHKo7bhcrjqFLA6fC6jsV/5gMObYC2juEtnXBnObuxEKF
RBZeihDYmhvYJAlf/l14PtVfcSwlFTmWSJdOsEQMwQqMAtn4gxY9Hmta8IkSXhaF
RKc/DIdCTfkh2bUNJpxEPTLGhoKM5b1SodEkH9nScuAeZngx/Ge+LT+XIvZ+TU+d
/9vUVWN4cT6nLcF7d+4SbaCXOL64Xbs+RVCPwGpIy/Joj55C6XZjAb/86feuL+CZ
6egBQDhr/8NgQWl9p/YyUHSHKyapZj5SUjCgoI3CHuVr1pdXvvRxjq84i/nqvlvq
0/cHxOYM7Z64qa7oan4NvlUNvGJndbfJ0B08xf5WW76EQIUPHD+ikqCaHZrdaFQV
qsiknKHGjNhdJ+LPqAcvnqa7vVRp0yTinFYdiABZyyMkXELqMVD8ysEH9sCSJEFV
EvFwJB7piWsBv5bnEy6Tl2zl5IdNJWG/cCSa3tCHe0dEb8IDFeVM+NyuqOeYvusV
YiWmSOICgWpAyAzyQWlTieX6z01uLPwUczlweM8TwSyLUPtFt0cw01oQG9FLVUL2
yG+k32gvnYP42tLLoUUQKOTuxchkXfOfnfWOD+8XAYUncpjjikqhSW0SzqGwJ1jn
mwRMtK4GnD184uvwhsXt
=XQs+
-----END PGP SIGNATURE-----

--jVbHoIG19HtkTtAts8n4SM5ltNSdaPnEj--
