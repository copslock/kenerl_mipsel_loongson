Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 11:15:46 +0100 (CET)
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:10022
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990421AbeBTKPhfzMo1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 11:15:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3OyEXCTGS23gji30cjdgHbRn5xkgX5U9oXJo02Q1uRQ=;
 b=K2pmp61Mi+R96gxJPEM2Cryjh0WYSFpaef2PgvrkYoyKZr8cAfiDlkBRXKYgVekpzuCqwWipW3gv2WquyeJ4+CPM7xUhdPysBU25ag6DYTTSj5e+rvJGDnbs94orgRqCTR0FPIc9RufyY+j9d8XLV+wpZJ0kWbWVOnR5wmF+JL4=
Received: from SN4PR0201CA0065.namprd02.prod.outlook.com (10.171.31.155) by
 BY2PR02MB1332.namprd02.prod.outlook.com (10.162.79.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.506.18; Tue, 20 Feb 2018 10:15:17 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by SN4PR0201CA0065.outlook.office365.com
 (2603:10b6:803:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.506.18 via Frontend
 Transport; Tue, 20 Feb 2018 10:15:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.506.19
 via Frontend Transport; Tue, 20 Feb 2018 10:15:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37250 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1eo4x6-0006yS-GH; Tue, 20 Feb 2018 02:15:12 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1eo4x6-0000Dc-DY; Tue, 20 Feb 2018 02:15:12 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w1KAF0Ax020530;
        Tue, 20 Feb 2018 02:15:01 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1eo4wu-0008Ne-FV; Tue, 20 Feb 2018 02:15:00 -0800
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-mips@linux-mips.org>, <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <patches@opensource.cirrus.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c7eae315-c8b8-3a4c-af1d-f7d713beb7c8@xilinx.com>
Date:   Tue, 20 Feb 2018 11:14:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39380400002)(396003)(376002)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(53546011)(76176011)(356003)(36386004)(4000630100001)(305945005)(26005)(9786002)(2950100002)(336011)(186003)(6666003)(64126003)(50466002)(39060400002)(106466001)(229853002)(83506002)(6246003)(77096007)(4326008)(65826007)(5660300001)(8676002)(58126008)(47776003)(65806001)(65956001)(31686004)(63266004)(110136005)(316002)(2906002)(36756003)(230700001)(106002)(54906003)(31696002)(81166006)(478600001)(7406005)(7366002)(8936002)(86362001)(2486003)(81156014)(23676004)(7416002)(171213001)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:EjgY6YMwG1AoOQtkKw9RyKtrs/P/p7Q068Mj8o/ZS7dp53nWTOb3cUz92g0IjFSqrm4/A6j+PbhHSp0NpBA6wY3oHOYXZ6N1xDH9rcz36sSIKpYoVd95ZEOAk9zlIYho
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d7877b-fdd3-460d-a230-08d5784ad67c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;3:5vAB1XTQ81RltH1iuHk78DkfyZ0A2gHeOgmNP4aAh9YHyE44H/YvRLxxPq1NvVWE2P0xlW0UvMCudb1ZZVDiV/SDBEZ1W/OJa54Zs1tiYFFIJ0lKY6ZUktXCopEpgruRA4MAFGzDl1i78hXBoj2ktCOY/eHtVPE7H1m1MOk3PrS14iI7wqh96PWO9jI1GJuAggQQFU3LYhOIF/hezjbrNNjFdyLNhIgsJfATalyxlf7laNnSLPwu9amI2wBZ5eTOnr8SZI/rCL4R17ZtVWmF9hMir3ux9+hw+jfcCEc+0yL+D5Z3yS3hgMRukGoAAjX4jAK6lbW1vwvZzRpvZtvz4Z+SfI8kiJy7V/GnrOvHBuU=;25:OG0ab6MckfdiUEgT8oTlitNMRvs7yTQBoKTewGOHe8XRxti1pNq3kEj/R4f695gTu7J4Xa0R69sogLt46oPTo4IVjRUR18niw/eW+wle33lujizhe0rr1cR/rqif8qzWW7idAF8IKfr/37YqgXYzDckkXXB8tqPZ5siNEZwHYZl/A4x1YplgJIj+sTfFHpwyOGKJIzILrQ3zUSamCB0NUkWZzGvJcLegxqQ1zBvLR1Yd88mbVUenP21qbup6/R5FlOHL//1HiBH898heOrrRTFrnXw4lptTkQHiXzcmaURZzapdjtyBbZqNB55ll1jyNP9ATh3Nzi1UPflUVHCNR4p8aSZAkoSeDgCaV9hUaUAo=
X-MS-TrafficTypeDiagnostic: BY2PR02MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;31:8hi05CkSay3NVJ0ZH4iZDgKKtTFpccecA3AB+mGCJwjSmsgpWKghGWqZsJYNp3YQs1w07knOaWsfz5jS9/o626sWUvMXumXmPfEUpQDGvbcQWRIpoYcW+fJb2EK5FTgUbODBvfMJTsVGu93OnyERK5eEZ4uq8b3MFsEo3j+pXHVSOitzf83jvNInLcGumZgUXSi8xuhOWA4IQ/VrUa2iugEXgLdB0lNBkCE9dSIloUM=;20:xS6BbVQzs9JuFoh33rQJY2yGCYmQ/XCWdMY1IWb/BVTf2/zwTx1i8Vr+B2Ct0ZphIDaaPbGbXcjj1GSwr5CRFW+0ArB/yCyA9dvidhlIY41Iktg3HSH4lVN9PtA2j9YKyvCUJXTBjQGKK2D0iyJLYeyT4sEo77vbeikWWdWkYLcBolWIVAc1leIfEmMqcWSAMWLaQQ4aeiSDRI4NTiZcN3FBu1MemtyTo/Y/4bOtI8SK/5cBR+rMHcYOHccJ/Oth4PdCnLu6uchEwRFhPct8Qq6KAd38rzcHFRAKBENrGENdcGZjYkAGKni9dn5UM6OhvcNOqXvwgKoLyqdquv+vR9p2ixs4uFO9TDdvlQiRSugnZ935txm+eloITSzONlEjy3W26xCQS74+jrhm85CWu25+Oe9K0kupVG4CiFgmAv2mSgRIFpwKXPDG7ti5yM+HEsPRc8rvRQ61bvBmK8DZ8c2nWZs01KD5KcJ6em/tqbKBJu8KY9fUYenagyrduZA6
X-Microsoft-Antispam-PRVS: <BY2PR02MB133298A10C7B60584B9B2405E2CF0@BY2PR02MB1332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR02MB1332;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;4:daso7F7Dt/AfbmU14ZeJG0Wfs3lkKK7DJtIKyoBGq+HzEJQDtBda9r2fTaR+OoXERRyFg29KEVvJHM0GXvgryRVi/X5ODVTdp1etk7omzzjAhOkWeHiRHl7rKs5t+EM49DN3wDee+9MtYBbK+ON+RoofRKPlFx+VaQKFRPUYSbtAwAWc7RH2ymXHFKd/N0wd94p3Sgu14BFeHGXLqqBUtq8XMp5i67k+SOBTb3P7ENU8CN1FLnlb5QyvdZEnKLvFyWoxDJuMZ86c1yQCa0Wl0mCdMc14ExNJjFo8zS3jYYYmc0hIbUPSfdnZdBVGWAWFozoN+DHP7iPljWxc/IqEk1V3w1NrAqnZ9yv6Nvw2h34=
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxMzMyOzIzOjhXSU05TkdaR0NvT0Myam9VNDZ4RG0yTFQ5?=
 =?utf-8?B?Y2hkV0ZGWlFtUzBiVlI4Rko4UDlSK0t0N25uTEt0eVViUkRPcWtOdWRJZFNN?=
 =?utf-8?B?STBxeWp0bW5KcGFqY0VrR0IzTG9yTVhYd3JmVmowY1dKTENwcVBMc1NrK1By?=
 =?utf-8?B?RXhUQ2JNNk1JSm9hNWtnUDNGUWEzUW9mUWxwamVrNkU5Vkt1dDdlWmZnWUxa?=
 =?utf-8?B?KzNUcEIzbTZHemhtcFpEWm42bWNVMWFsQ1o4d3g4SHBZR05rUjB4OWptNEli?=
 =?utf-8?B?Y2J1VGI2elRiYXZocWNSc0ZaekJ5Sk1STmhQN3FRQ3U3MWlmQnF4elBFQSta?=
 =?utf-8?B?ZTFNejltM0I1b242dU1IMjJZcDc4bm5CdVJQZ2E5aFVzS3A0MC9vNnI5dC9D?=
 =?utf-8?B?VTQ3dzA1NDM4NnlmSFVDTitZMEpQKzkyeWd1VXFHWWtDS0FTSUZrUHdGVDZV?=
 =?utf-8?B?aGpvY0JpSVlGNFlTd0JPV09iUnhsY1FjWFVRM1dBbW14amZ1d0tzb3pQMkdr?=
 =?utf-8?B?bGhDV0hSY2xHa2JWR2dmSXRSK04rc25Vdiswei9PNmR3TFFBaUJYRy9Iby90?=
 =?utf-8?B?OXlMUHh5QWNMOFBtaG5iamVoaDA0czB4cFMyR3RTaEFja3lIaWhhQXVicWdE?=
 =?utf-8?B?WjREYVBzTFN3a2ZsZnVFa2hZSUswUlg3d1hDZFJxWUM5aUEwWFZHZGpvVXZU?=
 =?utf-8?B?blAvTGx1VDBSYUtaYUNhN3NvVUNEUGYvalluS2pGVDFweUdzQS9Sblg3QnYx?=
 =?utf-8?B?bFBJMlVreUR0R1oycGZBTTZaMTBoYVZqWDZBMFVSYlBGNHhiaCttUzRKOENS?=
 =?utf-8?B?cE9MRjl1ekNOWTl3UnF0dmRCdGZQbW1teDhaMFVrR0xKV1g4UVJNWTh1SXAw?=
 =?utf-8?B?aGlJU0pMT3pvWTUxby9kNnhuY3MreUJCM1JGR3MyZXVtL3YvNkJHeHA5OERp?=
 =?utf-8?B?aFJJTTBYRGJkZC80VmIxQzBoakNDZlBSN29pUHdpWnphazlwWXYzT3c0bEJV?=
 =?utf-8?B?djlXMU01QXRvbXREODZUTDFOV0lFZkM3aHBiTXFWTUJ1dXRuSzhlaWZ6b0hl?=
 =?utf-8?B?MWVYVkFWdG0yVWlmYlRnVlNMMVYyOElrUjlSTXNlYXdvbk1BTmREZzJRdW5Q?=
 =?utf-8?B?c0h0UXBwdFdpajlzQUpSSXVCVHlMVzllUk4yQ1VKVEpBcEh3MWlaYkwzOTBt?=
 =?utf-8?B?VFY0RDg4bVFhN3MxVGVCbmFpSlBxSFFVVTBnWkIvQ09Oek1SOUc0Tm1KN3Jx?=
 =?utf-8?B?NTA1TWlNa3VneFhXeGdJMGZ1YkFUMlNjSzk0eVhieTFCbWp3cVQ0MlZFVkxE?=
 =?utf-8?B?Yjk4bGJDaDJwSldpTml4YzdRZzhRUnpBeWd1eWRZOFFYVFdkR1ZvcjdmT3k0?=
 =?utf-8?B?ZTBwWU9ucFBUNHp1aWpWM3dqTXBUYVlnYWIwc0M4bkdaaldQWWtmTE9ka1F4?=
 =?utf-8?B?QXRLb0I2OFlDNkE4Q1lqYkg3aVpYWEM4QWNBSmlkekFVRkJOTWtJc0Fremda?=
 =?utf-8?B?SUJ1bW91YUdNb29haTc2blg4K3VEWlAvM2dSVGdpMis3SWwxUkNYQ1ZBNmRh?=
 =?utf-8?B?S3BtVDV2U2puY1VBVk5lY0hQdjg5VFhUSVJ1ZDVnZ0cxL3AvMXlsU2REK2U3?=
 =?utf-8?B?TDBpalRYVFRmR1ZFbVNmTjNFVXVpVVJrVWtTNSs3N3RuOU1YbXZrQ0VvTzNa?=
 =?utf-8?B?eXRZYjJDeWo5aU9vckkzSVhYZ082MzBBN09SZ3R6VWxNcTduS2lUWHllRFcy?=
 =?utf-8?B?dm5vaFBsT3liaG8xK2JJRDJLdTh3eVcyWno1SGN0M1kwbTVSS3VKTkdhWk8y?=
 =?utf-8?B?NDdjUW93b2FUZitjZGUrUWVJQ2x6RFRocVVDMkNuL0ZKQys3SFlhK2Z2dFNh?=
 =?utf-8?B?cysrVFBoQVR2UXlOd25PZ2lpb01EcDBtSmpxdFJmZzBURUNGVnltS0pTSlpJ?=
 =?utf-8?Q?PR5UaW0dfj6jtYbsforf50Jizwf6TI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;6:74Q5cNCH48cvbymJC4fsNU+Ertn3Gtdq6AluD5hGLq9alHlrQWlc6yRpNxzQXp9EXAkOQLhBTBRSoqQrrHeU8cTgcvRv2jY/Iehe6oHFjx3xM15zF00usAA9Ssot1kIYcwhRreRGo6VLMbfBHPnMk/6B8d3CLKIkoF9E+HI3YN6ZKL4wE5HCFa2xg+KQhfB3uEZbY4Xhy50f6EFaNidXGvnHqf0Ml+d9XsDvzV0rpz0aWdS6imhA8VNMPcQ06DRoPmlg085jbEJsogi13RqzrBDspxqjYXAIpbVVThLs8vurSzrtZ1Txkrg8msVOYcQ1VY+yQxlN690qhh5ZJO/xAIxxCR0JXsOUEFjoPIPENNQ=;5:nUDplGBwH5oKzPembzMI1HQzRaqKeYohPaNI6c+18wTv0aiyHDJPsRcmgjveNwb1wk5WmMKprFxk38+2xKihkChmZ/ReoT13T3ogoxNtEMINXndTmljQuCYfF2cVSq423GLLdESNhTcHMwKS+9u1aBSxF63s8tB6sp78fkqdIdM=;24:tgkQu0iLqqeSyyy7AXrw/8ezQl4j1csp0FtzZc9mkFVbjde4TOy5frWGERAGQcrB22MRv4Y+fyLmdd3XZdxtziquE2/ZGsktaN09G05NV84=;7:St0QFm9AGje+KwMMug+T3vVrbpz8ikG72f8qnEAVD3Pel30/FrHPI/BY8935HFBNFxSH5JWVoRDbfo7qYdftjP6KO8M0ubBan8KSqyfHfEa23TpZdbQastfuKFs6YqkR1hjUvty+lFF6norEZTUPnIZODirQ+iicN3bQ0LNM4sjJamrtk4s0dMaYG+hPQSCKzhu85pHwfQJg7Gh+K84/WiPqhVxiADbe5HlArhF05vvd6A2daTd3/LxbT4ioaoea
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 10:15:13.1541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7877b-fdd3-460d-a230-08d5784ad67c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1332
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 20.2.2018 10:31, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 
>  drivers/watchdog/cadence_wdt.c         |  5 +---
>  drivers/watchdog/of_xilinx_wdt.c       |  8 ++---


Acked-by: Michal Simek <michal.simek@xilinx.com> (For cadence_wdt and
of_xilinx_wdt)

Thanks,
Michal
