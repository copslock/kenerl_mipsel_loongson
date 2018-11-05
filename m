Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 00:06:21 +0100 (CET)
Received: from mail-eopbgr820122.outbound.protection.outlook.com ([40.107.82.122]:10871
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992810AbeKEXFRM03Ss convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 00:05:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcl0x9JPXnqxi7nzXFtjjnz1YL/cmqZRsdmBPtj6a1Y=;
 b=FIXqJr6H7mGeJu+IJslYnc0qvmLPMP0yhC+l7Fju7PYBL868zoTwAYhDUxTvFGS/F+Okv9QeafoHvZvFKbQUMC7UHimrQfwoDlwUzse2xcyacish80+L+ASddKKWM4kaWZXVD5GWRFoYWUlqs8hUkHrZwqBEofjbaQ9mV9e6usU=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 23:05:12 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 23:05:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Daniel Golle <daniel@makrotopia.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@freemail.hu>
Subject: Re: [PATCH] mips: ralink: add accessors for MT7620 chipver and pkg
Thread-Topic: [PATCH] mips: ralink: add accessors for MT7620 chipver and pkg
Thread-Index: AQHUclDU4A9bTORXSkObreQnHb9S5KVBiDyAgAAc34CAAC5EgA==
Date:   Mon, 5 Nov 2018 23:05:12 +0000
Message-ID: <20181105230511.ierfp3yyqdwkggml@pburton-laptop>
References: <20181016103806.GA1544@makrotopia.org>
 <20181102020713.GA880@makrotopia.org>
 <20181105183615.nbvnfapug6zm42pg@pburton-laptop>
 <20181105201935.GF1389@makrotopia.org>
In-Reply-To: <20181105201935.GF1389@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:300:ae::30) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:eF47f47jPsRC9mhkqhwKbhFBUTmX4r7J/xyLo5egGHaAMSKT4sqkJ9bidIDYz+pGna4VQnCwy4tzktGhUNWb5cW0/lfEXM6L/VsJu7Ohdb6OR1Xyw5K88PhmCHyYjJO4h8G4HFAiDWz5ELAZeQOzSwcXmOUZRSA+pDDNs8v0b6ztQH8PZfsaR35cKXGCKLf34Ofaeawwt3wt8kNxYbmoVzerSY0vCSnMdqCJRqJiBRSwpPotaMcYwEi2vyoioWVHySK6iE7VpiVNB61kUPcGcx6aMSkWcXLIcHnQnyg2GQAh41rLsFwaextQDnn1txJ1p61dVVhAL7F7fb5oeYWD2RH4FCVdb5hbEg+t0M8bm5pvaLpiEZ3tO+kIftmgd30rWcn6wmTJVNaoJNh+jYi1By0k6XsC3hDqhyQP4qQvmiCcmd7CStckWOXzgzQ7kPke6iFN6ddC55aAbMYXgAlq7A==;5:Q03HxLIadYSozW4BfAIIdjvcLjptnjT9SVjgVcj8TaGlNvhf5klXpzSZ8tCX11uZU33m/9xu6MDChLTbNvsVVFF0sRCp2CeGAganNyaqOVGSXuK2oNCCfrYgUgF8Df6wnewP/Lh8QgTNJFmFDez3ZpwutJxufu7K7yYjId60oD0=;7:/GPLyFVT4i7VLoA6dd8kruUW+VVJ2s94YG6BY9051QIF3WnXhgpVqf8k6ctMrKpOoThPQ3vvXBtwGh1ZRWx4ps+Gxp4R44X+Q2st5mp9dPowFlFI+S5w1I8t6kowx9Rxiz0Q+HFOhy5NZxLet7yVoQ==
x-ms-office365-filtering-correlation-id: 5ceb5bb6-5fd8-4392-e79e-08d6437323b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB156659207FB7179009B67FB7C1CA0@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39840400004)(376002)(366004)(346002)(136003)(199004)(189003)(9686003)(508600001)(66066001)(11346002)(446003)(2900100001)(186003)(316002)(6486002)(42882007)(54906003)(6512007)(58126008)(4326008)(6916009)(53936002)(345774005)(305945005)(7736002)(97736004)(99286004)(5660300001)(39060400002)(6246003)(68736007)(105586002)(229853002)(2906002)(26005)(14454004)(106356001)(8676002)(25786009)(476003)(6116002)(8936002)(3846002)(44832011)(71190400001)(71200400001)(93886005)(6436002)(14444005)(1076002)(256004)(33716001)(76176011)(81166006)(52116002)(386003)(6506007)(81156014)(33896004)(102836004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s1sV9F34ZZ8IdchQrXMrgx1UG8rINd14BN6SH2y10NknAZsC7cYdfD4skGU7V8lqSC82L2izVKRnCP25VqWf5603LwIK/ZrVwvOgdFEs6qChnGFdKQTAgU02q73TWB8FLQcwXMtsqhRN87K0w4v3OzwxMqL5sVlm42X2iSj4KE9zzcj8FQ+AepQzBVtyubL4eQOqrDarAnRLUXHdCiq2mQu0Gtbl1Qz9AHMp8SzU130AzMSHjwQho9kdd6uZ+Xi0emQpl8EYMhPiJTg/1bf2PXUQmhm1zWUJOncRTUG6CtR2XDMwZ3m8M4z8OGPjzyhQgJOBozMtu2P8/TkKXgAmxueTIwUifPFkFEk+zkS5a1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <356D88B2F368B24FA4236AD813D379E8@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceb5bb6-5fd8-4392-e79e-08d6437323b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 23:05:12.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67094
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

Hi Daniel,

On Mon, Nov 05, 2018 at 09:19:35PM +0100, Daniel Golle wrote:
> Hi Paul,
> 
> thank you for the review!

You're very welcome :)

> On Mon, Nov 05, 2018 at 06:36:16PM +0000, Paul Burton wrote:
> > Is there an in-tree user for these?
> 
> Not yet, OpenWrt's out-of-tree Ethernet driver needs the already
> existing int mt7620_get_eco(void) and is going to be upstreamed once
> MT7530 DSA for has been completed to work with MT7621. See the driver
> in [1].
> 
> The two newly introduced accessors are going to be used by the in-tree
> rt2x00 driver which gained support for the RT6352 wireless core
> included in that SoC recently. In order to be able to carry out tuning
> in the same way the vendor driver does, rt2x00 will need to access the
> pkg and chipver fields. See [2] for example.
> 
> > 
> > Looking at it I don't see any in-tree code which uses the existing
> > mt7620_get_eco() function. I'm not fond of adding code which isn't used
> > at all in-tree, I'd much rather we either:
> > 
> >  1) Get the driver that needs these upstreamed, and these functions
> >     could be added at the same time.
> > 
> > or
> > 
> >  2) Keep functions only used by out-of-tree code out-of-tree.
> 
> I understand your concerns with regard to the mt7620_get_eco(void)
> function which is currently only used by the out-of-tree Ethernet
> driver. However, the to-be-introduced functions mt7620_get_pkg(void)
> and mt7620_get_chipver(void) are to be used in-tree by
> drivers/net/wireless/ralink/rt2x00 in the very near future. I just
> wanted to consult whether the introductions of such accessors is
> generally acceptable before implementing the changes in rt2x00.

OK, then my suggestion is that you include this patch in the rt2x00
series you create & feel free to add:

    Acked-by: Paul Burton <paul.burton@mips.com>

Presuming that the functions are used by something else in the patch
series.

Does that sound OK to you?

Thanks,
    Paul
