Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 22:02:08 +0100 (CET)
Received: from mail-eopbgr760099.outbound.protection.outlook.com ([40.107.76.99]:56480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993663AbeKSVBpeZ5Pg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 22:01:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR6Q3hG3hYLpbioSi3vivJvNLJOSd0kJD80x3c7GY4Q=;
 b=VgoswmAdGDx9R3Jx+C1VVIeh/gybsCDjkEv4IMGm56SaeDCBLvkFx5JCe1Fo9AQDU5ptuq7rOaPlpRvnSMvt2UES8lECVbE77kfJMs/Qa5HWOG2qvEzTpviyt9hg/KyQFeVumne5VBM/WL3xm5SU4YfBO0SgcwXNBozzaOCmrVw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1264.namprd22.prod.outlook.com (10.174.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Mon, 19 Nov 2018 21:01:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 21:01:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/9] MIPS: remove the HT_PCI config option
Thread-Topic: [PATCH 3/9] MIPS: remove the HT_PCI config option
Thread-Index: AQHUgEsSui+JPzSoxUeZ8Yhne3ADkw==
Date:   Mon, 19 Nov 2018 21:01:42 +0000
Message-ID: <20181119210141.nissqr6zaldt23xg@pburton-laptop>
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-4-hch@lst.de>
In-Reply-To: <20181115190538.17016-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1601CA0005.namprd16.prod.outlook.com
 (2603:10b6:300:da::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1264;6:w5MSfvQugO4IGrlpdtZuBuaS5wt/lts9wHS0xK0edHNZQI+Mxp0tIDXNmmo3lo8MxX/SowSIBEy1KtAymfyYw7kM19sePEzCPgP1U+8wOoB18RAbsPCdEE7Ux0hB3KTgYoIjgwsuUz+qprFHOhgJHWXxj4CFKn/xtWuweRQuikg0XiGmJfbah1GNwsknhTzu+hMZqh0JPEURsAE6UFgwvDdZbe9CwzWyGKWn5+4hvju41266RX52Zc/FNxig4cG7nqwrG47ViTPhcjye4LlcMF7QVdYBTFxwo6N2jye8/HUooHvmk7Zlya7jKIKCksGDpv5FB2GFNBxsU9bkkc9sqxkVZ9NQAmj012u4Rn4i5ePVW0UgkaKjAubmihRvlnc0XMbaUfWIuXZWbfrqv2LcIGAbjDYWy5/0v0cwson6HBPLJtwMyS8oTXLQJPogli11/ByEmPH6wVqDyUvCuzOQWA==;5:n20lpqQm36kqI43ZCZfFeRj3vywjVUWyh0Uah8GovPV/mF2ohWahvZtwBTTFaTEUYiAr6IwZs0e9W4wNSUdyxs6TIZf/ehPFRcDyQ6H9qYHqaZ2iikMiS2Kb2DfLYncebwzkHEacyLDnH2I8LG2DFnwNk2eLdrcKJFV49lX82NQ=;7:bFDM8Kvc+KPFJ5zmc7HJ5igtjnYfi/hDPaW1TG4pscA4W2Q0ljTkz+QRxtUtdbwaMF9cJjJ2xw+6fVMElxlk1tqRdCU494W/DiPkA2g9d5CG17ota1penrHSt+o4gQ/70hoh9h9QqYPFDRZxCnAkQQ==
x-ms-office365-filtering-correlation-id: a213c00d-2072-4689-90c6-08d64e6234d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1264;
x-ms-traffictypediagnostic: MWHPR2201MB1264:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-microsoft-antispam-prvs: <MWHPR2201MB1264E63C324C308E0C0176CDC1D80@MWHPR2201MB1264.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231437)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1264;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1264;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(376002)(366004)(136003)(39840400004)(199004)(189003)(229853002)(26005)(14454004)(186003)(305945005)(6246003)(39060400002)(8676002)(7736002)(42882007)(53936002)(8936002)(99286004)(54906003)(105586002)(33716001)(52116002)(256004)(508600001)(6512007)(9686003)(106356001)(386003)(6506007)(5660300001)(102836004)(76176011)(58126008)(316002)(81156014)(81166006)(33896004)(25786009)(6916009)(4326008)(6436002)(446003)(66066001)(2900100001)(68736007)(11346002)(44832011)(486006)(71190400001)(71200400001)(476003)(6486002)(3846002)(1076002)(97736004)(111086002)(2906002)(6116002)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1264;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B9oNVe8KrQbhQs9R9M7mIr4ozggOvvFi85YpMRFF1zVyyyxB9M83/xdxh3Pn2VVi7EI8jz2bDkQyMsO8TkBxrTBY/TDTzWPZDqiDtNR7T0Uz2xAbNaYMImyR5mKo0WSIlTOYHEtJPHrZXmTurXl1HBzdKlYhFs6nRTNszIQhWPNK9Pk+JG+Mr+2GGERcs4udIwBKnDXEa8tRe9M+JfFmI3Bzbhh6aYIgZzJlUNMKdZXYSXc2qYqkTbqojxpq5PQUpgUqyxp/mjjq/HzVC+Yb6tBFVZry4Iv2wMac/lf8z3XKnb/ecFrLeDelvpg+YeY2pm9jqB/HcIGG9ahr/0trgkBqkRtQFffwCR1PAt2MC70=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40C8AC8315647748863615FE4C97EE3C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a213c00d-2072-4689-90c6-08d64e6234d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 21:01:42.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1264
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67382
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

On Thu, Nov 15, 2018 at 08:05:31PM +0100, Christoph Hellwig wrote:
> This option is always selected from LOONGSON_MACH3X.  Switch to just
> seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
> on CONFIG_LOONGSON_MACH3X.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/Kconfig                                | 11 -----------
>  arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
>  arch/mips/loongson64/Kconfig                     |  2 +-
>  3 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8272ea4c7264..7d28c9dd75d0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3040,17 +3040,6 @@ config PCI
>  	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
>  	  say Y, otherwise N.
>  
> -config HT_PCI
> -	bool "Support for HT-linked PCI"
> -	default y
> -	depends on CPU_LOONGSON3
> -	select PCI
> -	select PCI_DOMAINS
> -	help
> -	  Loongson family machines use Hyper-Transport bus for inter-core
> -	  connection and device connection. The PCI bus is a subordinate
> -	  linked at HT. Choose Y for Loongson-3 based machines.
> -
>  config PCI_DOMAINS
>  	bool
>  
> diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> index c865b4b9b775..781a5156ab21 100644
> --- a/arch/mips/loongson64/Kconfig
> +++ b/arch/mips/loongson64/Kconfig
> @@ -76,7 +76,7 @@ config LOONGSON_MACH3X
>  	select CPU_HAS_WB
>  	select HW_HAS_PCI
>  	select ISA
> -	select HT_PCI
> +	select PCI
>  	select I8259
>  	select IRQ_MIPS_CPU
>  	select NR_CPUS_DEFAULT_4

Should this also select PCI_DOMAINS to preserve the existing behavior?

If not, could you explain why in the commit message?

Thanks,
    Paul
