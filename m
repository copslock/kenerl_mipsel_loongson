Return-Path: <SRS0=DhUk=RA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D504AC43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2762083D
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PcFVXjhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfBYVWg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:36 -0500
Received: from mail-eopbgr740114.outbound.protection.outlook.com ([40.107.74.114]:61941
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730887AbfBYVWg (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYPJ7kv/+xaGpVY/I2asws4spALcAkBF3ADA7p+RgBw=;
 b=PcFVXjhZ1Q9N4Esqq56IMKLSnNGC5hImKfCbRzER3SHSc0A4kG5Rvq5CaUXLnmOxSIopbmrIy8sCB566v9s04KK6Kjsmf/p/gLAfmrNf2JkJdfOyJEZurEQWHapCmi3/RL2HGD8IXn5XPRPNfqKimA8erM8VDlpi51SPrENnt9g=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1245.namprd22.prod.outlook.com (10.174.162.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 21:22:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 21:22:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Wang Xuerui <wangxuerui@qiniu.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS: refactor virtual address size selection
Thread-Topic: [PATCH 2/4] MIPS: refactor virtual address size selection
Thread-Index: AQHUzBCwLpAFqojKT0CWT8Vb6mx5TqXxCEiA
Date:   Mon, 25 Feb 2019 21:22:29 +0000
Message-ID: <20190225212227.hl556cdtkrfdgfja@pburton-laptop>
References: <20190224071355.14488-1-wangxuerui@qiniu.com>
 <20190224071355.14488-3-wangxuerui@qiniu.com>
In-Reply-To: <20190224071355.14488-3-wangxuerui@qiniu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5218a946-90a1-41fb-a893-08d69b675865
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1245;
x-ms-traffictypediagnostic: MWHPR2201MB1245:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1245;23:SM5nN3RmhQy5O50DCzLr5ZbRvNelR/+vUWPe0pH?=
 =?us-ascii?Q?Mn/6Edy/4yA4Xa3bDvktYX0IFZf43Mms0bWN30NB1o8MC9Rcmnm5BjDsHH7h?=
 =?us-ascii?Q?2EGU2muY4+9qL4mDzYIhiYVdvEI8NGYJZyqwRHnVAj/uRQdYBtUSWwHedc3Q?=
 =?us-ascii?Q?3+dgVbM7zY+213Aftlw75mZboNNTMg2kYRALPV7zRJsL7rAI7witV4Q23bQz?=
 =?us-ascii?Q?Fd0zXECotig0ZDDgrzc7hEM06PPcmpgGkoGOA/gaajBtF1tCfldAaTtrATXO?=
 =?us-ascii?Q?WL3my2r7Av6s10yC2ttWQGilkl8yipzLX324iDSiYdaAj1/LF2+cEey6Geq2?=
 =?us-ascii?Q?2aoDGwK3bHGsLOocCnISXoG4hvGdKQsOFFxS8p5CkMc8Qrmxr1sq9pm4WCJ0?=
 =?us-ascii?Q?kvfGotFC//oHuggcKJLVjVLURiflml+3Ftohh3zF9F3CfR5qqqik9CteHc9y?=
 =?us-ascii?Q?BsjRG3UcLR4wROa7isTloywonvNeWU8c9TCo0saQEN3fMUnroXVhB4IV8iBT?=
 =?us-ascii?Q?gHOj17EuPXIkfBchE0wTLXZmC6LqSiyemD2B8tY1CdCqH7EwZiPrnXNLhBL3?=
 =?us-ascii?Q?SaYmqvzZ6OhygX8WbN4rbSZwcYvs0snZ0K/mvSVFZUpzq8sMOIw/eKCInnCu?=
 =?us-ascii?Q?Xdane8j3th+Uf8JCADQsQgqTHwaf8Mq+FZV6HlSPs3uPGokTnGlY+wsK3PTF?=
 =?us-ascii?Q?vS2SDdXc97W4v0xKKRRhWFW4aWf2LhryRgt5c3Z3jKDmMD4J+idqKsFXDwlL?=
 =?us-ascii?Q?v3y1Gnl3LsyGizafi5rNy8qPuBz+F7JsB2mG7d9xUdyBdXMWVL4/4xMbNBWK?=
 =?us-ascii?Q?uLHADQr9WDgkG027iQXj8BMkzKM6Vdha9GCN/j34upLUzWQIl4Gjy1QoTkKW?=
 =?us-ascii?Q?I7SG5q4L2RmXJ9FptpeYHUQeYvpt8v286rISZ5jx8Pnus7yQtD3IIonSv1jr?=
 =?us-ascii?Q?NuoF1vQBJ3hJbci18lV+cMy/ZsPaXeCA9lS+hBK0NAOaIlr1datG0+6/d9UU?=
 =?us-ascii?Q?BGZXLraD94u1CkaoGPywoHzjqfIDoJobTWARK+xoQFJgcoRlA8lvTpwN2Ujf?=
 =?us-ascii?Q?noB3Z3GHNlzqTQgE7ZuRm6KFbTOKmqnpLBoMUkFVRlaXt5naeY1E3KiOi+3T?=
 =?us-ascii?Q?tmDtJc3v0GUZFOC7aa+p+I2rY7tfiirJsevAEPCOyfa7O+TyUHz0RMRB7S0+?=
 =?us-ascii?Q?K+4Uh7wD341ZFooRVsYqnIAMn4yFcwjdf0VaGoVqrZnpxNuVXlv91EcahT99?=
 =?us-ascii?Q?81x/wmktTJzM2b6Nk/mHX/dyexlL6swiIIVx83UDVZOm0d+U0KQCBWFqu49j?=
 =?us-ascii?Q?kAIUPIgLOdgREJmzByFkya9c=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB12451A0DA80771213A3EEB96C17A0@MWHPR2201MB1245.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(346002)(366004)(396003)(136003)(189003)(199004)(51914003)(186003)(99286004)(26005)(305945005)(7736002)(6436002)(6506007)(386003)(6512007)(9686003)(58126008)(54906003)(486006)(446003)(6916009)(256004)(2906002)(3846002)(42882007)(6116002)(229853002)(11346002)(476003)(97736004)(44832011)(71200400001)(5660300002)(71190400001)(1076003)(4326008)(14454004)(25786009)(478600001)(6246003)(102836004)(53936002)(81156014)(6486002)(8936002)(76176011)(52116002)(81166006)(8676002)(316002)(33716001)(68736007)(66066001)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1245;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mRmdztnGACtNSmkCHcKYpgK0+CfCEw1D+krIusL7E/TKtBJR+/djSW6UQ2ahEGw1mdZ7PT9rNdQAd5ExUxVtBpKX8DPSpLseCe8I4z0SfcTdRA1WW2WnPnZExK0DixKpVsdJPUcTMn0OHpEe1ySPSx79/C4ld7fgIFgmgmZ/tEUIe/6IZhz7xn7myi4cR257npj0S+1bK18PvbhTJ78yMs+WzG7cA4F8pPYDFg401xK2HghRjJ4/d+g2mZGDzTA80VigmdgozcXmG2ueeM7AsFv2Y7ktl9ECN1w4LzyjxrGwyd4qHvmR6vpqllacdaj1xOLqZG9ElhUmDh1FD7edlgkDVQT2OQkKacNo2lPJJj2efGtWQ2JaulFEfhpr2swbLgpdmVpK0tgov3F67pMwETqzpDZPoEoaeCNNJYcd/YM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24C8D17E8AC1A24C94303579B8F1EAB0@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5218a946-90a1-41fb-a893-08d69b675865
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 21:22:28.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1245
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Wang,

Thanks for the patchset - overall it looks good, just a few comments
inline below.

On Sun, Feb 24, 2019 at 03:13:53PM +0800, Wang Xuerui wrote:
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a84c24d894aa..b0068a1e1e33 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2158,12 +2158,27 @@ config KVM_GUEST_TIMER_FREQ
>  	  emulation when determining guest CPU Frequency. Instead, the guest's
>  	  timer frequency is specified directly.
> =20
> +choice
> +	prompt "Virtual address size"
> +	default MIPS_VA_BITS_DEFAULT

This whole choice ought to depend on 64BIT - it will have no effect for
MIPS32 kernels.

The prompt might be more accurate as "Maximum virtual address size".

> +
> +config MIPS_VA_BITS_DEFAULT

Can you rename this MIPS_VA_BITS_40?

> +	bool "40 bits or less virtual memory"
> +	help
> +	  This is the default setting on MIPS platforms since antiquity,
> +	  which gives 40 bits or less of virtual address space, depending on
> +	  the CPU.
> +
> +	  If unsure, say Y.
> +

Isn't it always 40 bits? The comment above the definition of TASK_SIZE64
in asm/processor.h suggests everything back to the R4000 can do 1TB (ie.
40 bit) VAs, and TACK_SIZE64 is unconditionally 1TB.

>  config MIPS_VA_BITS_48
>  	bool "48 bits virtual memory"
>  	depends on 64BIT

With the choice depending on 64BIT you can then drop the dependency
here.

> +	select MIPS_LARGE_VA
>  	help
>  	  Support a maximum at least 48 bits of application virtual
> -	  memory.  Default is 40 bits or less, depending on the CPU.
> +	  memory.
> +

I don't think there's any need to describe the default again here so
would drop this change.

>  	  For page sizes 16k and above, this option results in a small
>  	  memory overhead for page tables.  For 4k page size, a fourth
>  	  level of page tables is added which imposes both a memory
> @@ -2171,6 +2186,11 @@ config MIPS_VA_BITS_48
> =20
>  	  If unsure, say N.
> =20
> +endchoice
> +
> +config MIPS_LARGE_VA
> +	bool
> +
>  choice
>  	prompt "Kernel page size"
>  	default PAGE_SIZE_4KB
> @@ -2187,7 +2207,7 @@ config PAGE_SIZE_4KB
>  config PAGE_SIZE_8KB
>  	bool "8kB"
>  	depends on CPU_R8000 || CPU_CAVIUM_OCTEON
> -	depends on !MIPS_VA_BITS_48
> +	depends on !MIPS_LARGE_VA

I think it would be cleaner to introduce the MIPS_VA_BITS entry you add
in the next patch here instead, and make this:

	depends on (MIPS_VA_BITS <=3D 40) if 64BIT

Or maybe even give MIPS_VA_BITS values for 32BIT kernels so you can drop
the "if 64BIT" part, eg:

	default 30 if 32BIT && KVM_GUEST
	default 31 if 32BIT

With that & similar changes to other uses of MIPS_LARGE_VA we won't need
MIPS_LARGE_VA at all, and dependencies will be more explicit about the
range of VA sizes they actually care about.

Thanks,
    Paul
