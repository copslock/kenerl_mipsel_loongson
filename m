Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 00:00:14 +0100 (CET)
Received: from mail-eopbgr770110.outbound.protection.outlook.com ([40.107.77.110]:63601
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993827AbeKSW7bTyPD7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 23:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMo+ooJOs9fk9OOzJ/0PB3z2Qbyb1H2TnM1mcaOaKjs=;
 b=b4fj6H0vbpSai/O/55Oer+sXsPPU7Hy+41m7SXgXxUGqt5/96v0cIC2/QcmwM75FNeUgwIOxhioi/SEVyVG+467f5eIF2wVKdVQ0tm2ZgxtFqFEZIYr7r/p3L+Oiai83bLzAocHVmw6rutQKhx0Q7100WDdAi5IWMKNzZCXmpM0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1758.namprd22.prod.outlook.com (10.164.203.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 22:59:26 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 22:59:26 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V5 4/8] MIPS: Add __cpu_full_name[] to make CPU names more
 human-readable
Thread-Topic: [PATCH V5 4/8] MIPS: Add __cpu_full_name[] to make CPU names
 more human-readable
Thread-Index: AQHUgFuFg2zrbJCEx02Bx5oO494m6A==
Date:   Mon, 19 Nov 2018 22:59:26 +0000
Message-ID: <20181119225923.pegl46uepnx6ztlh@pburton-laptop>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
 <1542268439-4146-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1542268439-4146-5-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1758;6:yF67X6FQZ5e4ubZUwnh8OSNJAkRWyFNiVtRI9Drf5hm4AzfgN5WaA0L+742NDe12px9CIGp1PE7XOsteDeDGj1v2b/n6aH+9Qdwmt5CCCcErGOvX7G/5h/eCaCCTBeEqPQnHlFI67Qg4e9ABOLoXO4YX328JgZzdhXrAljZahjkM2D6QwLyhqgHBoH7m7bCZhbSNzOr+DlOibxayjPv7BSLpfkZRGpvvBPdEBvSlapJN7478zULraNR05GoyR6NbJ3pLdu//nfF6ORQ6y2eBuPnvnYuxAKsBQCj5IJsQncTSKehdvMpMM0UJR/uYEKuEMGJjADqI4WjhytULinpiw5W57WPutC1E/P3ugnhQV6cMhI8KMwS9ana00WW1vYV9cGjH4IIQI0Jet05FHkEDy8F6NOdwP19qetu7c7NBM7MJKqjad7udSi3fI/GrQUw1Y7mMkxIrKbtONhTLXdyr/w==;5:87OTkUsDcQY+/losCHQeP/070y9rSLmG8eUDDiK6fu2IrXsOaDoUKDDF+gOhBRdH7UbSk975Vu1A92ZQazEWmXu9164SxHvW3wN2C9fWgXnkACm548dDAKnAlcS4MRqrl0VUSg7giabk8e20lNBaXc7kHF67fmB3lvstKMfiC3o=;7:1h95YwMknzEqZCUe3zWEAJXOZZ/ApLO27ignAMSR84kwhIoOqQU6/FtfVYQT9Vu+4A8ILl5lntkvPOcjgG5tPBkNA8pn0/3bqpQANXI+/Oq6kvMoqMQsvw7V9nBfZ3uDViKCvgjgne0+47OmJxSGlA==
x-ms-office365-filtering-correlation-id: fc602454-bc81-48e3-07d7-08d64e72a73b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1758;
x-ms-traffictypediagnostic: MWHPR2201MB1758:
x-microsoft-antispam-prvs: <MWHPR2201MB1758EEDAFC430A7EA0012FA6C1D80@MWHPR2201MB1758.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231441)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1758;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1758;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39840400004)(396003)(366004)(376002)(346002)(199004)(189003)(4326008)(33896004)(25786009)(39060400002)(6506007)(386003)(97736004)(102836004)(1076002)(5660300001)(68736007)(6246003)(256004)(6512007)(71200400001)(42882007)(9686003)(2900100001)(81156014)(26005)(186003)(71190400001)(8676002)(33716001)(8936002)(76176011)(14454004)(99286004)(81166006)(53936002)(52116002)(508600001)(486006)(105586002)(476003)(106356001)(2906002)(11346002)(44832011)(54906003)(58126008)(316002)(229853002)(3846002)(6436002)(6116002)(6486002)(305945005)(66066001)(7736002)(6916009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1758;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EcL1MwXg6Gmu7bAbNsk4BKaFhjFAo9/IN0xWmaaSc/G+eXYlcMUUGQIOQDfIZh2sF9s5MFGUFZW+Z3rvnjdZAttZafpBqqoMW2N7kW02NVoF7E3vGGO6ZUdIkv2k0Xu2c+5RuFpJgehb9B0A3Pkac6UoWLAZLpZZjWKlaDHGiL8JycAtr6U8K/v58Zv/RSU5oPzlSuMG+KnJ3isII1sEH+AXHoGfu5sc9+wTDe2w3CDMJlZyKQ1aYiIVC0SWZfq6HvXasjeE0WLqmTVM9CxHEdzRSHt5gfDJ1oCf7FdsBvjIXPARw5MPp+NCoGOB9rglB90qM8v8z2BMUUg/9VqqEuxfB6ehl3tYtMN0RCn0Wd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6EAB367F89AE646B17BEAFB2F6EAFA4@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc602454-bc81-48e3-07d7-08d64e72a73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 22:59:26.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1758
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67388
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

On Thu, Nov 15, 2018 at 03:53:55PM +0800, Huacai Chen wrote:
> In /proc/cpuinfo, we keep "cpu model" as is, since GCC should use it
> for -march=native.

Keeping "cpu model", ie. __cpu_name, as-is sounds good...

> This is only used by Loongson now (ICT is dropped in cpu name, and cpu
> name can be overwritten by BIOS).

...but you don't do that because you remove "ICT " from it.

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 65dc2e6..9282cd3 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1500,30 +1500,40 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  		switch (c->processor_id & PRID_REV_MASK) {
>  		case PRID_REV_LOONGSON2E:
>  			c->cputype = CPU_LOONGSON2;
> -			__cpu_name[cpu] = "ICT Loongson-2";
> +			__cpu_name[cpu] = "Loongson-2";
>  			set_elf_platform(cpu, "loongson2e");
>  			set_isa(c, MIPS_CPU_ISA_III);
>  			c->fpu_msk31 |= FPU_CSR_CONDX;
> +			__cpu_full_name[cpu] = "Loongson-2E";
>  			break;

ie. here you've changed the "cpu model" output, and you do the same for
other cases.

> diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
> index 72e5f8f..d4f9979 100644
> --- a/arch/mips/loongson64/common/env.c
> +++ b/arch/mips/loongson64/common/env.c
> @@ -212,5 +219,11 @@ void __init prom_init_env(void)
>  			break;
>  		}
>  	}
> +	mips_cpu_frequency = cpu_clock_freq;
>  	pr_info("CpuClock = %u\n", cpu_clock_freq);
> +
> +	/* Append default cpu frequency with round-off */
> +	sprintf(freq, " @ %uMHz", (cpu_clock_freq + 500000) / 1000000);

This would be clearer using DIV_ROUND_CLOSEST(cpu_clock_freq, 1000000).

Thanks,
    Paul
