Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 00:21:50 +0100 (CET)
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:4704
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2XVlhK5p3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 00:21:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=86zIvCdj6LudLfSTF/Jq8dcKPcxAftkCIeZ3zhgZsBY=;
 b=WpUqJDwn98kMq37va94byMiUqG/f+D332+Xe1QosMGGyajss8dpBDILH+pvPPNCboxA57bRVGHpnvunw00qNb0zqLbBtkbpjN+OzEJzcB2VkZVWEx2lYjLJr8wV8bJZuKlwrUf9/DWTlLVu1oC0jeqPOCgpDjtR2SQDR8n87O0U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 23:21:30 +0000
Subject: Re: [PATCH] dt-bindings: Remove leading 0x from bindings notation
To:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marco Franchi <marco.franchi@nxp.com>,
        linux-mips@linux-mips.org
References: <20171129205515.9009-1-malat@debian.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <c7200904-f016-8789-ee5e-fe5a281be215@caviumnetworks.com>
Date:   Wed, 29 Nov 2017 15:21:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129205515.9009-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0089.namprd07.prod.outlook.com (10.166.107.42) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c555795-2d45-4d06-e107-08d5377fec55
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603277);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:zyb5ohwycoeqgrVitTrqQ8svU5yakLabFzE6Ug2gqZ9N4Y14YeAOQ4eE0ERnwCuUut+5PUL3P6zgmhfSkxBm9opNdIsruiXNO5IKVh0s6qXynuMbtWNXwHv/+fNlnt2JMIkj7IfpqL18xCdLFZvdUZA4dQVzn7SQcfMP2I8OVCMlj7U+llGg7yxv1e5ppZALQA3S610Nrdtn1Z3jMnR7Ajc4HIYicPCpjNVDrullGNwUuhG//ky+gpBzozPoPpt6;25:b5nYfQCEhrTtjjAGTLAdQZRwfYIqna/iPS5/55qSj+puvS3tnt3GIMDbj7c7nmPKRcRVBIZ5/4DkmsbQ+oXwZKAk3g4qnMByvX+aZb2e++oQaES9vO6Gous5kuDPmlQmjcnfuwMw2lnUVYNu+5J0fMuBmrK+LcmfkiVtvwQoKopz8ym0lZUSFxx0rsHPhQI/xBvSat5sP08O00embw2XbGEqT/6A0WePMVhbDW7etGWC5sEewCE2vNGEiwdO+pIRb4lOslzX/IM0pr9Konrl5dQ6ojvv7NEUFtZj/EYJNwqUPdJLCKcmRjP3N05NtmcLkW5AxC1CdO/hL5md+uxCOg==;31:j6s6xTclqXZlGzt0iju1tO6UQggXkoy2MhFte2hez+ZXN06UkHk3yuqxIyrwjw4+ZgSb4wIrzva/KVWJQFxH3gjtbYipYTjZmSyY7YB39xyJtrZ6QDJ39JqE13WWJBCbWSdnXe1eldtq26qzMYBHD3mTeVf9+iRTUwgi2vbKIjLG+Ks4rW0p+IJWbpsfiHTlc1jV2oJ/Al0T88NJa8DHGjxp19aHrJTpyPaB+iEysXU=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:dKRP2IByIA/mAhXefoM1K4QgBr8sAleWonEEIZxeqAW0Tx7PrNbDNWk/M+XhCoNHhCsclvMuJb50ABGPdf1bpFfOFOrm33lnu7BHpsqqd7fgi544t3ON0czYiLi+DrN6z54JXjJW7gW7vBOUbXx/Peh1CsY/98IAiKmlJI50Zu/ZR7sDcyL/7TDBf5vh/QybGBkcx/vvaj9bzhF9xtESI4GKpz9LWPss9vfk/GG/oAGbHTfH4/n3AsxZQJUDPGObNmrhHWcdlxcb5aA5d8iJLsl5L+6caobgEnWWOKM2d2Vvp1PEfTpRVifFMip7r+qc1ONhz9wopo1Y9txk4XD2MliJ3qFEIdrmBpTJirwDzF9qsnoQhPyN7iZhZs1mjPZrI1bEnQ0/hFbPyeF5IUI6S7IEw8RTZhSIbyZMaCm8pVvV7Cfc5G8AJo3aKJEjDHgPhBVupE8ek3eDLqGTUUD9B3QdyHbJlITAGj6AhWbGF3f3lSMmWLUBTyyqbXQx4AhCLOe5HsJO2iEgwZxn/9wZOaYbpAxvS/VsFj4p0pNGPfAn7oRETHbOSyCKoryFf7+i2PjiQKT4Pk8xl7GLYBAWVxcc7FNYF+DtXxXFjkA8Xf8=;4:jJhUJFkCgXswWBopZIbRlRQunKix+U6jTD4GlNbiYZOip+kdtjGX2NOs7wxI3/TUUON0JGGCClx2AVcHtTeFp42fMr+CyjQnDyzcol+kfxXtVQdkI+yNov9hnEVL/XS8aRE/hfymO5qBQl1Cl7xJMtfeE4iDhzZW9FtG6zE71HTKLm7VUzXhq4n9cMQuCn7+X4wiqJIcL/qeUUvpblwMYI18ijlBRzD6aFi2sEzkPjCSZOm7iBAlC4RLspWrMlAbtmF49N9/y22q3lRxnCd55A==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494AB6B3901061BB5A389D8973B0@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(3002001)(10201501046)(93006095)(6041248)(20161123560025)(20161123555025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(199003)(189002)(24454002)(110136005)(316002)(50466002)(6246003)(64126003)(58126008)(65826007)(25786009)(6666003)(31696002)(2950100002)(42882006)(5660300001)(8936002)(6116002)(3846002)(478600001)(8656006)(67846002)(72206003)(47776003)(6512007)(53936002)(16526018)(83506002)(31686004)(65956001)(66066001)(230700001)(4326008)(36756003)(7736002)(305945005)(53416004)(69596002)(6506006)(97736004)(2906002)(101416001)(68736007)(81156014)(229853002)(6486002)(33646002)(23676004)(189998001)(53546010)(106356001)(52146003)(2486003)(105586002)(8676002)(81166006)(52116002)(50986010)(65806001)(54356010)(76176010)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOnduZEg2S1ZSQUpEckZ5QlBJTXlSWWNFbDRn?=
 =?utf-8?B?cE9DRm95MjJQWjN5cjJTNDZRV0E2blNhVVYrdERnZENvSWJnRll0V2N5UnF4?=
 =?utf-8?B?d2RpQkdkU0tWZk9jQ2l2bFAwRjlvb3M2VkZKcDl0R1V3MWJJb0pLUXM2L3p3?=
 =?utf-8?B?WVBCWERrUUZubnN5MjZYNVVpYVdOU3JxeUtPcm02NFNrQ1FEQ2Iyb2VYZmFu?=
 =?utf-8?B?Qk16dFhNVjZvWHQwSVQ1NmxkUXJpQ0xOWjhhWE1ydnVrRTBjZDl3OVNkMDli?=
 =?utf-8?B?citiRjZRQjZaR0NHRVhvclJMa2lZRndheFN3empDUUhodmNCNkM5TnBCc2FT?=
 =?utf-8?B?K29YWU16bDlhNUlleXNpbGxVbzFYa21wRDNTdWNBT1A5RWd1MTFvUXpLTXVO?=
 =?utf-8?B?ZUJOc1dJWGc0RkN2TTBzLzlhQW4rckxyWnNaL0dGKzFobnlZcElxRkRXbDcz?=
 =?utf-8?B?U0x1ZjVLeVFYUThFVHFUZ1J0Ui9sM0U4YjJmUFY2N0F0YUcxdWtMNU16TkxG?=
 =?utf-8?B?Rk9SUTJObk5Yc2VDcFNwZjA4WFVxL1dDZlVBZmRCamxlMkNTc0ZVMjJVNWZH?=
 =?utf-8?B?d1NQSmIrUVMvMVBhTU15Y0dFbi9HUVlTbFBQeEQ4b0dheTVEVC9qM0xtS3Rl?=
 =?utf-8?B?V1RCZmRrRjYxb0ZIMFp5eGZjUCtBNTFmS1QwdC9nWmRvYjdRbzRMa21UL2dm?=
 =?utf-8?B?WnRZMUlEZUF3Rzh0eVl5MVZTSi9Cb21saVNNb2huSkpzK1RzUkk2OWwwRGpl?=
 =?utf-8?B?SWxmelJuM25oMjhsM1ZwTnAwT0ZKTXpXWTRqZGlwWEJyV0UrZUw1YkY0Z3hy?=
 =?utf-8?B?THZyL0lhbmZ1RjlUUHEvOEZpU1pFS2MrNkJoWW9kWEZKcXpPcmdRUlo5Yy9E?=
 =?utf-8?B?cEtweHB4d2pMK3ZjVlovMExYR0ZRMWg3TU9jczhxRE9tL3YrYmFUdldyRXJq?=
 =?utf-8?B?c3N2TW5Da21EYUVzWXhmR2l4cWlZV0V2Z1MxT2hEeDBRYzF5TW9palI3RjFt?=
 =?utf-8?B?ZUFUb0dzcjAvQWd2cjRNWnlIMVNiN0N2blgvVVJpU2JIdktTMTNwZi9vTjR1?=
 =?utf-8?B?V28yTVc5eXMyOTROaXE2a3UvTlhuVE1NVEkySW84RVFiTWp2VzlGQWtIelhQ?=
 =?utf-8?B?MUJVWCtmcUdtb3RlVGJBc0dVaTVSY0FiUEh0dldtaklJUmJIbWZ6b2hYVFRh?=
 =?utf-8?B?SWIrTlpidVYrVjBBeEx4YlNhNjRjMkVVZVFBdlQzaFNwWVNvajZPcnU2YUNN?=
 =?utf-8?B?U3F6djY3MEduOC9vUENzcDdiV0hxMXpFZ0hLMzBteDZnOXl5dndhOGQ5eW03?=
 =?utf-8?B?cllTeWpwM09aaTFyMmFRQ3FiNVY2aUFvUkxmMGtKcndSQXJQeXl1ZkFVUUdI?=
 =?utf-8?B?WHVVaUp0RitLM2Z1YVpQTUlMR004VVd4R3k1UGlhcUIxMEI3L1lyK0l1b0s0?=
 =?utf-8?B?Z3B2QStLZlRxZDYxNllJSERVWXJPK2E4cmFSbTh6Y1c3MG5vckhUNzNvajV1?=
 =?utf-8?B?WExZRW96RUU3YUh0YnFndElNc3VqSjcrNFQ2bjUvN1BIQ3JaRGNGeTZBSHNm?=
 =?utf-8?B?WGpXL2V2ekxCV2N4Y2ZDUWpmMWRLN3h0Nm1SRGdWa3FTa3FyRnlTUmY1K1dq?=
 =?utf-8?B?SmVDc09sMnhMRTZ1MWwrZldEeVpnNkdNRDlWWGkyN2xTK3NFTnhHMGRFV2R3?=
 =?utf-8?B?WG5XV1ZzbkJqUG9FendpREFJaXBkYll0NTdSSmdITDduQUlZQWlYamhoMm1N?=
 =?utf-8?B?YkE4V0FqTnBSZTJVb3BrN3ZmU0hZZldoUVd2bjFFTmdEWXVhTVJ4WTBTQmJi?=
 =?utf-8?B?SHdreVArLzdDZHhZeXFWdFZnYk93eGFkYjE5THplOVNIMFBIeFJRempyOGZL?=
 =?utf-8?B?NHdKQmhtMWI2OTA4SkFVMnR3K1JSVDZ0VGJSUDZpU3NvWVdadWhDN2xwU0hB?=
 =?utf-8?B?ZWVRaGYvVU1wM2hGS1FYTXpxSU1XTEQ2ZGpKWmdUcDBiTFRwemhBdXIxQjlO?=
 =?utf-8?B?QkFuQTNkV1NDSGI4ckpyOCtBVk9jYjgwTVlUUT09?=
X-Microsoft-Antispam-Message-Info: FGVvMEF4YuswJx/Z9AZknZ8hGtdRf9Mev3fEzjKubJMtzQjyIJsgQyS3GSXeCOlo8Cz7xjwfFR2JwYrc+WGgug==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:5GvPHkOtjyfAjjkFTWl34lamQ30s0Gqisyb7c8THHCsK5/N4fUJmceoV9RbPaR51eo1AVYC50L50NUKHUHfx9vk7thbnW9d0N/PrkrYKivS+IHKAnfQLXf/edUZM6GWX3WKtShV8Z9B6dYmWRaeUEOf4KHMKpdJBHJJMD1K2gAC+kYxC3Jm7k9ImDCTP6Y4piRgMln6zdYafe6rYWS9ltMzttuWGzOo6ZGZesL3C9/h23m/OOhKOTKdilnt6NvuqZdPlwmWwJdqCbRcdrlPWXZwgA/ry1u8RiuVjSlhZkWYygZkjUHK4uleJ5XWBxX7ntqVTFUtw0N/YKBcXuPcXMXZo5f0LVKFnevk10j3rNp4=;5:6JEUs75Fzk7dVmb8k2qfLNvOl0tCgqprgJqioiR41PqTQefkkmPEy5HA1zqmUM1a07Fphypc2P3tghZUvUPjV11GEqk3EnVJYGjydfl/1xad2OButD3QqvE0WedHUEZVOczCFBcxl1tcUKCZaCFZwghBGHgGprooLkj/Pmb+jIg=;24:GV4l+w6rVDbdi3Z/1mbfrXey9cS1xWsqfOaJF9eC6OYQACbJWRpsI9f9Eo1Q6zDeHsn8y/kfgC69pfoChZixyfFYVqJxDza12zLPToZhxrM=;7:Q+iFpWSAPKjQsqsbrFZXLShdwAIelIi/RAxkNK68+xd3N3uDf8nBe/aMLXId6G/hJDKnGsxIPl7fRGg3mPbHWjvmacSabCoQ1MSCXYWIe8D5XHYMAVzMJgDKPlhi07PEGrq9dLvLHF7/MJq4kylWQRZLpqH/f/zItmoVIKAfolZ+QSL0xcSrgNf4pW9mzGKtXdGPMvyi5v2htp3FJhnaH7m0fLYnof0onD4QlX5HWpcdPmz/W4VItdFyZyqHhSkt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 23:21:30.5093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c555795-2d45-4d06-e107-08d5377fec55
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61231
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

On 11/29/2017 12:55 PM, Mathieu Malaterre wrote:
> Improve the binding example by removing all the leading 0x to fix the
> following dtc warnings:
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

How does it fix the warnings?  You are not changing the .dts files that 
are compiled.

This may also cause the binding documentation to differ from the reality 
of what the actual device trees contain.

> 
> Converted using the following command:
> 
> find Documentation/devicetree/bindings -name "*.txt" -exec sed -i -e 's/([^ ])\@0x([0-9a-f])/$1\@$2/g' {} +
> 
> This is a follow up to commit 48c926cd3414
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> I've also checked using the original perl command that I did not introduce:
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
> 
>   Documentation/devicetree/bindings/arm/ccn.txt                |  2 +-
>   Documentation/devicetree/bindings/arm/omap/crossbar.txt      |  2 +-
>   .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      |  2 +-
>   Documentation/devicetree/bindings/clock/axi-clkgen.txt       |  2 +-
>   .../devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt     |  2 +-
>   Documentation/devicetree/bindings/clock/exynos4-clock.txt    |  2 +-
>   Documentation/devicetree/bindings/clock/exynos5250-clock.txt |  2 +-
>   Documentation/devicetree/bindings/clock/exynos5410-clock.txt |  2 +-
>   Documentation/devicetree/bindings/clock/exynos5420-clock.txt |  2 +-
>   Documentation/devicetree/bindings/clock/exynos5440-clock.txt |  2 +-
>   .../devicetree/bindings/clock/ti-keystone-pllctrl.txt        |  2 +-
>   Documentation/devicetree/bindings/clock/zx296702-clk.txt     |  4 ++--
>   Documentation/devicetree/bindings/crypto/fsl-sec4.txt        |  4 ++--
>   .../devicetree/bindings/devfreq/event/rockchip-dfi.txt       |  2 +-
>   Documentation/devicetree/bindings/display/atmel,lcdc.txt     |  4 ++--
>   Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 ++--
>   Documentation/devicetree/bindings/dma/zxdma.txt              |  2 +-
>   Documentation/devicetree/bindings/gpio/gpio-altera.txt       |  2 +-
>   Documentation/devicetree/bindings/i2c/i2c-jz4780.txt         |  2 +-
>   Documentation/devicetree/bindings/iio/pressure/hp03.txt      |  2 +-
>   .../devicetree/bindings/input/touchscreen/bu21013.txt        |  2 +-
>   .../devicetree/bindings/interrupt-controller/arm,gic.txt     |  4 ++--
>   .../bindings/interrupt-controller/img,meta-intc.txt          |  2 +-
>   .../bindings/interrupt-controller/img,pdc-intc.txt           |  2 +-
>   .../bindings/interrupt-controller/st,spear3xx-shirq.txt      |  2 +-
>   Documentation/devicetree/bindings/mailbox/altera-mailbox.txt |  6 +++---
>   .../devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt      |  2 +-
>   Documentation/devicetree/bindings/media/exynos5-gsc.txt      |  2 +-
>   Documentation/devicetree/bindings/media/mediatek-vcodec.txt  |  2 +-
>   Documentation/devicetree/bindings/media/rcar_vin.txt         |  2 +-
>   Documentation/devicetree/bindings/media/samsung-fimc.txt     |  2 +-
>   Documentation/devicetree/bindings/media/sh_mobile_ceu.txt    |  2 +-
>   Documentation/devicetree/bindings/media/video-interfaces.txt | 10 +++++-----
>   .../devicetree/bindings/memory-controllers/ti/emif.txt       |  2 +-
>   .../devicetree/bindings/mfd/ti-keystone-devctrl.txt          |  2 +-
>   Documentation/devicetree/bindings/misc/brcm,kona-smc.txt     |  2 +-
>   Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt    |  2 +-
>   Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  2 +-
>   Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  4 ++--
>   Documentation/devicetree/bindings/mtd/gpmc-nor.txt           |  6 +++---
>   Documentation/devicetree/bindings/mtd/mtk-nand.txt           |  2 +-
>   Documentation/devicetree/bindings/net/altera_tse.txt         |  4 ++--
>   Documentation/devicetree/bindings/net/mdio.txt               |  2 +-
>   Documentation/devicetree/bindings/net/socfpga-dwmac.txt      |  2 +-
>   Documentation/devicetree/bindings/nios2/nios2.txt            |  2 +-
>   Documentation/devicetree/bindings/pci/altera-pcie.txt        |  2 +-
>   Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
>   Documentation/devicetree/bindings/pci/hisilicon-pcie.txt     |  2 +-
>   Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt      |  2 +-
>   .../devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt       |  2 +-
>   Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt |  4 ++--
>   Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt   |  2 +-
>   .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt         |  4 ++--
>   Documentation/devicetree/bindings/regulator/regulator.txt    |  2 +-
>   Documentation/devicetree/bindings/serial/efm32-uart.txt      |  2 +-
>   .../devicetree/bindings/serio/allwinner,sun4i-ps2.txt        |  2 +-
>   .../devicetree/bindings/soc/ti/keystone-navigator-qmss.txt   |  2 +-
>   Documentation/devicetree/bindings/sound/adi,axi-i2s.txt      |  2 +-
>   Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt |  2 +-
>   Documentation/devicetree/bindings/sound/ak4613.txt           |  2 +-
>   Documentation/devicetree/bindings/sound/ak4642.txt           |  2 +-
>   Documentation/devicetree/bindings/sound/max98371.txt         |  2 +-
>   Documentation/devicetree/bindings/sound/max9867.txt          |  2 +-
>   Documentation/devicetree/bindings/sound/renesas,fsi.txt      |  2 +-
>   Documentation/devicetree/bindings/sound/rockchip-spdif.txt   |  2 +-
>   Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt |  8 ++++----
>   Documentation/devicetree/bindings/spi/efm32-spi.txt          |  2 +-
>   Documentation/devicetree/bindings/thermal/thermal.txt        | 12 ++++++------
>   Documentation/devicetree/bindings/ufs/ufs-qcom.txt           |  4 ++--
>   Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  2 +-
>   Documentation/devicetree/bindings/usb/ehci-st.txt            |  2 +-
>   Documentation/devicetree/bindings/usb/ohci-st.txt            |  2 +-
>   .../devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt      |  2 +-
>   73 files changed, 99 insertions(+), 99 deletions(-)
> 
