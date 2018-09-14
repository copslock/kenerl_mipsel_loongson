Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 21:58:59 +0200 (CEST)
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:23392
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994560AbeINT6tOjcdp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 21:58:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMFbAEQqKnGRuFvcC4S2jUuKCljazzFeh3MNTfblZIM=;
 b=dz8udEgNwLKJZswse2lIc77MZCefVzD1U44667GwmqzqwHLrZf3dwl6swo+H5iO1gWgjNZer65Lr8Q8ohiDh/V9VDt6KETJ5Z/4gnkQQhgSGeJu7Ozi4FnWYouiIkWe+UthIIhr2E3KoyWS4MdayUyXbR0jqCNvI7lzZYi2k0fQ=
Received: from localhost (63.83.14.10) by
 SN6PR08MB4944.namprd08.prod.outlook.com (2603:10b6:805:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 19:58:37 +0000
Date:   Fri, 14 Sep 2018 12:58:34 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] gpio: vr41xx: Delete vr41xx_gpio_pullupdown()
 callback
Message-ID: <20180914195834.5cosv4zpt6lph4c4@pburton-laptop>
References: <20180912113204.1064-1-linus.walleij@linaro.org>
 <20180912113204.1064-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912113204.1064-3-linus.walleij@linaro.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [63.83.14.10]
X-ClientProxiedBy: BN6PR10CA0032.namprd10.prod.outlook.com
 (2603:10b6:404:109::18) To SN6PR08MB4944.namprd08.prod.outlook.com
 (2603:10b6:805:6e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86403a06-5f3a-4f45-b3a9-08d61a7c7663
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4944;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;3:gQfOq4+vuP/HT91rlNOkWBIkofOzBczjK9xlAF9fyMyx7Ow6ZUl2heu9sXrgeO9BupWEkh5/SVmDu5kDRLP+N4HaAPOkgkFboQEpGgxRu0hX/pe9Irp5vjv6Npr1a7cWTg5WQWaI+yXKzfjE6Uc6/qQYUHsldiOajEfsybAwWgYPSkIsZdISCiXR6BdK6RJf3TwJuIbcaO2tKKDWj27ZPAyN7+M2RQWclWhwF7sIjQoOWtyUO52qQLIffBwuBrZr;25:AudvMPtuw31fB4yQ/WCjlt2vTZpYyfIatkh6+2Dm48oA9ruekRv9aD7GPNkDLsAJVnMfDKxX4VQG640Xd6ZCypTnI2RKXkK0QP7huIOjHC8CBrp84Ll3ooFMObwCqZr6UTwdssg4ZNzcUytW6rD3OR/r7+3iRXi51jYB7Pjua5NkFl0LLLFZbpp6slhPwvpMRqtjQgiib14RwPJl7RVIMXjWY2/c473hOG+Ct+PRMY+31R1vNH5LdynCQQialvj9eSnyV8hyE19gxfjqEj2/YqlnAWfXG7AuuPuOMgWOQvvciM7BjhZyVU5tlVogJaCkz4cd2VkQr3DlKBOd17qsBQ==;31:RMBbnAXWA3u4bNwU9H3mdeVQAylrgqaGULdOUEqWOHx+in0/6b7HEzsY1foxIFFo5hyXfylyhKVPlIdPItDj1G+oi+F5DHDOVE5A42plDnbRDlTnr+UuXI9hs8Xz+9ZGuR+YnbnHc+vSCPSRRpkvWNfjdzQpkFvcAfBwKyMDjiag94/OU/R3obKARI3aiShLo/vowW1uhh/h5EkbX1j4XNJuwk+jNmxcGt225kMXDM4=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4944:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;20:OQbyYAGfouoZGKFIoFvibAuDlDzssyubLyShsBp/LFxtx3wd+DalDSBI2a0tWPiBJWuOTO6IDKzjhF7ocZ4MD60aCvHsC/DsPywhB5GCH6LhLhYofqP6P6qdn/lA0MCzlSVVtm7yFJ/9pQzD6foeApVvuXvEOS1qd0xHusavQNDjraAmx4bFaHJ8+qu+oD/3IE0W9k+ATZFcJNNTTWAjjN9gEJhcwnO80VoIJ9kvj1JDQ5PigGYORlAz8k8I15xP;4:p/6ASddpt9Ln0CqtzzpZCOjoPOc1b2QVyXDNmPvcxaO2yRtuUz2QUbjC7VYk1mTlQzorLo6kjQxhW9IXU4A+tRjzl6dc5uRDasTvMYOSrn0DCg+k+Cjgf0GJV0ePC5ux/N28lS8ystaJlRxKOsS3R1h0Q4JUmTrNHTBDZmIKkB364DmaG+LouqyBT5sOrXGNN9yNwW0ssvsCp8DS3p4vhrf1ghJLJw+VDL7k2RHPVTYxJuHmcDgT2T7u4VxhblfQvhyOCF9N1wk99DoaJdbGHQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494490692F11A8CDC4941F36C1190@SN6PR08MB4944.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231344)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:SN6PR08MB4944;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4944;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(136003)(366004)(376002)(39840400004)(396003)(189003)(199004)(2906002)(23726003)(3846002)(58126008)(7736002)(76506005)(6496006)(305945005)(76176011)(42882007)(446003)(478600001)(47776003)(11346002)(15760500003)(476003)(956004)(81156014)(53936002)(6116002)(16586007)(97736004)(81166006)(9686003)(52116002)(105586002)(1076002)(68736007)(16526019)(316002)(66066001)(8676002)(106356001)(44832011)(54906003)(6666003)(5660300001)(25786009)(6246003)(14444005)(26005)(33896004)(6916009)(8936002)(229853002)(33716001)(6486002)(486006)(6346003)(386003)(50466002)(186003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4944;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4944;23:glumuUA5DkaaT2nxzLPhpCXZD1vN38HXqhTWuI3zD?=
 =?us-ascii?Q?OYSnysdvvOxXncMNUywWFV8nqCLnH5m9xZqHexGbKGAREjblE6A9TwnPnuYl?=
 =?us-ascii?Q?lX242N8KkpQ9jYQTtQp/Wh4wY6K/YTHh2+q3MK5w3gYx45LvzCQrUPNR8hyd?=
 =?us-ascii?Q?OLx+KvWCEmwbC15lHZgHtUVbeKemrcbLy2yzwZqxc7NM68EW/wvBXnfE34PG?=
 =?us-ascii?Q?6oU1P7xkA7cLi6+MBaC+4GNoK7kIMDLEgcSFVsLJ711g6zFesGyhk9uBswMA?=
 =?us-ascii?Q?ZwCYs5N2tv7honge+Ig4XP3toxmBZsPJ+fMtAmFz5BX4hEpulatf+MwcHUgd?=
 =?us-ascii?Q?GCG5bmJR1/bly8Lwh+As0YWpKjUFozI1pPVNj7yolplpmg+6/qyuUDWTiF5R?=
 =?us-ascii?Q?uwP4CJva8aLxJZVajPJ4yGCSUMDsc2IxnHujlGpqQn9ukdN4CBGPUeDyTQI0?=
 =?us-ascii?Q?qOFwo6fFWFjWLq49LN+XE1NYoCJlHwc3y+ZKIYabACBG7AfrTnD4Ro7RIN5k?=
 =?us-ascii?Q?9DPhDcYvAkyI+AwmZQP2/doosnJLBAS+GQcGAdPQyJ1XN5JrnAsy3j+69X7H?=
 =?us-ascii?Q?3ggQ+M6ZCLiLwIpY9+mfzLsTcrzjiK4YKgV+j7jnVRDPT6GXHCTh3kGhtM7K?=
 =?us-ascii?Q?Kz1tIcDQ0t1zxu1lPaC5ckQJm/e611jerD8LJKyMwh4dePl9YJ9kNVmSaUIc?=
 =?us-ascii?Q?Wf4qykZGFbsvFtyDXMcyxv197oLoMOafxgtD3dDA9sr527uvDyliWgSLGBe5?=
 =?us-ascii?Q?y/urW/8Fq9OPkLgeJd9brnstH1kRXJyJiSX1hmAeWkf3jZKpTi0YCg+EMeeT?=
 =?us-ascii?Q?JvGqibTZ+Y1PvpSFxqf+r8PTdLzLdZO1OfTxxDJShmSP0aR3UXNXT19SRI+q?=
 =?us-ascii?Q?6bTZxdjcE3Ndadg92XVVdKKIH7aAi2uoVwp/eEkBSi2PJvWMh0c9rrCaF6oB?=
 =?us-ascii?Q?UgKOBbKD4cCOW3aoBfJ8MmiN7O/WkWFVVZjmrRiv1x/KFmRAtAlvxilt0Z7w?=
 =?us-ascii?Q?JedfZ1VwK6mJmzQlpTLyas2dVv3+iilzelmh/U4ZqzoSs2nwyoPWaLklsFY1?=
 =?us-ascii?Q?gqGc6yZ8GfWPg4nncdSNhtW3QAOcM6TIbCRxvkzT9OeOwldyMXafV0P+c0x2?=
 =?us-ascii?Q?bDqOvZXI+PFfI2rujCH2vN5FdSO+j3A+suvQhG9LMhPdUn6scM8mzQgzfcLn?=
 =?us-ascii?Q?xaGcDBjmVoOGk/kW1wdYLzUUxbHVVlGDJh5GvNBNduQWkZfzk2sed+rFMb1I?=
 =?us-ascii?Q?cOBa1Z9GIle7IaBsP/A2RU0boEajn98vihsW3YwlnyAVbpPsgo653XOvYOFA?=
 =?us-ascii?Q?iY2E3qhtMhui0bObNRg4fGMI26z7bfcq5snqgVT/ZQEpxca1gKBBlkZxLW+H?=
 =?us-ascii?Q?RaAeL2Ihx5qi52TrVvMl0FBcFk=3D?=
X-Microsoft-Antispam-Message-Info: OnjE/ouWmBmjwGtPAlMVR9DrmkFdfkNFzOLCkQaDiQcvLW6Lapi7GJq0C7TB7tD+X5RnTEl5VNiwJUlKvs7Jf4W8Hsc4lDyNOl+pY4CbzK0RgWcmocPJ8hkER6LdPtHx4+hETXYXaV9ZY+4K2ALfHYnAEAFPvu407F/vUYQKTDMhQRWc2nMxeGKW1bB7o6DKtmdRgoGTM/0zBiuMDW4+NHFsl6x5MxqByAGCsu1kuOiQBraSHbfI7jEs7CiBrAG4i9BeNydIPWOCJGOoE7akjgkCJpoje8BJcTTRD5bNaKh8IRcCmktCfNAU/jcBmDgQmoYRp54j5Qw3uYN7IOY4Ce0uzNG1l7VxTTypFkAS3qU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;6:UHYsGK7eL2/3Vn8loe7r0pWMOiLJkGIOyF2D43WMyC3+MeUn+OE6Mc9DUbbzMtnRhBAQR4Mfb5+2cpnDNFXTnscrjRGhvxQ2HOCxN50L655oMiF2Psdi82SMWOGu5MzfXtThpMYKI0HOqbyLh9LJKVGsz84farkbD+ltU2wqPvh8YFp7qqMFF1XLmfgnEOmA4yhBd3IwK0NkhI9i5IzjerQSvwC1guXrw46J4x6sE2HUmk36l4l04g/YKjyx/rYnrchA/IbftQiqCSkApLvq/Ak+jxKYaSOOzBXvyNWWCWihWy08BGK7vtYfBHu5+M3V9f/trnUmRviVkHklvTSu5K4AH7t/sWyMtguqg79xaumzWY+kegKNJrdMmGMcezFdh58tXbPknVCmt3vNzkQ6vCch5Og2bSlslz3yCVGcJ/C9utE4SzVSpWcRpCJCrXsmkXJXWtwwOBE8OxCq165BMw==;5:tNweuLP43nSX1EBhcX0P04KvgZcB0T6EDe6gezSH26zjXv/kpxAQcu1sG9txPqyMQZUlqFkdrQ50j1vPw7XsMzqDtT6recpedle9xETsVJuxgRZph8ZwgfaVF8DEHl6ETWe8+MIeqeFgz3Y/fjDqwCz4L5D9uvwdyQIXKcxO3Gc=;7:ZgfWvWappPMGHoBZ/5cvwrr2p4rpuWaySwfcEoSYQwceywvis6apJZpFZ1/c7BiqXizNPo+iVDTkH1Zerh6xkCllyOk9GgbD3c+ZQOildQWTqPBZ7xoUxJ2wgZHRiKU8xl+1rwiiyTQmoOG4Vt48nWEGMfmJt19F34250mfTJGF/YJ8Pd/lnPBvYA3Kx7+FlkyWSn/HSHmonqDwbbZoIM4yd/Sc/31ITQPSyyGrt9MVkZOSFP/E+W1xaJzmmmcPt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:58:37.9983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86403a06-5f3a-4f45-b3a9-08d61a7c7663
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4944
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66309
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

Hi Linus,

On Wed, Sep 12, 2018 at 01:32:04PM +0200, Linus Walleij wrote:
> This API is not used anywhere in the kernel and has remained
> unused for years after being introduced.
> 
> Over time, we have developed a subsystem to deal with pin
> control and this now managed pull up/down.
> 
> Delete the old and unused API. If this platform needs it,
> we should implement a proper pin controller for it instead.
> 
> Cc: Yoichi Yuasa <yuasa@linux-mips.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/mips/include/asm/vr41xx/giu.h |  8 -------
>  drivers/gpio/gpio-vr41xx.c         | 38 ------------------------------
>  2 files changed, 46 deletions(-)

I presume you'll take this through the GPIO tree?

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
