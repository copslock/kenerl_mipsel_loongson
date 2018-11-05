Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 19:36:24 +0100 (CET)
Received: from mail-eopbgr730123.outbound.protection.outlook.com ([40.107.73.123]:42222
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990768AbeKESgUC3eUO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 19:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olcsXYNHw98W0YL634W1CS1xhKF5yvMm6VvbJcnIQYE=;
 b=rjMpWh3pNS643B+mKr7HNaN8OWNmwQWhELXwFAF2xaYwE5W3+YhLzjJOuWPkMz9bzpm++8+HJC3AJrl/nMpyYUuXDZScZDz6lTMKJdHvA2cNImX6dOtzEsi1RMFgQ1T7LIgFc/DayQLp/+WslyndckGK3nbxYrsoLytVdSP+8HM=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1069.namprd22.prod.outlook.com (10.174.169.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 18:36:16 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:36:16 +0000
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
Thread-Index: AQHUclDU4A9bTORXSkObreQnHb9S5KVBiDyA
Date:   Mon, 5 Nov 2018 18:36:16 +0000
Message-ID: <20181105183615.nbvnfapug6zm42pg@pburton-laptop>
References: <20181016103806.GA1544@makrotopia.org>
 <20181102020713.GA880@makrotopia.org>
In-Reply-To: <20181102020713.GA880@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1069;6:zmZDwklgT9NermCRLuIkyqgWhb0oOZd8/lhh2R+qNAhs97Cy5ef5TUqcRuasH0lNhgNNACBRZ0eHD2dmsed2eI2nj43ySxBKRDfonnTFB9hr1rhgeasG+UhcnQ9YXSa8NoUuo6L9/jlSSkFuq7zDaQIHJj5ecp99fOuL6J74X2edS2vXftErJeyd92fKDwkFw2Mx7NJVm4ggVatFJOuMIs4bCJdS9+FINqPGG2K9SscIn/ZG6PZkVRC+wZJKezKUwq9X7reioL73YPl21ba0qqKs7a7nZaW3gO9Tg/DhzOZ5zCCf7u8h588ItPWgf4N+Q+aXqLzH8Ff+3Y0QAeIF4O3F9mwZMEl/4YkdTNeWhioGyDcOe3ugtwvj6fJlKtbAf+vb1pV4icOevZvzGuuyH7Ac07e1Lvo3MRpVMS0506D/6IaKHw41N5RN+pGwB6O5Co14/FxSFFSOHn7KZBnOTw==;5:7KLa0wFCZ9V1mCstoW5oTsBhnN8dR83QaMPEXkg2I37ct516kwbQ4nfrbCxBEv14zJmReGmKk8iLbJKas9Va/1unb8xOCS7Bc6EimXzG+nIcmjHf2e+UMS7caUEUYyv1p2mth/cbnundhSwWngeqsJMlgjQUz9DiQ0FrZeTrCoE=;7:12q9dmv+JbdCdUh+U9qzEWDMYHqDjBQ7MZMrrJAiOj6L6Gy8zxt1qqyufJ5IwT69FQlx3z+V6P/NVzgKC5Lk5KjJuIiQjrIc2KGkgRFORai3ov/x6xIeftUDjCfZeqQ2Wb9CgCrHCi5n8lQRE7EnTA==
x-ms-office365-filtering-correlation-id: 2eb9e132-3292-4b19-65fb-08d6434d924c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1069;
x-ms-traffictypediagnostic: MWHPR2201MB1069:
x-microsoft-antispam-prvs: <MWHPR2201MB106923DA163A3461B42D997DC1CA0@MWHPR2201MB1069.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1069;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1069;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(71200400001)(71190400001)(4326008)(11346002)(476003)(486006)(446003)(8936002)(39060400002)(99286004)(6436002)(42882007)(52116002)(386003)(6506007)(33896004)(102836004)(53936002)(6916009)(6116002)(1076002)(186003)(9686003)(6512007)(256004)(229853002)(44832011)(8676002)(76176011)(26005)(81156014)(3846002)(81166006)(7736002)(2906002)(6486002)(305945005)(97736004)(5660300001)(25786009)(508600001)(2900100001)(68736007)(14454004)(54906003)(6246003)(58126008)(106356001)(105586002)(33716001)(66066001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1069;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VU7pSvQYygr8TNTQAYHEbqcOfmlIR9pDLjDj6DsS+mPtvAttTKg/SZvrAU7IsopWdC1uEtOsQDPE89sqBAH3BY6ZZhUkux+DCLABgowqr7axmlwB0e3CbiNN3euvtfuMklk2l45Wdv+AUqNc7stcjQ89k4L87kr+jFNrRf80+ypZcBR8jT2S0ugORE4FWyUcvZ/pk0HKPF8r1mhKTkxwCbi7rCOsORv8N4oWJUz2nb8TXdp5wTU9awRAXpu1YOTYVzwj1L5fuc4qCXJPRwjWH1QS0ukJIwyb1MY7JoNh417N6kUTtnNxfhjlp91onFIpkMcVZcjcylmtgtyUse8Kz+REbhznZzr2pejxOAfNEHU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1EC7A824160DB4D80AD6943121F7862@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb9e132-3292-4b19-65fb-08d6434d924c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:36:16.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1069
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67090
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

On Fri, Nov 02, 2018 at 03:07:19AM +0100, Daniel Golle wrote:
> The RT6352 wireless core included in all MT7620 chips is implemented
> differently in MT7620A (TFBGA) and MT7620N (DR-QFN).
> Hence provide accessor functions similar to the already existing
> mt7620_get_eco() function which allow the rt2x00 wireless driver to
> figure out which WiSoC it is being run on.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  arch/mips/include/asm/mach-ralink/mt7620.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
> index 66af4ccb5c6c..d0310a92a63f 100644
> --- a/arch/mips/include/asm/mach-ralink/mt7620.h
> +++ b/arch/mips/include/asm/mach-ralink/mt7620.h
> @@ -137,4 +137,16 @@ static inline int mt7620_get_eco(void)
>  	return rt_sysc_r32(SYSC_REG_CHIP_REV) & CHIP_REV_ECO_MASK;
>  }
>  
> +static inline int mt7620_get_chipver(void)
> +{
> +	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_VER_SHIFT) &
> +		CHIP_REV_VER_MASK;
> +}
> +
> +static inline int mt7620_get_pkg(void)
> +{
> +	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_PKG_SHIFT) &
> +		CHIP_REV_PKG_MASK;
> +}
> +
>  #endif

Is there an in-tree user for these?

Looking at it I don't see any in-tree code which uses the existing
mt7620_get_eco() function. I'm not fond of adding code which isn't used
at all in-tree, I'd much rather we either:

 1) Get the driver that needs these upstreamed, and these functions
    could be added at the same time.

or

 2) Keep functions only used by out-of-tree code out-of-tree.

Thanks,
    Paul
