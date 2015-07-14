Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 11:27:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36559 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009552AbbGNJ13WnG82 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 11:27:29 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CCB2741F8E15;
        Tue, 14 Jul 2015 10:27:23 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Jul 2015 10:27:23 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Jul 2015 10:27:23 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 75A7B4D119A3D;
        Tue, 14 Jul 2015 10:27:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 10:27:23 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 10:27:23 +0100
Message-ID: <55A4D601.8070604@imgtec.com>
Date:   Tue, 14 Jul 2015 10:27:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 01/10] MIPS: Add SysRq operation to dump TLBs on
 all CPUs
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-2-git-send-email-james.hogan@imgtec.com> <556240DE.1050003@gentoo.org> <alpine.LFD.2.11.1505261230020.11225@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1505261230020.11225@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="KpIeTahnMb4rGQaFf1IHBuXd0Uvbfhgsa"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48265
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

--KpIeTahnMb4rGQaFf1IHBuXd0Uvbfhgsa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/05/15 12:58, Maciej W. Rozycki wrote:
> On Sun, 24 May 2015, Joshua Kinard wrote:
>=20
>>> Add a MIPS specific SysRq operation to dump the TLB entries on all CP=
Us,
>>> using the 'x' trigger key.
>>
>> Thought: Would it make sense to split apart the data such that one Sys=
Rq key
>> dumps the CP0 registers of all CPUs, and another dumps the TLB info?
>=20
>  That would be a large separate project, probing a CPU for its implemen=
ted=20
> CP0 registers is a complex matter.
>=20
>  I did it for GDB and a bare-iron debug stub a few years ago and back t=
hen=20
> there were IIRC 53 register subsets already defined for MIPS architectu=
re=20
> processors, wired to various, sometimes overlapping feature bits of CP0=
=20
> Config registers, and now there are more.  Plus legacy processors requi=
re=20
> fixed register maps according to CP0.PRId.
>=20
>  James, I think what you proposed is good enough for TLB diagnostics (I=
'm=20
> not sure if dumping EntryLo0 and EntryLo1 registers has any use, but it=
=20
> surely does not hurt either).
>=20
>>> +	pr_info("CPU%d:\n", smp_processor_id());
>>> +	pr_info("Index	: %0x\n", read_c0_index());
>>> +	pr_info("Pagemask: %0x\n", read_c0_pagemask());
>>> +	pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
>>> +	pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
>>> +	pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
>>> +	pr_info("Wired   : %0x\n", read_c0_wired());
>>> +	pr_info("Pagegrain: %0x\n", read_c0_pagegrain());
>=20
>  Please capitalise these consistently: PageMask and PageGrain.
>=20
>> The older CPUs, like the R10000 don't have a PageGrain register I beli=
eve (at
>> least R10K doesn't),  Does that need to be stuffed behind a conditiona=
l?  Also,
>> R10K (and newer?) CPUs have a FrameMask CP0 register ($21).  Linux cur=
rently
>> scribbles a 0 to the writable bits, though, so I'm not sure if it matt=
ers.
>=20
>  First of all I suggest that this part is split off into separate small=
=20
> helper functions within dump_tlb.c and r3k_dump_tlb.c.  This code is no=
t=20
> performance-critical, so the overhead of an extra function call isn't o=
f=20
> a concern.
>=20
>  Then R3k processors have Index, EntryHi and EntryLo (rather than=20
> EntryLo0) registers only; some Toshiba processors have Wired too (cf.=20
> `r3k_have_wired_reg').
>=20
>  And for the R4k-style TLB the PageGrain register does need to be probe=
d=20
> for.  I think including FrameMask would be good too, that shouldn't be =

> difficult (switch on `current_cpu_type'?).

Thanks for all the feedback Joshua and Maciej, and sorry for the delay
getting back to this. I think I've addressed it all now, so I'll submit
a second patchset soon.

Cheers
James


--KpIeTahnMb4rGQaFf1IHBuXd0Uvbfhgsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVpNYBAAoJEGwLaZPeOHZ6apEQAIHr5cGU76LoveFSca3a7ZNY
telAN45YcfOV3paKMLM9I2kpsQLu8FUEjQT3ML4N0ocGFoFu8nBF97RbQ2WMWSID
VHJ6/FNdLQyOunfsCSydcrdiiD3oobtU8LzCuZIzwARzg+abYfl3/VJLjsjn3Um4
yD97PrdhN1+DhEWg1ztSC9kjars6CMQrFkt41wBr28W0hWH74atBWQ4zI/4wZU0D
/9VIxT30bhBeec32Qsaqvcbwotksm+Wq/+LD9fhM+UtOA6EJWH7LficpODu8hnpg
Ymts011JuczGLNH659pELi8Onney1rhn2BD4xvmwAoageLcaEXdIosmX4sSURQrZ
xyXvV2fyCGSaSo3WdY91yRhR13/yX2mKpTSsrGGyyX6cg4HK7uCbfc8plIXkFdwZ
Ccg3QgUUj7SS5xcSoRbBk+vdrfh0FGYUCNheBypdgi5hCsOTZZ9nmqBA9wMLX9GQ
oHh/Pr5ADUFTTCKVeepBZNzWA4+iEDa1EN8B7KL1zdONePuJV8xCG79IBzWe/bfC
tgkIZlXOzclxSgm8POVAZVoCWJHWT0Azj8v+YU2OIMi3xNETdfJJeJrtkHfciaRq
2VGqorfoHY15WgRnsHUcoRb7ucuZ3rpnR5QzamdwSqAQXjIvq2TmQxeiePow3jvF
DzaeLhNk65BDgeezftyU
=58zu
-----END PGP SIGNATURE-----

--KpIeTahnMb4rGQaFf1IHBuXd0Uvbfhgsa--
