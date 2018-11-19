Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 00:56:19 +0100 (CET)
Received: from mail-eopbgr680134.outbound.protection.outlook.com ([40.107.68.134]:11440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992767AbeKSXzMJWT2q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 00:55:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHYQTow3OViDbrLfkstiLoKb/axIimJmkz8r9KINo2w=;
 b=Kn1kcLsGkBDy+JElwb40HLa0bJ26iDuAKADznxaS/7zw3X8zsjkz5YvTqkH0kgfArnVd9YlyozFMLEV/kb9dE82Zv9cPL/OL/hvUhmsCNQMHP5RqJAaihWjnZp/wWc4ji9ISYkZFvrXljVow9QNJnnCkpqHeQuG550CGJgXg/M0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1168.namprd22.prod.outlook.com (10.174.168.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 23:55:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 23:55:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 03/10] mmc: jz4740: Use GPIO descriptor for power
Thread-Topic: [PATCH 03/10] mmc: jz4740: Use GPIO descriptor for power
Thread-Index: AQHUgGNNgBiyRy0FvUaf08oNYgAzkQ==
Date:   Mon, 19 Nov 2018 23:55:09 +0000
Message-ID: <20181119235508.ialc5uz6eta7l4vs@pburton-laptop>
References: <20181112141239.19646-1-linus.walleij@linaro.org>
 <20181112141239.19646-4-linus.walleij@linaro.org>
In-Reply-To: <20181112141239.19646-4-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:300:117::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1168;6:QVbztzVbRRtE+ZV5Te1PX8d0fZu8dO+sPQlPBN8NacMrvWn9mU8A6qULrZjOJ6yVsii9OJ43kXe73f/I3X55PAdbgT7mAP67yAVEy2mRA/iBtVMKdQdC0bmKLmhjlJy8A1+U5XNKBFrzTh8HNub5qr5VF/oFyb+1DknJcvcrJZ8B2QnKt0ChuvpGxEeG7+bqndWx4kTTwxrAz1DCADXn/X6HQ3/vqprmIHYIp2hIkjTeEhfmc+lbIuy1pbxK1/2QUCzFYJakkSM23jITWD+fChHi0RWHFCf8HtyrpsjZEeRIbDMBdVPRWCgGTbJQx13xsyMuD5vPLF3xxzdksLSS4VnUrG5eEIfBMN3Xb/c27+e10nJlwXyhmpaMZcydXN5cjTdc63XnXhUt3a+xUHRz1Z1jb7pSfUSQSHw9AvFGGHX1CeNR0CEMBpEr+Uym3EvryHxgfAaUqazJXjW8WEnazA==;5:JJfP+NbPnUtu6O+2WfBqcFk0ZnigYQp7IMkBSzavulO8RRr9EyTXw/StMjZ+6A6JaSUtX0I8ck0VzoGt1/PfrcjmkC+jejkANc7r+n6LHXDiF1zaBjttvTnr7GD/sgzJ8s7krM4DGGjuJv4L23D88NxaJ+K78wf2IvTgQTSlBy0=;7:LcIfrNHkg7v0DbQfQQe/aRyfC7FzHxJmhxyFhUka0hyjJz/c7dAdwBRloxUzljnw2YYgd0z+IOPqW3uXhpIPRn9V78h82W4PXbcfKyqaFej6uXHm8HF/3RcayLLtwvGK1sqzM8ux1P0Boi7drnsHIg==
x-ms-office365-filtering-correlation-id: e3d0a4ac-636f-4590-9d15-08d64e7a7030
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1168;
x-ms-traffictypediagnostic: MWHPR2201MB1168:
x-microsoft-antispam-prvs: <MWHPR2201MB1168B014E84B63EF1DA8FD45C1D80@MWHPR2201MB1168.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1168;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1168;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(54906003)(33716001)(6916009)(76176011)(99286004)(58126008)(71200400001)(71190400001)(4326008)(6436002)(25786009)(52116002)(316002)(53936002)(106356001)(14454004)(105586002)(2900100001)(256004)(44832011)(66066001)(486006)(6246003)(476003)(11346002)(446003)(5660300001)(81166006)(81156014)(8676002)(229853002)(8936002)(97736004)(42882007)(33896004)(305945005)(386003)(7736002)(6512007)(9686003)(6506007)(186003)(508600001)(68736007)(6486002)(102836004)(6116002)(1076002)(3846002)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1168;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vbPMzGi2Urs3jaJ4gVmGSmOKLcFQOmEPAJX0CGwXoZ7RkzCiB5JaaXZAETkJuEKMtnZ27dfnwn5oKEfKs0odqyUhBAthrFBJCzxn0yZpE7ThJXAK+4ibcTZjKG5uFdGNRrsC4Yg9dXXzqUC7dn+rTWbhhpsRS8+pmRR1jQyvsPFroP1pbqseSZTn/ddkHfArgUCY1zV05otW+zQ1aUDtaFU/ou60lgdEtp+PvorWbl1qdYUAh7btPqLd5mCeaypxkN26llypIv8LfHQ2X/O5Gm4QQxnl1Agbif/upjrDP81iuIOC/g0oUIntAD3EjAEk8p4jqZZszBGSYRNkAydZgbN3shb1J46C+9SHtq0YQfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61C394568C5E8A499AE5D14E3F31DE35@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d0a4ac-636f-4590-9d15-08d64e7a7030
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 23:55:09.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1168
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67391
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

On Mon, Nov 12, 2018 at 03:12:32PM +0100, Linus Walleij wrote:
> The power GPIO line is passed with inversion flags and all from
> the platform data. Switch to using an optional GPIO descriptor and
> use this to switch the power.
> 
> Augment the only boardfile to pass in the proper "power" descriptor
> in the GPIO descriptor machine table instead.
> 
> As the GPIO handling is now much simpler, we can cut down on some
> overhead code.
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 -
>  arch/mips/jz4740/board-qi_lb60.c              |  6 +-
>  drivers/mmc/host/jz4740_mmc.c                 | 65 +++++--------------
>  3 files changed, 18 insertions(+), 55 deletions(-)
