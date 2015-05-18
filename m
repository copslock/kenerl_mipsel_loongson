Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 15:30:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7258 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012313AbbERNaqYgYjX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 15:30:46 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 44E0541F8DF6;
        Mon, 18 May 2015 14:30:43 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 18 May 2015 14:30:43 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 18 May 2015 14:30:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 48FBCC05A666F;
        Mon, 18 May 2015 14:30:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 May 2015 14:30:43 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 18 May
 2015 14:30:42 +0100
Message-ID: <5559E982.2050704@imgtec.com>
Date:   Mon, 18 May 2015 14:30:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/9] MIPS: hazards: Add hazard macros for tlb read
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com> <1431514255-3030-3-git-send-email-james.hogan@imgtec.com> <20150515150845.GB2322@linux-mips.org>
In-Reply-To: <20150515150845.GB2322@linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="SoKc9jJ11Fg9351g69E1Ur8C0JcqCIA7c"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47458
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

--SoKc9jJ11Fg9351g69E1Ur8C0JcqCIA7c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On 15/05/15 16:08, Ralf Baechle wrote:
> On Wed, May 13, 2015 at 11:50:48AM +0100, James Hogan wrote:
>=20
>> Add hazard macros to <asm/hazards.h> for the following hazards around
>> tlbr (TLB read) instructions, which are used in TLB dumping code and
>> some KVM TLB management code:
>>
>> - mtc0_tlbr_hazard
>>   Between mtc0 (Index) and tlbr. This is copied from mtc0_tlbw_hazard =
in
>>   all cases on the assumption that tlbr always has similar data user
>>   timings to tlbw.
>>
>> - tlb_read_hazard
>>   Between tlbr and mfc0 (various TLB registers). This is copied from
>>   tlbw_use_hazard in all cases on the assumption that tlbr has similar=

>>   data writer characteristics to tlbw, and mfc0 has similar data user
>>   characteristics to loads and stores.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>> Looking at r4000 manual, its tlbr had similar data user timings to tlb=
w,
>> and mfc0 had similar data writer timings to loads and stores. Are ther=
e
>> particular other cores that should be checked too?
>=20
> The R4600 and R5000 CPUs are important.  The R4600 also covers the
> R4700 and the R5000 the R52xx embedded cores.
>=20
> For most cases the R4000/R4400 due to their long pipeline represent the=

> worst case but there are exceptions.

Okay. For mtc0-tlbw/tlbr on r4000:
mtc0	CPR written stage 7
tlbwi/r	CPR read stage 5-8 (5-7 for tlbr)
delay =3D 7-5-1 =3D 1 nop
but linux has 2 nops for __mtc0_tlbw_hazard. Is that one of the exception=
s?

(
For r4600, mtc0-tlbw/tlbr =3D 4-2-1 =3D 1 nop too

For tlbr-mfc0, r4000:
tlbr	CPR written stage 8
mfc0	CPR read state 4
delay =3D 8-4-1 =3D 3 nops (that's what I have)

r4600:
tlbr	CPR written stage 4
mfc0	CPR read stage 2
delay =3D 4-2-1 =3D 1 nop
)

Cheers
James


--SoKc9jJ11Fg9351g69E1Ur8C0JcqCIA7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVWemCAAoJEGwLaZPeOHZ6AuIP/2eHjK8v50JU+opbGKZU4FMS
T6IoBU8OqOl1U1YPsyHFbZNNkotdImB5JR2TKyuA8dRFM/1irzeV1YDWRL9doi6L
Rg3z7mRKEU2ylPLyATfjmPBHMQjoXWiWBFHJb9umi5ejWQJf27XILWOVjnWyog4x
q3nRPWFBAFa75UnmMDbs7LAhiZKvJ+CUDoZJBVrtzWmeWPFPKx1dsfBXj9ku8x57
BZdYiWrKaE0oUVDebDp3BBtBrROgXDbZ9hcf0qpU34jr+emC0iGEx/kbV9P8EIsU
C2IQM77BwHrcBbY0EQvp5U7iGpjE/jMmSJHcN7X0TdP5WWeGK2frWqnq9puEykVe
B/Uso3FXvHdLnyppaaN5OeTrPbXOt3Yk+6zxNBDkh3NKofFsUjPXgLzWf6X/Zbf3
oy4rb6WTUVAWD2ssgtGmS7uTodxfQZPyY8gb350ZAxvuAScOx4v64dWpC/qff2+t
nD+yy3Xp/KsFHm0NhPjTxZhdtBuUrRjls8Hn9n1O3FKNZQt33ddQLTuaw45rq8MT
ppEUA05eVdtX31ZkuqiJJgMGJUdHrcvbOqbaBfAw9qPr8CnQtraZKSQM3SGtQ/Hq
Xc8l9R8YONcVLbsfnzCq36JGhaQd1kMWrZ+LBKa6oovoVNAf+QzxpChdUbjKKc8J
0A+nYbPuZ+kVAv2WIoGD
=mxAQ
-----END PGP SIGNATURE-----

--SoKc9jJ11Fg9351g69E1Ur8C0JcqCIA7c--
