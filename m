Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 00:56:12 +0100 (CET)
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:18011
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbeKSXyeoGR1q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 00:54:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0mXjHtSS4jJd9CWwILmmAsm3b1fB/+flwES4ehz4tU=;
 b=nexF5vsUNxHecC4W2J+kQRP8B8W5LidM+5xILtoAI1hgOKuUvOJi52V1t+PBVZwFt8vHis4qPhGn8/nRUXarZulNuYOX1LlI17oQqj1s3sGPEwcHbIerwcis029zuDQiJxR4li5YQHqIX/UURH/5KbVcf1JlN2jxhRjJmkWYFrg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1168.namprd22.prod.outlook.com (10.174.168.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 23:54:30 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 23:54:30 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/10] mmc: jz4740: Get CD/WP GPIOs from descriptors
Thread-Topic: [PATCH 02/10] mmc: jz4740: Get CD/WP GPIOs from descriptors
Thread-Index: AQHUgGM218rxruqNnE623sU8elWDiA==
Date:   Mon, 19 Nov 2018 23:54:30 +0000
Message-ID: <20181119235428.tj5zkwedi4x3d4e7@pburton-laptop>
References: <20181112141239.19646-1-linus.walleij@linaro.org>
 <20181112141239.19646-3-linus.walleij@linaro.org>
In-Reply-To: <20181112141239.19646-3-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:300:d4::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1168;6:iQnPfULfjnA44oWC8LY0rwv9jw1V+JKVttA5tgZrcfZhDlSryJCxV8egOcpNK3csQqaxYBN0rlrp5nLd0MISFF15FwDlpmTxCeyY3+0TRUweJw8dJbA1N+bojLwjgldeI/1zhXW2T/CiFLHBw0UpNJcLtOpV7ABwqi1Ueyo1B8cIyu/fk1O4Xps+eAICXLW3INhCxXPj4bMc8XjHoh0RDgnSQs10TCW/Mw8w6MVCvgF2Ple7bIXTdPVmxkkfFku1qqw0lx/64d+b6W/RG9W8/lOBVer9R1kcMPxcukWzH06cegycRQVH0A6S5zSI9qDMQifmlbUn39zr9T6tjhMMwhFDxsbjg8PfD7ywOngFXnchZkZEH2Gbftck6Rf5xMBXZAmy5xfb0v35cM94bx1GiMe/asQAXkjNZ5gJL2vJyioZfuBKzdf62wquTsoeIIL4pYZVPqxQW9cx2l1KShXsqQ==;5:3WE1U6tb70UtdmeKnZGodho//zP2gJMV2AxugcnVboDjIVycWlYtzawYJhzqehZma6uZDHvex4F2LPRA7lwvsyYGsY3/1swKZ7vg5XBy283XnTK/yUsOYDJhmAG+5MHQxldW1R+DQuRoJOsaTSBcjyAaWXy3dvjK77ipqbr18yw=;7:QI0ZCRi3xwGucNzIc43MyhZo+GwwrSrpKipTXWYVSGfZLUu5pxfqc7EdbOCZQ3Z0GuZDGIxKhMUKUWPtiTF3Hb8edOCwrz9H4DTM4xmuTYipfnAu+dN0oB6iyqBCAuwEdw5CjzELVL7Lddc0FMpofg==
x-ms-office365-filtering-correlation-id: c5dfe73f-9873-4e52-937c-08d64e7a580e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1168;
x-ms-traffictypediagnostic: MWHPR2201MB1168:
x-microsoft-antispam-prvs: <MWHPR2201MB1168CF07835BA5504380A51BC1D80@MWHPR2201MB1168.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1168;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1168;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(54906003)(33716001)(6916009)(76176011)(99286004)(58126008)(71200400001)(71190400001)(4326008)(6436002)(25786009)(52116002)(316002)(53936002)(106356001)(14454004)(105586002)(2900100001)(256004)(44832011)(66066001)(486006)(6246003)(476003)(14444005)(11346002)(446003)(5660300001)(81166006)(81156014)(8676002)(229853002)(8936002)(97736004)(42882007)(33896004)(305945005)(386003)(7736002)(6512007)(9686003)(6506007)(186003)(508600001)(68736007)(6486002)(102836004)(6116002)(1076002)(3846002)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1168;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qr2AtNg+L2euY92F94pZtbFX5aDtqIbHNmZEWLnYdDRRtsq2cO3r1a3xbT28tdXZWJDvk749pvqD8+OnL07rADusBRZHvSgpgCg085ibsfGsdq5c5hzHf69ngRjo+su17Ru24EVGTAO2PHMbjfhHUxZRo1rQBYWZ5JMl0XUisjyqb+EJXYmVk8X5+AmWMtnWMzp40RgD43E5QVu96X916TKUpOi6GlLbUezFNtqrR/sBCUxIP60zPgKUcmurybIwfGRHp7XJp0E0m/t4f1VqSe6GkrYmwK7t4sLcvdlyRZQC+9/FLGEsBEtrx1EhSqFd4teJx6Wj3cqjelrvf+bW8iqysTqdx0zbAkFNxHGrGnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBDF11BF2599D440B2C6B1163BB9B3FA@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dfe73f-9873-4e52-937c-08d64e7a580e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 23:54:30.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1168
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67390
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

Hi Linus,

On Mon, Nov 12, 2018 at 03:12:31PM +0100, Linus Walleij wrote:
> Modifty the JZ4740 driver to retrieve card detect and write
> protect GPIO pins from GPIO descriptors instead of hard-coded
> global numbers. Augment the only board file using this in the
> process and cut down on passed in platform data.
> 
> Preserve the code setting the caps2 flags for CD and WP
> as active low or high since the slot GPIO code currently
> ignores the gpiolib polarity inversion semantice and uses
> the raw accessors to read the GPIO lines, but set the right
> polarity flags in the descriptor table for jz4740.
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 --
>  arch/mips/jz4740/board-qi_lb60.c              | 12 ++++++++---
>  drivers/mmc/host/jz4740_mmc.c                 | 20 +++++++++----------
>  3 files changed, 19 insertions(+), 15 deletions(-)
