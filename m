Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 17:54:01 +0200 (CEST)
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:13641
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993302AbdJCPxzG06H3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Oct 2017 17:53:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bqhDo0QS26UHPDhu7o6QTOMkGYqbDlJXV77X0bbr5Gw=;
 b=M6qclO5ddPrxnjnZk5gjgDqe4rdQygHzEnBO4iGJl8U3xZ1WZ4kif6iiFoT94ta/MzPileZqiALK/eRvBuQB/OOMbdT+737YEhWLcCGjQCBcwj4yZ+l9PPMjRt8nFfbSQfz0Mpe2QEtfwUlkiXeo2PQqUBclcqhZq0dSJTfBBvg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.18.42.219) by
 CY4PR0701MB3793.namprd07.prod.outlook.com (2603:10b6:910:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Tue, 3 Oct
 2017 15:53:45 +0000
Subject: Re: [PATCH] MIPS: Fix sparse CPU id space build error.
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
References: <1506965989-5043-1-git-send-email-steven.hill@cavium.com>
 <5b5111e8-c6c5-0814-d109-b325969c27b5@gmail.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <4bc7e31a-3db1-8254-9cb9-b794ebf0bf15@cavium.com>
Date:   Tue, 3 Oct 2017 10:53:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <5b5111e8-c6c5-0814-d109-b325969c27b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: DM5PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:3:7b::30) To CY4PR0701MB3793.namprd07.prod.outlook.com
 (2603:10b6:910:94::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b481620b-f99e-4c8d-d3cd-08d50a76edbc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:CY4PR0701MB3793;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;3:teHAX5sp9iTOSB31YxGuDNkv+O5LXzZHCV9YMou4VugcIZUvSqYoLSaDNRHmwMNM6EWuXFxK9tBNsyjTC0QAPjcdGT/7wOv/vQLshT7Mh0hASSrsD6cAFKJeYRR7iMmeSk3NGED2DW0R2EKVX8auDbq7LiARcX1pPq+McYQo9r4RK5U+HDsmpPPaeM3FfLriGGKNnxM13WIptUUflbVkH4m2hBUwGEPzr0PsiYYbEJ3zOfeS4zcSCeMV0HfJ3Lr2;25:mGyN/5R9xXjtsVh3fhrjn9QmwQoNX96TPAu1lTTkTfkXvbvrDVMGn1AWG79eG7L3rYxK/6ZDhCVvQL+iPuTsJ3NTThm1Gk41+qHt35Q9gLpzE8AsN+09lp3sZHhwGohSftcPkg9l10/VxRb6WSxADuuFugtEJ0J/JOeA+DB9zQq6PrUSDJRYEbY3b8IciFm7Z6ZoPVfYIDJAsRyazRmrE2pDi77/l//3qIQ6JehPzbJM4uAvOGDjaCXz32Ntv70PbNXqT6PUvei0XHeUVXMsNA8lIkfrF0kVU3sSccNlgt59uRAT5V1ZMxvyCzg9Uh0SIrq9h/CLPKznELTyC22g9g==;31:P6Uz+R4slqcTdWzgeNXVbZMl5kq7U7NfxgIWS4WbBDyqIVvXwADgWLRHBE9d8mlSfxvQm0rlwGY6fFV4OAteEawJp1+s7SWuuFJgu1x/sfc9Lpl8NKPbaDtNJVbgscCbhd6duLwjCeOnMpj8Z4JVrHU4KFDqo8M/FWdKVe7a/nhidwak/rBYbIhgJNkLlQzJ6MLS/saKX3adA3J22ugQmnCXxWuVGbKXh44yRIdrqQk=
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3793:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;20:F7HdbvotU0jsX5shkwnCWaPe/QyDU+xJyiq7Q2G6FrNYKPEjmrzUnc7ONT83OE7nJsm5qHvz4w9T80wk2U9NvE/98rb7B369m+CjqD9UOw373qsCXhRPo0glLfD7z1wH2RddfXj54lrQiMhnXxE4Ci5HzAQEZbxveGI3rbRffF5Hj97YX+r2snYvCL6sc8lcI+n8x/PtBFIhb8Uq5OXt5XCAoKBCH7P702AZte8YTcP5OiqQmJ84Syi2kgBdpscIHFcOgC8yLNwbp4jS4nm70hgkfXFSn1OWDhu3uUiGQ80Pv8YhTCsP2Iym+bDUd9n1jNT853tbiOfdydfM8xw8vbBgCdNNuqbrmB9qRTbvsU6YAvrBo86GaY2AJplgEvvEzh9+34y2BGzMEj2vzqlmaOTw7UGlyH6lkQiEbwbyZ2mip6kNgLmyaN1YRNTfDU2uoW+ICEVDRLiohFzRWd/og3Hirn0gRenx/PdWd6+Bm+mfWHyjIuFx/kkxNXFZIJdG;4:0AUD+5x79pPLmkUNL9cpHrguRhbRZo2EIKk5GTltpGuRSkKwKVfVM0nzTC7iTz2nvC7reicqeSBE4/pkXLA8oIwPH2IvMs9nQLMVl3OsnyJ8e1FmefXcMMU1WUdcM1c9OsHaiJD5NTfglafIAhpVawBKMA0GG+rD8nIHVVeLo6+hL5rsr9MC7/0sWDFbqYfwaHPZ1/BhAmhwlzuns+S1lgDCPDoOHZxLAhjIxI3kMqvi87Nm5nN8xLex2LoUZPFy
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR0701MB379359A9D6AF176191A3EE4980720@CY4PR0701MB3793.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR0701MB3793;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR0701MB3793;
X-Forefront-PRVS: 044968D9E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(6009001)(346002)(376002)(377454003)(24454002)(199003)(189002)(478600001)(2870700001)(72206003)(2906002)(31686004)(23676002)(5660300001)(36756003)(3846002)(53546010)(83506001)(8676002)(229853002)(31696002)(106356001)(189998001)(105586002)(33646002)(6666003)(64126003)(86362001)(68736007)(50466002)(65826007)(16576012)(316002)(58126008)(2950100002)(16526017)(77096006)(65806001)(39060400002)(66066001)(47776003)(65956001)(6246003)(53936002)(7736002)(4326008)(6116002)(54356999)(305945005)(76176999)(81166006)(101416001)(8936002)(81156014)(6486002)(97736004)(50986999)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0701MB3793;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3MDFNQjM3OTM7MjM6Qm1LRDkwR0JnN0p2MlJrczRLL2h3MU9t?=
 =?utf-8?B?ckNGTVJBKzNNZkoyNmR5eEkzTDBrN3hJUGxLb0ZIOUFNL2R4bFVGSGJ1Vnpx?=
 =?utf-8?B?UXRKRDMweE00S0RraVYzcWNWSCtWWVhWdGVPaVhNaVhnaTJCWE52UDNmVURX?=
 =?utf-8?B?RmMyckt3UzVTOE51ZE5OUU9KY1orRFljNDFrSmNXSHBJVjUrMnBmWGVnWlZp?=
 =?utf-8?B?SjIyUjFyTzFZaGp2c1NMQkJ0ZmQ4OG53cHJ6SkRDNGc2S2NEQkV0R2RlbnpF?=
 =?utf-8?B?RnFtU3ErNjBwNWVZK1hhK25GR0NYbHExNjZvTUVGbU9BS0NGME42dkhpU0lw?=
 =?utf-8?B?U2dpaVgvV0MxWUpDb05jN1IwNEE3a0k5VGZQOXdHSG9NLytWSVg0eTFwYjk4?=
 =?utf-8?B?NnBEbHpucHJCSnVoNDA0U3hYQXpKR2xYYXRhdFRaWlkzdlhPN2pTenNvSWJy?=
 =?utf-8?B?R2FrV1hrZjB2RjEyMFcwUTBrYzdlR0JuTTgrek14UjR2Qk5xeHRsbE9ud0c3?=
 =?utf-8?B?NzM1b0k1QVRrdm5NTkcyMTRkbWpGdXNpZ2VnZjJhcms5UjVmcHlKMDQ2RWJl?=
 =?utf-8?B?MVkyV29ScUNmZ09JTDBGdFk3WTMwZzFoMEJMK0FXUkhDUHdEWFFuV2Nva1Er?=
 =?utf-8?B?SlExeE1FbGFyZ3BJTk0zV0hTamFhUHhiazhBSHRaWFhhOGttR0ltdDA5Z0FT?=
 =?utf-8?B?a3VScVJnRFd2Mk9PdXE3MzJmUU5nbW1maDBueDVsbG9MeDExWWIrMWdrZTh6?=
 =?utf-8?B?cWdJcXdITkQ1THJSSkUyT2JRL0JxS1hQTVUxODV3b1YxcGwzWkdJalR0a1Yx?=
 =?utf-8?B?TE9sYXYxanFxWlFGd0ZXQmlUekJxaHh3MDNPM1lYZ3A3SjhjM2l3c2tzaU00?=
 =?utf-8?B?b1JpYURuUDBCcSt3aHJxTVV3ZEp2eWpFaE03bi9RWEJqcmt6Z1h0RFM1a2NM?=
 =?utf-8?B?NFJJYVFNYksrOFRuQzlZT2NVRWd0OVpMVTVzdVJ4dUdFSUJIdXArSFNjSDVu?=
 =?utf-8?B?T1lkTkV0dEhRL3E3SWs0TGIrUWpzd2YzSmgydENrUDFsSTBNV0I2ZGlZaVl1?=
 =?utf-8?B?VFVqZmIzc1VhY3NlUTFPVUlWKytzRm0zMmg3V1B1S1k2OG9yZ21HL0NEU3NI?=
 =?utf-8?B?SXhHeWs5aWNmTWVSSG5SazNQZzVGQVJQd1ZRMUp0TFVPR1VOTzhESThLa21X?=
 =?utf-8?B?SmplSGhYZTdzcjhrT3h5dEhoY2gxS0ppOW95Y2svVkVodXpEMm5iTFd4MlNa?=
 =?utf-8?B?Qk00UnY0L2ZPVzI2S2EvVEF6RlR0NTVkeUI1eTRrTkdFQ2l4TjYwVUdVbkd1?=
 =?utf-8?B?VGdadWxiQlFTdmowUTNXbFpJRjFQZlJjQlR4UE90N1hpSisvRTREZU02U3dZ?=
 =?utf-8?B?QndjR1NiQ3ptdTB5bDdPcC95TWlMWTVWSDFYVDVGOW1vMlZsTnNlVGhyNnUr?=
 =?utf-8?B?djlJdE5ZbFJxTGZTd0swa3ArVUp4M1NJT2d1aEVHRE1QSnJpSWF4Q2JYOEFj?=
 =?utf-8?B?cjBxSEhnNTZWZWQ2cHliM3NvTi9kdWQ4cURYVEhWMnZ6YWM5bFlOMCtNQjRB?=
 =?utf-8?B?L2lBQjljZno0aUFKdVhwQ3hVeWg5TjROMHpHcHVVQ0x2RGpJd1EvczFLVEp1?=
 =?utf-8?B?VGc2Ri9jSmlpN2hERDJ6bytYUE5jczR2bXlhYUZlV3J2cXgrRmpISzZuRDRi?=
 =?utf-8?B?S3NPSmRPTVRMSVFSKzNuQzYxeTNsOGlzeUtoOVpUaElIOUpKZFJLQkgzMW1Y?=
 =?utf-8?B?RWVOVHJRZGRuaUYvZVhUbHYvQlBONUwwVTlldjBqSTZkckxqa3dpcVhEY0cr?=
 =?utf-8?B?WTMwdzdhN2VFOFV3MDFyZTJaRERuVzgzNHRicVhkZklqbStES0VPV25jWHlW?=
 =?utf-8?Q?9oUAb7/GVpkzo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3793;6:0q3A/8ez1eBdIX8nwxafyIV4e3BmL+PnVR/A04QgBOHCBmexlS/PbUvy6GI9YFjw6vVEHHc3WiQR67k1AW7k/ONdWyiNzZfG7i8GNqkb1py86lF3EzS+ix2fxrQcQg4Ph0G8HhkzuBbcvh+iaejqUCF+NDko7iwdZYbgyPwXsbub//165b6KzeQNHew8qFJo1XfLCQAHcNCRgZKdTEIjCCHLhzHq0DnjH/Pi+d7VrPO4KCT/jgtCV67JGrMQhuwBCdS8nDNSX3ZGJ6U1QcfcBUhlJJShpp9BFoda+BSSHtg/sm0X4t7riWK5rHYN0szjut66ISy5YpjqnTfRloPe3A==;5:kZdOkws1ag5KTeKFXj2b9j8xoDltmwT2MlWS8GUmjxmhqc5H0QCJNV2ylimehO/AKO7OBnf1kw/YsuzYMjMs3RoDeW/B1tAQ6P/m/JdjOiVkOS2Z7vgLRgol6QAxB38rr733kaiyujPWtbBHwOoY7w==;24:Fh4FeXOMwm9zejaIOjFpVzEsLs4to30o7MqawahuokjH93wmbafA2eQ+5eb31PKRIF/JaaQ0pHkm6kagTZvOqp/g7vB19XhBhMKEQv2gzSk=;7:Y3VMXVJ4jlyJmW4bvgSexzZFWvcLXGeuP7Ce/eF117M0oNMn43VeacOdfxWbM5DCFwbKRsAaqRV8ioM//jJC2AgJW/oKa6dtlUClxiHcpBuWbGUQeF3qhBCnx44JUQDAntye6I0ckoiaNUmoeBk81M544WOibOD5YyPNOj3yrWsG1QEeRdlF0f61cZVRmyM7/hmZcmqUr2uypPrUWO0xQ4WWif9ynaTNzsQA1hBNH4A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2017 15:53:45.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3793
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 10/02/2017 11:05 PM, Florian Fainelli wrote:
>>
>> Patch "MIPS: Allow __cpu_number_map to be larger than NR_CPUS" was
>> incomplete, thus breaking all MIPS builds.
> 
> Did not you submit a corrected version as part of [PATCH v2 00/12] Add
> Octeon Hotplug CPU Support.? Was v1 already merged?
> 
Yes, I did. However, Ralf had already pushed the broken v1 patch
upstream. Timing jitter of patches.  ¯\_(ツ)_/¯
