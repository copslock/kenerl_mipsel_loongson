Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF0DC43387
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D7E206C0
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Q8MrKAy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeLNTDT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:03:19 -0500
Received: from mail-eopbgr680107.outbound.protection.outlook.com ([40.107.68.107]:54051
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730414AbeLNTDT (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Dec 2018 14:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjP/5XblG3ERgoZK6dTEg1cUhx2BO0wInn6oUdkIw04=;
 b=Q8MrKAy5dJilC5vLJ0K3X6Q62QS4q0I89uP7W4BXM+9+vu7hT786onlvvNRCEmPBtcoQsaM9fkmEisTZRqvD7NsD3of5cukgj0i4VcAVqNEzsPX5B24sjytyl3EOIN7wgw30MTo5NFZRuQb5ZhQvC2mpE2UCMZkhgqb5y+8yRe0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1725.namprd22.prod.outlook.com (10.164.206.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 19:03:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 19:03:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        Yu Huabing <yhb@ruijie.com.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Topic: [PATCH v2] MIPS: Expand MIPS32 ASIDs to 64 bits
Thread-Index: AQHUjCtCTMEMRdKza0eGsQC+3qNFjaV+pv6A
Date:   Fri, 14 Dec 2018 19:03:16 +0000
Message-ID: <MWHPR2201MB1277A6B7C058DC7A55CE3F23C1A10@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181204234333.21243-1-paul.burton@mips.com>
In-Reply-To: <20181204234333.21243-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0047.namprd22.prod.outlook.com
 (2603:10b6:301:16::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1725;6:dxn0dHZY8bCCSSbyPGcshBF+UxBGoJ7l3FArA+rlklfn4wPWwOVOoMSGYv51MWAwCq6+HP3WztX4YKnw/uuBFlqeIqEFEUKbpFm26jvxa1C94vC8dOzHZuJ1+e85ifdgRX1ZbD1B9ZAOwrdi8McwqMyBN2kxxLjNz8Zq3+s/1I9uZC+lRDghurYuRqLQ+eSh1xZqbMm1Z0axLrMjMJJXyo2Zm2UcefRquHxz3GwSHnRD3dEe50+2gj8O1imVfdd8Gq2msN51JjGOlZc8/aJQGrFd9NsK3i0vHDrG+0O3AkqdmnBMvQl2eLclCsvNnaP4w/aCunEMgv8YGfPPJgVqTmh5nHAb9vMmFLpDfC8DWP3Mmf1JnkI7BukOp24T/8kdN7hgStwfLOhkpGkzP0U4FcdPJ6d4aH4NUOj6u4zcr0mU+p6WkQ76XaaTYdKBkIKN791oHQdDyasY/5yH5j/tNw==;5:uHPyl7uSeqNNhShesS3uQR+lWL67dnkGycg6OE/kuMFmQrE24XlBbwBP3ee2Pkpp66KqfNIcTqO0g92fyzmDI+ZYvGOczrr3I2LV9/ZMVoPAau653pBGWDEolvh+3S70PGgNQQEWeQV1/NsKfTiXmVW6uA7FChVXR+hKqLk5jxs=;7:3NVtuSZuqjUDlOx6mvJ0N2ZDtIzlFzRBjQvm2KcCoPdsoc0/90hw3ii5cBqlmL5XiAIty7lD60/ehs1Z7Y57SG6RMPVdtenQuYyXqfD/eANXrY0D9xovrmAlQpBMr7bzCLwm3W1+ZzP9+xDIaAevsA==
x-ms-office365-filtering-correlation-id: 5cbc635d-5b81-42a0-3f10-08d661f6cdd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1725;
x-ms-traffictypediagnostic: MWHPR2201MB1725:
x-microsoft-antispam-prvs: <MWHPR2201MB1725FCF8271511E4B46E11A1C1A10@MWHPR2201MB1725.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1725;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(74316002)(5660300001)(6436002)(966005)(66066001)(33656002)(476003)(11346002)(446003)(71190400001)(71200400001)(305945005)(6506007)(486006)(68736007)(14444005)(256004)(7736002)(97736004)(26005)(386003)(105586002)(6306002)(4326008)(52116002)(14454004)(7696005)(76176011)(106356001)(2906002)(25786009)(99286004)(8676002)(8936002)(42882007)(53936002)(229853002)(55016002)(186003)(6862004)(6246003)(9686003)(478600001)(44832011)(81156014)(81166006)(3846002)(6116002)(54906003)(102836004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1725;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xkqx4LDMOeuJDCLvIBGBquw56ea+y1KCT34p+FM/iPedBj+EcxYJVwOiX1vSB9MCtwxYMM1sJuLG0zHmeJPiwaRJHsS8dNDDrYoQdnT1f1WKYgM6T/0oYzeRqsydbzfnLt/R4Agu8HiLUpsck3Ov+AehbIrn9LyXgi7bc1uOkAe3o8Ezsckj1lRm2HT07PlAqvwUU5dj+d1vdNGXktJIWiGa2IWWheWY3sVzmIILwLXIi/zvPmJj0Ffo/Newxth0c0mDb+G9UnZDXCXjLuvSC1LHfi+mdyb501n51MW7pNlZhnNmtySN842mre3Cta+W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbc635d-5b81-42a0-3f10-08d661f6cdd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:03:16.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1725
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> ASIDs have always been stored as unsigned longs, ie. 32 bits on MIPS32
> kernels. This is problematic because it is feasible for the ASID version
> to overflow & wrap around to zero.
>=20
> We currently attempt to handle this overflow by simply setting the ASID
> version to 1, using asid_first_version(), but we make no attempt to
> account for the fact that there may be mm_structs with stale ASIDs that
> have versions which we now reuse due to the overflow & wrap around.
>=20
> Encountering this requires that:
>=20
> 1) A struct mm_struct X is active on CPU A using ASID (V,n).
>=20
> 2) That mm is not used on CPU A for the length of time that it takes
> for CPU A's asid_cache to overflow & wrap around to the same
> version V that the mm had in step 1. During this time tasks using
> the mm could either be sleeping or only scheduled on other CPUs.
>=20
> 3) Some other mm Y becomes active on CPU A and is allocated the same
> ASID (V,n).
>=20
> 4) mm X now becomes active on CPU A again, and now incorrectly has the
> same ASID as mm Y.
>=20
> Where struct mm_struct ASIDs are represented above in the format
> (version, EntryHi.ASID), and on a typical MIPS32 system version will be
> 24 bits wide & EntryHi.ASID will be 8 bits wide.
>=20
> The length of time required in step 2 is highly dependent upon the CPU &
> workload, but for a hypothetical 2GHz CPU running a workload which
> generates a new ASID every 10000 cycles this period is around 248 days.
> Due to this long period of time & the fact that tasks need to be
> scheduled in just the right (or wrong, depending upon your inclination)
> way, this is obviously a difficult bug to encounter but it's entirely
> possible as evidenced by reports.
>=20
> In order to fix this, simply extend ASIDs to 64 bits even on MIPS32
> builds. This will extend the period of time required for the
> hypothetical system above to encounter the problem from 28 days to
> around 3 trillion years, which feels safely outside of the realms of
> possibility.
>=20
> The cost of this is slightly more generated code in some commonly
> executed paths, but this is pretty minimal:
>=20
> | Code Size Gain | Percentage
> -----------------------|----------------|-------------
> decstation_defconfig |           +270 | +0.00%
> 32r2el_defconfig |           +652 | +0.01%
> 32r6el_defconfig |          +1000 | +0.01%
>=20
> I have been unable to measure any change in performance of the LMbench
> lat_ctx or lat_proc tests resulting from the 64b ASIDs on either
> 32r2el_defconfig+interAptiv or 32r6el_defconfig+I6500 systems.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Suggested-by: James Hogan <jhogan@kernel.org>
> References: https://lore.kernel.org/linux-mips/80B78A8B8FEE6145A87579E843=
5D78C30205D5F3@fzex.ruijie.com.cn/
> References: https://lore.kernel.org/linux-mips/1488684260-18867-1-git-sen=
d-email-jiwei.sun@windriver.com/
> Cc: Jiwei Sun <jiwei.sun@windriver.com>
> Cc: Yu Huabing <yhb@ruijie.com.cn>
> Cc: stable@vger.kernel.org # 2.6.12+

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
