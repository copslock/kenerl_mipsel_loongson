Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:28:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8090 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012693AbbHFQ2wHnmpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:28:52 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BFF4C41F8E13;
        Thu,  6 Aug 2015 17:28:46 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Aug 2015 17:28:46 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Aug 2015 17:28:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F21EF8B39FF4;
        Thu,  6 Aug 2015 17:28:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 6 Aug 2015 17:28:46 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 6 Aug
 2015 17:28:45 +0100
Subject: Re: [PATCH 0/7] test_user_copy improvements
To:     Kees Cook <keescook@chromium.org>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
 <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   James Hogan <james.hogan@imgtec.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <55C38B30.5030405@imgtec.com>
Date:   Thu, 6 Aug 2015 17:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48690
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

--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On 05/08/15 21:26, Kees Cook wrote:
> On Wed, Aug 5, 2015 at 8:48 AM, James Hogan <james.hogan@imgtec.com> wr=
ote:
>> These patches extend the test_user_copy test module to handle lots mor=
e
>> cases of user accessors which architectures can override separately, a=
nd
>> in particular those which are important for checking the MIPS Enhanced=

>> Virtual Addressing (EVA) implementations, which need to handle
>> overlapping user and kernel address spaces, with special instructions
>> for accessing user address space from kernel mode.
>>
>> - Checking that kernel pointers are accepted when user address limit i=
s
>>   set to KERNEL_DS, as done by the kernel when it internally invokes
>>   system calls with kernel pointers.
>> - Checking of the unchecked accessors (which don't call access_ok()).
>>   Some of the tests are special cased for EVA at the moment which has
>>   stricter hardware guarantees for bad user accesses than other
>>   configurations.
>> - Checking of other sets of user accessors, including the inatomic use=
r
>>   copies, copy_in_user, clear_user, the user string accessors, and the=

>>   user checksum functions, all of which need special handling in arch
>>   code with EVA.
>>
>> Tested on MIPS with and without EVA, and on x86_64.
>>
>> James Hogan (7):
>>   test_user_copy: Check legit kernel accesses
>>   test_user_copy: Check unchecked accessors
>>   test_user_copy: Check __clear_user()/clear_user()
>>   test_user_copy: Check __copy_in_user()/copy_in_user()
>>   test_user_copy: Check __copy_{to,from}_user_inatomic()
>>   test_user_copy: Check user string accessors
>>   test_user_copy: Check user checksum functions
>>
>>  lib/test_user_copy.c | 221 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 221 insertions(+)
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>=20
> Ooooh! Nice! This is great, thank you. :) Great to hear it helped find
> a bug too. :)
>=20
> I'm wondering if we need to macro-ize any of these. Probably not, but
> it just feels like there's a lot of repeated stuff now. But I think
> it's a bit of an illusion since each test is ever so slightly
> different from the others.

Yeh, I wondered that too, but I agree they're all slightly different in
their requirements so it'd just end up confusing things.

>=20
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

James


--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVw4sxAAoJEGwLaZPeOHZ60TYQALZHVpKGUHKd/ATy5gxfqq8+
DM12XcxjOhP2Adzl8StQ+sF6TSHf5K9fyqul5NLrj5k4Vk9mnITcxJ4BVNTpTurh
cIuvcrcdunDYOH30mlAAnl2XYULl96Oi94gu0PbMLGNgdTugqJ9s5xP4i2zAKJKv
GzqzkHnLvrphtZ3FKP4ZF0XXjWmsBBnzBSWcDlgRDfdkx1MiSIBBGUA3yjja39AH
YM1Zjuo5Dn7A1ABi+fECvofM7C12T1nQiaaxNUwpkYnUZW1S8HS4TVqb+EgAlzL2
jEZEzo3KzuiKaIqF9IELkEOtMYne/Of6IIXtSDoPiiDaJblBfFU+WtzorV7dttMk
6h4037fnEPBJHmDHy8hyltmzeMcJFQDSwpIkIgbdahMHPEtXNZbncvD5TaojAixP
E6KCBsazjUguCGm4sPk3hhTPZTwS5rsK1sA72Zn38J3FHwzoJLYYf9wYih9w162P
0UImDGAYS/1LIiWIl4aPEjQ1xITlw/IqY7Up8y8Z5LLO0GjXfja8iHr62BpfKAM1
LqP0N9D+g6S6T5b4vImPHM4lrPh1k9pNVX4IHFjm7bNHMc5BJLaOQvVo06JT4rMv
hHHnSl6hlzX3EfSXrh2HfSnej01OXur0nOKcNPJSfxMx/pIJs1MejpqfsSx0MgiC
D6szhs9/VIhNSzWidoeE
=OHbs
-----END PGP SIGNATURE-----

--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O--
