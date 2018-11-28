Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2018 23:33:48 +0100 (CET)
Received: from mail-eopbgr780093.outbound.protection.outlook.com ([40.107.78.93]:57216
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993973AbeK1WdpMhMb0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Nov 2018 23:33:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHwlI4SscH9LEgqCrhwUHU69EuRcP4RVjplcQ6oaUcA=;
 b=gT5A8Id4Li2vRhJigtgRgKSc2K3+Ees3CfpIt1JCQGK2uIce5DYatWV0QdaIWQazHeR1JBEUAcQ1jTqk6ZTosawa8x08Ltd7yWmjnBrzCE9zTgOlWulL8ENsgKaLoZW+6f2y7t6OpojuDzCrvgk3RAEIO8shbuXL3zDMxd5VyXw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 22:33:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 22:33:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Topic: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Index: AQHUdvBc6FH/gm/eXUqshhyWFnaOnaVkohCAgAFE4QA=
Date:   Wed, 28 Nov 2018 22:33:42 +0000
Message-ID: <20181128223340.xocdpwtb6adl4prn@pburton-laptop>
References: <20181107231931.6136-1-paul.burton@mips.com>
 <alpine.LFD.2.21.1811280308430.32615@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811280308430.32615@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0017.namprd13.prod.outlook.com
 (2603:10b6:301:29::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1565;6:YC0owICwNcTlNo4wo8D1s0I67yBJUtfjUTlOVWZtBMSiLqdwcdWyH/7NV2KLVPfvzHy6TJ+y6Ly8/rkjh46M8lG6t2xU1PFc+Z7EszboitBaZxyxpZqLr+lzdYTwj9uMsfEsweK/sRy3Y9fR/WI72dXiSrKiMn84kR6/I6usx+LBWx03iz14j6oFKHqrSHYPZokR+7gTQw+VLUaNlaqtVNQVRGRyq/ZGtazNenEZqz0ljx5/+OKy3x6y3u4T9OKkeXipryBnKa9XswEhUiZ6DK/rHEsrlXXjNYLWBdgret4HnbEi28zoQlnR6lpw+i7DT5vPpAxYSy4tCZM2jxEmDrGUZTPTncEFhb/7gNhjbOLNPzTYT2BsOB6YKAj9a3nujcU0C+i7ZwTTj+4SCIIgAdhSa2Vi5Xf1VCocEN1eo9D/vwOAoWD+wxz8o1WGzYDgPfIooE4c1roKrJ5fx8/EpQ==;5:ZNnHwF2Indw2QnrlSQ7hpwfaIf94axUfhvc8WgOwUl6Tfuo6ps5wVCaPHqmXxPXnQHF9zbcAtkzb0w6SlRlfR5qqWDGXnsdbwoGbbNYYhEtI5WgJT4DKrMFGD0ypZ8kvlM/X3rV9PyxaBqP8b7pt26C0CJj2IvarVXDcfQnSJdk=;7:eKxBIJETckSIbI94n4MQoZaZIpCbEqW5cdFUNEFI3q909ZbzfeABKtZNpBu0XNxqpUWuzDApvp6bip8ZFz7irs17dqy/6aFtSP63mRLFXs6mAzZT23xOrH4McSLY+yVT5hzNK9XblW1RwzR1zrgoeA==
x-ms-office365-filtering-correlation-id: 5e013050-e4d5-42e1-60c3-08d655818ca3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-microsoft-antispam-prvs: <MWHPR2201MB1565953A6BA652240AE6D7DFC1D10@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1565;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1565;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(346002)(396003)(136003)(366004)(189003)(199004)(508600001)(386003)(52116002)(76176011)(97736004)(229853002)(6486002)(81166006)(14454004)(81156014)(2906002)(33896004)(6506007)(6436002)(26005)(450100002)(256004)(25786009)(99286004)(107886003)(71200400001)(186003)(102836004)(42882007)(71190400001)(66066001)(53936002)(316002)(6246003)(44832011)(68736007)(9686003)(5660300001)(6512007)(476003)(106356001)(105586002)(305945005)(6916009)(7736002)(11346002)(446003)(3846002)(6116002)(4326008)(54906003)(486006)(8936002)(58126008)(33716001)(8676002)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1KyIRMONW9JioRmzxYbE8r+cFjec81l9I4TveFD1Bm8VJSn1b0BgtASFj6u4J3Mk5w+cDAIC3XO7F3EgYYNCh7NC+0ZNSbpHWvfpP33R5OnflPux5FauEGYgk+I0bZAOG1g466+8crrTy8SxGVd8bUAZrNzpUWzkiT11PN20mrlv8HbUhr2JM6IyUr1hNvvHXoZqIPDcxhwB9nYixFHsX6Frk1TBxF2aAxscrUsfi7aQXBjgM4n4ACG+hXk1cfT29MqT/roGuotjLWUH37FMUQgFL2JYIkkAkem0Sbp35ZYU+gxETW9NraVClyESwfyyDl8UIFTXALf0WUTW363B81hde3emvlOpOpLWrm+olGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <466344E30320CA41BF1475A42050C4C0@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e013050-e4d5-42e1-60c3-08d655818ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 22:33:42.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67539
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

On Wed, Nov 28, 2018 at 03:10:53AM +0000, Maciej W. Rozycki wrote:
> On Wed, 7 Nov 2018, Paul Burton wrote:
> 
> > diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> > index 0edba3e75747..8669fdb503a5 100644
> > --- a/arch/mips/include/asm/cpu-features.h
> > +++ b/arch/mips/include/asm/cpu-features.h
> > @@ -195,7 +195,9 @@
> >  #endif
> >  
> >  #ifndef cpu_has_mmips
> > -# ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
> > +# if defined(__mips_micromips)
> 
>  Wouldn't it be cleaner if it was written:
> 
> # if defined(CONFIG_CPU_MICROMIPS)

I suppose it's just a matter of preference - in practice both ought to
be defined or undefined at the same times. My personal preference is the
standard macro provided by the compiler, so that's what I used.

Thanks,
    Paul
