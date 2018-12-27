Return-Path: <SRS0=uIlq=PE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB177C43612
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127320882
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="j1Piqe6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeL0QxE (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:53:04 -0500
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:20805
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731196AbeL0QxD (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 27 Dec 2018 11:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iok9lGmyjnLfyqq1dH1i1xJPTLSxzHtljOV9Kek2G2c=;
 b=j1Piqe6wQpM/XCG2cS7sRHDa7yKnxBsDbWRNr3JmdPEeR2MwhoQn36mt5ilUCu4LaZgsy+esLXsu+YFB+FclIvFHsdHc+sMzd3n4BmlZQ2NPNQB2eRXJMym4S0MoIPuZa58/UfniHM9bJcfJEKdLSX+Z31JpZiAqEDaWufpau94=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1760.namprd22.prod.outlook.com (10.164.206.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Thu, 27 Dec 2018 16:53:00 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 16:53:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mailmap: Update name spelling and email for Dengcheng Zhu
Thread-Topic: [PATCH] mailmap: Update name spelling and email for Dengcheng
 Zhu
Thread-Index: AQHUnWeVIUV8ynEKQUW1jztKoyHgDKWSzmkA
Date:   Thu, 27 Dec 2018 16:53:00 +0000
Message-ID: <MWHPR2201MB12778D33C66A94F2FF3F68F9C1B60@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181226220835.12122-1-dzhu@wavecomp.com>
In-Reply-To: <20181226220835.12122-1-dzhu@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:209:15::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.144.210.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1760;6:zx2CywDcdoRo2z7mXvl/LVCGbcQ4KVMEadzOjrKc6v/sGGR8QEiVWDLj5kTca3qxJEexqoEJhI1c/JG2m0KmmezNw44y6zWnMP8grUopDtRz/SVbAI1M/wwjTdgVg3hC5Pv+4SJN8oTjV/AoqBuC4vctlpGIgBl2OZx5k3qPqBRHo93QVETaENILaOcyfPWjW3gYSnhq9lcE1iYz4l+XpyIvatsKJ+yTR1rp2tuEhTmHK81v1zBk2MxwSAIDDUXRcRQLq6JwM2V77D/JdLiw0BtHPo6ynxEJQUU8uzSmBvGwsag8HgE6SZyViqGT0iz/97dboPXpM1O1Lm/6Mf8cPbuxowc0tgkSFaJb5LmmZ/IUSFyKaTZqTIsx7IWRKC8nE7RD55BWCq1RNdkL5KE7Ybjc/MuVFF0olbMMF/0xKk91ebdB24r1Pyi4zxRDbeKS1ZSpDYwsFhsNCbqhAOkjdQ==;5:OGJSa2UtlAEXHiNuh6WhmrJId+TzE/eW/A8hrhNiFRhTsI5v8oXy786g3qCNy2f4HLc13jEtfEwQzj8Bd/u4/tSCuHVRWVg95fUoLXuGPwl8GFMf+KdeZedq/Ba0J79KTxmEQQexotN56Y/1RElphts/1OmWRMgFhqFSLVJFy3M=;7:GkxbfmE/s512gdYdQ10JtMw8WiywbxO9ROReIzJ84tBRDO86eZOyqY7Zm8Kb8Hm/zGKUqovTD6/A55IAA1ZE8CAHO4/tMul7vOE3shvZlyxELizp8Dts6Xk1oqRPUz3q2WDaZOFTTPGZwMPJNA+ITw==
x-ms-office365-filtering-correlation-id: ad1a863a-54aa-4715-ddc9-08d66c1bc250
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1760;
x-ms-traffictypediagnostic: MWHPR2201MB1760:
x-microsoft-antispam-prvs: <MWHPR2201MB17609D7A322BA6C1B09D34CFC1B60@MWHPR2201MB1760.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220047)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(3002001)(6041310)(20161123562045)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1760;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1760;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(136003)(346002)(376002)(396003)(199004)(189003)(26005)(316002)(71200400001)(71190400001)(6436002)(76176011)(99286004)(186003)(55016002)(44832011)(106356001)(446003)(486006)(52116002)(14454004)(229853002)(102836004)(9686003)(386003)(15650500001)(4326008)(66066001)(68736007)(6862004)(6506007)(7696005)(97736004)(5660300001)(33656002)(6116002)(256004)(478600001)(305945005)(53936002)(74316002)(105586002)(476003)(14444005)(42882007)(11346002)(2906002)(6246003)(54906003)(7736002)(8676002)(81156014)(81166006)(3846002)(25786009)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1760;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vnaO96lGr4R8kAK3FQe0l1fZ1RbKGbQVYUXuvQyHe4RDJnagbgt+sazkcdAJzW4kj53XGOtVHs+lzlcp0GyZeAxjSjN8dlHEIV9zTpvP7Io6gkKyU3zRq4wcbZdexVRnECNhhSSUWEHjDGYNSvPafvkNQWRa6uZBLa7Hpr6NW1xIXK5nFp+WQdsiyvdH02M6LHsMsGjsVckZdGVkiXeKi0Qwx2HLB35QgHb8LIWq5xqOHE9foA/j1bvvm5lvoFbgeaqOl+TfntiFXZdRsAeRlPdek9miL5OZ6iGIp1uLXXJl00Lm0mOW6jv4/H3Si3qN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1a863a-54aa-4715-ddc9-08d66c1bc250
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 16:53:00.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1760
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Dengcheng Zhu wrote:
> Change my first name spelling from Deng-Cheng to Dengcheng.
>=20
> Update email addresses.
>=20
> Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
