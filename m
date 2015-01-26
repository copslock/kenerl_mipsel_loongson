Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 13:04:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46584 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011431AbbAZMD4nsVcx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 13:03:56 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6FDFD41F8D91;
        Mon, 26 Jan 2015 12:03:51 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 26 Jan 2015 12:03:51 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 26 Jan 2015 12:03:51 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FDBFC3C39CD7;
        Mon, 26 Jan 2015 12:03:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 12:03:51 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 26 Jan
 2015 12:03:50 +0000
Message-ID: <54C62D26.80907@imgtec.com>
Date:   Mon, 26 Jan 2015 12:03:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
CC:     <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] MIPS: HTW: Prevent accidental HTW start due to nested
 htw_{start,stop}
References: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com> <1422265236-29290-3-git-send-email-markos.chandras@imgtec.com> <54C626CC.2070104@imgtec.com> <54C62941.6060604@imgtec.com>
In-Reply-To: <54C62941.6060604@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Jt7gEVxwkSQUx4S35WPSWRjALHGLAfKGK"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45481
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

--Jt7gEVxwkSQUx4S35WPSWRjALHGLAfKGK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/01/15 11:47, Markos Chandras wrote:
> On 01/26/2015 11:36 AM, James Hogan wrote:
>=20
>>
>>> +		raw_current_cpu_data.htw_seq++;				\
>>
>> not "if (!raw_current_cpu_data.htw_seq++)) {"?
> Why?
>=20
> on _stop() calls you just increment it. The _start() will do the right
> thing then.
>=20
> I think what you suggest it to move the if() condition from the _start(=
)
> to _stop().

I just mean you only need to disable htw the first time its called. I
guess the extra branch every time could be worse than the extra disable
and ehb when nesting does occur, so its probably premature optimisation.

Up to you.

Cheers
James


--Jt7gEVxwkSQUx4S35WPSWRjALHGLAfKGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUxi0mAAoJEGwLaZPeOHZ6LikP/2VfrnBHGTDfCK3TABp//uoT
ba3T/RY6CAQqouGGHRoQVlZ86RZhQQ8i/dmI8zlJDNQS/CbX9HybNK0DCM51i1XQ
KnEZZjQiICRdc50Do8fb0m+nTd68AXfvMRkGutQCiaDPS3p2K1EHPGBmUA7Edk3o
64uqtzoNS8fSlH9wcRW4sUj9a1DsFroJQMuK/O9Ecch4s6mDfVz7/PP9xol+p8sG
V3TJ19r684efT057dxRtiX/k4b00zAvZ10v6+tDWJap+2rTyJPYHmWP3juYyDfnw
xagu28RvKTWrwpJgkY3cRhIXI5ZjaBQMymxmAaXQ/asv9UrjXQiXfd6JB8VTb8eH
Zsx4YbGVBayd0K6gCdJnVAaoziRX2Z2tdRiy0Y/yGHaYZjYw7UiibMmg1l1hcrsZ
zQUQ8M6KqwiH5sO4v9fz7RrnPdigskoQKY/OSgGhTaLARHXy4qxHoSnILJVaqUb3
X7+U8fRor6WJL0GNeXkV41U8oEHaSM+LHgqaHQXrmY7uGGv6duFtNFEHP2ojKM2O
cpYspgCS0wh711BnuFEqLnYUmwaQMdDbMVY6xBEK4/dwc3jSrMM9YIovEsVbWssE
Sous417YfJIB6kFGwpzJe9Mz4ofvoBKi4riInqOS9SuAWaEQDaK9kgqTpDb9AWBp
lKU673ETaQI1y1LAhaza
=DU8u
-----END PGP SIGNATURE-----

--Jt7gEVxwkSQUx4S35WPSWRjALHGLAfKGK--
