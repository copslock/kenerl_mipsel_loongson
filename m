Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 23:48:06 +0200 (CEST)
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:19215
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990393AbeIZVsDSL208 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 23:48:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZh5kF5nsocyo9wKlTnKDCq27kmajh00uaCH111mFyQ=;
 b=ADsSQ14Y2Y+kYQaiFeI5PSrjgzzYSIsaDjLBTzEAfsnha6vTOgADrvVQefeqMIr6uiAraKmHoZaKy3CrXNi5w5rwmHz6FlgJnLP+wf+ZyyHzhGSmBZwrz9uCHAbNwTDbKZXS78/kHFYlB8BS2eApP5nbAFFjWg391IgPW5yQ24Y=
Received: from DM6PR08MB4939.namprd08.prod.outlook.com (20.176.115.212) by
 DM6PR08MB4668.namprd08.prod.outlook.com (20.176.110.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 21:47:52 +0000
Received: from DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d]) by DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d%3]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 21:47:52 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: Re: [PATCH 02/10] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Thread-Topic: [PATCH 02/10] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Thread-Index: AQHURPt+32mRRKCVwUWowbO02c5p7KUDOywA
Date:   Wed, 26 Sep 2018 21:47:52 +0000
Message-ID: <20180926214750.4h7iuqaglno7i2mv@pburton-laptop>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
 <1536139990-11665-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1536139990-11665-3-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0048.namprd19.prod.outlook.com
 (2603:10b6:903:103::34) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB4668;6:3NVNpyWFKlNASmp36JAdXlo8O3xOpJ+FBp2rWXHWGf3GREZWn1jbbdg44H+kvjA4SPZ3YbFpL4BNNcH7Wr55hPgGxaxLqKn8CTYxliVqtRYGFUG4/PbtLaGKDAn3VSNeNvdcpQJBMyn2QcS4DBtQ8NYviLAFvJPhYdrvaHRtKDTzVWjbfM9ouaLz1vfncQduLj81RH/qwxJc0QHZL7FO+8g/apbQDsTHdNddKcxziGXbAKG8nRrBj2ZvuUtKZLc601wRrV+Lj4hq+B1DIISGDjnwwPer+N8lKCd8p1o0XpDjSstaamZfwqXiCv61QRvcgTjW8Xi2yUZsGDOcPjrSCp2KELns/lR0FI4U9w26eDEyQExOdY4NLQUXnBoFPv5UM8yLMgAIdNKfuNjWV+k7b30DrVX3yylGEdwbd8InSZMqZCDi4YJvedyRVt5p5x68o5ctunPfaxvdHLtH/bKI6w==;5:grEGMG4k5IQv0XWcM5lCHb243/VEY9zwBfOAQ0vsNA+Wzif2Wotmbn4RQVyss0qBX39wR3mcAB8nIgDwgkRDuJkT3MG4IJOL4d1Hx00MFkvaXVO4S31Zhlf8wgX3jGIQgEdsBjHUnGYbDtaTCAwbJbkMNqG4wiM3nwba2J0+0ss=;7:ez8FNEWcfWYoLKfbXVRJ+JK2psSxx6wF+OjR2YZi3V/wPnJesNVrWAvbIWmPsRBHMf2G60YkZO7oEqB521tYS1TcLRMQqBCgEduaWGntmMgfObgKXig3/Jqxewpnu+VhIPHgYOzrypj20zUgOlPGRke36UMINrueJyVpvrRrm6K/XsHG/nmX1XDiTbs0O/YDbmQ7HHMmbaGDwSoHyXly+OkSjXd3/gaVzSCfZ48X8zo/qgqLD9hWyPRvsgP7asaf
x-ms-office365-filtering-correlation-id: f43c9f20-01f7-400a-dce4-08d623f9b585
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4668;
x-ms-traffictypediagnostic: DM6PR08MB4668:
x-microsoft-antispam-prvs: <DM6PR08MB46687537190F02D6BBF4BBACC1150@DM6PR08MB4668.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051);SRVR:DM6PR08MB4668;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4668;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39850400004)(376002)(136003)(346002)(366004)(199004)(189003)(54094003)(6246003)(9686003)(256004)(6116002)(44832011)(7736002)(71190400001)(58126008)(54906003)(11346002)(3846002)(110136005)(476003)(305945005)(1076002)(33896004)(39060400002)(14454004)(446003)(6512007)(52116002)(6506007)(186003)(33716001)(6486002)(486006)(4326008)(26005)(386003)(229853002)(15760500003)(2900100001)(99286004)(68736007)(5660300001)(102836004)(76176011)(105586002)(508600001)(8676002)(81166006)(42882007)(2906002)(66066001)(6436002)(7416002)(316002)(97736004)(25786009)(5250100002)(8936002)(81156014)(71200400001)(106356001)(53936002)(34290500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4668;H:DM6PR08MB4939.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fw5vSJgnuxHlAF6vW7oQK9f0/RtYi4HEVWxc4UcT7+SPvGkhA8Fce0sqii/qXXMoqO4SI398gqQel/LuLnlM/hhlga37HppnvEbvpRkKawlf+Mc6pMWOJMmM6Oef/0LonKTYFgzHyHKHrT3vpF0GOBHaIR+xN1tGjsMNNlXVsd7040KS1VDE+qyQUjkWjne8wKZJ0ZXIAiX9WAgIuvy1peqmISD2tOz9adhxPvSTB0vSWim4PRSMAkhgFYpgor6F1N8TElhpjXJuiYRpdjduXqqr4rLulkY8gePpN4dCWZyLJcOHid0AnLviTxYXdYZAErxVtmZUfCaUIjI5yMwYAlyK0nQu13OsjGiPTQhriVY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DD242081522A4439B5BC6CC0FADDC59@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43c9f20-01f7-400a-dce4-08d623f9b585
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 21:47:52.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4668
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66589
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

Copying DMA mapping maintainers for any input they may have.

On Wed, Sep 05, 2018 at 05:33:02PM +0800, Huacai Chen wrote:
>  static inline void local_r4k___flush_cache_all(void * args)
>  {
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
> -	case CPU_LOONGSON3:
>  	case CPU_R4000SC:
>  	case CPU_R4000MC:
>  	case CPU_R4400SC:
> @@ -480,6 +497,11 @@ static inline void local_r4k___flush_cache_all(void * args)
>  		r4k_blast_scache();
>  		break;
>  
> +	case CPU_LOONGSON3:
> +		/* Use get_ebase_cpunum() for both NUMA=y/n */
> +		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
> +		break;
> +

I wonder if we could instead just include the node ID bits in
INDEX_BASE? Then we could continue using r4k_blast_scache() here as
usual.

>  	case CPU_BMIPS5000:
>  		r4k_blast_scache();
>  		__sync();
> @@ -840,10 +862,14 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
>  
>  	preempt_disable();
>  	if (cpu_has_inclusive_pcaches) {
> -		if (size >= scache_size)
> -			r4k_blast_scache();
> -		else
> +		if (size >= scache_size) {
> +			if (current_cpu_type() != CPU_LOONGSON3)
> +				r4k_blast_scache();
> +			else
> +				r4k_blast_scache_node(pa_to_nid(addr));
> +		} else {
>  			blast_scache_range(addr, addr + size);
> +		}
>  		preempt_enable();
>  		__sync();
>  		return;

Hmm, so if I understand correctly this will writeback+invalidate the L2
for one node only? ie. you just changed which node that is.

I'm presuming L2 ops performed in one node aren't broadcast to other
nodes, otherwise this patch is pointless?

Thus presumably L2 caches in other nodes may contain stale data, right?
Or even worse, dirty data which may get written back at any moment?

I'm not sure this is safe - do you need to operate on all L2 caches in
the system here?

I also wonder whether it would be cleaner for Loongson3 to provide a
custom struct dma_map_ops to implement this, rather than adding the
condition to the generic implementation.

Thanks,
    Paul
