Return-Path: <SRS0=93BA=PR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC19C43387
	for <linux-mips@archiver.kernel.org>; Wed,  9 Jan 2019 22:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCDE206B7
	for <linux-mips@archiver.kernel.org>; Wed,  9 Jan 2019 22:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="os2s35l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfAIWIt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:08:49 -0500
Received: from mail-eopbgr790138.outbound.protection.outlook.com ([40.107.79.138]:55264
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbfAIWIt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 9 Jan 2019 17:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmFQ8mKLGAVs8zlbYM1iB7Fs2xvPKMo4VMrMyCL1wd4=;
 b=os2s35l/RFPEANpSJcorxVDdhNWqL9EL6XtjbI4fCwh5Cr6MxO4OYckznLk5BqqV4RPfxv9zB6hYcAgKxCupIhmYBiF3HaaR2ykARMEEZjKtOeKJfULTqjyZlWAg03JxLE9kQ3gNgpQ7ksdM5qTqIC3+SHvlPdv4qxICqlvF7V8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1534.namprd22.prod.outlook.com (10.174.170.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Wed, 9 Jan 2019 22:08:46 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 22:08:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     YunQiang Su <syq@debian.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chehc@lemote.com" <chehc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Yunqiang Su <ysu@wavecomp.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Topic: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Thread-Index: AQHUpQeBAWrYYUkmtUGq4PuZ5oHDz6WnhbYA
Date:   Wed, 9 Jan 2019 22:08:46 +0000
Message-ID: <20190109220844.qk5ufkzjmfwxe5aq@pburton-laptop>
References: <20190105150037.30261-1-syq@debian.org>
In-Reply-To: <20190105150037.30261-1-syq@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1534;6:+7WBiuuGQgzfGhiUn71Q+psjonUeuTHCTN9qdvUJeGyOjFNGYIJVwoRq9z7n/7OWNHy1Se3yl15OHENi1tPhxFuH/FF+WrWUloclypn+2zsOpFL+zWh+drFLoHAZuOmfqm52WrPYNuXo3OOM3ZFqg3es/yn5jmF9g2oe4Zh25O9/MovzzuJTIgePhmX2NmJBzKYdJaE4AmJu3sKYyQ8LL3180fe9ENPP+OuLH0oA7qdyF2UorOIqZ+Onl6+PKvDsLZ7dkCvb5kgB7RvTv1CePu/5UBH+DZzkkUaqZb/46z68ufq+TKvx6Y5RfC9cVw/r3p7duGJqDTiDL1aMyyysl6gJni59CynydrRnZZOzavzYrXUSn16/aQOz66vhgq+kUyWd2laYUWnQfoVI2OKGExUpxZimAvxI+R9jVVsUr/pNLz7lUG9HzWb7GGqH3bXf7a+sJGm8Up5qu8yCYlRxBA==;5:GB1rhTk38MzBYvs6WKedLFB1gG0HlSv5I/2IQ2L0QRAYzkV8WKR255bPd6pIPbs/LeQbRQ4vTWjpFJ7XBNg0knbGuGg9a1id7Z+1KxzQgLxbKdMAaW1hc4+Sn7mBVnf0gKA9o8SlZtzbOxILRd5OWSFtReZKdgjKJFQQYyoGjrQk8+Pso95f5Um22AcD7o6Zmmeq1C6w4YVimJlDrhHvaQ==;7:6+p3AcsJPqAtyxLylvBBDzS1/h3b+c5KlHu6ubOrP0SCuJXJjJMSot00gSocMeVkgAecpJbkXTb3PU49bcB4tgn4nNd4nmb25cxj9jgPDSyavvzZmqIwTJKtWVPn8rdKmUr4NjxDn3+Yo64z/5v+zQ==
x-ms-office365-filtering-correlation-id: 647b42fd-addd-47b9-5b87-08d6767f061b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1534;
x-ms-traffictypediagnostic: MWHPR2201MB1534:
x-microsoft-antispam-prvs: <MWHPR2201MB153414D9DA7E4BCBB37D1A78C18B0@MWHPR2201MB1534.namprd22.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(346002)(376002)(396003)(39840400004)(189003)(199004)(54906003)(33896004)(76176011)(1076003)(229853002)(476003)(11346002)(6512007)(6246003)(8676002)(6506007)(42882007)(105586002)(446003)(66066001)(9686003)(107886003)(6116002)(386003)(3846002)(8936002)(81166006)(81156014)(6486002)(6436002)(58126008)(316002)(26005)(102836004)(53936002)(39060400002)(5660300001)(97736004)(305945005)(7736002)(14454004)(4326008)(186003)(2906002)(71190400001)(486006)(71200400001)(33716001)(99286004)(52116002)(256004)(68736007)(478600001)(6916009)(44832011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1534;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LTFZAtUtSxxoi05ng2S+PgGuuFeJwcZ6hB2vdqCinSWygsUyExvmUr4mQzneVAv73MuuOEakNg2XUsB4GgEldN6U11yPZOYIuh+jUHc6vf8OfHQIhbDpruIMxN6C46nupE/1o86SUsIZHdDak/9Hw3X8Swp+owipbYrGT/PSAEURU634DaRDL5XCEuviv5Vw7rZcw2M4VUfVXAV+5WyJ84OF+uAdPANxZ2vBFMcoZ7eSsirh6Edhn5sZv6H2Ngi8S9vD3s6ziRt49ziT4feF/WA7JARd+Qf/HdkqN9+9ZHGcy09BycIyrBHqq815ep8k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <456318F5E5300B44BF44A3A34D037E31@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b42fd-addd-47b9-5b87-08d6767f061b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 22:08:46.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1534
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi YunQiang,

On Sat, Jan 05, 2019 at 11:00:36PM +0800, YunQiang Su wrote:
> Loongson 2G/2H/3A/3B is quite weak sync'ed. If there is a branch,
> and the target is not in the scope of ll/sc or lld/scd, a sync is
> needed at the postion of target.

OK, so is this the same issue that the second patch in the series is
working around or a different one?

I'm pretty confused at this point about what the actual bugs are in
these various Loongson CPUs. Could someone provide an actual errata
writeup describing the bugs in detail?

What does "in the scope of ll/sc" mean?

What happens if a branch target is not "in the scope of ll/sc"?

How does the sync help?

Are jumps affected, or just branches?

Does this affect userland as well as the kernel?

...and probably more questions depending upon the answers to these ones.

> Loongson doesn't plan to fix this problem in future, so we add the
> sync here for any condition.

So are you saying that future Loongson CPUs will all be buggy too, and
someone there has said that they consider this to be OK..? I really
really hope that is not true.

If hardware people say they're not going to fix their bugs then working
around them is definitely not going to be a priority. It's one thing if
a CPU designer says "oops, my bad, work around this & I'll fix it next
time". It's quite another for them to say they're not interested in
fixing their bugs at all.

Thanks,
    Paul
