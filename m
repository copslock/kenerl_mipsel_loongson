Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 02:51:32 +0100 (CET)
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:46464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991770AbdLABvYaMpfi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 02:51:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dcBn1BCYLdbdhthGLYsRoBkYpzEALoJx9HbszjfkUpA=;
 b=L1zGuujUf62eKIVj9KXSGy+Z5V1Sbz2f5zG8XFV4wTibWfRN2NlUFz03uZOymlW90AiZYeOYCOMTd4g8U/AstgHKHKmi/5I/rfr7eQ4v2ZsVpdwRBO7NhKAd1lfGJaaBdd5sKrDzsRXHl2Rs1k8QR+9C8sZddoN9MFPbfcvNJRU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Fri, 1 Dec 2017 01:51:13 +0000
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     James Hogan <james.hogan@mips.com>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
 <20171129005540.28829-4-david.daney@cavium.com>
 <20171130225333.GI27409@jhogan-linux.mipstec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <a5e99796-154a-8950-3a38-4788f64fafa2@caviumnetworks.com>
Date:   Thu, 30 Nov 2017 17:51:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130225333.GI27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com (10.166.202.34) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c97869-2f65-43fd-cfce-08d5385e0132
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:sf7RpDVXWdkXHHFm7oUIfBGoSG7ndYc18tZzYTpjofuyU+j4WjPYqqKslHuPBf3dS3lvmq5mQxqIjZwIN16kpwO80DoVma5Qab9BsFPCqGPSzTmDVdlpZp7qEnyGUHSLUmyNyBoa4O6pz/PvMyTqm66TJpiB9iL+LpHzQudbIgZ24w9bASOG3bQudPgmZacmiWIgKKcRugZvT1nnvi6hCV4qtRxfre4/cHu3xyLqXX3zaB+7KYVUMgUl8aUrFChY;25:2rIOzP5WsqQjm/nPoZzChT/pZhHCI69w/Z/uQ9W6mOm//BUvybTrnpOGkD+H03L/w8XRMoVlCNn0I9GCM0gJjcOnI9fbqGpFu5pm52ouc1ksezZKspUZ33Z8XC6QBvm6cB2zqzlMbr/4a2INKo2sb1ZcrWVetaQ9i8O6e2rLUGbP47HB53cZ+GEOibd8c3vNETodhBoNvqx1CgegwGRhLuacc6LBF79jG3SDUGoFly199XbN+kpn4ChcFPt8sUNMpjRRzLxrSxc+rJkNlXq+GQyuWOdfRneOqZOFTtpa6FZZgjM8y6A9IkiadJ2AJLsNzu5DFgCu3upntv31GOVlbQ==;31:ob0n+LURux4LeZcoozfabsW4CvonGhy3rB9yx1HUg6sMtF8cwvZInWWcRjotZmHPFoq8ovOCujNSJPhjFQfhMHs6lsSqY9bfKBzoa7boL6J9rlUZxlrPXOvAGZadiRohm6nxmHr7zgXoU2wk6Pho+kyRagam1eyBheV+ArILopjgEDIndNGMDV/cQCDug3ItPKQKoyPUiiTIyfwxZUvGDR/vJ3cqa1rHBnIBL7gHRsk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:2ahI7sXZmPxWANMmQwDEn4AT27wL1aZQkEba75GErp3iM6UyL4mOrIHlknaffkqsE1dhiJY7HQHrwYqHnAyk/FajVsgwK1REx5xDhJfKXMWsQ3dCitT7i4v1Kvc/95yAKPBGQB1bFcZygFC/p6j48K6uyiqi/G9xEQyZvqMoy5jhqRT+NCzVjgXpAFXg3EAlO0XuqTJ4kjfbrT+9ol60eMYZcflxO2G/8tHQoRlhJs4mTlVNmtBrNE9yNx+7HZfStJh7LrtNEkFupthtfoTMow3Uj44W4Be/GTcNt+HFokjjhdhuCnBlgtdMK7K5U0uclGTuHzzSAiGXOkRCCNwLM7Z2FKYPHJuNfLwQBY7NUMMks/3b58IcBwcKM4ogbcbG0RR5NKdIRv2Nf6uxrJbFspaPWYp19/oEHEzHeuR2MeL844i2SBKv3pCcIbwuLkR7hpiHnU4U2QrBbKBkjAfBf3sdRtLS8u7Yz7406exJWOAlU9441xjllKDB3RORGu17Q6t0FzEs5hXXAnc4lYeeZGC5+6oRwqV4Fkoc3vccEN9i9ZCJfhT0KPbaH1IaoxgPMouCuiRaYo+T0zSTqmftf4DRyWOdfqg2LzVXBTolq3g=;4:Essi8F+2WuhLw9QMOHketEC6QEwKtdTVKD4oEMBN8D42/TWk3XQj4Ys1fyXIRY+fCU6w587YDFjfINHUkuW42TYBYk8LI7eBWv+a13ze9TRyYUcrRKZ+7Nr1yBUhJ9pd/XngBqw3Ij8TIZV8M7oo/tAYMiMr+/UiChhBnHSwiL5nq9HKMvfu9VSzuuCiy5ysjCgCZfNmsZ27ZmScZ6tPHe+QkaV4KDPiDfHoRwEaWJay0JeqK5Dhu2zu35fukESfVRpUrA6iRe/nWfr7/FYc0g==
X-Microsoft-Antispam-PRVS: <CY4PR07MB349434F5E99CC3B8AE11A83997390@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(3002001)(10201501046)(93006095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123558100)(20161123555025)(6072148)(201708071742011);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(39830400002)(376002)(366004)(189002)(24454002)(199003)(25786009)(64126003)(97736004)(65806001)(66066001)(65956001)(72206003)(106356001)(16526018)(4326008)(316002)(230700001)(6116002)(478600001)(50466002)(58126008)(83506002)(54906003)(54356011)(110136005)(76176011)(3846002)(31686004)(2906002)(81156014)(31696002)(67846002)(81166006)(2950100002)(42882006)(189998001)(5660300001)(68736007)(305945005)(65826007)(229853002)(7736002)(8676002)(105586002)(6486002)(575784001)(6246003)(107886003)(101416001)(39060400002)(52116002)(33646002)(36756003)(69596002)(47776003)(7416002)(6512007)(23676004)(53416004)(6506006)(8936002)(53936002)(52146003)(53546010)(2486003)(52396003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOlR5ZFg5ajJBYnFURWdQSVZvTXVvblZwK1pY?=
 =?utf-8?B?bGlJbzhoUzZKdGxZR0dtcDc3QkE1OXdMK0JrMlN0RktnK3dIcDdKbjhSU1RP?=
 =?utf-8?B?UUVZV3lRbUUxUXhDN1MwK0hoRmVZYWpja1NScTlpS1ViWktFNWJvVzhmUmpq?=
 =?utf-8?B?eGRLdmpGTlpxK2xlVTc0L3ZNanltSkVzSWZMQlQvVUxBTUF3RlVqR0dEUTcy?=
 =?utf-8?B?WnJsUmNpQmRQcnNUUllGd05sSXpRK3RaNUZycXAvSkdDOUpkUFlWczI5NGpZ?=
 =?utf-8?B?SkZxYU9BMzU0Zm5WZDVqRWFITndxbE9VMWdDVjBMNnZJVEcxenNmZExJdmZ3?=
 =?utf-8?B?ZFIxd3F1NTNvRXltOXZXMWlpTmhSMWFLZXVBNFZZOGJzOVFDU0ZvSTcwdk1H?=
 =?utf-8?B?eGpoSnBXWEtKckRheGVFSGtBaERmOTQvSEFzb3ZKdnNWK3hZS0xKTVI5dTNI?=
 =?utf-8?B?QnNSRFlmemhsTmpHSjJ0NFpwZytVMDl6Qng3eElBdHFQaGZTOVhpL2tBNlJZ?=
 =?utf-8?B?ejBPUjVVVWswc1JiUitLNVNHdjJtRVB4TVBTdSs0TmovVW1XVjIzTll5UUZE?=
 =?utf-8?B?ZE55SGJKSlZJRWNnWWsyZnlXNERGYzlYZ3Y1M2o2bkFlelBDZkY5ZzhwSjZF?=
 =?utf-8?B?SXNodVpZa2V4YVdub1dVQTZiV1hQVnhzcEsyTE1ra3loeklkZm84T0d5QnZp?=
 =?utf-8?B?eEFwRzFjY1l1TjNiWkNiMTQ4dy9GbGZNalJQY3BYeU9ZK0t0cEl5SVh1aW00?=
 =?utf-8?B?Vi9SOTV4V0dWU25LaWYzcWZiWm9BYzd2bWRZWVJEY2cxSzZNRkgxTzJTNEVn?=
 =?utf-8?B?MFBxUy9lUCsvajZPcDNIYUFCeXQ1UW9DMnVWUjhDVmJ4UzhuZVAyVDRNVEVE?=
 =?utf-8?B?c0h4UE5hV1duUFdsRVNldzA1VW9kbHRjSUlPRXFrNDZ2TENwdmlOSS9xcUxH?=
 =?utf-8?B?NEt1Sjdyb09uMGszYmxEdENvZmQwWitxd0V1ank5Y0lMY3B2Q1JJYUowS3Fl?=
 =?utf-8?B?WE50ekdiQ3FVdEk2NSs4YnM1UEZRaVg2d2U1M1lkaUxTaFcyME82bXNRVEhT?=
 =?utf-8?B?cGtuaXIrNkgvMmN3VmlpZW40cmE2aWJYOStJVk5rMjg0UWNHS1NzRG05bUpF?=
 =?utf-8?B?dkk0R05oQ1ZpRTdMV0JwN3M4Tkx3V1FONVN4Rmk1d2tacTFiMEFkYVBSTmV5?=
 =?utf-8?B?NVBYc2t5di96VlhGdStWRnZqSFNFYVVjTDI0cWMxakg0SXRTSm5Oc0FpZ1FN?=
 =?utf-8?B?MHUwUXhUandPUVRDN3hkWnFJQzF5aVdTdWFlYWpFU29ES3hLSStqUjZZVEhW?=
 =?utf-8?B?Y1hDSDZ6YnhIQlI3MldIdzdPZjYwbGtPTHk2V1Q3STNSSHJIWThrdXU4Zmhy?=
 =?utf-8?B?cGV6NWVJdkEwQ1JSWjBUTEZEWmpwWXUzZWVBM1ZaZi9kTCtLTy91eW9ZZVhx?=
 =?utf-8?B?Zmd4dHZYWWNudkhrczlvV2p4ZFRYTDkvaml5ek1xQXd5YThaK0tFczNiemFT?=
 =?utf-8?B?WTJCdGZGSlJTTFNMTWl1KzUwcjNYMDduaFZSTlJPTzlLemJOcGdmdVoweGJt?=
 =?utf-8?B?UUMwTUwrZGRsenNYR3lVN0ZWWjVQeFl1cWtyTk5Pa3VMZ1pjTUJic3BzcEF3?=
 =?utf-8?B?VUp3K2NzT0QwWGlEVHE4UUhIK3dFV0wyVnpnUlUwT1hFYVljS2lRVTFNSFdT?=
 =?utf-8?B?d3RzZDZocUZFamI1RjFTaWFvdkMxVEJDVGxCYVJTdHU3bXhjOGRuVkRza3Nq?=
 =?utf-8?B?aUtvWkR1TFVrOG9UTS81dXNmVy95dFFGLy9VTGM4UmE5ZHdYTVVkaDJyUGQr?=
 =?utf-8?B?c1ozTWdIVU5Ud2hMcHp3QnRRTmxIOFM3MmFrUDNheWZLOXY3NXMxZ1BacFox?=
 =?utf-8?B?djgzVjhCcExRVDFmdTlZbUYySk0zelNKT2xCRWtEWDlkZ2hkdkF0RHkrdjAv?=
 =?utf-8?B?U1dWYzU5YXVudzdPbThVMGR2Ym0xNnZYSDBGUk53cm53Zm1SaWlCbDJqcTF1?=
 =?utf-8?B?c1VGTGtBWU80emNtUmtZMlU0OURXSndoR2xXT1lWWEtoTjY5OENKY2plUDla?=
 =?utf-8?B?VVQ4S0g0Rzk3a2Vyc0V3QlBLTHNKRHk1SFdVR3dIQndpbU5TdzJnLzJlQVRt?=
 =?utf-8?Q?iFeMGYzrrtGBBezmODYcE/w=3D?=
X-Microsoft-Antispam-Message-Info: aqo8jD7VVez9BxDEHcwoYFJaaL0Xt3rgcYzTIiftRU9M6tJyW7ZByR5UmKN4Tt8hKdUiaUmiCPrEHirHuqvy0A==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:e8qxH1H0Qym8QnKw2sltKYZWTYrBG4UtFD5f/OtDd49WsySRl8d5c1q7VccPt085cKhggC1AMM8BygT20S4RLYbE5KbtCAVdK4wgc8cZ0fEcqP60TMIwKg7DMA/LCIymgvDjw8z2M8RTQbO4BXG699yxjYAvoHi8BXwUIBodjMAwbyHPzxExnn56dV4//58YMVu+wMNICBYdyCUbAfiwGxOrbWyaS2iI7pEOqkzUY6nc+kjRmEeYYIAgo4w8nL6PMHsXbmJBeG8q+qM97p8Y3UutYuE97BsOFqjYuD07Z/xV1t9BvxSUH/6jEvcaEd/bO2B25IrKWn+mU9yqj5xHqNzO3FpMKi0N4/UYzrkId9Y=;5:9SdzZXSjv78Q+QWpr4U78/QFDCNguQIwhOX1bKISVWZtdGCokR/QZiSttkTDVPuiEoMiAuHH83klldUtDjcYZJKr6jOOYkaghjVVNuIzJ6a7j6u6fxPOYINn9onBXIUpI97TUp/c9mn8pGG0SiFbT68YPQaubPc/L/LpV+8CAek=;24:DdBBEyD4BJNjOTFF0L/KE+As6K9bhCTJ3pn/1UvXUvTyYtDOQTEO3qrNjIqilJa6vQMhTWUfCUydyXv3oENX0xRqzlkdnEVXiamdWpsp0X0=;7:yr0CNs4AC1W1ra/YDB11UsKPp7SfLL4naa2hUdc6C47JsQZx8pQZnJLqrC3tOt+IUzJKqwYimOlzGO1cBh1nTW4sYjJUIh9TGpugGu8Vfa2hb/UgAApCYnQg2pXkBYrk+Vpa1wUwxhokED6gkGSq8LvPjdIAnVkSFfif4X2jDSIprWWG1i154R4qZLUarIm/QO5/gvIqJfvV6asB7Picnc0s/SHzBZ+MTnp3qrwiR8ctoIxEmdAKc7xBWML0bbnB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 01:51:13.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c97869-2f65-43fd-cfce-08d5385e0132
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61256
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

On 11/30/2017 02:53 PM, James Hogan wrote:
> On Tue, Nov 28, 2017 at 04:55:35PM -0800, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> Add a global resource manager to manage tagged pointers within
>> bootmem allocated memory. This is used by various functional
>> blocks in the Octeon core like the FPA, Ethernet nexus, etc.
>>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/mips/cavium-octeon/Makefile       |   3 +-
>>   arch/mips/cavium-octeon/resource-mgr.c | 371 +++++++++++++++++++++++++++++++++
>>   arch/mips/include/asm/octeon/octeon.h  |  18 ++
>>   3 files changed, 391 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
>>
>> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
>> index 7c02e542959a..0a299ab8719f 100644
>> --- a/arch/mips/cavium-octeon/Makefile
>> +++ b/arch/mips/cavium-octeon/Makefile
>> @@ -9,7 +9,8 @@
>>   # Copyright (C) 2005-2009 Cavium Networks
>>   #
>>   
>> -obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
>> +obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o \
>> +	 resource-mgr.o
> 
> Maybe put that on a separate line like below.

OK

> 
>>   obj-y += dma-octeon.o
>>   obj-y += octeon-memcpy.o
>>   obj-y += executive/
>> diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
>> new file mode 100644
>> index 000000000000..ca25fa953402
>> --- /dev/null
>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>> @@ -0,0 +1,371 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Resource manager for Octeon.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2017 Cavium, Inc.
>> + */
>> +#include <linux/module.h>
>> +
>> +#include <asm/octeon/octeon.h>
>> +#include <asm/octeon/cvmx-bootmem.h>
>> +
>> +#define RESOURCE_MGR_BLOCK_NAME		"cvmx-global-resources"
>> +#define MAX_RESOURCES			128
>> +#define INST_AVAILABLE			-88
>> +#define OWNER				0xbadc0de
>> +
>> +struct global_resource_entry {
>> +	struct global_resource_tag tag;
>> +	u64 phys_addr;
>> +	u64 size;
>> +};
>> +
>> +struct global_resources {
>> +#ifdef __LITTLE_ENDIAN_BITFIELD
>> +	u32 rlock;
>> +	u32 pad;
>> +#else
>> +	u32 pad;
>> +	u32 rlock;
>> +#endif
>> +	u64 entry_cnt;
>> +	struct global_resource_entry resource_entry[];
>> +};
>> +
>> +static struct global_resources *res_mgr_info;
>> +
>> +
>> +/*
>> + * The resource manager interacts with software running outside of the
>> + * Linux kernel, which necessitates locking to maintain data structure
>> + * consistency.  These custom locking functions implement the locking
>> + * protocol, and cannot be replaced by kernel locking functions that
>> + * may use different in-memory structures.
>> + */
>> +
>> +static void res_mgr_lock(void)
>> +{
>> +	unsigned int tmp;
>> +	u64 lock = (u64)&res_mgr_info->rlock;
> 
> presumably this could be a u32 *, avoid the cast to u64, and still work
> just fine below.

I will rewrite to just use cmpxchg()


> 
>> +
>> +	__asm__ __volatile__(
>> +		".set noreorder\n"
>> +		"1: ll   %[tmp], 0(%[addr])\n"
>> +		"   bnez %[tmp], 1b\n"
>> +		"   li   %[tmp], 1\n"
> 
> I believe the convention for .S files is for instructions in branch
> delay slots to be indented an additional space for readability. Maybe
> that would be worthwhile here.
> 
>> +		"   sc   %[tmp], 0(%[addr])\n"
>> +		"   beqz %[tmp], 1b\n"
>> +		"   nop\n"
> 
> and here also.
> 
>> +		".set reorder\n" :
> 
> nit: strictly speaking there's no need for \n on the last line.
> 
>> +		[tmp] "=&r"(tmp) :
>> +		[addr] "r"(lock) :
>> +		"memory");
> 
> minor style thing: its far more common to have : at the beginning of the
> line rather than the end.
> 
>> +}
>> +
>> +static void res_mgr_unlock(void)
>> +{
>> +	u64 lock = (u64)&res_mgr_info->rlock;
> 
> same again
> 

Will rewrite to use WRITE_ONCE().

>> +
>> +	/* Wait until all resource operations finish before unlocking. */
>> +	mb();
>> +	__asm__ __volatile__(
>> +		"sw $0, 0(%[addr])\n" : :
>> +		[addr] "r"(lock) :
>> +		"memory");
>> +
>> +	/* Force a write buffer flush. */
>> +	mb();
>> +}
>> +
>> +static int res_mgr_find_resource(struct global_resource_tag tag)
>> +{
>> +	struct global_resource_entry *res_entry;
>> +	int i;
>> +
>> +	for (i = 0; i < res_mgr_info->entry_cnt; i++) {
>> +		res_entry = &res_mgr_info->resource_entry[i];
>> +		if (res_entry->tag.lo == tag.lo && res_entry->tag.hi == tag.hi)
>> +			return i;
>> +	}
>> +	return -1;
>> +}
>> +
>> +/**
>> + * res_mgr_create_resource - Create a resource.
>> + * @tag: Identifies the resource.
>> + * @inst_cnt: Number of resource instances to create.
>> + *
>> + * Returns 0 if the source was created successfully.
>> + * Returns <0 for error codes.
> 
> Only -1 seems to be returned. Is it worth returning some standard Linux
> error codes instead?

Yep.  I fixed this and everything below for the next version of the 
patch set.

Thanks,
David Daney
