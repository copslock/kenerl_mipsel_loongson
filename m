Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:55 +0100 (CET)
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:6211
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993109AbeKMWWYPFCpu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9QwR9RtQpdIEVfq02HZbgxcmIE5mGVtIyAKxczxH4o=;
 b=l4AZvxQpM5reUB7ub1c0R1EcSph4p+aVpkTacAL3mX0FYWd/yYtPdpbL/hS3veuein83rZYHqPIkmf0FE99JGrn0vclzk7Cw/Bl+YSTYKrLYVNVeFs0yaPMoteKDQYnaDJkaaKvzlp3X7c/gPjrU8lFGe9uRUt6HbVGamLr0q/k=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:22 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Avoid using .set mips0 to restore ISA
Thread-Topic: [PATCH] MIPS: Avoid using .set mips0 to restore ISA
Thread-Index: AQHUd5+smDXaSHv3s0a8JFdkhOmXF6VOT3GA
Date:   Tue, 13 Nov 2018 22:22:22 +0000
Message-ID: <CY4PR2201MB127215A140FD8D4393A70363C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181108201426.18512-1-paul.burton@mips.com>
In-Reply-To: <20181108201426.18512-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:TAQy0NV1v+1B+hiof9YGcPbhY96f7ZcOihorW4vIpgjN7jCbkYrssYHCfEgTbHIWyXfXabObqAx1EUGKKn/lgQhLSDJ3VE1/cYMCGAZczhQGNsuX21vpRA8DWLHwEKPg7bwePSeyuEcE2yOYLOj0vaa/c0pjWaOo+2IJIcO3N8tzpe3SmCP2+O4m0352hMbBFBhgIvmO1fTTs7HLWf54i7cIKqJ8oTZtT1DT3TxmcWi3AJV6CtFHUTzn8BMePMb74tHKlvq/iIgjY74cY18MaRrDLWcu31doKg6FQGRQzWCWR51/1Zw8byJ2H5GbUUSY+almi8K2X/w20rqwpMfC6IMJSTilGzZSRk8U38VPYKr7HV/sTpcFHdd4Tn7vBBfvpXa1FDeFHBf39845S4H1lWpgWlF+OM0yrZW/8nGxNfmCBBHpVNLOeJKWx+tMww5AWXCHvM0R0Oadv4VDSmfCrQ==;5:FjoMxU04yvnmphzqiWSJ20BslyEVIEmxm0lH5tDGHbmjLqo4T1WxGF4w3W3K4bUfLJ4QFbRTIP2VuXa0FaXMn7yYwfAwNtL4yF7o2aEJdPqIDk+g4tmswmjA+sWLTB0BqoxNRLLCi+iy8A4AFezkc8kMzmrCkDaECNL+Q2uqXxI=;7:zf5AO6T7HpGyqYk7X4QgmM6sg9pl177wgkFd8XZVDdCU65FdqyjuX9CEKHbBCJVfsysF6ZTBeB6Py8ly6YMAlNGKl7gidJWPVBHBSQMZs+fBCTQ57ztLT2qz0al3TVkGlU9VG3EKNhvmEOpyA0tSZw==
x-ms-office365-filtering-correlation-id: b2cd5718-6a0a-456f-eae4-08d649b67b70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB13501FE14AAB11AF7835875FC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(52314003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9qFrLDP5Hexv7upUz7Ggt1uk83b8T0UawJFnMU0glzPc3o3eKTnR0ynLmlDqK5YsI9mIDD1s8GksaOJ5g8mYe32B7KkOy7qE5Yr7l1Pe45LmIRmaQhKNQnEEaPH1G08PRj2JxKhDvAUyLmTGvu5epRQPIdd03WmQaKNn7SD5siwVLGuN4uaZkd53EVvsRX6MhVh+8qCM5z10bxkCyW3hSt9uJhW+tEGGYBRYqssAVGU2x1XJPG66alf4TiVODH6g8Z4uLxAnliWJeUPUaPSFMASvgf0dce4k6bbk0pIfkTMPS+Kmpxqcqm2LBhr5wfDuUFCwAZqPh4JO4UK14ob3hqHExNg8FtPhdWrYjTr8ZGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd5718-6a0a-456f-eae4-08d649b67b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:22.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hello,

Paul Burton wrote:
> We currently have 2 commonly used methods for switching ISA within
> assembly code, then restoring the original ISA.
> 
> 1) Using a pair of .set push & .set pop directives. For example:
> 
> .set	push
> .set	mips32r2
> <some_insn>
> .set	pop
> 
> 2) Using .set mips0 to restore the ISA originally specified on the
> command line. For example:
> 
> .set	mips32r2
> <some_insn>
> .set	mips0
> 
> Unfortunately method 2 does not work with nanoMIPS toolchains, where the
> assembler rejects the .set mips0 directive like so:
> 
> Error: cannot change ISA from nanoMIPS to mips0
> 
> In preparation for supporting nanoMIPS builds, switch all instances of
> method 2 in generic non-platform-specific code to use push & pop as in
> method 1 instead. The .set push & .set pop is arguably cleaner anyway,
> and if nothing else it's good to consistently use one method.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
