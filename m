Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 01:24:16 +0200 (CEST)
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:18944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbeIRXYM6rCeK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 01:24:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x62YsZY4atoGxIOpXgVwRDxD6IWHKl7B5TAN1dtFY00=;
 b=ARocFHT0gyhXam8YCb9zXI+43jZk5UQ84QXTTCQBHxbB84xbnBcsdjAxdHqFQ5+T1EXQ+3RrBk4BGCH41g3BAmPUvtdCnotNOrILgCx6SKk+bFG8n3DJkJOoKMk7mi20kdgbjcamn/8M2LI1NJcpC0QNSIT68qnSbd5pGxg4KJA=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4024.namprd08.prod.outlook.com (52.135.195.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 18 Sep 2018 23:24:00 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 23:24:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V4 01/10] MIPS: Loongson-3: Enable Store Fill Buffer at
 runtime
Thread-Topic: [PATCH V4 01/10] MIPS: Loongson-3: Enable Store Fill Buffer at
 runtime
Thread-Index: AQHURPtsNKlUejJ/606ecdAWXlfAQaTh6EwAgACQ5oCAFEojgA==
Date:   Tue, 18 Sep 2018 23:24:00 +0000
Message-ID: <20180918232347.cla4bmdiq23qh3jk@pburton-laptop>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
 <1536139990-11665-2-git-send-email-chenhc@lemote.com>
 <20180905165438.cqdr5cq36pbujtjc@pburton-laptop>
 <CAAhV-H7vuFKK+H77EnF0P2ae50FMo0DeUniBLoTcagn4xO0QnA@mail.gmail.com>
In-Reply-To: <CAAhV-H7vuFKK+H77EnF0P2ae50FMo0DeUniBLoTcagn4xO0QnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0090.namprd19.prod.outlook.com
 (2603:10b6:320:1f::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4024;6:clbbK6kOlgOmEc3XUJM9J5qxhArwVNplxc7RBrVHb4TsguiuDR3j66e497MDtOg3sLT4qXQlUuwiN+2XlTOc/Mt43cIryczBYTIm8sc69sGDugxkVb8XMz790Nf+FxOdy4UdiCl1F1Yke3w98BtGALEV9W4MxLUr0YoBoXbJKcArMrrNnZCpbaiQ/LlG2o2RIGKgXBsVTEO/P5NeTLVrqqGLGlTnrHCupicb1uSiEQrbayY3/kQVCAfyudPuqPMpG05G92reJUv/d1IQeq1MOG6tU/zLhUytuaJ5yscik7FEl2pgpfJgTrKcJ2NNvYGPC653HeluQJh6322qVSpg6Wqz+Q71MViB7si+PsoszabiAUP7g+MCPhFU1qlb6zJi4xP81rCEBWaFDSEjK1MRSuh7sW8a6/IXDn876JEkzfK7iawNqC9V38nWyEFfN7cYYMAREMTFzz59tDJzoF9PAg==;5:1n7yZuFE9XNtX6yZQYu4aSn0yGIRwqL2l/zi4ykvMLySmxKCOxbr3n1Ol32G+Hw+wfTvTR8jO4oq2DrXNiruK/JZBJ2w2PXszIYOw+cBE/Yk9jOQGgpzhPv9JKTC7bhMqzzxhJA8ngNNo5bY9I4p9vy6Q/+Sis6jtb+Xf/s1NS4=;7:u9tkmx1hJ12CSMTCGpzPa10v7bS0us83MqtUUmT0N0Vr6fIpykQV9hh5F/dEMOkcrU8xCw+RI9+Dg/GrCTIqi1UlYHABW7spM61Cqx1BldVff//IuEq+qEDS2dqenFLhy5f7zItylPMsj2J0YUoIpzVsgHWAwIsGao3ShmbmqQioE6O5yZiniiqgb/AS6hnyI9oVsrMxl1RuKyiRIIiR6+oNOfKoo05tRzSbeJVXhHaviadt/K++djl/Lu0egVQJ
x-ms-office365-filtering-correlation-id: 3ccca2d9-9932-4506-1595-08d61dbdd025
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4024;
x-ms-traffictypediagnostic: BYAPR08MB4024:
x-microsoft-antispam-prvs: <BYAPR08MB4024FB5A38D00896917337C6C11D0@BYAPR08MB4024.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231355)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR08MB4024;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4024;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(376002)(396003)(366004)(346002)(199004)(189003)(3846002)(5660300001)(81156014)(81166006)(39060400002)(2900100001)(229853002)(1076002)(5250100002)(11346002)(2906002)(446003)(6916009)(256004)(44832011)(486006)(25786009)(6246003)(93886005)(14444005)(476003)(316002)(8936002)(7736002)(14454004)(66066001)(386003)(4326008)(42882007)(105586002)(478600001)(6306002)(9686003)(6436002)(54906003)(6512007)(305945005)(8676002)(33896004)(97736004)(33716001)(99286004)(53546011)(6486002)(26005)(6506007)(186003)(52116002)(53936002)(6116002)(76176011)(58126008)(102836004)(68736007)(966005)(106356001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4024;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EpGZsOcj1RYSgoawTCM3HahPdAefiECzGZYUswLsgO0j80wpFfxxJQRlILZo/To8jsuls9f0Re0uEZAdolnraCzRFF81o68KoWAErJK0cTHwuBU7EIvF3H4K6Qbq0YhKtmcpXV4S/i5Uas/HXgKBiZz7yz04IoHZH8XqEEmQ+bhGV2acr5vpJJjBJ5xOLKaiSzf7z5iyJo8hYZktWjdKKB7Ou/jIIOlwqvRC6xrFenZ9w91jWOyrVQQ/LWMlEsd7bWjOfsL/8IGQjIGL7BYTRV+/b6Zasrr+O+NTq+H5+G5/yd3UDittX8LVSry/FGpaPcW9ObwB0SNqMvbvQpwrWZNChPi1SJK/jvapRl7rN0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F09D4DE76A2284AB218EB3B08AE106B@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccca2d9-9932-4506-1595-08d61dbdd025
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:24:00.1021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4024
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66402
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

Hi Huacai,

On Thu, Sep 06, 2018 at 09:33:15AM +0800, Huacai Chen wrote:
> On Thu, Sep 6, 2018 at 12:54 AM, Paul Burton <paul.burton@mips.com> wrote:
> > On Wed, Sep 05, 2018 at 05:33:01PM +0800, Huacai Chen wrote:
> >> New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
> >> (Store Fill Buffer) which can improve the performance of memory access.
> >> Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
> >> the generic kernel has no benefit from SFB (even it is running on a new
> >> Loongson-3 machine). With this patch, we can enable SFB at runtime by
> >> detecting the CPU type (the expense is war_io_reorder_wmb() will always
> >> be a 'sync', which will hurt the performance of old Loongson-3).
> >
> > This looks unchanged since v3, and I didn't see a response to my email
> > here:
> >
> >     https://marc.info/?l=linux-mips&m=153248530725061&w=2
> >
> > I still haven't seen any explanation for why you can't just do this as a
> > one-liner in C, the same way we enable tons of other CPU features during
> > cpu_probe().
> >
> > I'm not saying I'll never accept the assembly version, but I want an
> > explanation for why it's necessary first. If that's not something you
> > can give, at least describe in the commit message what goes wrong when
> > you try to do it in C as justification for not doing it that way.
>
> In practise, I found that sometimes there are boot failures if I
> enable SFB/LPA in cpu_probe(). I don't know why because processorr
> designers also haven't give me an explaination, but I think this may
> have some relationships to speculative execution.

OK, applied to mips-next for 4.20 with that noted in the commit message.

Thanks,
    Paul
