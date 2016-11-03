Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2016 12:50:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24913 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993022AbcKCLuZXIY4h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Nov 2016 12:50:25 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D7F3841F8DB3;
        Thu,  3 Nov 2016 11:49:22 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 03 Nov 2016 11:49:22 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 03 Nov 2016 11:49:22 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B95AE189FB3BC;
        Thu,  3 Nov 2016 11:50:16 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.188) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 3 Nov
 2016 11:50:18 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: v4.9 fixes
Date:   Thu, 3 Nov 2016 11:50:12 +0000
Message-ID: <1659598.SFC0DQAQ01@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1863454.LZTIZr7UgM";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.188]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55659
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

--nextPart1863454.LZTIZr7UgM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Ralf,

Any update on getting fixes for the v4.9 cycle merged? I'm getting worried now 
that nothing's been accepted in patchwork & no fixes are present in either 
your upstream-linus or upstream-sfr repositories, even though there have been 
a good number of fixes pending since well before -rc2.

Given that we're closing in on -rc4 & you're on holiday from then until ~-rc6 
it would be fantastic if we could get these fixes in ASAP, and preferrably to 
have some other means of getting any necessary patches into mainline whilst 
you're away. I'd be happy to help any way I can, but really really don't want 
v4.9 to be a broken release for MIPS - especially given that it'll be LTS.

To quote part of the email I sent you on the 24th:

> There are a few fixes it would be great to get in ASAP. This one fixes a
> break in the generic kernel build:
>
> https://patchwork.linux-mips.org/patch/14401/
>
> And these 2 fix rebooting malta:
>
> https://patchwork.linux-mips.org/patch/14395/
> https://patchwork.linux-mips.org/patch/14396/
>
> These 2 from Matt would be great to get in too, allowing KASLR to work with
> the generic kernels whilst it currently faults:
>
> https://patchwork.linux-mips.org/patch/14414/
> https://patchwork.linux-mips.org/patch/14415/
>
> And this one from Matt fixes an issue with the alchemy build:
>
> https://patchwork.linux-mips.org/patch/14405/
>
> There's also a bunch of patches fixing up printk output since lack of
> continuation markers has started triggering unwanted newlines in 4.9:
>
> https://patchwork.linux-mips.org/patch/14429/
> https://patchwork.linux-mips.org/patch/14430/
> https://patchwork.linux-mips.org/patch/14431/
> https://patchwork.linux-mips.org/patch/14432/
> https://patchwork.linux-mips.org/patch/14444/
>
> They should all be really low risk, so it'd be great if we could get them in
> for -rc3. Peter mentioned you're away for a couple of weeks soon too, is
> there any plan in place for any patches that might be needed in that time?
> I'd be happy to help out. Are you going anywhere nice?

(...and there are more fixes that have been submitted since then, a number of 
which seem like they'd be good v4.9 material.)

Thanks,
    Paul
--nextPart1863454.LZTIZr7UgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGyR0AAoJEIIg2fppPBxlItwQALJI701TxFNigyWGQdJG3h+V
uZkBQn6q03/K4eLX8WyqFU6t50WJ08bSMeZy/mJIdzhOcypimotdSBgHlZoX5FRy
5823c2nVnapGda/V/Bgh/E5Sq/gFJ4WUSQSSnbgGN5pBW2Xmf+VhFioR7vb8fnOf
xYYz7LBQVsRqfSHpK+d5XwNf+98Bbamc+oSJR3yqMDU+fkAITXIvLtkQiR2LqP/j
golbbC+h6aFNKQkxv8tQt88r7LPYg4Sj2dFWwNcFL9kuo3Vi0m9WnfR4SNtj+w4x
mbxX0EC0uZRzEh7/FCCh8WRutULH9wbIxlvKoXmTcATdbT4HnKIUHUAD/7Gk42cQ
IEnvj97G1T9NO0/T8mtFdM1UeqjQl0ScgyzNUL9kw2i6gGP0zEaWgUk0zpmseIIO
0U2LUlhM7Ur7wM9dE32y00FsvVE6yPaPkKUxv0nQQIrIT1rpkOMLo2ZGTkoiIpEZ
mUaefn6P+w7UbqcPQJOii24iBVqDxGMXgOhTMSjquzEDtZ9EAjubfXwV6yGPxg6C
QWJcTwx1aydyAfiuN/eFRFDEATWIehis7CM6P+Lb5uFPxzb0gXz3CniT4wXQfDWk
lSI3+n+wTjVySJOjHXq7QgjJBf6BAjRUKvyOqdWtNNHvJoS0bv4xEnVLc0nsP6Yu
ejuZYKZ71NlDASFZ2whU
=6/kO
-----END PGP SIGNATURE-----

--nextPart1863454.LZTIZr7UgM--
