Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 20:08:14 +0100 (CET)
Received: from mail-eopbgr790137.outbound.protection.outlook.com ([40.107.79.137]:54432
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991346AbeKSTGay2qJv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 20:06:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYg45vlXLiYksrALHZ42dUIShuf6S0XfUn9RtBYRLso=;
 b=eO4inj+iXEnkhqJj3lhGjqf3atgyf/D6IR1RGzudUUFYx39n1ip7hp1puzRyxphb7z/3ukoYd8rPulnwhF+lFOUtFnNR4s/YZeSS+Ieyk8Z+COXk81s4sjDuUgWNRktC2uZyQvRUvFBIVwniU2k/PH8BXfU7r3/7vse1q2yZfSk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1327.namprd22.prod.outlook.com (10.174.162.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Mon, 19 Nov 2018 19:06:27 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 19:06:27 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Huacai Chen <chenhc@lemote.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn
 calculation
Thread-Topic: [PATCH] MIPS: Loongson3,SGI-IP27: Simplify max_low_pfn
 calculation
Thread-Index: AQHUetWT91JwGrXCmUCrq7i3nDCSA6VXgEOA
Date:   Mon, 19 Nov 2018 19:06:27 +0000
Message-ID: <MWHPR2201MB12771953A7F479D5670BD8E6C1D80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181112221742.4900-1-paul.burton@mips.com>
In-Reply-To: <20181112221742.4900-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:320:31::12) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1327;6:RFQAGkm+Ah+1qAzF1W4qfJQijAEYTur06I99850YgDBjkssLeLJc3jsSOiD+EfrgzH+DqZZFJWJM3J2TYk8lNYExRLtqvTQydKBhPMbBEx0n2T+/nyzdakU1sK6+QG/ExHV7S8QmQpS3TD/2YMVq0iGVDBmVWoCUZzJgFlDm0yTXfH+MQKffqH/FekTSn6MqBODw8nSe9GMki62W9310J3iJ95ySQsJCwzMjp0/ikfOzgGvreTst83x9oDC5i0QjOK7V2y6IjNDAU2L8sagE215yes2dHtYST094Qd9L/bRvfgJziKvQAvYNg4I1zk4/qlmY/gf4R6CP0Zd6779ETuiMHsmXlv8nlMeTap1CaKs1uhlqS0KLMBCzAsLgVBbnD/ZHGIYzeSG2968tgE464BjA5xx239RgTskAjX2KzI3oKKiDc1BgR/CsTD1HO6Xk3pQlEzkqiQR7cw9CgYfkrw==;5:rNQmT+A+vdsGWJdeHukJC74nNKfzP8rGgE83qypik4/dOIwjIEB6H83JM7VxJygXPzootoK7SlxtZ/BF8l5/8ziozqlQBZT9TXvpfD+nBsN3axs8Y2H5G5ElYlzFGIRFFNcoxQS3EF4r6xvJg2uph/cqSBskXgCvCDbwBZVQ5Vk=;7:/Jqnwcmc6L4nKqdWJEaQzb801DxvMZMMHztPrElCXoXYmuQEsaRwhbbWMrWkJUenOPQ8MgaEgqD7Nbnxr59oWGOBNL9AOYL2dv74mpvTLQvz9k9GasPSujxM5ElhQZ3j+VDm+J+YYIwBkxeoLjvicg==
x-ms-office365-filtering-correlation-id: b0711ed0-f16b-48bd-7e45-08d64e521afa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1327;
x-ms-traffictypediagnostic: MWHPR2201MB1327:
x-microsoft-antispam-prvs: <MWHPR2201MB1327E09F4BC62AD7071F2CCAC1D80@MWHPR2201MB1327.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1327;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1327;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(476003)(6436002)(7696005)(2900100001)(76176011)(446003)(7736002)(66066001)(11346002)(8936002)(186003)(386003)(6506007)(486006)(229853002)(2906002)(25786009)(102836004)(6862004)(44832011)(305945005)(74316002)(99286004)(52116002)(6116002)(42882007)(3846002)(316002)(966005)(106356001)(256004)(54906003)(97736004)(6306002)(9686003)(6246003)(14454004)(478600001)(55016002)(53936002)(71200400001)(71190400001)(105586002)(26005)(68736007)(33656002)(5660300001)(81166006)(81156014)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1327;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1OQ4+M5UrFEEaiaV18Y8rkQisCdzMzUCYF1iy5KzOFJWsh8bO5TqHdXCujV1qYOfsZkS3F/dwvX7CFylCoc9cgGzPoQHErSilQDGQZMci0EpV1qY6M9lSFNjbADsOR2KVON+uUqKac8c+ziK10ueXS4sr5hLsUQCcR/uhMq9n28CSNYdXeW5oYb5yAU5fAfxPA8VX/tU98h1LudHC79Aegg99xtpG/vpoKt2/+KNMS6y2PC09jWuIxq9bJgI6pgMq5uspshGyZ26DtrJfRbkbi7RJrwAIYyrquIG3dB+dE8psBiB968bMFOhWcETKtXEoSbsdlkmLQh1rEQXLMiGuFs3py5m1FKZt/pcDvKkWJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0711ed0-f16b-48bd-7e45-08d64e521afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:06:27.4289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1327
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67378
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
> Both the Loongson3 & SGI-IP27 platforms set max_low_pfn to the last
> available PFN describing memory. They both do it in paging_init() which
> is later than ideal since max_low_pfn is used before that function is
> called. Simplify both platforms to trivially initialize max_low_pfn
> using the end address of DRAM, and do it earlier in prom_meminit().
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> References: https://patchwork.linux-mips.org/patch/21031/
> Cc: Huacai Chen <chenhc@lemote.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
