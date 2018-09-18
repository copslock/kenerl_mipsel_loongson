Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 01:17:31 +0200 (CEST)
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:21863
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbeIRXR2KbEp9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 01:17:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0byp+ABIUm6mbdrx06RXGiaCPdQ2HfTBoykGHpuwQTI=;
 b=GmutUPzo1SCUs+nNqIIA4JQ54aDwUfmt68NPgN7683S02gYvUlBBJu84uJNU8T84hyNM+UtzbNR2ORSb9fHsFA1qf/lr+mczrcbGuVzDji+y4Czce4ImO5svraNii0zDAwGLKrJ5k+R2jrPK9xGtSimHDa0gUAjRZWhUChhuNdY=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4597.namprd08.prod.outlook.com (52.135.234.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 18 Sep 2018 23:17:17 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 23:17:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Topic: [PATCH 2/2] MIPS/PCI: Let Loongson-3 pci_ops access extended
 config space
Thread-Index: AQHUTLlv55mCPi4wOkyVU5zYQaVnDqT2sgQA
Date:   Tue, 18 Sep 2018 23:17:17 +0000
Message-ID: <20180918231714.oibdygquyojqud45@pburton-laptop>
References: <1536991273-20649-1-git-send-email-chenhc@lemote.com>
 <1536991273-20649-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1536991273-20649-2-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:405:2::23) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4597;6:y4eWFN8bNPnJIqyzS/Zf+C6s+CDshTMWp1xUSLpvSOMFWrJC19hzBJn1b4z2GYda7mN0uw4hGyc0MbV+n+T739w0KRpOibFQkMp4AXxIU9Mcof9i9vyeIi+dbaWWfjcrrzWz73R98PTJQ7iC19ryUJzpe+dyLlQ3QbaNK6Twa/xSknxmzdxpSIEpVFL+yvwJ1j3chEv37+om8o/2ZuESuBcp8I+4pJLW1V/TGPTgrBMNi6dMNSdKycQn+GJwOsM4CWByu0+yuOwFtV4SoshjH+sghJylJLRlmshio/hfOFDAG3793dAUabgnu9Mr6UI3XCNyazC0zuO5rTBNMVS7OKNMBepKb1q9e6sqv4SnY7T9b0IMVloR1+iLIJTKG0UUIpvXvloJNeL3XB6ULvzIbRb7KKysRGKEqn7QpSalXSLD0q17BCQUlqFW1H0+hIstBskGyX+fweDvu1Px6BDUEw==;5:6desoN97/ETe3pFlCtV431DTZuEdl1kht2apcKE6ryWKxVtKRND1LOMNQ4RD2qdKjl7bUbya5sS82dv6bYHKGgZQ4W5JeQxU6MWk/VJUUuUgvDiIgA9x1AgW4gAsdV++NmqK3N/BFg6ti3PXXwLbzuCoFEu8o0LfXTQ/6dVAwHw=;7:xh9iA3IWd+RtDogq9T3nqB66r2rs3Z9lvQ4Br/DIvP/6Gg5I2ZCHyfZlso0vLQTNizQU1PjZQ5dsj/WppxqyB/L/eP7CvM2DYIwpeSUP1SvvVABfBNCUBMNw3Z7GjwLAzIfAb8lvsqHM6JWNVWkC49+ikMlGG0Rr5L74IbQC0m+mMIrRUbyjrj8KvVbpaHZm4BvomUlJshEcW9Nmh8WRgTQVD8MRK/KweM4Yp9HlHRyQO6pNO5Xud6rKl9B/zBYF
x-ms-office365-filtering-correlation-id: 21e46d14-97b4-4767-e0bb-08d61dbcdff0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4597;
x-ms-traffictypediagnostic: BYAPR08MB4597:
x-microsoft-antispam-prvs: <BYAPR08MB4597B4C5EBB05207F0563E4AC11D0@BYAPR08MB4597.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR08MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4597;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(68736007)(8936002)(54906003)(6116002)(3846002)(9686003)(102836004)(99286004)(25786009)(42882007)(6916009)(97736004)(186003)(81156014)(316002)(4326008)(58126008)(81166006)(446003)(26005)(386003)(33716001)(2900100001)(5660300001)(2906002)(6506007)(11346002)(39060400002)(6512007)(229853002)(6246003)(1076002)(44832011)(6436002)(486006)(52116002)(8676002)(76176011)(305945005)(476003)(6486002)(5250100002)(106356001)(14454004)(7736002)(53936002)(14444005)(33896004)(256004)(478600001)(105586002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4597;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fhbEQiPQ+yD1F4QsEUvL5czN/ErOLOOYJiM55GiuqxntvFzro7YE5Amlip4h7IlX7TsiEczCP/8OMBXYXTYQEXD8D1aXycKr77Aff4++w3yal24Q9sQhWxDb0Inpi+fgan8j7o2n6F5dpUdjacFXzNznQjhqca2OxYJOArW1q+tHF/QowffuwKlUqp3+6Iaev3WAhsM5x66Wem3Ul3Ist+UrWxX+WMy3qo77BXKzJAc4MLuksgJenKFCizHstCT5MUHwXhAdaFd0mEfNvlaiI/GEcoj9qfEgCjkCVaxEYWD35mnunHEYTJwVYKkFV1FgBRPBFWs96xyu8JunzgCL958G55kaZ87ZnXTxbpc6s4I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56DAAF8F94907C4891EB84872BD2D3CB@namprd08.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e46d14-97b4-4767-e0bb-08d61dbcdff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:17:17.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4597
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66401
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

On Sat, Sep 15, 2018 at 02:01:13PM +0800, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/pci/ops-loongson3.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)

Please can you add a commit message, even if it's brief.

> diff --git a/arch/mips/pci/ops-loongson3.c b/arch/mips/pci/ops-loongson3.c
> index 9e11843..3100117 100644
> --- a/arch/mips/pci/ops-loongson3.c
> +++ b/arch/mips/pci/ops-loongson3.c
> @@ -24,16 +24,29 @@ static int loongson3_pci_config_access(unsigned char access_type,
>  	int function = PCI_FUNC(devfn);
>  	int reg = where & ~3;
>  
> -	addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
> -	if (busnum == 0) {
> -		if (device > 31)
> +	if (where < 256) { /* standard config */

This can be PCI_CFG_SPACE_SIZE instead of the magic 256 number, to make
it clearer what's going on.

> +		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
> +		if (busnum == 0) {
> +			if (device > 31)
> +				return PCIBIOS_DEVICE_NOT_FOUND;
> +			addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));

I know this is existing code, but we could clean up some unnecessary
brackets whilst we're here:

  addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | (addr & 0xffff));

Actually we can go further than that - the only thing in bits 16 & above
of addr is busnum & we already know it's zero, so we don't need to mask
addr at all & this line can be simplified to:

  addrp = (void *)TO_UNCAC(HT1LO_PCICFG_BASE | addr);

> +			type = 0;

Is the type variable ever used? It looks unused both in the existing
code & after this patch - can we just remove it?

> +		} else {
> +			addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
> +			type = 0x10000;

Similar comments to above - we could drop some brackets & perhaps drop
the type variable.

> +		}
> +	} else {  /* extended config */

Should this be "} else if (where < PCI_CFG_SPACE_EXP_SIZE) {"?

> +		struct pci_dev *rootdev;
> +
> +		rootdev = pci_get_domain_bus_and_slot(0, 0, 0);
> +		if (!rootdev)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +		addr = pci_resource_start(rootdev, 3);
> +		if (!addr)
>  			return PCIBIOS_DEVICE_NOT_FOUND;
> -		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE) | (addr & 0xffff));
> -		type = 0;
>  
> -	} else {
> -		addrp = (void *)(TO_UNCAC(HT1LO_PCICFG_BASE_TP1) | (addr));
> -		type = 0x10000;
> +		addrp = (void *)TO_UNCAC(addr | busnum << 20 | device << 15 | function << 12 | reg);
>  	}
>  
>  	if (access_type == PCI_ACCESS_WRITE)
> -- 
> 2.7.0

Thanks,
    Paul
