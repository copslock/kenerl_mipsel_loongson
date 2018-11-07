Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 01:06:09 +0100 (CET)
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:22559
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992820AbeKGAF1hzTbY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 01:05:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY5UYI3bJpaaIDbKOj013jhAN+fHVy8lz9llwbKWwdE=;
 b=hni7K78rHDqxQ7NPoLMKhvIm8YjRj5CdvITFgm2t+VTrj5KI4j+pbu1S01x5Y9HSbRGlgfh2j05FlCwulGzycQsJZhvB5+kWRx4DPMKAJLAaajmzJvxz6bMKWj9P+qwMZHUrEpzmCFvOVYswlsOfSx3YsZXfvnpxsHGyT9KtHuc=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1215.namprd22.prod.outlook.com (10.174.161.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 00:05:25 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 00:05:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] MIPS: DEC: DECstation defconfig refresh and new
 templates
Thread-Topic: [PATCH 0/3] MIPS: DEC: DECstation defconfig refresh and new
 templates
Thread-Index: AQHUdLZ2psxsCcLn20O7oQ3b64dyiaVDcbuA
Date:   Wed, 7 Nov 2018 00:05:25 +0000
Message-ID: <20181107000523.tp346yiwq5fgszs4@pburton-laptop>
References: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:320:31::30) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1215;6:wq7+clLz2YJWlpzqr7vfblkBvshI6IQ3coNcR3NkujLzWmpoA8qY9QsaESQLw+y8wRdCR2iHWIi2RuN1JeEs7v7VxUzrpzWOiJ8mP9AuUbGwMXog5JOJSJtX2K55NyZY+21fnE9W8p2Q0TnlNORByTP9/3X1YEEL9dxJBAxwvTcY88gW9cbk4RxWohIbKMMn9o8FcI8XNVHFCE/nVffL0X2gRSkWZeNbW/FcikqMy6BpKC4pk2QEFYtFGbcfM1UGGbJah0RVGwTZAY72OgTNrB3wmMHCFj+kf/uc4Gp5JhhBt/oBMGhbCKeDLsYxeotqqt/gFGgl3KdDQwefgbXt5xVdtZFN6ROhisHuueZ6w3qs8mhOvlY2LUfDzU01kh52JZ1MssxrZMJDIxnZ76kl0VPxZoGpbBXEsBujLz4mL8XQHJkaGDPTw5TjCXav+2DxYusydMHKlwKGTGXp/VDx6w==;5:TCUDSGjXzxWmKHjSawyqWVIBt1w2+hCIOHXD/kD59Qv+vLGWHjgeKDaNyIYJyAqRhVMWXTNvEePSPBjVIDVV0nW0HaBmCczoR9pKHi00Y0MubBJa7AmOne469NLKFPcGz7j00GWtHtMmaGeGyJzFkfGBw9lgF1hK4m/wrWc8t/Y=;7:23WvgA0mj1RNyYuT1J8G/KhPUPFwh9yCyyRgIYihiZvR2A0Bif+T+bppqmCdzZvla1TylO0Y5KslUBsy2nLDLMiV2tfTbqQFdjUWPH8HIzXSo3TFesahGMHtKLja9YLAIRT2BeGxivUFfaQM8hE2Ew==
x-ms-office365-filtering-correlation-id: c3233329-aa81-43d6-0ed9-08d64444b758
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1215;
x-ms-traffictypediagnostic: MWHPR2201MB1215:
x-microsoft-antispam-prvs: <MWHPR2201MB1215556A5CB498CCFDCB8D01C1C40@MWHPR2201MB1215.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1215;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1215;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(396003)(39840400004)(376002)(366004)(199004)(189003)(71200400001)(58126008)(54906003)(6486002)(68736007)(105586002)(6436002)(229853002)(106356001)(52116002)(76176011)(6916009)(99286004)(6506007)(6512007)(33896004)(386003)(9686003)(26005)(5660300001)(53936002)(81166006)(6246003)(8676002)(316002)(81156014)(71190400001)(305945005)(102836004)(8936002)(486006)(476003)(7736002)(44832011)(3846002)(25786009)(6116002)(14454004)(2900100001)(42882007)(1076002)(11346002)(446003)(450100002)(2906002)(33716001)(97736004)(66066001)(4326008)(256004)(186003)(14444005)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1215;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xIctdqK4aGbipRQ8jnwwZ7ZvsT9ymUv1DALCZ5sVbRBSuXVOPCebQCnP5N8GPOZKl5AFLB+ued4vgeNGjY5OnKft1jkbzrh6hx8bLaOfPxHdSKRnWOVOvcF0rTHluth8Uoh59b61LOCdnPM4n3uYXKwN6M4zWJ+RoARj3jjLmOqeM2eedCE2+8n64TPNJEEv2t61d/i6AvgcWqlAbIW5sO9GhCQ9MxM5YB34965xWHlecGWEc1qcL6we+DFgKY3WfigdQufbx5DIJfy1CdwLAsrTUqL2EO5mtdv0ghd5l7QZKAZ95zNzEBi8XpHcoarA5pVvd9WRJGRotU2Y5KrWRH1ruAx2utq/9d6LTn4yBQQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F16EE64B0B7E084A9B00E9ED36B9B483@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3233329-aa81-43d6-0ed9-08d64444b758
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 00:05:25.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1215
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67111
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

Hi Maciej,

On Mon, Nov 05, 2018 at 03:18:41AM +0000, Maciej W. Rozycki wrote:
>  It's been a while since the DECstation defconfig has been last actually 
> updated rather than merely regenerated.  My `git log' examination points
> at commit 3f821640341b ("[MIPS] DECstation defconfig update") from 2006.
> 
>  We have since gained a bunch of new drivers and also some drivers were 
> unnecessarily disabled.  Therefore I have decided to refresh the defconfig 
> (1/3), and to make people's life easier also to provide an R4k version 
> (2/3) and a 64-bit version (3/3), covering all the three base DECstation 
> configurations.  Apart from being ready to use with actual systems these 
> additional defconfigs should make it easier for automated tools to verify 
> correctness of the non-R3k configurations.
> 
>  These were all verified to build and boot multiuser.  Please apply.

Thanks, applied to mips-next for 4.21.

Paul
