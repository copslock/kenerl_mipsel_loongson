Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 19:12:09 +0100 (CET)
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:10775
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992783AbeKESKl4v91H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 19:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgOcS7kwe9d2KeTV5hxmW2lXp6viz6U1ZLGzJ1GowMQ=;
 b=WCN6917LXXkz9hfGM42b72wK95g/UXvfahIQGGpJTrYXA4woFipvbyNRKSBX+aASKHUInT1TNCyBL31R2Dt8ElIQN61NbMHL+72NtrKUzg3NU7zcyvSkyN3+5cSuP3uM6QhhjEvoJcJsER0ovGnvapuyi23SG/SfuZxKhZazra0=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1279.namprd22.prod.outlook.com (10.174.162.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 18:10:39 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:10:39 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
Thread-Topic: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
Thread-Index: AQHUcbhcbz7B9XfQTUuMxTjjhGHjqqVBgkOA
Date:   Mon, 5 Nov 2018 18:10:38 +0000
Message-ID: <20181105181037.m2hxoosf7z2bz7lu@pburton-laptop>
References: <20180914095808.22202-1-hch@lst.de>
 <20180914095808.22202-5-hch@lst.de>
 <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
 <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org>
 <20181031203206.GA28337@lst.de>
 <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
 <20181101051359.GA4164@lst.de>
 <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0052.namprd10.prod.outlook.com
 (2603:10b6:300:2c::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1279;6:GaGw/kGKHhFqC4J69XoppFOBcvLGhbuK/uNrwPcRTxwtVBKPpTLPcdUUgLZpthaUVb7/YTJ8rC41yJDCOm0Ip1/f+VPXn+EcTssfKXnR46XZp07CRjTrVO/nFcP3wPwhYyYnTmcdv3foXe4INSwFRYoDJEymkmg/SwJGEoIFhQEPkM2GGsTM99Wrk41ZZj/EYRFBluzBWBbsjgA1iWM8VU+7kq2a5Bf6dEV6CXiTL5ypwqVwyvMGBxlqa+EoopOhoC78vpvkYPeMWe64bowXIvpUW9MimChSG9R+b8ANN13zPAqEhmUito0Ixf7Wbx8HkBrgl9jFc4Ub55QfKAucvIeDR0q4R9A0Lbq8a2axvEvkIGkGe9WzIcJ1CzdiQhLG/QE72SXYWHnyxNNemLqsvadN9TVDgANW28ceYH8DosWIM60xVbK+ALFRryVaaXpe52m3Y7uHb1sxyvydct5YCA==;5:9OMOUYb+r5Hm/JtLBnT7NjSo0tPHVQpVXNfcebq4+UgalOQHHRrk7fQXIZe5kP4/ruu0j9jLCOAAhD17Rak++vlqJ492t3bAYTNJKSs7yPQcjSqm5g14WTsjRvshxs9BGhoslIh6P/PwSyC9SmJLMbXzsUHWhBmp2pibQN77i5w=;7:vsvN5mG4wneVHl2b9gAZ5ZF/HWwtqNDizB3TED5jYin3Ju8/qmg40nmMvNAEgMeHJCtbA7Qa0OSnI3ZHOl4nEZNxcn4rfVJq0eE3O1+hfB/elBfwgfFmz178UFFmadtCGFAehBRhhMcBxl4k+vaPAA==
x-ms-office365-filtering-correlation-id: 5e8176f9-16d3-467e-f81b-08d64349fda4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1279;
x-ms-traffictypediagnostic: MWHPR2201MB1279:
x-microsoft-antispam-prvs: <MWHPR2201MB1279AF95CB0E7A550A72EFC0C1CA0@MWHPR2201MB1279.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1279;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1279;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(396003)(376002)(366004)(346002)(199004)(189003)(6486002)(106356001)(6436002)(2900100001)(6506007)(14454004)(11346002)(54906003)(316002)(58126008)(6916009)(2906002)(6512007)(6116002)(386003)(3846002)(42882007)(4326008)(9686003)(102836004)(33716001)(71200400001)(81156014)(446003)(8936002)(71190400001)(229853002)(81166006)(508600001)(53936002)(476003)(25786009)(97736004)(6246003)(305945005)(99286004)(76176011)(52116002)(66066001)(105586002)(68736007)(93886005)(33896004)(486006)(26005)(44832011)(1076002)(5660300001)(14444005)(256004)(8676002)(7736002)(186003)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1279;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l4sVFJ+0xkOLwK7fN6x6Yg8KJSW3MXu6s9XlF866DKhUb1QioVzOeo9pJv3iLiLZ0NOSY/PQFZd5JSNqXLUryBLPfgMhYnKIbAI+HdXHBjwJbBrtrDsvOAnN1MVEa4c8kb9CjeLsDS1CfjoN3Y8Ah7P4eza/fTkb76+kqHZYgfndj4BGsmDpYa9cgNUKi7UMNHOWMm1iScg7+wL8mycK5naEygMWa6HP4dfBsHx9QrR9H8kC8UsmDw5cJFVehGUJLFwRpE88gpIbQMYR08P5/LwoUzmXZxz/xZZM1VyU1waWwBrSjNMi+SkWNTpRkq2RIVqbHrLyh7/pX1CD8KmcPCC0DN+PV0TzQGMUKDpKtSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5FB772CC972D748A869B1B81057D179@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8176f9-16d3-467e-f81b-08d64349fda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:10:39.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1279
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67087
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

On Thu, Nov 01, 2018 at 07:54:24AM +0000, Maciej W. Rozycki wrote:
> Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545 
> ("dma-mapping: merge direct and noncoherent ops") that causes a cached 
> allocation to be returned on noncoherent cache systems.
> 
> This is due to an inverted check now used in the MIPS implementation of 
> `arch_dma_alloc' on the result from `dma_direct_alloc_pages' before 
> doing the cached-to-uncached mapping of the allocation address obtained.  
> The mapping has to be done for a non-NULL rather than NULL result, 
> because a NULL result means the allocation has failed.
> 
> Invert the check for correct operation then.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
> Cc: stable@vger.kernel.org # 4.19+
> ---
>  arch/mips/mm/dma-noncoherent.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, nice catch! Applied to mips-fixes.

Paul
