Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:45 +0100 (CET)
Received: from mail-eopbgr770132.outbound.protection.outlook.com ([40.107.77.132]:18461
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993097AbeKMWWW0d3pu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46uHIlXpE64ED8uIjjzxBRnez0j/CFHsT1mUhNdY3zY=;
 b=dBsgPsHDWSWVV3v2yTmcez5fOMDFeRdQFrWx3v3yz/1CUaP2AEvw6QOtiw1v7oDzc62UoYwz5zHRdCpO27LaUJdISRILc/lZcMwjrvyhVqe2XyYA55AIfygej8XRvtYeS6rIesn4jULUyleDODmONRtW9SmqPCY9yvMCVW0IYTU=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:21 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Topic: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Index: AQHUdvBc6FH/gm/eXUqshhyWFnaOnaVOUM4A
Date:   Tue, 13 Nov 2018 22:22:21 +0000
Message-ID: <CY4PR2201MB12729A8373E66B296CE8DB5AC1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181107231931.6136-1-paul.burton@mips.com>
In-Reply-To: <20181107231931.6136-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:301:5f::47) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:00piGLq1GeQtUFxuTW6XwZeYkC2gKpuYQuhV0ms2f6BZGXyfchjIqhEgxhEwLRpW5o9J2XByhn8fZdDe5iLTYx9cvynq31sXuVX57PsVIVQBs9QRnV/ZcVzDCOPDCyIRrpA/Km1G+8PP4cfIE/Sn2QO9j83Q7VA+8JkFKQTEJnRj14ca4T1GRDX41fbAzbpLOev6P/CJsV+Xzk4BaBI0x/VVSR9OA4zDokksN0Ei1ANH26CTWLhCxNT+IC/U1dgwkl4HjaEEJo44jG2bZ6N/TUnk/lC2LVgCz9N3hoy9MpsFpIZLCbVeBu5U4bAEH7gBKctQ+FuvvyM8LxS+fW8egmNpT64NkmDTLQ2J4z1BFlJWGn54lUHVdeDylSSvwdj/RtHhT67ciAqK4c29zV53hprUX50ZmuMyK/dk7wBeuJy/egmY7in/rSNCEgSYhz5f+p60qqayooSFqAA08QXrmg==;5:LLbF4S09lUuHpCQC6tWkHeoLLqP5ViPdLigPs5kRYw9cZ3ATuMf+s97WiKtXr0TGk/aCL5lFANtkq31K4VdPiarrgDiCrhrCH/Q4xMwAG4rLk+oDr4uOMwe25ik5hKxLY/VB7Oo2Hrmkw9ZFEuHHFHoYQw+Qu0tW8BKaZ1UqoVo=;7:rSEhUZhTDdci90hXBCdFcoCL6GHwlE4+EYMHsmiPFaQkecaAmpGAU7EHd4B7PxcytOoLJLphDDzAzRDkpN9rOGF9YIfUhA7W3GU9Mey097aIbwVsP+xXEbxmsqEsJJ5QbG1Y6ZZQwc6qPKRrasgk4w==
x-ms-office365-filtering-correlation-id: de3c6c54-0400-475c-bb02-08d649b67a9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB135083483064A16BEC14B60AC1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C+xnXoXMhQai7tXHRmMLnpWeYOpE4jcNobXEKs4+OIr7HNwMGCaxHNkBbT9ycEm4kxnp09UgGFOXb3hyC34bYZB+LwO3ZyWOXByH7fBMaqTDgPw1t0KpQ04DKK4Fk/G2N/k4su0jcwa9JICbAXqRIrE4E0w5kFx2tsITkdQVCzVphcrCdgqAQGjNeigXl5LeHUVmoCBlRkJ15P5CAUTtHJGWszNnV2l85KTWy64b/2tEveaDDG7t/xVA3pGps7yatNxuAHds6a2XjKuPtwLvb4+v6Z64XaqkLuagv9tHVavMu/mSoWFdZwSrA6JGThHmT15TbWq7XWa3Cpo2bQWWWT8U+iv64cewnMoLRdFaoHk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3c6c54-0400-475c-bb02-08d649b67a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:21.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67265
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
> If we built the kernel targeting the microMIPS ISA then the very fact
> that the kernel is running implies that the CPU supports microMIPS. Thus
> we can hardcode cpu_has_mmips to 1 allowing the compiler greater scope
> for optimisation due to the compile-time constant.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
