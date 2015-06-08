Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2015 10:34:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44604 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006602AbbFHIeEtFTwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2015 10:34:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6890841F8E02;
        Mon,  8 Jun 2015 09:33:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 08 Jun 2015 09:33:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 08 Jun 2015 09:33:59 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 91938E1DD7D51;
        Mon,  8 Jun 2015 09:33:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 8 Jun 2015 09:33:59 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 8 Jun
 2015 09:33:58 +0100
Message-ID: <5575536E.8080608@imgtec.com>
Date:   Mon, 8 Jun 2015 09:33:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     stable <stable@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
References: <1431002870-30098-1-git-send-email-hofrat@osadl.org> <554CC530.20906@imgtec.com>
In-Reply-To: <554CC530.20906@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="rib3XQ4j4fb09VQqnP6aG7Rdr8hV955CP"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47900
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

--rib3XQ4j4fb09VQqnP6aG7Rdr8hV955CP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi stable folk,

On 08/05/15 15:16, James Hogan wrote:
> On 07/05/15 13:47, Nicholas Mc Guire wrote:
>> Fix possible unintended sign extension in unsigned MMIO loads by casti=
ng
>> to uint16_t in the case of mmio_needed !=3D 2.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>=20
> Looks good to me. I wrote an MMIO test to reproduce the issue, and this=

> fixes it.
>=20
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Tested-by: James Hogan <james.hogan@imgtec.com>
>=20
> It looks suitable for stable too (3.10+).

This has reached mainline, commit ed9244e6c534612d2b5ae47feab2f55a0d4b4ce=
d

Please could it be added to stable (3.10+).

Thanks
James


>=20
> Cheers
> James
>=20
>> ---
>>
>> Thanks to James Hogan <james.hogan@imgtec.com> for the explaination of=
=20
>> mmio_needed (there is not really any helpful comment in the code on th=
is)
>> in this case (mmio_needed!=3D2) it should be unsigned.
>>
>> Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=3Dm
>>
>> Patch is against 4.1-rc2 (localversion-next is -next-20150506)
>>
>>  arch/mips/kvm/emulate.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
>> index 6230f37..2f0fc60 100644
>> --- a/arch/mips/kvm/emulate.c
>> +++ b/arch/mips/kvm/emulate.c
>> @@ -2415,7 +2415,7 @@ enum emulation_result kvm_mips_complete_mmio_loa=
d(struct kvm_vcpu *vcpu,
>>  		if (vcpu->mmio_needed =3D=3D 2)
>>  			*gpr =3D *(int16_t *) run->mmio.data;
>>  		else
>> -			*gpr =3D *(int16_t *) run->mmio.data;
>> +			*gpr =3D *(uint16_t *)run->mmio.data;
>> =20
>>  		break;
>>  	case 1:
>>
>=20


--rib3XQ4j4fb09VQqnP6aG7Rdr8hV955CP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVdVN2AAoJEGwLaZPeOHZ6aGoQAKjI/LWr2uRUZfgwpbQtV7j9
Wag0W8DuS425L2ScRFkSfsProPASDt688NEJaMiZhZBMDr/u62g/XTUtxllbO2Gi
K29kLf85fRWZSy6f2fYPuon0pIuYDEgzEkUS5oJ8HEHI2FHphgJ3lBbl75ZGvigR
0TXS/IP8HmX+tRyjcQQHB4DGFcQ7bTRXRY74JwrOZc6nH+40drTskNtObSGn1goo
Cb9trlAUvMQH3zhV5TbFzGiWDZBuhxo7WSCPZHPpQ77qUqOP35DjmQESAXOlDQ9U
jHOovF2p+2D046JHiGwqC8FlaQAvN76/SKJdzYOiHpozTBQXkc8ilvXwTGu7czbU
odUGFL6+mC2UjO/1nEV+qAkakBtm7ZqdqPaqZnwPsojFrt7XAOLVWPGd0BmYZCsB
z4KPogC8jp/HNc5LqpTt25cYSOguKwvLKJ4TQYY+y187DmobrXnWVj6b6oQnUAeI
2RYw9C5WRsfsaea9Ov1m0adKsopYrGe2Z7ts2xIDIrte0hVBMIvl4XyxJriNsKPd
HsmxRpSpDZUnDFjMDV4sh4PJ1+LWjiISbCBxho1LXwOel0k/I6fWYYqaU83SyVlp
26Uy6/KgaSfbWFM2/rBTBc9QiZALV+/tLRMsZuiVCHkSb0RRh8RsTH6M+gXuKdj+
+gKCfXJSF/BBV2RcOwvQ
=KsSU
-----END PGP SIGNATURE-----

--rib3XQ4j4fb09VQqnP6aG7Rdr8hV955CP--
