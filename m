Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 21:42:36 +0200 (CEST)
Received: from mail-co1nam03on0118.outbound.protection.outlook.com ([104.47.40.118]:6349
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIUTmdALBxI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2018 21:42:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evKKJU2ZrofABVlGAt3NtS++qWvftMfLoTo7RCkBWCg=;
 b=eH8ujKTo6naJPDXor0ec+6WxekXRGSwEVJzcZzrRPn77nAsgULpyF/gnoDktQe54ddBMTssUH7W1GEsMxl8gUJ/AVN5W//PNUaX6rCRGfrxaHZ2jNDmujNz60U6HkXfAFDdNR/z+BBKLBmiRtih94U5aqZfoiJUSzQ4tpDbH9Po=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4197.namprd08.prod.outlook.com (20.176.250.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 19:42:21 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 19:42:21 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Thread-Topic: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Thread-Index: AQHUSa31EH+nWViWyUqWS4bgWcE9KKT6UFYAgADitgA=
Date:   Fri, 21 Sep 2018 19:42:20 +0000
Message-ID: <20180921194218.at7ejkmmiucmawzo@pburton-laptop>
References: <20180911090049.10747-1-hch@lst.de>
 <20180921061052.GA13705@lst.de>
In-Reply-To: <20180921061052.GA13705@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0075.namprd19.prod.outlook.com
 (2603:10b6:320:1f::13) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4197;6:oagfglKhbEVVgiOazbc7iQAjAG1REXUz8RXzw6liNWPPRdW8pQtDeCJsbKGltCyTAjT7UZ3DqocVho1sKqHjtR6iQ6tUheCNcAGd5vhGcmfgK8HY524Tcz1DhBRjHp4X8FaNTPIG9H+tj/t2ofvOknr0dGZtg9bwQYFm1OSfaeXZvFB8xcBRucFgxBdBuR7HkJyyEpmvtS16DP3MwuUKiRsh5pm86D34W6Zlv6adKRl0YxVs5SlBbv0Fw55QkJogY/JYlPT81pzkhpUIrIuSvkDeFv09erd0Hzrdhr4E91x6tNg5rgkuJ7YGCnJiexGefBCjfdgSCy+WU4eyfKeuW7KtgVb8SkBeI9vy5NTxAX/jFXLH+MRpWeRjItiACEpbbcW1yIDdXIxw5JsJtaxOZlKDo7yo3n8ngSbuX65Yix3EFZ2F4qNaMTxnoK/yOWZgVnq3a0i4b6dWvQBvrIby+w==;5:IjKYmbbexfHigaAKvu0mLZxqHPdoijbYCgDAYv/CnwoIAETcudB/bs6KMMm6Uln3Bya79oRgg4/srcGjcfat6cCqU5KrAd1kPiNftJLvgIErelEDlw09dx1/Zgtrd94Me2oLf7ueW8EnWxJlpsPcxiznUN/JXWUVl1/POAUM20A=;7:IFFZoVaYY/BylouQoJDpJye0VpgVflCpyuhk0euXwf0oku54Xq8mkDPAiN6yne7WfdIxDa4YggTpDd+JOeGa8KBoCcBk+w23vI/IZOLAxpkyLYnFtpdBzYNrVkrxoZo/++IMY0XzLW1R54Kf2xDpziq7lnOg9+T7ll/ACPnXG5WehnEIrLaf6JZv6ebWPCDqyQkdR8gAorb18rLi5bTxI9JgySPqSymBqOGuwXSoKcmailvxm14zQSPoD6CSfvUA
x-ms-office365-filtering-correlation-id: 3395bf94-7f08-40fd-7d74-08d61ffa5830
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4197;
x-ms-traffictypediagnostic: BYAPR08MB4197:
x-microsoft-antispam-prvs: <BYAPR08MB4197BE5246CD3FEFE59FDAB6C1120@BYAPR08MB4197.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(155532106045638);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR08MB4197;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4197;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(376002)(366004)(39840400004)(136003)(199004)(189003)(81166006)(66066001)(81156014)(486006)(102836004)(476003)(256004)(8936002)(106356001)(105586002)(5250100002)(14454004)(478600001)(99286004)(305945005)(54906003)(8676002)(58126008)(7736002)(9686003)(6436002)(33716001)(39060400002)(6246003)(6512007)(110136005)(316002)(52116002)(76176011)(33896004)(68736007)(4326008)(97736004)(25786009)(2900100001)(229853002)(53936002)(5660300001)(2906002)(6486002)(42882007)(44832011)(446003)(71200400001)(71190400001)(3846002)(6116002)(26005)(1076002)(186003)(11346002)(386003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4197;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yziFI+6cm6f4h8HOuRX/QrbfyLYOOBmzNxRwUmOCCuyY5wH1PdWjRjYzBXmZztYjdPuyL5lr680YDIUbDE1Jc+Aa9N8uu7V61j6TnB8/MkARJ+y/xLiZcDqXWmnfcavwNZ/nzSyitKrNugl5vSXrp2JBfYHt7ucivptK39DUpMJ1sAACqrOk4L0TTIaEPm0LwylvwjSFrDU4/K/CanzCbMmgWZ9tUrwHreYZ5holGdjou88vjgAIwcoIg37yIe4SGiFEsObZd46jMQ4bd3cdBFvuEL2Fo6hgLGl0rdgPeBjoGf7UnCkxzi4rCXxN30Y6qsgFJ5sZuENzlUuaxrEjMgDM/RKxXzYwWjTlbJ510a4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFF51622A9D0EB4C959480118C3EFF15@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3395bf94-7f08-40fd-7d74-08d61ffa5830
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:42:21.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4197
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66486
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

Hi Christoph,

On Fri, Sep 21, 2018 at 08:10:52AM +0200, Christoph Hellwig wrote:
> Paul, other mips folks, any comments?
> 
> At this point I'm tempted to just move it to 4.20 and add a stable
> tag given that no one cared so far.

Copying Kevin & Florian as maintainers of the affected BMIPS systems in
case they have anything to add.

> On Tue, Sep 11, 2018 at 11:00:49AM +0200, Christoph Hellwig wrote:
> > The patch adding the infrastructure failed to actually add the symbol
> > declaration, oops..
> > 
> > Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  kernel/dma/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index 9bd54304446f..1b1d63b3634b 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
> >  	bool
> >  	select NEED_DMA_MAP_STATE
> >  
> > +config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
> > +	bool
> > +
> >  config DMA_DIRECT_OPS
> >  	bool
> >  	depends on HAS_DMA

The change looks reasonable to me, so feel free to take your choice of:

    Reviewed-by: Paul Burton <paul.burton@mips.com>
    Acked-by: Paul Burton <paul.burton@mips.com>

My thought would be that it would be ideal to fix in 4.19 since that's
where the breakage is, but having said that I don't have much insight
into how bad the breakage is for the affected systems.

Thanks,
    Paul
