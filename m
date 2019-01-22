Return-Path: <SRS0=jHXZ=P6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C0CC282C3
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C88E21019
	for <linux-mips@archiver.kernel.org>; Tue, 22 Jan 2019 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="I4RQ83UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfAVRjl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:39:41 -0500
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:63040
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfAVRjl (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 12:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gllEsU39kDfeftIt/SqJJu16FmXPt4rlb+/BImlmAEo=;
 b=I4RQ83UQs1v0MJzwVZRxwWhLOG3adG7eejj0eLEYtgEZeGRRoUxZdp83+UMa1t5Hca7cWMpMqq1Ii3Cc98z4sThWnOEeXhIBxUa/pUB2y0mSjqkf2dXzBlSkZoPkXhXdW7qaBpl1bo5KDO2ntZe1fql2qgUHC/d+FO5n6kjkafc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1071.namprd22.prod.outlook.com (10.174.169.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 17:39:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 17:39:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>
Subject: Re: [PATCH 2/6] MIPS: Loongson32: workaround di issue
Thread-Topic: [PATCH 2/6] MIPS: Loongson32: workaround di issue
Thread-Index: AQHUslMr3zYjjhdNfUi8nqj6Gf3emqW7jjkA
Date:   Tue, 22 Jan 2019 17:39:36 +0000
Message-ID: <20190122173934.g4xbqsq43w7hkwy6@pburton-laptop>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
 <20190122130415.3440-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-2-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1071;6:JJrTxrxmrMbMqBgdLjeAMkHnLBZLP29TR2HTTe/mPKksM/DeWT8efE2c62RaebPj5BDWDWWedQCIuE0J6G4XxD3AAz4dOctXzF3YuHPt+yE9jQ23eYqTm/6aGouSwJ5A49YX7s9JWijfWhdubH0GC7R4oAIY2JLq2K+jUuvu81NF1q9DfpS7RBSBnc7hczxKZ3eP6Ghv38QrQeOGjyWVl/E/iZvIw2XBzFuodcss7e4znyhpAApgehRDrIzINKjkJdh/lNHFJ+KAhR5zMLXSYL0eBPCYTT+I/xVywxbbla5utxojHPfUdurXa8gZQsmpXiEobaWc4fd2dXMDjbXTApXl7n3k9BZ9ScuJowN5PpuZtyyl41EHmyl49G4b3DGVO4CwOf5Msrnys79q4lSf+UOGac9VvfHfppcYghcHFxC9D0sJBeDc6rxRM7QYx/mWWK+TRLQcwOAe6EznJTZg7A==;5:IPFxuID1SDebelvhaiyxT4mng/r95/NxXiluE0kL4zAeISHjMWB5Kcge8wSbI8xnFVibI5595xHNIy1JWLGFVEAjqK8Rehrc2VzLNv11GdYBNCWnbcClei0e56VZRBCZJ+JbHGXSnpzVJ9bJP+59wQI5mtPl6CJe3uadNjE3pCwFQWCxla8iWmXMATZTJT+SwRtGq9szL1keEBu0su1mbg==;7:WrUifCGMt7os8JcGIV8YEVPM5st/yEsYlT3/jIURCm1OQnt7LrXwmFTjMqb2PXDfRxtWHqscqUYvvSUcx5mtSJT7wEnonxPeDSbZPX2QPC8FXnRiGH0usy7Xk1Gh32pifOTiZCRZqjkxssgpARe8DA==
x-ms-office365-filtering-correlation-id: 8917d7a4-7b15-472b-bc8e-08d6809093ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1071;
x-ms-traffictypediagnostic: MWHPR2201MB1071:
x-microsoft-antispam-prvs: <MWHPR2201MB1071F4059AAFA01EB1A44DD1C1980@MWHPR2201MB1071.namprd22.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39840400004)(366004)(376002)(346002)(199004)(189003)(6246003)(39060400002)(4326008)(25786009)(486006)(97736004)(53936002)(102836004)(106356001)(446003)(2906002)(11346002)(316002)(99286004)(105586002)(1076003)(71200400001)(76176011)(66066001)(71190400001)(42882007)(52116002)(81166006)(6116002)(3846002)(81156014)(8676002)(54906003)(68736007)(8936002)(476003)(6916009)(26005)(305945005)(58126008)(7736002)(33896004)(186003)(44832011)(6512007)(33716001)(6436002)(14444005)(256004)(6486002)(14454004)(229853002)(9686003)(478600001)(6506007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1071;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ZkBL3dTd1bF7H/dIVNQTVXIPZNhJ3aJc93tmXq4Nyj+cId6vS/2aCT0Mn09grwKSrHhZiYbJ83lf840mULAmTA9rrfBnCWjvlWyGoWWcov4SAZ6LMV+OgXMT5WiPMf1vFFC68l8lnRV2gXFFxdQS41TzMbYoGxPKdRuoZXe4bBc4Kl44cURBJMU8SvqKVO/4JAfd0lwPKBZwoRNBS6Nyf3tv63syeHyjvivD9LjZoUijYxuXk4Jdf1Kl7Q2yGbitn2zR9I/2dKeTHhW3XU++851AIqOPRlUIhFlG0DZTEHFPtmE6lNFt2mJbtFBhUInEGgzXFTu6HKIGfMh2JS71Hxg479eswybjKDsmvcIw+o/pTTH15kVqXCUrmgMGgTtOV40LhPppPMhHPkEOnMT8tTqbUHfJ4r1VBLBO9NCOZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A74B83926FA724A8711822E12CABDCE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8917d7a4-7b15-472b-bc8e-08d6809093ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 17:39:36.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1071
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Jiaxun,

On Tue, Jan 22, 2019 at 09:04:11PM +0800, Jiaxun Yang wrote:
> GS232 core used in Loongson-1 processors has a bug that
> di instruction doesn't save the irqflag immediately.
>=20
> Workaround by set irqflag in CP0 before di instructions
> as same as Loongson-3.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/irqflags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irq=
flags.h
> index 9d3610be2323..59549d972439 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -41,7 +41,7 @@ static inline unsigned long arch_local_irq_save(void)
>  	"	.set	push						\n"
>  	"	.set	reorder						\n"
>  	"	.set	noat						\n"
> -#if defined(CONFIG_CPU_LOONGSON3)
> +#if defined(CONFIG_CPU_LOONGSON3) || defined (CONFIG_CPU_LOONGSON1)
>  	"	mfc0	%[flags], $12					\n"
>  	"	di							\n"
>  #else
> --=20
> 2.20.1

Thanks for your patches.

Since this bug exists on both Loongson 1 CPUs & Loongson 3 CPUs, I'm
wondering whether it also exists on Loongson 2 CPUs. Do you happen to
know whether that is the case?

Thanks,
    Paul
