Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 20:21:16 +0100 (CET)
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:27936
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbdK2TVJqmQki (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 20:21:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UrfOr9Esz91UdEsYbT8BipkJDZp1VKZuWnYZx+8Iqw4=;
 b=TD9YjLGnpU9jBaraWW/J4rtISMvyhev9+eGtq/PlQHtv9/y5q6qNN+QiJDIw8+0t7bQ07WKj1/NiuDygfUDOj8ZCAlTLgT4helU1MC/cez1qXhFHOpaPpzswPtuuR/8789Bc9BwbtVryZ4/fu9Uh+PscCuUa6MApfhzJdRnwqCk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 19:20:57 +0000
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
 <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
 <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <cef2bbe0-cb06-6938-f665-9840eb67172d@caviumnetworks.com>
Date:   Wed, 29 Nov 2017 11:20:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0097.namprd07.prod.outlook.com (10.166.107.50) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2833b3-b580-4989-ffde-08d5375e5201
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:uaihPuir2KQM+1aN5gT9v5j7IpRlGwWkbRBRyYnlmAp+V6snEKBPLtYK3J3GM2dbERFaeBNqQowJFi1D8m5QavtG5GQwBSh1QEWh3FEdH9POKsFgKILsnKM1Y5NoUfNCLdNPd+MRvmdv3YKuU42qKDXFMOPCPo1rDiVSE6w32Vufxg89plDqjXPdfzPL8bU9dxa0lP0TYbSTlpi9jsrtBiLOFApus2CJ95JGterVOWTliDrwAaq7p/xWCiJnmAri;25:F3hqmtZARFs39fDFQO0ADDrkAyE/uD98Y4ny4fj3xCRkZEiZlkHpBbhUlO9r6QZmbEknQ9nHfqL08vxjOGae87WKvsBt5F/NsnHYyr2KTtkL1G0mPyqLmzxGLCBvYOvHjWkmJNcfXS6ddB1Q9hjf2bkAA2waUSqIbwtUzTyz8pZGMe2OBrk7N3Z5Lb3lanRQrExreV2uEfzSx0Hqs5goQz8lJIaVsT7ANjLGMQHX0Ay+jljG/1kWKshXLZHsGn1euHFQ5acTAX76T2LJ6MyJtjvMcoFXP8lxUv2Th9h+mibhwdTHp1pU2fvEqSbY99S41G1818FwnlGlLQHibm1QKg==;31:F7SdL581Tlor+aRtnLfRkjAALscb4yakzy7PDVhx+bFf9Ee6RmoCgzsYhRsXH832qxxGt5ZaRraTKeeGUbZqcpgppjWebONTLsYL/+8rBLBDxW9+axb5LFo1Nb3u27IdS1DaSVNwmvJes6unknrxdAK8p7FQ2pJkuOSrdvsM0exIvn+My9pUgEdvktWJcV8EqAIfAdK9NFeeiwyD1bxCARgCK/UVLkJTyrxKx2P8y3A=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:klQFHoLSiygM6fOEAHYdWdAjkvgPHLVvmifiyO3kvoDMEumDwJMzrGKS7nkc6hcRRH8Uicm082WzxUPcrxXXzyybrnqv2n8tG1qEJBhrV1scIPemN2eRselHF9bvJGO/6CzuE5mwC0zE+zgQwjgn3rkJQTgbRfaOktu4SdYPh+kGf3d+Yw+kRJCrSFIV+0cpXkbZRYqjd9DrA0bKdFH9ZYZKZa3GgoV92hEhGr/ayX7/RT32LCzB/oDhZHK4EsnkrV6CamBC6MSis9+YSkyxhSRPH89SYvaXS2BTJJedXbaw70/DmY6Pcmlq2rfYDeiD6jFQWP4M6Xqf3ALjiuFHyZzAGM4MO70gwYMUrQIwe8ldWmeEyiBSzsWRtyhI8PaBAYEwmej+eymLiwsfwSwoBY7UsC0cnQM2niz8iG5ePWMkzYnetV7favA7DHzy5q7LrQ5zvWbXBKAvIpP0ve+s09Y9+cU7ys3xdHqWLAsqalVJch2d5u51oSpMNRvuOwU4Q749ZqzqHoTAJOAv2KY86c07FIJlpOD3W4RqRjXda2rDGzyxaZX1kWbrFylb9SyxSxvi3FqZNRAh4Tcypqr84aa2Urm43Z5tIVI2IQiCYCM=;4:esDhDuGMFU8/hUVb7u6dNsO7CUqBXdVmd9E+O6s779YU3MSQI7myybdF7gd/lw8F+77L3gixoCMIE6LguIeLHSTaleK4pCm2XsMftGIRhV9HhRbSFpwnRQeTprQYMXil9PvOojSSfkISktuNORNGDU3D9yFAKCM+A4EQpycu88An82Qe54A/mzlM/F2Z8WHbyDeILifAzjrK/imhAL+2NDrpxx0f5ipcEPt79BiSn+Gm15M0ow+63gkSbij3DQ9+NEQOKJYVHVRQQrejYNhAbXlycdx/Zp6R3kDMYAws6zNZyosj8rAZ1/fOH2XWAzJK
X-Microsoft-Antispam-PRVS: <CY4PR07MB349615944B92899C9C01E88A973B0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(10201501046)(3002001)(6041248)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(6072148)(201708071742011);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(24454002)(189002)(5660300001)(230700001)(16526018)(8676002)(81156014)(81166006)(7736002)(97736004)(53416004)(305945005)(3846002)(6116002)(101416001)(2906002)(69596002)(31686004)(66066001)(47776003)(65956001)(53936002)(65806001)(4326008)(6246003)(39060400002)(65826007)(93886005)(189998001)(2950100002)(42882006)(33646002)(54906003)(58126008)(316002)(110136005)(6512007)(106356001)(31696002)(105586002)(107886003)(53546010)(229853002)(8936002)(6486002)(50466002)(68736007)(6506006)(52116002)(478600001)(23676004)(36756003)(72206003)(52146003)(83506002)(2486003)(67846002)(64126003)(7416002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk2OzIzOk1tZ2pMdWtaeFRBaW1RYzBwYnUxUXR6Q1ds?=
 =?utf-8?B?b3FUT2JqZysvM3RrTllWcVZXOUIrYVg0eUovc25lekN6VVJNNDVxUDlZT3Vv?=
 =?utf-8?B?eG9Pc0pkNy9GUnViYkxBT0hrc3ZqdkNvMkJ0clFIbm45ZTk1TGxXZXZGOEUw?=
 =?utf-8?B?UjNpYTVBSngyTWFENVQ3Y1d1K3FlRm12ZzRRaFcyV29OdjU5dVVnbHc5cFRh?=
 =?utf-8?B?NVowNWt0MEp5cVZYQ2F0eHJNQ1NlYUN1QXF1ZW9xclc1bDRKMFVTaVJRLzZD?=
 =?utf-8?B?cGJndUlJQUFqRzFpc0Z0ckIrY1BHUkJxWW9PeE9rYkk3azhOSGVMbnFMKzR2?=
 =?utf-8?B?SVZzQk5nK0NJTzlvaWEvOHBIT3BQZnhVU1VLTFNpSTFrUEtoV2dpL21IVVQ2?=
 =?utf-8?B?NHFqM2tDb0szeVoySC9MZ25xcWsrKzQzQUZoS1V0VktiNlVsa0tNRjBMbU5x?=
 =?utf-8?B?clJNYnVhbll4OWNPeTlZcDRqVFZVb3pvN3BySXpBT0lEcFNmSkwwaXpUTm1w?=
 =?utf-8?B?OUkrR3V2V1JycENJWkNQcVJjUUQzdHF3MUZFZUQraFpXQzErZGF4ZTFja3Vv?=
 =?utf-8?B?K1lLb2drVit0emZRa041VThHMzVYS3UrUk5ySDdqcnc0WFFyekdRSTJ4SWw3?=
 =?utf-8?B?OGlVa3VKREhIY3Z6cW5NbkZQZGNNbS83YlNzbmltMzg4WlRteEdQK2tCRmRs?=
 =?utf-8?B?UEo5eVplclJGOFpWK1RXZGZEUXBmTWt4MUJ1YWh3aDZNUHNPV2ZVN0plWWR2?=
 =?utf-8?B?aG5GbVNSMU1xYzVyd1MvZDhvVktrMlEwdnIwV0ZmaUlLbEJYSSt6YUdma0R6?=
 =?utf-8?B?NXpVK2lod2Mzb3JRNzJNZ3pNalA5UHFVMzFxdXhGVEROYUpCNjl5bGZlYXl0?=
 =?utf-8?B?VFJWUlNSaHdCYmJKclNmL0tlYUh5VTRDaFNjZld4VzQ5cFdyMlZuMlJkZzg5?=
 =?utf-8?B?bHYwUDhCS3Vyak1WemVlT2NVdWtZT1lEYU96aTVuU1ZxNytKVWpIRldhSEhq?=
 =?utf-8?B?SVBZOGNWcitFOWpCTDgxTHdVL1dEUW41aDZDekY1ZzNneXZTd2FVUTFVbnVo?=
 =?utf-8?B?cG84ZjUybGJBb3htUy9jRmhlTm9GV3hYVkUyUGljNHBEemxQYUlsNzIyd0V6?=
 =?utf-8?B?T2ZyaEpRdFg3RHNYcW4vRE9oSEZZNE9BUktZR2haeDFaMmUrOFlsczlIWEN4?=
 =?utf-8?B?RDd4SUpoWk5OYm9LcWYwRUp1WnNMV0E2TUN4YURNV1VnWXgwbU91S3lEWUtj?=
 =?utf-8?B?cU5NZnRwQjZzYzdKeGhNZ0VpUWxPLzRRdWlOWHpDZ1FnNVVJL2hXNU4zUDRO?=
 =?utf-8?B?bHY4eWttQUtCNG9OSWJoL2pTL1RxTExUTW1KamZrUGh0VWROM1dEamRmbTNm?=
 =?utf-8?B?UWxNNGhhQTRrR0hTSE42Z2Z0M0M5dGFLRDRtd1Q5bDA4RFprcUpCSTNMbXpy?=
 =?utf-8?B?UXdmUDRFQW5LRHdkYWt5OWVhZE1HemJCc1NRaE5BeDc2bWs5bXYvSWxmc05x?=
 =?utf-8?B?QUxSTHNJb2NwbEpQUG5hYktBTWRpaElSRWVVTmtjdXlVZ3Zoc04yRjEyMXB2?=
 =?utf-8?B?UlVWNVNQNjBVUU1ReUxGNjAxaFBSV0F1OHVmdWpyUmk1Zzl0RUIwSDlmTkFi?=
 =?utf-8?B?dndWQjdtWWFXb1lRNUY1M1V4bmZ1OUdpdXBhR3pQSXNHVWRjNTFLd2JGcERw?=
 =?utf-8?B?eWNCSTgxM3l3Uno4dU9yT2xhM2FtWlM2NDJ5eEpxMHhuKzFza3dRM1RpTlZq?=
 =?utf-8?B?bGlhL0FqZzk0dUFoTHRHTythSUJKYmJMTWVKSTJNMWd2SlEwbDRMMVVMaGph?=
 =?utf-8?B?enU0a3VCT2JYQjBQWGNaaEIwTnNmaVhpYXdiRWdoWXozQnBGQ21RVFlORFNx?=
 =?utf-8?B?Vm9qNFprQnBISTlpaFlIMWRjOEZZMERDZDJCZzcrUExOWXRnR2hkeTdYLzRN?=
 =?utf-8?B?TUxtblJZWEkwdThGd1hxZ0FmZTJyL0FtS3F1YlcrWDRJRzVqMnQxWExwbTg2?=
 =?utf-8?B?Ui9wNGVPM2JhTlQ1VGgzZGppbFFoV0xLeXgvdz09?=
X-Microsoft-Antispam-Message-Info: vTLNF8Ve5/KuIJbl/hfNVBy+lwy31Ax7CnAdnIVVugf8DtwBkwagABCNvbUFBaula/q3dMIyUh4hE0zZTbKTng==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:4wbJlwn9NBpwE6bN/6K5wcg4cMXRGTqrSEXpS9G0oXG+8+IBYuGYjyY9FsQCpNwZez/jW94z0nt8SA68zyZFsT55Y/4OObUc9Yq0Pqn4Hg6THUH+ThmqMUFcNAA5oXGkK+2bJsqFqOS80uBO+mknc5m4yNMoBowcHVd9Azt9Yaiz7xc29ooA3hnCLJLPnMksfxp+eYwogJuEqR3FIarnB3mspQg3EFjrfZxgKUdGRNIaPUHVJy+TCWBvIB9dz+1F4TB/7O/lAqGKUQVftxnZsRVLqZeI46j1EkyJV5dTWNzdzE0io5Z5X8gtUpgaxfA4h8kl6/UQgfIqCdlsrVp15euxh0FiLLi+hSiqdaxoTwg=;5:Sa+jQpyzsg2V0T21Tz4yNNS4JflZNhOM0OBMM+cBLw4lXPc56JCWRAYRB2rseBHY8sAAt6p84jesrVtOPG986OJkvC9veNKP15aB3/qbTVGCtkCyF70Z8ht9mequz9NQKmVb4XhSXnp0az5vdudRIxQm4Qq5ni4mVvdjr14TTzE=;24:cfVe5UnuIPVm7jkehPihx6wsMY6dmPC/E6QOj0euW1AUXkqdg56M1IF5RL9P+tU9ImRtiRYcHBqutKzFimniFGmeiXLw7SZWSlkcB/EQySk=;7:GJyOjtd21GcTkQpBXDmInr+tSiuummJRBpLKQ2v5aKzURmMBnSWID3yHIQtRzGu9vPaCx7DCyk2XfRC8L9YDhWNK5o8oT5UqTEAWoNo6AWnMn57kZ7RNDfRLfe1cNd5hoFecuTsXvFzO6Lk78110Mq3DhQPHiDaAPXj52xgEoGIS4QKCZw75XByeuer93PZAZuzJPEAKYXPxwBT5HxJO3EXxzIk4FolPzgGzX7xnp5UltpcJJ4YEQDVIHEl5hbe5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 19:20:57.8390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2833b3-b580-4989-ffde-08d5375e5201
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61224
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

On 11/29/2017 08:07 AM, Souptick Joarder wrote:
> On Wed, Nov 29, 2017 at 4:00 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Wed, Nov 29, 2017 at 6:25 AM, David Daney <david.daney@cavium.com> wrote:
>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>
>>> The Cavium OCTEON cn78xx and cn73xx SoCs have network packet I/O
>>> hardware that is significantly different from previous generations of
>>> the family.
> 
>>> diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>>> new file mode 100644
>>> index 000000000000..4dad35fa4270
>>> --- /dev/null
>>> +++ b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>>> @@ -0,0 +1,2033 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2017 Cavium, Inc.
>>> + *
>>> + * This file is subject to the terms and conditions of the GNU General Public
>>> + * License.  See the file "COPYING" in the main directory of this archive
>>> + * for more details.
>>> + */
>>> +#include <linux/platform_device.h>
>>> +#include <linux/netdevice.h>
>>> +#include <linux/etherdevice.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_mdio.h>
>>> +#include <linux/of_net.h>
>>> +#include <linux/module.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/list.h>
>>> +
> 
>>> +static void bgx_port_sgmii_set_link_down(struct bgx_port_priv *priv)
>>> +{
>>> +       u64     data;
> 
>>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>>> +       data |= BIT(11);
>>> +       oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>>
>> Any particular reason to read immediately after write ?
> 

Yes, to ensure the write is committed to hardware before the next step.

> 
> 
>>> +static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
>>> +{
>>> +       u64     data;
>>> +       u64     prtx;
>>> +       u64     miscx;
>>> +       int     timeout;
>>> +
> 
>>> +
>>> +       switch (status.speed) {
>>> +       case 10:
>>
>> In my opinion, instead of hard coding the value, is it fine to use ENUM ?
>     Similar comments applicable in other places where hard coded values are used.
> 

There is nothing to be gained by interposing an extra layer of 
abstraction in this case.  The code is more clear with the raw numbers 
in this particular case.


> 
> 
>>> +static int bgx_port_gser_27882(struct bgx_port_priv *priv)
>>> +{
>>> +       u64     data;
>>> +       u64     addr;
>>
>>> +       int     timeout = 200;
>>> +
>>> +   //    timeout = 200;
> Better to initialize the timeout value

What are you talking about?  It is properly initialized using valid C code.


> 
> 
>>> +static int bgx_port_qlm_rx_equalization(struct bgx_port_priv *priv, int qlm, int lane)
>>> +{
>>> +       lmode = oct_csr_read(GSER_LANE_MODE(priv->node, qlm));
>>> +       lmode &= 0xf;
>>> +       addr = GSER_LANE_P_MODE_1(priv->node, qlm, lmode);
>>> +       data = oct_csr_read(addr);
>>> +       /* Don't complete rx equalization if in VMA manual mode */
>>> +       if (data & BIT(14))
>>> +               return 0;
>>> +
>>> +       /* Apply rx equalization for speed > 6250 */
>>> +       if (bgx_port_get_qlm_speed(priv, qlm) < 6250)
>>> +               return 0;
>>> +
>>> +       /* Wait until rx data is valid (CDRLOCK) */
>>> +       timeout = 500;
>>
>> 500 us is the min required value or it can be further reduced ?
> 


500 uS works well and is shorter than the 2000 uS from the hardware manual.

If you would like to verify shorter timeout values, we could consider 
merging such a patch.  But really, this doesn't matter as it is a very 
short one-off action when the link is brought up.

> 
>>> +static int bgx_port_init_xaui_link(struct bgx_port_priv *priv)
>>> +{
> 
>>> +
>>> +               if (use_ber) {
>>> +                       timeout = 10000;
>>> +                       do {
>>> +                               data =
>>> +                               oct_csr_read(BGX_SPU_BR_STATUS1(priv->node, priv->bgx, priv->index));
>>> +                               if (data & BIT(0))
>>> +                                       break;
>>> +                               timeout--;
>>> +                               udelay(1);
>>> +                       } while (timeout);
>>
>> In my opinion, it's better to implement similar kind of loops inside macros.

Ok, duly noted.  I think we are in disagreement with respect to this point.

>>
>>> +                       if (!timeout) {
>>> +                               pr_debug("BGX%d:%d:%d: BLK_LOCK timeout\n",
>>> +                                        priv->bgx, priv->index, priv->node);
>>> +                               return -1;
>>> +                       }
>>> +               } else {
>>> +                       timeout = 10000;
>>> +                       do {
>>> +                               data =
>>> +                               oct_csr_read(BGX_SPU_BX_STATUS(priv->node, priv->bgx, priv->index));
>>> +                               if (data & BIT(12))
>>> +                                       break;
>>> +                               timeout--;
>>> +                               udelay(1);
>>> +                       } while (timeout);
>> same here
