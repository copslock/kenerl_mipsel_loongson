Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 20:22:44 +0100 (CET)
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:1586
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdB1TWfQI2ji (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 20:22:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/sDssFqAx4nDjIVPwVHjgDXn0ipGmheZPpNlvXKVJEg=;
 b=SlBUC6IPxNDZNHT650tpc+EWDBkanN4jK0mctEvXhdMz9k4a7TVZzpbVfKRDDOibZraxpa/+4oO9DG7zcK1N7LTnI9MCyGo4FoBJ3wyJQFS3yRSEPTWcGE3kcOE18uSuz6GEW6ge+vd9H2qGuYvySQerH9fHSNYWbkdPtiWQUrY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2423.namprd07.prod.outlook.com (10.166.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Tue, 28 Feb 2017 19:22:23 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
Date:   Tue, 28 Feb 2017 11:22:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA075.namprd07.prod.outlook.com (10.160.24.30) To
 BY2PR07MB2423.namprd07.prod.outlook.com (10.166.115.15)
X-MS-Office365-Filtering-Correlation-Id: 18b43fed-e96f-4f97-6d6d-08d4600f210b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2423;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;3:qP2Z5dg2viqZ43RsaG+KKYj+15nWD6EALUQ/16uMOsjcVpE7D6m77cjiwiML7XRltS7yXPgmJMzgUKiOllj3uqwRVk1y0qIIpLUBsD3yaZ4eMhgUnm5YNhfAtpDi7ATyn+mV/Lm7efHaE/C/fvXHPdBDHAZU7HNnfBpSO0Y9i/rhp0zDwuqVbthsNEyDtZv0VAolLVBafq9AOJvIuaYa92tkCQn/Fwk1/kfeiOu2d0VhOTvalZRxAIP2Gfw40KhNerZm++LtC9oHp3bQy2WCxQ==;25:5kkDdb3d4qf+BwiEIf/BS6icsDVHf/C+ejNr1APFkBo9m7aWtiXqjfPMNGPwEjPvglEPVwoflE5maj1miticIrH7grU/+Rhu6M8ZH0gUWk7TkBju8wYLtYwb8UGJ79dTNH4BMVANhZDf0q+RG3huJDBc8O2FjRiF1VC31W4pwxCrIIK5o/1A9YCrAXm+5b0S4wI/l9Ju1opbxCjUet7b7uD7pGCzM9CZ1AmvL97M67qepvMjdXKpgMxDXKQ4C5QVzsZJ0v4wv1O6o3NygByfo3HNBQzm6ymoqUla/hK5PNlANubHtGJbGxtT6RWJOpwcS0yGit3qn+H3CwYwuB0+KpElmStMaC0ENfbe/b5wGgU6XHRnt2OwBhSVS4BB96tUD1d6fKdG15zNqbcKT6Mf/TqkKgkIRghFu9gq7rWEDwplsDqEsWP8irHb3UOCndffCqwmCNz9CqXkafzvE0c43Q==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;31:oxViDWUatwI93W1+n0SjacY1QtJFbrlb2qqV7bbI7yjpzA0ISFWViuxD67N9lCUO7zHM5ci6E6Xyf1fBN+VE7ohZmddy28xuOM5LLdDjp5aHbTHCQ5vOtV5Q26B8n4SWj8SAYyk5l7ftemqptEh1RxhMTLH0d/kxMTO1YXQqaaxj/wa3oL49iK6udlXDr+EgOoDF3d8zTZqWLO1ZvaytcZLklejGHn3dvfIJ4/6Aedg3D/sM2vfyh+CChArFGNXB;20:m/Rh/aozJUcUdlsxYdzm2rD7kAhwfZpIfTKAMzYV3PhyNkpXXIczDYHIvR59Zy97sWGU4Oozq4BbBqkhyWoDTmOSxziuDqArFaKZlSrdS15zgLkCr20xjkcJY7rQjxVRED/EHtnmwKObp8+EZg4vo6FpMWYJSlo5LrGtbSdTsGnXaMMn7y8PmxCsRjzdDMexegWowISHN9G59q3XmBgJVec/JoE1BjyIoeuqFNT/K7nor0p6+xgx878O819kQElo+4m0xbBCdTgFl05GeYTLxGtlR2/KcrL2kX47P8r8wFt3AILdQx/RzYtSeRWx+tDtemE/TxaW9ZyO/Rs60qFFmsOCX4czIWH0dxhwiC6kVuqbZdu9ghnPnWfaVmMQ5A+FA/0naaG2ti77DhB/oUGBNycmtGnUTsaVCla8qBAYg8V9R86zinOp2vaH24qnV0LJheFFaOME1SvwwoCq/+riJgkYtcmPaRdLZVeu9mKuzKNcTI61vgiJ2WIvDplzG3s9ydaBIDoIiBqLEFA0xomxjjyBm9oSCBSAxM454kNL7IG/BGosJJFg7OBlhRWOIkzHeNCOAjMDGkA+Ns6XwkxXYpX6TtOKUmVWatlAXeb/Pc8=
X-Microsoft-Antispam-PRVS: <BY2PR07MB24233C8ABFAE49F32F9A299F97560@BY2PR07MB2423.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:BY2PR07MB2423;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2423;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;4:SynSRKzmsnvlnJZnBFr46/X5oaNwbmcaN8PMNBFNHMN0sBxvAVl67mDWKhBPDRgIxVyNoBmvXCedHl4j6SX8WuI64OR8cCbDY3d0CLp8AF0gtRoOmnyCj6d1vn5WJnR/yzg7rU+C/NhmjnwFNh6MhlearfeUwusew1Kkvkf1G0h9o0BZUW7609TkCRcjz+f2k92KAqeg/Hd7TJ8jEDnLFYtc6qYo9YOnQVuYq/ajAzJg+Y+O6yBgp2KFTiQC6XGg6ggrHKIp2HDfOvP65AHBav4XHNGrg3IyHEg+op2BEveHFH9NyE8DkTQdd61huYIRBixh1XU1QLhNC8hkgOXWgPu8CazW5HknpQapK3cxLE9QpVSGOYTla9kDu2wpDeKwMCqWIApLusChU7Cef1ely3axJOVnapPF9Y4tlvKwpcO8pVTa9FxBihJQEGBg7+Lh2VN+IdUL9OXSeO102xmEKQbcv1LUYa5hdTHQUBXQypUh+zuc/7V78t9lPZRgW1fK7Gs2CC5fxBoyQfZ4N5hx/hf1hIMrDlpkFVqjwykKSpFyM5/Hgk/Pj8R0OGOfBYfxoeHJSmBrOFtOGcwigYlCkEzGoe5Q2nHy3DbrF2upiDO7C42GtA2g9hLPq7AQxmvEwK0XvXV+CYxEB9FMPdpEXw==
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(189002)(377454003)(199003)(966004)(31696002)(65826007)(5660300001)(53546006)(6246003)(38730400002)(65806001)(230700001)(54356999)(50986999)(189998001)(53936002)(101416001)(6116002)(2906002)(66066001)(50466002)(76176999)(3846002)(47776003)(64126003)(65956001)(68736007)(6666003)(305945005)(92566002)(105586002)(7736002)(23746002)(97736004)(7416002)(106356001)(4001350100001)(53416004)(93886004)(8676002)(229853002)(2950100002)(31686004)(54906002)(81156014)(83506001)(81166006)(42882006)(42186005)(6486002)(25786008)(6512007)(6506006)(36756003)(33646002)(1720100001)(6306002)(4326008)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2423;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR07MB2423;23:cyNQg9jTw47VKZzgC5QhH8SVWiQB2At0RJFLY?=
 =?Windows-1252?Q?rwrDt35t0QjXQQilti4UamhHVuzJY7XMYrTho4D5cIVhfAv8D6/aTNi0?=
 =?Windows-1252?Q?K7wEm2nBL1fyXZD3ZFGqLMH7INW6CDRpfekQIKhJlt9pvWhs0iWPuycE?=
 =?Windows-1252?Q?JidQDg+ygaoumlhR4YqhtI+a7Vrb9VCOCX6wgnD36Ww0qQoIfKIZfxbD?=
 =?Windows-1252?Q?iXEb9rmgJluEKuamvgR2f/tBwz8vt2Emd1cWZGybSvpD8XDt+ApB/c4P?=
 =?Windows-1252?Q?r8FGX5hJDYtPR3iVWt3LuHf2+d+/maUWUWPkiXZOqhmNWwCnjKmaYpde?=
 =?Windows-1252?Q?7jLdez4iZzKfEbEkhO6wmOjYWpfoDWOwwWO1yvxuzCpmGcae7atPUc34?=
 =?Windows-1252?Q?GQFnWUDSkAjrG0dAu6HFBdCrojzehFRUWJ2PA3GHlIqCe9X28u/YCBF4?=
 =?Windows-1252?Q?lT5/0foWzUo83NZlbrkqPRCnciIT/rKOBlAiElMhdyTZmOu474ZgCO7/?=
 =?Windows-1252?Q?sHGp5J/RxTykb/GLYgZuU00LPx0Hl0JzsK+GI+x+pmA40kb2xYNVInV7?=
 =?Windows-1252?Q?hgReAep7cgkDD7bho3byuXeBvip5H8+l4FTUn0EcDL20JYg6cZ9gf1nS?=
 =?Windows-1252?Q?IDMcjPBmYXlkPKtaVeea+c9jZKx8FEQXOmklrkL5AoAMtTSiu1zDkkYo?=
 =?Windows-1252?Q?r6mKTorsFxn22jtlRsHOskKsjIZfX3EGX0jl0cxLMLTU/r4iFXcynTI3?=
 =?Windows-1252?Q?+Apk7SWbCaYAOUwkQeRTueoMGYDhp12EA+LCbi8ogQj2CYOkfWGQEhFu?=
 =?Windows-1252?Q?mZwelKcTdN8nbciDdjUy2r4OSudCkfb2TdD7ddswhlb8PhRahFCR9X8b?=
 =?Windows-1252?Q?nFigg3DZVIPFIKKrdYWYb6Uej5R3FKL4XecyMZ12VTuSDkZTFfwYO3o6?=
 =?Windows-1252?Q?BkdENeynzUEmHsWDKcFNNLA8U2OAAaRFs+OPeXE7KIVGizU38/t3QogZ?=
 =?Windows-1252?Q?JWmuM37ulQ4y85iuv0FVFwQPjiPU8Q7Pgu6B4Rt5UYLieGH4rwKYRc/K?=
 =?Windows-1252?Q?EFkbvRIRBIDw7PyW6lJKK8mjK5uTp5ACPQvkNBT7KoBuKxlKK00f9ZUs?=
 =?Windows-1252?Q?JtTQ+qgGYOJyPnxAKrH80gqf+NCK0bHG824YRMNvDgYUmnN3MUajceTH?=
 =?Windows-1252?Q?09OouK1NLZZ3TLJO//FqIy6ewgwSTUYF//yrqwkOCGh4GH0ONu8Q6BQV?=
 =?Windows-1252?Q?8oPBEgv2CUVkvgBCKtANMmr9nJDlq7EaMzm70ZHcHK1ETfINob4s+UWG?=
 =?Windows-1252?Q?6iHEN2g4r/SiCslWXtX90zy9lujRhKMhzB8KZdMLJLQ33MgGVm//mYS/?=
 =?Windows-1252?Q?W11tGRr4uJsoNAAQDvJKoeR5qJIDJ+uS2jvj2oaysK/+DOPUFYcFSzZQ?=
 =?Windows-1252?Q?Q+4kg8mlr8T8edxsxWDp1kgn5vELfGtKU3DjY8qHfaQqMShxVlUM/cM1?=
 =?Windows-1252?Q?OFUE2dkmjJqYMNIJTAFnIP5MYVrPvAhnqArtmUTGAJVpiuhvFtjkZ89T?=
 =?Windows-1252?Q?Q/y3eP4qg+KumijA+YJee/5p2ZLQ5jBFAO9I+Vl+5QKfOQxLUoYopoz0?=
 =?Windows-1252?Q?L1kcfcg7ueJVXCzzKDj9/w=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;6:vbt22xGI1DHg/fSn7vYAY1Ztn5Uk08IS5b+hhUeMBm7cs1OxleQ3x2ODNbsvI2inVa8F0QHTYQWsPwYIPCNZIqGkQiRe4xp0CUQ5/NunGzfIJ+9IK5NQEWZOnRiwGPsBLCywsI8aGDImeH71OS5lZzJUyyxzM4jNs552mfKq1VxF8z0xxbFeuOIfP1pEgg5OGTpNtzwgizWyKFV5wPXkBxGJEupoJujmOh7A+C/BVV1pIF/LBFeUbGYbn0Tl3slLKrckyS1oKFoJ9JfFc/ZCntkJW4+xABRfY0KHh2lQGwpfL3kEcU2rBLS4GIXExd3RWtvE505m9EGirR6w2+Y4lhFrw6yWlL5wdEQKgsbKWg2pBOgsoXE2cINRaBMb4/IVJPOf9CNF3/VurFZIpwvTkg==;5:C1oXIcVA2+WynXQRhczmD3YFlGJG/d1ymlNsNO4M1mkNgHQJK4GA4o2Mln9BVvdDmrAE2Xc7VYNxX5RFCx/3HDYu1eBt5Mw1qO/488XUTyNbL+QbPM/9NQS3f3Gco+h1X92mkAyou4sRu/QteNahYw==;24:2PYi8K/Bs2X9j87Y3WHDLPvvakG4c5fwin5XX8rnJr8Bgq++ZugQHPCQSAjZXsb7kNRfv6/K0M59H+ut5J/p83Ech/mWAoa6E000bTBf/Sw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;7:kmYbqSUaz+AW7Pk3GkffDFxXbvFP4U28t8Mzk5CidIGVgr45qTSZJaBygkLVM1kPQm+iLXBG909tl5DJINuJcTL2M5MRF7N2IrNR9fMvMq7lewQraM2khVEawhWe2/j9SM8QNQnpQkkk3155uAlbw8x8nvOEw1IPbHtMWT/RiSXD0C23HUDJgMU79NJckr0QUCHoVsjrqSHV3kgocDakRMXg00k05Ap5FQCIiLzyqBxFekaL8ICVcmjNsKVcmPwS2dYEyB9nqPldAYkFOJVLSZDFcEVzqpQT4b9+KkOw4PGklGvOiXl+0YOyOnCLHH1pz0CKvx8ZRyZqwzvCTH/IGw==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2017 19:22:23.6411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2423
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56930
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

On 02/28/2017 11:05 AM, David Daney wrote:
> On 02/28/2017 10:39 AM, Jason Baron wrote:
>>
[...]
>>> I suspect that the alignment of the __jump_table section in the .ko
>>> files is not correct, and you are seeing some sort of problem due to
>>> that.
>>>
>>>
>>
>> Hi,
>>
>> Yes, if you look at the trace that Sachin sent the module being loaded
>> that does the WARN_ON() is nfsd.ko.
>>
>> That module from Sachin's trace has:
>>
>>   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0
>> 18 WAM  0   0  1
>
> The problem is then the section alignment (last column) for power.
>
> On mips with no patches applied, we get:
>
>   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048
> 00  WA  0   0  8
>
> Look, proper alignment!
>
> The question I have is why do the power ".llong" and ".long" assembler
> directives not force section alignment?  Is there an alternative that
> could be used that would result in the proper alignment?  Would ".word"
> work?
>
> If not, then I would say patch only power with your balign thing. 8-byte
> alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel
>

I think the proper fix is either:

A) Modify scripts/module-common.lds to force __jump_table alignment for 
all architectures.

B) Add arch/powerpc/kernel/module.lds to force __jump_table alignment 
for powerpc only.

David.



>
>>
>> So its not the size but rather the start offset '03fd77', that is the
>> problem here. That is what the WARN_ON triggers on, that the start of
>> the table is not 4-byte aligned.
>>
>> Using a ppc cross-compiler and the ENTSIZE patch that line does not
>> change, however if I use the initial patch posted in this thread, the
>> start does align to 4-bytes and thus the warning goes away, as Sachin
>> verified. In fact, without the patch I found several modules that don't
>> start at the proper alignment, however with the patch that started this
>> thread they were all properly aligned.
>>
>> In terms of the '.balign' causing holes, we originally added the
>> '_ASM_ALIGN' to x86 for precisely this reason. See commit:
>> ef64789 jump label: Add _ASM_ALIGN for x86 and x86_64 and discussion.
>>
>> In addition, we have a lot of runtime with the .balign in the tree and
>> I'm not aware of any holes in the table. I think the code would blow up
>> pretty badly if there were.
>>
>> A number of arches were already using the '.balign', and the patch I
>> proposed simply added it to remaining ones, now that we added a
>> WARN_ON() to catch this condition.
>>
>> Thanks,
>>
>> -Jason
>>
>>
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
