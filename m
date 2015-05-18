Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 15:50:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44130 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012839AbbERNuLhS6Uj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 15:50:11 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9E8A541F8DF6;
        Mon, 18 May 2015 14:50:08 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 18 May 2015 14:50:08 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 18 May 2015 14:50:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 924722352C74D;
        Mon, 18 May 2015 14:50:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 May 2015 14:50:08 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 18 May
 2015 14:50:07 +0100
Message-ID: <5559EE0E.5030606@imgtec.com>
Date:   Mon, 18 May 2015 14:50:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/9] MIPS: dump_tlb: Take global bit into account
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com> <1431514255-3030-6-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505160137150.4923@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1505160137150.4923@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="69RVe8c9NgQRHoLkoIkKgiRuxinoiDEBR"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47460
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

--69RVe8c9NgQRHoLkoIkKgiRuxinoiDEBR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On 16/05/15 01:44, Maciej W. Rozycki wrote:
> On Wed, 13 May 2015, James Hogan wrote:
>=20
>> The TLB only matches the ASID when the global bit isn't set, so
>> dump_tlb() shouldn't really be skipping global entries just because th=
e
>> ASID doesn't match. Fix the condition to read the TLB entry's global b=
it
>> from EntryLo0. Note that after a TLB read the global bits in both
>> EntryLo registers reflect the same global bit in the TLB entry.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>>  arch/mips/lib/dump_tlb.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
>> index 17d05caa776d..70e0a6bdb322 100644
>> --- a/arch/mips/lib/dump_tlb.c
>> +++ b/arch/mips/lib/dump_tlb.c
>> @@ -73,7 +73,8 @@ static void dump_tlb(int first, int last)
>>  		 */
>>  		if ((entryhi & ~0x1ffffUL) =3D=3D CKSEG0)
>>  			continue;
>> -		if ((entryhi & 0xff) !=3D asid)
>> +		/* ASID takes effect in absense of global bit */
>=20
>  Typo here, s/absense/absence/.

Thanks!

>=20
>> +		if (!(entrylo0 & 1) && (entryhi & 0xff) !=3D asid)
>=20
>  Hmm, it looks like r3k_dump_tlb.c will need a similar update.  I sugge=
st=20

Yes, quite possibly. Would you be happy to test such a patch (assuming
you have r3000 hardware available)? Patch 1 should allow the code to be
easily triggered.

> using _PAGE_GLOBAL and ASID_MASK rather than hardcoded 1 and 0xff.

Yeh, as you mentioned these describe the PTE rather than what goes in
EntryLo. Perhaps it makes sense to have a few more TLB dependent
definitions in mipsregs.h (patch 7 already adds a couple for RI/XI bits).=


Cheers
James


--69RVe8c9NgQRHoLkoIkKgiRuxinoiDEBR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVWe4PAAoJEGwLaZPeOHZ6lSgQAItjkrBFcStqw4DqbXjC16eT
YbkL7GG/C5Y9ofEpqj0PZYQ9lOqv3877AUdgaFWiYA62ZcDLg9L0ARvbsNJXmn6G
AZ2My1bOdz53AE2rGQKHTPD8gwV7w4dCMcworGJYkpnKE5TVKSSfD0vBBnwErEVX
zMAPbSBy3iBCk8wt8FOO/W9agLlSkvhI8ftnpkDVCZm7Jd0bC+5ASdKiVFZsImGS
+PpYbd8FPy/uDTftrBzVoodKwZew3AT69eqmmwuwPpsxmTe9jwzDvhFXa5UuitGE
FqelPokX6Nv6eE+dNPPBVEqzeb/tUv+kL9WprfHHGfrVSNrNzWo+sfLCPQ2TlGxB
eYmuccrdy1lLJJfVdsPXLgkUdZ3VxegOFvN4QkbofIym4QP+2cmy7vuPwHCQmx2D
UtTFIrQbZ07nkUa+0OvpdSchmyhYqmWq486pEjrDscojttHUe+OAHt36e8hW6uUp
G4P22LOD6jWCbwkrYRcKEcJfHV10GK3LlH5jnDbxNyLaGt6MtWZrduvjQGwMplcB
KlcrFnHBdb28pTVSSa4zQhlx/MLxbMdhM8YrH0qKa1gM5g8ZybKr8WDzH7MvOlRm
kgHJCLDcOKhU6tdN5ifKRvhoCjofR376ldgwi7JrwwqmTk7rRDtNevGHr+VNmvWX
J3xlfKQTRmolxKIKIeTg
=W1K9
-----END PGP SIGNATURE-----

--69RVe8c9NgQRHoLkoIkKgiRuxinoiDEBR--
