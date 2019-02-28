Return-Path: <SRS0=OKHG=RD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA8C43381
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 02:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8250218A2
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 02:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WhZdYn8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB1CPd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:15:33 -0500
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:6172
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfB1CPd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 27 Feb 2019 21:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnXSelLTSHQdWx8ft+EEefJhnVXtAWAT6Pxz7mLTnnQ=;
 b=WhZdYn8iJIS1Et2pPhogje162IFwpfZ/b37q097Yo8LMU8FDzGevwr7YtjmnZRBAWaO0xmzCXJNQnH2tWTect2WZrbKfsHz7gdgSXBW9wYVzXGskn0vGpnkops9dsw/Ws+seEg/B0BaYpkXBUMNlW7B/JjOwrxVeiUemADPPo1Q=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1469.namprd22.prod.outlook.com (10.174.170.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 02:15:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 02:15:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Steven Price <steven.price@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v3 11/34] mips: mm: Add p?d_large() definitions
Thread-Topic: [PATCH v3 11/34] mips: mm: Add p?d_large() definitions
Thread-Index: AQHUzr7i/d0uU6ROnE+g9kAjsVHJ0KX0eXKA
Date:   Thu, 28 Feb 2019 02:15:28 +0000
Message-ID: <20190228021526.bb6m3my46ohb4o6h@pburton-laptop>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-12-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-12-steven.price@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 227ba9c0-1117-4909-342c-08d69d229b80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1469;
x-ms-traffictypediagnostic: MWHPR2201MB1469:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1469;23:92VmhE8VajLr8IvYkXy6O9zUoJmfDrPe5fBu3?=
 =?iso-8859-1?Q?L3oHh61jH+c82XJ72LE1k9rUz9po/0CEbw39N0D9xl7SQibZY62KJSHkUQ?=
 =?iso-8859-1?Q?dcFyJvZuyPmgHicFr2HPdOjzwU0tegsnqSeI04bsNkXt1KkUxhrPGsLgI1?=
 =?iso-8859-1?Q?1H+I7D/TFgPyqD8II+PhCHn7lKDjIJEidOHhj0KkbOh+vPdmW/95XDzH7D?=
 =?iso-8859-1?Q?HxKbOziNgx55QqW/097gQgvzHaB2fDTgZBeoiDjIjXR2OikVQOPaXzsPzz?=
 =?iso-8859-1?Q?TaLURxPz19OvgMYYreXf5Bss/m8dKeQc38lvY/ua+xAe7///OyGz2/zXk+?=
 =?iso-8859-1?Q?rnDXYSzNxt+zlciG6hl9ionyNHt9MYioete/Z/mBwcRZcHCBh0EDSHFKD8?=
 =?iso-8859-1?Q?RAY+N6WAtHRY7ERqU7DVGcBe7+R1Tx5OC+M0S0yb4yGySKE4svhWRplwWc?=
 =?iso-8859-1?Q?UFsYlEEa5naLu/YyaVgOhmqfwebfWB+ZogDfR+TvUNFqg6Y3ITXn7vqXQ9?=
 =?iso-8859-1?Q?Bmk7BycIgPK0wARTkoZXANlXre9hSxvXDw5aSNdre2mo29rBoNfjb83RlO?=
 =?iso-8859-1?Q?tZauHaun5hPuvlFuN7pY1iaBuHqMzEMDAofeAh1E6Hao/PN0tZQ/toshH2?=
 =?iso-8859-1?Q?gaoPnQXLVIs3bMrUTxZ+biq1JiwsJiKWlWuei2x2Au80BiYsN/KnXpFE4Z?=
 =?iso-8859-1?Q?Nco5DrxdU+Fo7ac1PZtR6z70C/aLZxnss41qElRlWuyYuP+UduDOd/oe4c?=
 =?iso-8859-1?Q?MgeGahyNlqQbE+RuS7eIuPW3eVPAraflkS/3nLA6N2o9vfFKRvGeD4zkLp?=
 =?iso-8859-1?Q?kU1df9uziBlL8WBM6HUiRS+58gjTkNjR4u/QCZrD2jGxGj58sSInsOjCyy?=
 =?iso-8859-1?Q?sbmyBoVGQ3WzZYLOJmG+z8Nw3w0Jcnj4eLObbom0SJ7qjXgA1x7HrtBG+w?=
 =?iso-8859-1?Q?XHSQB6d1ALcVAB0G3YZQk8DHBIzWsMPQVTmdCg6QK2HswmwNoZ9v6+AoeB?=
 =?iso-8859-1?Q?S3Y4Q9sw9NCaZGQpo+yzb8KMiQeZPN6L02mU4KgoH+kttB9dQmW2Qb0+JT?=
 =?iso-8859-1?Q?OUo+IhZWrK1UH6R/FyOW/hsLtcjuoSe8YLLmwyG/p7jEB0KXR0rFQIPIvt?=
 =?iso-8859-1?Q?N+7HHI7WFVjR+gxw4O+TuBm3YggypceylSfra53ZWebFc5Fd94Vn7W7SR3?=
 =?iso-8859-1?Q?MS9Y8ZG3hTkK/HjkzNuYWqaBPNI83NRFXA265E8ofdBXTAB/RDDvJSnD1T?=
 =?iso-8859-1?Q?yfj026Z3MrcZ1/baXw3ZPKxM1xxlcjnvmkUmGi+YF6VGWXFvKlQUMPH2Dp?=
 =?iso-8859-1?Q?1e552h3u8PkYx1QXbqmcI3TPoVVtYBNC9TSGjeKc7PRfhOHPSgQMfjxpCa?=
 =?iso-8859-1?Q?gvrMcnHtrI=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1469306DF391A760F5BF888FC1750@MWHPR2201MB1469.namprd22.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(376002)(396003)(346002)(39850400004)(199004)(189003)(6916009)(2906002)(186003)(9686003)(476003)(478600001)(8936002)(305945005)(7736002)(33716001)(52116002)(42882007)(229853002)(6512007)(4326008)(44832011)(11346002)(446003)(5660300002)(486006)(256004)(97736004)(1076003)(26005)(316002)(54906003)(102836004)(66066001)(7416002)(58126008)(6506007)(8676002)(53936002)(386003)(25786009)(68736007)(6246003)(6116002)(14454004)(3846002)(71190400001)(105586002)(81166006)(4744005)(106356001)(71200400001)(81156014)(6486002)(76176011)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1469;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mdpvv8Wg76jgS0g+vjM2ejjZh4TdJVU/PQHbDnP/ayCIKg2Ke1grvoVK2DV6DvjBXoEjZFhX2PuvXbd8rd5TU0O0mr4IAYkMCxj3RHZigtvAPyaOzlnF+jX0m4dRXGh6GuAqHn+KIkDU6veVTR3JqqH4SLn+g8GZG2Ut7Cn2xat1CvZ6rdI/CPCOoZeEGcT+GRQFWIMapodjL/9DP20oT+94gfAP2YLmtMSATTayWFhf5y8FiohZnXUCG+FtATBHle7xZuzpucaP0pAyylW4cAqPQlV0vSVAP0fsDVLacQDkQVvl24rhv2Vx4VVkAJsqbRWMt27BBihwMFfdlNR1ChCXCF844UDY7B4BuMrJqQjXOoEojwaZu4H+rE1GxaFOarStvHmI7O7Gw2GX2mPmjl7GSjmwYS6kVyPzTaf1Mb0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <54A1222541CC9C469C907705C8F0722E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227ba9c0-1117-4909-342c-08d69d229b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 02:15:28.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1469
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Steven,

On Wed, Feb 27, 2019 at 05:05:45PM +0000, Steven Price wrote:
> For mips, we don't support large pages on 32 bit so add stubs returning 0=
.

So far so good :)

> For 64 bit look for _PAGE_HUGE flag being set. This means exposing the
> flag when !CONFIG_MIPS_HUGE_TLB_SUPPORT.

Here I have to ask why? We could just return 0 like the mips32 case when
CONFIG_MIPS_HUGE_TLB_SUPPORT=3Dn, let the compiler optimize the whole
thing out and avoid redundant work at runtime.

This could be unified too in asm/pgtable.h - checking for
CONFIG_MIPS_HUGE_TLB_SUPPORT should be sufficient to cover the mips32
case along with the subset of mips64 configurations without huge pages.

Thanks,
    Paul
