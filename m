Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 21:57:03 +0100 (CET)
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:5952
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990754AbdLAU4vbDRNb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 21:56:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AOsSg7h+xTKJthejAroZQQMgbMWKAsQrtXjDrrULl4Y=;
 b=IgAsUI7Wq8nm7ie2VwxQcdhpocxW8uCFONpk4eusVElT4/JwDLWCBJQgK/WrwtSE60ngajJDcy5Z6I6DjZ5rrF5lkZNPJhIXH3A7S3gcERlt59wPwhZrHk1AhKqs2wBDwnUZE7ZiGbNwsUg51+uClcDt5FUMnb/5INWONFpOkzA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Fri, 1 Dec 2017 20:56:35 +0000
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Munoz <cmunoz@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com>
 <20171130225333.GI27409@jhogan-linux.mipstec.com>
 <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
 <99dd185d-6e5d-f474-90aa-ebee63045c42@caviumnetworks.com>
 <CAOFm3uEy52yog4H_Hco0X+OHF5yiHUZYAHaGz4MefKcYQz3LUg@mail.gmail.com>
 <2ac5ec17-cedb-5dd8-6ea7-f065025639a9@caviumnetworks.com>
 <CAOFm3uHSp3ziQ-h1-V9uz07+jiixpgoUB9UZV82fOkrMBk8aZQ@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <1c34c7f5-4237-0fca-e871-ee18c262a3f3@caviumnetworks.com>
Date:   Fri, 1 Dec 2017 12:56:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uHSp3ziQ-h1-V9uz07+jiixpgoUB9UZV82fOkrMBk8aZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0035.namprd07.prod.outlook.com (10.162.96.45) To
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b9d7ec-8535-4413-adc7-08d538fe0312
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;3:d6upu/EHaqNh2pDWFfPINt3+1z5SfwRndKaept0E3LiPoE4CLUer+EDEF8AFyNZ60N2eNrNwJn9P7KH5TS6aRckbDVl8R86v7UrzcRAVhHMOttAfYLHiriDwq91wz7vxOD9vd+JKfsI4uA58wb32f20Qv8fHaX8pkObq6KTxPuByxn6RoWm53Op6DqlMIQu4rkxcuxKMiNk4gH/KcrdfkdaSWl/BLDHGXELo/4u/7e2u7yjKS0dRxiQt9Vjl4U0m;25:pGqiaKUJI38ZAVseSBuIg9yaMlu5uR+B8uQZFQhUD/cWwdz+6mdhfWealZxkErf2fwjb8Fo2xurpMi59kEFgBRhY3V2QR9fxyowbOQZqgMUg2HEVrQc0WCWKslj3gwjETeyxUBE09PcrQ3oL6ChvFSTx7mkHv2ib0OkbIejbAiAQ4XSR8GFZjDyzFlrjqfb9E9GcayK8eV+XXcsX2LVRCzi26My6tGwh8PxQ+lUiFElVy6K4zi9kkb3n3v2rlsyCaStpswlEZiHeGU5HrgGrshsR5YJOncH+tdseik0TufQhegI8K9LJ6m5aNdIVVGGiDXBkV7zfLC905vs/m5pJHQ==;31:ZE+kN9b1HnjZlwmvy4Gn3B0TH9WMB2Ika4HNSVNpd6PQEBc7jvTMLM82w/UP0j2owZFzfXF7SN3v+Z/r8dSWVhMkzq/CY/R6blStwALoBvQUSCGqENZZ+oBnjcBKoErSmzYxaqTKk0QvqZg8mZOd6k2enYzLXjoHaXtTuWYUjN9883IZMmnHmHOD/P06IsSOeyZIDWvnEm+bkc6snLmQGeFSpI5JiEh5/EozYGGn5tY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3493:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;20:ECOlT57GvbL50HOdOZoNSiuKgCY5hAkHBiDq243zykfLg7/g/oBmWNTRH9I33fx5t/a7NUhvwT5N162UHHVMMkbKTsvMK2J8uz1xF7NIhAvTVYx9yqBy97AxZe8hrnsYqz9AWp20JIsXd0ZrCo83IMznF/Ji5jsmgAJJKX4/XILMjtRdzlU0Rqsh1c7cWSQppESeurCDTv/eJ/E0gm6Tvfu8zOJXas4zbgp1IEbRzANg7WfLW7toEYSKMs0a47opiFJchF+cKrKcSfic779dIwjS5vf0mx6vtLlwLGuh4fLAH0LyRLIApTQ3cmcqFDBfj94G/oadEnqeLYt83iZDTDg9DFCgHRp9Ktt1AajrxfQ+xEAZhKx2CIHc4xugcbudL3A5xXKw8TWQuMF4kWYi0akvYFHwLARrL0voo/HAg0JDxaWd+u0Fv34GledhYbwAkdMwldWYQdJ990ZIPIvcOdSAQKr0kMapzHvA4kOC9OzO1JdepbdSJ8IjwcDICNsgKJwyhDe21N4Vye9RJ+PDvZxfmdUSD0GTqYvzlSauBy4yoy4kQCek6sdF4gckcEv6fGuAjevYU9kN7fPrEVzPJabQQ6EJM0vftzgBSK3LDIU=;4:40dreM9fGNxzr7WYmTAifctDd21WCo7FxALLwCVc813pyZPb6QGOXW68OfVRjj1Pvownr2aIlk8NwH9TPaMT8WhhjWyjYmf9iqb7F4Kce/b/oiZLHkcUUTXecB5bTQBJfbK1iRPR1KUSD48GO95oyW8aRCbWNA/UJlMuVrklf2IropJ4dwjSuGIrE+e/gWHMAsx0G1fX7BxP3nIbvEgrNBrqcQEGNpNACPK+Fg0/ggOXgho3z5lrzw0MBR7ygcwwnhMuVRoKKpr463qYsxruLg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3493CCFCB60D5D58AD0F675B97390@CY4PR07MB3493.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231022)(93006095)(10201501046)(6041248)(20161123564025)(20161123562025)(20161123560025)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3493;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3493;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(376002)(346002)(199003)(24454002)(189002)(54906003)(53936002)(16526018)(8936002)(83506002)(93886005)(6486002)(65806001)(2906002)(39060400002)(4326008)(58126008)(6506006)(966005)(101416001)(66066001)(65956001)(47776003)(54356011)(52146003)(478600001)(23676004)(2486003)(76176011)(25786009)(229853002)(6246003)(31686004)(106356001)(67846002)(189998001)(31696002)(6306002)(33646002)(3846002)(53546010)(81166006)(6916009)(65826007)(36756003)(305945005)(7736002)(8676002)(53416004)(105586002)(7416002)(6512007)(64126003)(42882006)(68736007)(316002)(230700001)(69596002)(6116002)(50466002)(72206003)(52116002)(2950100002)(5660300001)(6666003)(97736004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3493;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzIzOkt3Q0xaYXdrV2JXalMxcWpiUUsxTkNuUHo5?=
 =?utf-8?B?dnNSZkx2cVpzeGYvRng3WmZ6eUNNZnl1N2VnSDlPdHVXL3dHVzM0dzFCMXEy?=
 =?utf-8?B?RnJlK3dqb01qT04zOWtoY2ZmSHF5YzdpRFg1bEUyekZhNkwzSy9jWWVPWEZT?=
 =?utf-8?B?R1RrNDRvQWxNZTlLdlBxMUVkSlNlZ1c1T1R6MmFTUE02VFkrNG1hSXBRcmd5?=
 =?utf-8?B?aDFTeFcxRCtCUC9zZ3Q1STJrM3lrN2ZxdDhpd0RpbGJJWWFUczdUNXh4eTE5?=
 =?utf-8?B?b1lvdTNWZFpCNjVLL3JQcDMvZXhiWGs5Um9aM0V2NXBHMnBsVHlsUUJPcmtx?=
 =?utf-8?B?VUVkZ0cycG8yQnpkK212cUM5VnRjUGh1bTRLeVZOZWllRjNndzlBb0dTdzdP?=
 =?utf-8?B?azM1SFdQVHluT3hYSjZoMEZ0bDRvaFhLcHhrNUdTNHFvanpXZmhMZTYwakRF?=
 =?utf-8?B?QkxvWC9NUS95V0JZOVp0Zk8wbkdtQ05FK2x3TjBVbmh5LzNuSDBDd0NqQnU3?=
 =?utf-8?B?d1pGSkliR3QxdXViSEg4K3V0cFdBV0ZjTVhEWnhXc2oyblIyc3AvWURJMHpS?=
 =?utf-8?B?TEVkZ1dxcnlxZjI3aVhZSnd4VUlBRUcxbGFSMEw2ZVJaQ1hmY0RyWmQzcEFL?=
 =?utf-8?B?VE1sWXdmRHRXN1hTSzMzV3VHUzVmR0xXYSs5Umd3cHVMdGdwdkFHWTl4MWFN?=
 =?utf-8?B?a3U2UDVjbmZpalZrWnFiQVR6QStuOXQyR1ZXdUwwRUtxNHdJckdTVUZEL244?=
 =?utf-8?B?S21JVm9jUDVLV3drWFA3YzZ4RkZQRDMyQ0VHVnU2c2xhQmkwWFV3b0h1M1U4?=
 =?utf-8?B?OUpobkp1WkxkcUs2WmFCcDZNVjRqSEkyRFdncDlacU5MOVlCU2srZWdYUlU2?=
 =?utf-8?B?Y3E2Zm5lQlFsNGNrYTZTaHlqVlh2WWdNNWtQa001N1oyaXRjQy8rZE8wcHhi?=
 =?utf-8?B?WENHcXpmMVY3YkVCY0wzdStBWkgrMEdtZm5BVjVvdkJJTEtGTzdZbVNGMUM4?=
 =?utf-8?B?WDZNdWcwMDJ5ejYvWXhKKzdQQWlRN2ErMXNPOU1MYU9IdDZKQW8rcUg1RUph?=
 =?utf-8?B?N3BkNjFJZkFJeGdqcEwyRk1tbWpIeFVONWNpTGxLRk9UU0Z5bG5zTVVLRjcx?=
 =?utf-8?B?UjIzMzl1Q1VjcVAvU0pFYmhEUGRqVWZEaktPY0NZeFNRTGphaFd1dStzb0lI?=
 =?utf-8?B?dUZMVDlpVm5YVFhBcVo3M21BVlliUXY5NzZnWEI4S0pnOWtLblV4MjQ2d2Zv?=
 =?utf-8?B?TDlXV3JqWHFpL1pSMWFEcVBTUzRjQk9wb29CV1h4emlDOHFrRXo2clNSZUpR?=
 =?utf-8?B?OVpMMjdBOWdjdTAvUlBPamN0bHpSOGJSUy9PUlZ6b2wyelYrRWN6ZkNpNXht?=
 =?utf-8?B?SmJJV3FzdzJWMGdIM2JuOC9XRDc0WGJxNlpJUkNxbHVMNytUeEZGL0FNajE0?=
 =?utf-8?B?VXE2UTFqTkFOdEtWUEVmeWVjdVR1N0Z0VWNzZUZCWExYSlpNSlQ1MjlxSDV0?=
 =?utf-8?B?SmorMk8xSGxYR3hidS9yaHZ5bVFEd29VOWZ3U2c1eVRaQldlVkR2YjdidUFu?=
 =?utf-8?B?OGN4eTNWRmQ1Z1h4VHUrT3RDQTYrUTRZdzU1WUlCWVhiczB5ZHJXWTZBYU8z?=
 =?utf-8?B?QmEyV2wvVkdISUxOaHpRVnQ0c2dvRzYrMkU4TCtmczM0OWFPM2tzS0kxODVu?=
 =?utf-8?B?UGlpZExzR29aY3llMXBMMEM1NGtJc2Q3VzhmdGdBQkVWaUt0dlNGa3ZqdXN5?=
 =?utf-8?B?WFJ6SFh5WWErNC8vaFpvL3ZJR2w0ODVNU3JvSW1VUEpKUVQ1UUxNQm84cFFM?=
 =?utf-8?B?K1NiZ2lkb1JCZGwwTXdqSTNCelFZOVQ4T3JnSkR3bXFRUXhydDlhMUdSbC83?=
 =?utf-8?B?RWNoem84ZEQzeFgxb29QRVE1Qzd3VHZuZlBTMnQ5NGwyRmlyWTd6S2lJUUN4?=
 =?utf-8?B?NWRRaWx6NldtekRXK1ZMaFhxTEliL0Z0d01jK3dtU2ZsazE5dVFOMktXTFRN?=
 =?utf-8?B?YTkyYXdHdWZtbmRUbEVoQTIwL2VoeDJic0tIVnRmOVl4ZFdFTm9Nd2syaGtt?=
 =?utf-8?B?eGF5MnpybjN6YjhBK3JmbG9wd2FvT2x0YURmZ0dieWxGZStYZWwwaUQ0YVNH?=
 =?utf-8?B?eGc9PQ==?=
X-Microsoft-Antispam-Message-Info: RRv2b/WRTvpJcyk+Xw1YmKCa5ykObtbHFvdc/vqytAaSf7AXmrFWZr7cV7Go39RaGb/gB0TGXWCtXwamhG0iOQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;6:RzvXliooIhiLf3OAw8kbGsvkZ5twsSipUhq2q+gwRpDP/CAmPozRcpXNZ4jQ38VciFU4zE6YvJypKuADIiCJTIDY7wS85Ned44counEL3WucsSV1OtEnjT+GYea3qP5VAKMDVhWXha+Adukeg5CtlN6wWqcVHqumOyRW6KubBoqNELrwLSFVpxQXa4iIoEqc2+L2FNlwoJkKS7avsYe2I49II0xZRb+24hwFMYTPDYtItY1DVXxORo6+8R3BNKglMmAUmWG7Jbj6ViKdLnHspa7zRq1A116e1iCBHL1EE/Dpc3LTSwxsjcDZNiKygCvy7x41rRq2Yoi0y0CsDEc8loeciDJI/Qe4/Lmi4cimdH8=;5:C6a7+AYYFqrxIiDKZa/6PDFq04uOBdXHlnQbLffLZeZblQwLXWUc2uwk44XgFcbIk8d2qLXejIfIK5Xl4qfQ/MJ8V/rMBotc4RqqhD6xA337s+X55ggy7X3tedUOGTvpI8ZoOiHU5OcyT9iHPU7OqdVoWWTkIstlDwvcbNIt3GU=;24:ciI0y3HOVR0f+XBtTL/KdYhoSfIVW+8EZQ+maqSwG5HQbVYz9RIGuGBEAbKjYX3ni8QXgwA3DZBsCAIgyMi11moCwD7Bx1nXrEcMvXNqQmA=;7:DBQ9zdhigzKeyhXojJCyOcEpz2l/iHR9u+zvay6f621LW40X+tIckGX14gXfpcx6MJUqkHDA4FSISoaaHFCH9aFF7UZCc2gPV/LYEkKt8ACDyOK4LADQRH2HKgSCv6VrtAcEuei76s53PV4d6HLZGeattWQLl8/nd583qK+LnQqtAtfzmLzQkJzbEO/KDgJdm+rdKJZnLHahgJDKFco+KgIQISHKar3QXIBcnzQWCwVRWMJitHUpoKwDDgst2WHY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 20:56:35.3291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b9d7ec-8535-4413-adc7-08d538fe0312
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3493
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 12/01/2017 12:41 PM, Philippe Ombredanne wrote:
> David,
> 
> On Fri, Dec 1, 2017 at 9:01 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 12/01/2017 11:49 AM, Philippe Ombredanne wrote:
>>>
>>> David, Greg,
>>>
>>> On Fri, Dec 1, 2017 at 6:42 PM, David Daney <ddaney@caviumnetworks.com>
>>> wrote:
>>>>
>>>> On 11/30/2017 11:53 PM, Philippe Ombredanne wrote:
>>>
>>> [...]
>>>>>>>
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>>>>>>> @@ -0,0 +1,371 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +/*
>>>>>>> + * Resource manager for Octeon.
>>>>>>> + *
>>>>>>> + * This file is subject to the terms and conditions of the GNU
>>>>>>> General
>>>>>>> Public
>>>>>>> + * License.  See the file "COPYING" in the main directory of this
>>>>>>> archive
>>>>>>> + * for more details.
>>>>>>> + *
>>>>>>> + * Copyright (C) 2017 Cavium, Inc.
>>>>>>> + */
>>>>>
>>>>>
>>>>>
>>>>> Since you nicely included an SPDX id, you would not need the
>>>>> boilerplate anymore. e.g. these can go alright?
>>>>
>>>>
>>>>
>>>> They may not be strictly speaking necessary, but I don't think they hurt
>>>> anything.  Unless there is a requirement to strip out the license text,
>>>> we
>>>> would stick with it as is.
>>>
>>>
>>> I think the requirement is there and that would be much better for
>>> everyone: keeping both is redundant and does not bring any value, does
>>> it? Instead it kinda removes the benefits of having the SPDX id in the
>>> first place IMHO.
>>>
>>> Furthermore, as there have been already ~12K+ files cleaned up and
>>> still over 60K files to go, it would really nice if new files could
>>> adopt the new style: this way we will not have to revisit and repatch
>>> them in the future.
>>>
>>
>> I am happy to follow any style Greg would suggest.  There doesn't seem to be
>> much documentation about how this should be done yet.
> 
> Thomas (tglx) has already submitted a first series of doc patches a
> few weeks ago. And AFAIK he might be working on posting the updates
> soon, whenever his real time clock yields a few cycles away from real
> time coding work ;)
> 
> See also these discussions with Linus [1][2][3], Thomas[4] and Greg[5]
> on this and mostly related topics
> 
> [1] https://lkml.org/lkml/2017/11/2/715
> [2] https://lkml.org/lkml/2017/11/25/125
> [3] https://lkml.org/lkml/2017/11/25/133
> [4] https://lkml.org/lkml/2017/11/2/805
> [5] https://lkml.org/lkml/2017/10/19/165
> 

OK, you convinced me.

Thanks,
David
