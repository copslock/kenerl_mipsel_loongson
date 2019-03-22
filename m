Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01DC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A5421902
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 00:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="NnuumdKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfCVAAs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:00:48 -0400
Received: from mail-eopbgr710130.outbound.protection.outlook.com ([40.107.71.130]:2334
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfCVAAs (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 21 Mar 2019 20:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfwk6hMP/WUiBQ12WQh+LE0i2VmZHpTy1BCAQx+THHc=;
 b=NnuumdKncH+3XopGL8MX2vzmCOrFbr7Wx6w7kZEH09zd1ToHGfvM8G6WY8kaJMUD4mCH6dF/EUgsV9/XTx1enUDx9Sl7tZHbqhqcxcXd1cYWw5aotHu5e0S/C4djyPn+HaBTrRKAk9GprxYgXnDC0/j0RLULhJyh6xHw+ptrOl4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1471.namprd22.prod.outlook.com (10.174.170.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 00:00:45 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 00:00:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     George Spelvin <lkml@sdf.org>
CC:     "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] arch/mips/kvm/emulate.c: Don't waste /dev/random
 emulating TLBWR
Thread-Topic: [PATCH] arch/mips/kvm/emulate.c: Don't waste /dev/random
 emulating TLBWR
Thread-Index: AQHU36v0QUkII+7gSEaAupI0L3eDY6YWxT8A
Date:   Fri, 22 Mar 2019 00:00:45 +0000
Message-ID: <20190322000043.krzxo7coqibbxi6c@pburton-laptop>
References: <201903210604.x2L64Ord018045@sdf.org>
In-Reply-To: <201903210604.x2L64Ord018045@sdf.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4a48fc-9fb4-4128-2c4e-08d6ae596e87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1471;
x-ms-traffictypediagnostic: MWHPR2201MB1471:
x-microsoft-antispam-prvs: <MWHPR2201MB1471EDBF9AA5E768428B480BC1430@MWHPR2201MB1471.namprd22.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(366004)(396003)(376002)(136003)(346002)(51914003)(199004)(189003)(53936002)(6486002)(7736002)(99286004)(8936002)(6512007)(8676002)(54906003)(316002)(9686003)(81166006)(58126008)(33716001)(81156014)(5660300002)(2906002)(305945005)(3846002)(6116002)(66066001)(229853002)(6916009)(105586002)(97736004)(106356001)(476003)(11346002)(6436002)(478600001)(4326008)(42882007)(186003)(44832011)(446003)(71190400001)(1076003)(6246003)(14444005)(68736007)(52116002)(486006)(256004)(386003)(6506007)(76176011)(71200400001)(102836004)(25786009)(6346003)(14454004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1471;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lhcqDsDhrFqH6ID80iE2Z7u07LcxGjh/E2UU08SSxQovkVQ7kDhN29xLYsJYwO+G+hnSkb+jCD9K83gFhuiTZja+uYnoglIH9cea/pFVflA2KwOKbV9metcNY834WwC7+kP96gkzZ8I29b4/LKzysARyyTZ3wXCV1gJvWkesCMFOYM6Sw2rbRWb5BZiMtuXbmhyG5kxeAWc6Cxv5o2Qc4WvKoyxDZH4HIEzWdr3YnfmUClmtPeiQ2cJ3B8VXxUBASVkHt/psoP/ni5BawYes7GGMWYVsJi+gQEfbcwSNyChp/hRd6pkaUQPdhiVUd1+XcMFdcl5rgf6Ei+1ywwlgKAQjxt0s82KN8XDxYvS4ZwKqFNjPuNuwDytmNgtqWwDPCoVMBT0b9wAP1nEkPSNUjlNyOcIZkTpVnFyYXtheQGs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <282A703B60DB9C4F90F7F6073E332300@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4a48fc-9fb4-4128-2c4e-08d6ae596e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 00:00:45.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1471
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi George,

On Thu, Mar 21, 2019 at 06:04:24AM +0000, George Spelvin wrote:
> KVM_MIPS_GUEST_TLB_SIZE is 64, so we only need one random byte,
> not 4.
>=20
> A more complex question is whether we need crypto-grade random
> numbers at all.  If safe, we could use prandom_u32().  If not,
> we could seed a private PRNG and use prandom_u32_state().
>=20
> Or could we just use asm("mfc0 %0, Random" : "=3Dr" (index))?
>=20
> Signed-off-by: George Spelvin <lkml@sdf.org>
> ---
> I ran across this whie doing some other cleanups, and thought
> I'd pass it on.
>=20
> get_random_bytes() is quite an expensive function call.
> Is it needed at all?

Thanks for the patch. I expect we should be fine with:

  index =3D prandom_u32_max(KVM_MIPS_GUEST_TLB_SIZE);

We certainly don't need crypto-grade randomness here. Using the cp0
Random register would be an option for configurations prior to MIPSr6,
where the Random register was deprecated & we shouldn't rely on its
presence. So we could do:

  if (MIPS_ISA_REV < 6)
    index =3D read_c0_random() % KVM_MIPS_GUEST_TLB_SIZE;
  else
    index =3D prandom_u32_max(KVM_MIPS_GUEST_TLB_SIZE);

Though whether that micro-optimization is worth the extra code is
questionable.

Thanks,
    Paul

>  arch/mips/kvm/emulate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index ec9ed23bca7f..a689f3db3094 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1139,8 +1139,9 @@ enum emulation_result kvm_mips_emul_tlbwr(struct kv=
m_vcpu *vcpu)
>  	struct mips_coproc *cop0 =3D vcpu->arch.cop0;
>  	struct kvm_mips_tlb *tlb =3D NULL;
>  	unsigned long pc =3D vcpu->arch.pc;
> -	int index;
> +	unsigned char index;
> =20
> +	/* Do we need this quality of random numbers?  Would prandom_u32 do? */
>  	get_random_bytes(&index, sizeof(index));
>  	index &=3D (KVM_MIPS_GUEST_TLB_SIZE - 1);
> =20
> --=20
> 2.20.1
>=20
