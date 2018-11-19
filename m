Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 00:21:08 +0100 (CET)
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:14144
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbeKSXVDJ0m27 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 00:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiOfJMl8BtDiJADTYGWQTMLkx41+ZV1JeTBIaCvla2g=;
 b=e8ZqvdpDWOrYpxzj1DVXR24ngDcwOtvZSKayeoRPaFBi8PN5IomuTr95iDmMBmJ9XvNDKonq2Bhu61bkaEKZO8UQ9H9c6f8cfNEhJ+I40V9ng6vCZhv3fBYO0bujOXs/T1/JMZAjn5lsxSlYGGfPsePGAi5XzhgRsM/mLX7GsWU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1503.namprd22.prod.outlook.com (10.174.170.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Mon, 19 Nov 2018 23:20:55 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 23:20:55 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 1/8] MIPS: Loongson: Add Loongson-3A R2.1 basic support
Thread-Topic: [PATCH V5 1/8] MIPS: Loongson: Add Loongson-3A R2.1 basic
 support
Thread-Index: AQHUgF6EaOu3pxVeWkmKufZ4kCUNyw==
Date:   Mon, 19 Nov 2018 23:20:54 +0000
Message-ID: <MWHPR2201MB1277D0155E0BB3E9ABAAFF38C1D80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1542268439-4146-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1542268439-4146-2-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0001.namprd17.prod.outlook.com
 (2603:10b6:301:14::11) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1503;6:wsgbpr8ictPacpAPxwyE5AUfe4WEbTuX+mu0nNKsqiXc1Hi/fGSStS0NAZYK80lyLLwGmFvmQ4bhpZSJ7eSeF2YRpMLw2yl7fsq0TeOKsK/VjOrBbdWaQM173bk/KjVdYZ8U+QKtfF8GWk7fPVTbw02T7AlRc9VCOuzXkKYj9ctM/9qJ27ijRj+UoOOdKks7aEsVgcF8TB3P6JvPQ67/FoBwQweasITT1oxWzesaqx9dlLqzFYIJFLVaXBQK+WtYRSylUV26LQfjzkzijdIzOFhHF6IacuQFb776O7SHhrS0Ou2QoFsVjIDoUVCO1NZMADyde4sT7KHluYMYpcNiConCgdd4bW0z3M9VA/FeUJEeOu7zfRuDFadp4yQLUQxSklUSluBj+/FAgvVub9fP0Zle7z4KOYq4/jNVUIWw9W3GdGtyDgXqQ6zKn9QdI63THDyx2z+EgSlFwtLI/7w9+A==;5:WitKDwTjNQoxaxdxnRi0rFvqb+wSnx8qsC9bffnZUulB6Ix5CVxd4cGw52190ww7eBK1L+QZhiJopF78X2s+vGWqJZF6WOVabiwSHBK0tGo1CYN574njIMFSBzOCLFTVOrwjOxxWhs+69fWOU7eVNWuINiIegpNggxUll8HKnSA=;7:sfSSeRC1odn2zF4zahgucEDcCPkQJ3hgBVNLKLDUX8sJHZsqSFNlNi9wsvBbiJdfrNjT6LbRSaaI/gsE9bDr1/8AgoZW2lUI77eAa6Ox/r3I3XFMQ27BnXao6qnwSpii9rjLP1TnhT3mYLm4sDKp0w==
x-ms-office365-filtering-correlation-id: 25e38483-b650-45a2-f7f3-08d64e75a74e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1503;
x-ms-traffictypediagnostic: MWHPR2201MB1503:
x-microsoft-antispam-prvs: <MWHPR2201MB1503D237B9B3E2C1AFE734E4C1D80@MWHPR2201MB1503.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1503;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1503;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39840400004)(346002)(136003)(199004)(189003)(476003)(6116002)(3846002)(11346002)(6916009)(446003)(97736004)(508600001)(4326008)(229853002)(9686003)(25786009)(53936002)(33656002)(256004)(55016002)(6436002)(39060400002)(66066001)(6246003)(186003)(26005)(2900100001)(44832011)(486006)(71200400001)(71190400001)(52116002)(7696005)(99286004)(102836004)(386003)(6506007)(76176011)(7736002)(305945005)(54906003)(316002)(74316002)(2906002)(106356001)(105586002)(8936002)(5660300001)(14454004)(81166006)(42882007)(68736007)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1503;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /dZZO1Tn50AdR8cOuAe6Wvxt63EBCPOltHhBKkjuW9qTcbd7oSDm1udKizwheXj4Z2AroySQc/MNSOgsjAHvJIyfLwohLpDvCSkTzN+gIkVyARwwuZTRQ//YAxr0EvZ4ieQTTKIuVvZRUsbIXw3myW728ZyD0v1GBlUxBPzJSdonOmookizK4zu15J18RAjO7A2E1/pqxndF4EHouh8Rem7yasYqcQNrC5a9pg/AnxYRrt5ySYpTNEfc7WVEZGk3KiJSEUQ0OKTMYKRTBLa9FhNk6K8klHL+3jcZj9lScQuTGAnNOcxlI0GEltC9zoZZplTnYRjHpoQNNRaLgfNm5yvau2aIWzMmeCj5/MnOEpU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e38483-b650-45a2-f7f3-08d64e75a74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 23:20:54.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1503
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67389
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

Huacai Chen wrote:
> Loongson-3A R2.1 is the bugfix revision of Loongson-3A R2.
> 
> All Loongson-3 CPU family:
> 
> Code-name         Brand-name       PRId
> Loongson-3A R1    Loongson-3A1000  0x6305
> Loongson-3A R2    Loongson-3A2000  0x6308
> Loongson-3A R2.1  Loongson-3A2000  0x630c
> Loongson-3A R3    Loongson-3A3000  0x6309
> Loongson-3A R3.1  Loongson-3A3000  0x630d
> Loongson-3B R1    Loongson-3B1000  0x6306
> Loongson-3B R2    Loongson-3B1500  0x6307
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
