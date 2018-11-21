Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 19:22:05 +0100 (CET)
Received: from mail-eopbgr760103.outbound.protection.outlook.com ([40.107.76.103]:23936
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993846AbeKUSVf66O00 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 19:21:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CesVEn9R1UwBUZu8vbtgaK8GxAxIp0adkll6dD0pL4s=;
 b=Ep8UhkS8GVjRBmCWaenY5BdTj49wxJicmuumhfr1VE4EJSioKFFLk4UrXvt6jdgKNC78XTKXPvoi690k+60IhbhuEWQDMrJC4Xlb/0yGqi6q0hqN8PGTe+kyOfaX+3ajMbwSj5Q3DLPGMSNWqDq67jDxfdn8B4Y4LYzyH8P3tXM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1119.namprd22.prod.outlook.com (10.174.169.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 18:21:34 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 18:21:34 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Regerate defconfigs
Thread-Topic: [PATCH] MIPS: Regerate defconfigs
Thread-Index: AQHUgTVS3GKroqpOD0iGPcWc8UUUO6Vai6MA
Date:   Wed, 21 Nov 2018 18:21:33 +0000
Message-ID: <MWHPR2201MB12775ADA87E6BEDF360AED46C1DA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181121005819.23815-1-paul.burton@mips.com>
In-Reply-To: <20181121005819.23815-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0060.namprd10.prod.outlook.com
 (2603:10b6:300:2c::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1119;6:vTnAMd0ueARAwgQyARV6IeqH0iwf/GXU3KP1wNBqj6ZTyeOf/h1yISHLDArUXA2yOx5mO5HHgWOfiz0Ek24uM0P9bA2lJMg71tzul8zN6ukEeeRjn1BvB+yDsRobFm8lp2HhjPurPxTGV66trQivyQVGB9wzX9jDjygtIU8ibunsWiDGXxqJs+lwJQRelzWH7JOywD2Tusgt8y84uYsi0eU+U1yDse4vIZvr+S1hiX6czeNtKcQLRqI7NMA2vMnEM3gDP24Zxu6vQiWURjN0sKLLmlGenhqb5Mn3yzGN1IzjNfjuyCOjd0IiKpC3EibYYDneupRg/0eU5rqGkpA7wAfYvkCate7ho9uDvRCmHOwAS+eohErUBZ5tyJlJAcC/ZZ8ZeJLn+5S3gxjyGgMGbAJ5bVWp/Gla4J9xidHQUgfZAW8k60FQccjMh0lrinqLlFkPw2K1HL0Kga/gqsu01g==;5:pFKqZuLtdQfYWvwodsDUSxc90uq5HhZ86ZOfwd5RH7Ls0j2AiC34R3GUj2Rge76jdAb4ZATzlbcj60XWaXjkGoOILAXAXQbEJgDmMYIRKZDzFLZcQJre6xbFhlxHBKy23gw7qyKjQbfYxm7ca+ogbsIr1V1aBjK99rMtZnlbfog=;7:1E3wxP4noErKA1Lb+gfzc+WnjLipXYTyvsCcDw+02CoqXTLCrUHTkere7tkC8SQ1cyVVnUBEwxChzQkkHtmelLJTQ2kNgvxCMR9USkeEZhUiZimx9clWXBbqAIZIOZ/kmbbRo0acK2wmrnHo5U7szQ==
x-ms-office365-filtering-correlation-id: 884ee9cc-ac4f-4335-171c-08d64fde2a9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1119;
x-ms-traffictypediagnostic: MWHPR2201MB1119:
x-microsoft-antispam-prvs: <MWHPR2201MB111923A37523739B4F863074C1DA0@MWHPR2201MB1119.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1119;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1119;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(7696005)(52116002)(966005)(76176011)(3846002)(2900100001)(6116002)(25786009)(5660300001)(99286004)(6246003)(9686003)(6306002)(2906002)(229853002)(53936002)(55016002)(478600001)(33656002)(71190400001)(71200400001)(105586002)(66066001)(386003)(6506007)(42882007)(106356001)(97736004)(476003)(7736002)(102836004)(486006)(4326008)(8936002)(6862004)(26005)(54906003)(44832011)(81166006)(81156014)(316002)(74316002)(8676002)(6436002)(305945005)(446003)(186003)(14454004)(68736007)(256004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1119;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mLl5GPqj486R2jt6A4gOlq4IRX/Bs52mtLsMMRtqRZN8fah2iEMKYbfkdhfsqL5K2e/ruZSKFN/e1Oy5TuHidMKAeUbAwThdL0bGvCVk5vnd07umSokRN/6plK7EtIzAI+mY40vsjbwzwlLtkfdCbZWz7ntuHu29cwF6u5EoajA8ElC+L4DbYqAZdgpZL7qeQodpaKHPpQ6mkbgo09Q22V9TNSSGb/fCPD9HFQHvG0MeIyDhHuq23mYn0z8RvDODZbWKOMoGNhmk2p8YqtrF9YrjRBJhkRvcAAnWyRcqqkrQZG9NIJYr6CPsXEAIQcd3bUqj3GboimnuPYjspeDDAUkCvpwZqQNh6V++rd/KgyI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884ee9cc-ac4f-4335-171c-08d64fde2a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 18:21:33.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1119
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67421
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
> A couple of patches have come up recently to remove particular instances
> of obsolete Kconfig symbols from defconfigs. Rather than doing this
> piecemeal, simply regenerate them all.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> References: https://patchwork.linux-mips.org/patch/19635/
> References: https://patchwork.linux-mips.org/patch/21156/
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
