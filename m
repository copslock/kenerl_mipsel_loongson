Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 18:40:02 +0200 (CEST)
Received: from mail-by2nam03on0083.outbound.protection.outlook.com ([104.47.42.83]:38656
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993887AbdFOQjy4xCvI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jun 2017 18:39:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YxtHSgQKUUMtlGOE7EGpi2cRQxrnyBs0Be22ewE9PHk=;
 b=hhOZ4gvfMrSOMJIG89L8duYk/ve6RllDCe44XV5cSkeEXwOP/81aUE9JeG5HrqwdPRLGBM+KWs9TD+QH0jOuAxx2V9Uu6MJl6PbHXtr3myure+KfIeXZMkYIBbK9wAjpptVi9+1i35n0/kmiTSBFjU8A24Pjkb0GVLo+t3z2T+w=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from [10.0.0.4] (173.18.42.219) by
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Thu, 15 Jun 2017 16:39:58 +0000
Subject: Re: [PATCH] MIPS: Octeon: Remove unused L2C types and macros.
To:     James Cowgill <James.Cowgill@imgtec.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
References: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>
 <92415d13-3c66-76e7-8db3-ee0110c0611b@imgtec.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <cc285382-246c-a5f1-de39-1343578de47a@cavium.com>
Date:   Thu, 15 Jun 2017 11:39:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <92415d13-3c66-76e7-8db3-ee0110c0611b@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: MWHPR22CA0008.namprd22.prod.outlook.com (10.172.163.146) To
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3208:
X-MS-Office365-Filtering-Correlation-Id: ae02eed9-411f-4270-366b-08d4b40d2997
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;3:oidy6+szX2TUJP6v+ejys+UxauHWaWe84ljSwzPaaxUDBJfCGMzS+Q1YAqg/56RIGY7j9/jhkQlC3nZS1LfEf2d3PyB0BouEeCNLAcUKMLQW4mse/b6xIj7SgZzeS5sv1rSDbIzjNwWelq412biMfVWMOhzO4sJXEPpA+2O/glKX8gHKj2yCMzObnP6kYf5/395Vk9L67LLWeTdWHbehApmAL5NFbRff/4NrL188XeB4QG4EDsXPX+etmpjVqbZVsWKGLc+p6zgO58A2EXHnAVowENgf4qi3o1FxFfdP6Xx+WG3IfbrKQewX+F9hqU5y7rMWzOzZDS5LkRQz9KeQhQ==;25:lEymenlrKC7o7+rVVlHuN1cP1bFrtoNu//lm2ifeqXaOP1dUGuLXodwWjznCh2AmL6TOJ8BoT7lpq79c0ZMP93SpIiKuuaCaUURTVOhnDGNBDuUr9gvSxd2ILFPswEk/hCchTekN+6xxn8RJUUy7B9PpvTol/7TM2mHpXNU0O+d4HcM6adZZb4Mgu0xRH2gkg0H0U8aqe9IGoQeeVOvg4vtyWJbGHScL1kZs4fXt5vzvsHIr7clEuuGk9miAFY9XaUz13KKCYpV/d2Y0Ec4QNQQJoQATUgNmhjShCBGgQ/4HhBab0999s42b/5In71TgsZRDtGaVgJ7oJAgFm/5709CcsRw3+rLYvsoDcyhIwy1N+Rsx6t8uDgVHFIbcj+9fG+5HBlQjKqhK465EMYFUe83wI+Lolo8J/qWdczyEnBWjvutAVooRrZeQtf5zQIkzoBYnPc4fY1If+dXV6C6kPdWfCGxo9eRwrn8Lb+csIV0=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;31:3epK4Fshpt3M7PA76KVNc//NlIAltNgZM8pqYuQHDcBcKdOl05hJ2poA5hU+eg8/7gunsdxuTDCJiQC17eDY04rxrRrmNFSDoBdY68AAOFLchBxLPMciRNdC4gP4ebmVYR+0pwGVXbkAw5S+EAZmact2FJWXKKsQC85L2qWWCES2ygwlUf4rzT0choQI57TypdVJr4VXq811XkxCBNLyuwEPpRU2fxDb3W7qxK5sY3sXljg+miJP+wV4mPsJWHqSVFdkLiDIQh5VBeW7WbOakw==;20:6hRhIcNLdcfHRNW7/szpGrTqulZ8jaSGoD1O9gSAYGwrbFt+PLFmwoTTxJo1tS9sVdkdS3egS/xv+Ki23vS6jegQz4DjqkPutdyE1ThnTCuefqJSoFmiDGTM0ii/thfSIBBc39D8+5Tz2QghImK8U6XwmuQNIs9QGH/wbPtm7R4/+66wXphhViwG2yTUi8gYZq/3ayXW5+tpG/Kza92S9gMoj/9bK4egQje3hoIDTGrdNQPTbgvH2i+JdR9xLz1tGJHIpRqTsNrNk3B7bk4CX1vZV6llc5ZU5iK9PNots318zKasNVaoG+Ljm9POwruUyHUbbu3Pu9p8myi/sJc2Va8/pxGAF/DWNRlAVGj7PfQKHlcffFnbaFM85elf5+PxHdVKRkKBpM3DOjPgvIZUWKJKHnK9qt+ke6PmVFMO9UVOHkhAlTYmW6YJtHLEancwQCeZT6kgfwJCb3i0Vi4926v/+iD2G2YGE7MwcsMPlMnqDehwr6Cq/fIhd02bAt4H
X-Microsoft-Antispam-PRVS: <CY4PR07MB3208D8CB49C0F3440DA01B5180C00@CY4PR07MB3208.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(3002001)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(20161123558100)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3208;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA4OzQ6UVF0aGlZc3BVR3BKbERNQ2gzQTBleEVYcVN3?=
 =?utf-8?B?dEVkZ1FmMEd2ZFR1Mk96Nk5ncVkrS3d3YjBxMndIS3RDRFVFUkpxRW9lcEUr?=
 =?utf-8?B?ODJVT1ROREphN0xGYmFXOVlhY25VY0FpVy9CZWlNNnNMVWtNanBMYzhqUTlU?=
 =?utf-8?B?RTJEMXJZNlpHeFZBeWhaSmZBRG1CYXFWWU5SK3AzSEhxc3FFbGhaOEFyL2pi?=
 =?utf-8?B?R0hTSG9HT2VXN2R1RnhzWTU3NDZXZHRnY3JYNktsSVFmOGdpRlkvR0o3QXpy?=
 =?utf-8?B?MlBnbFJlU2RxWEQ4dk9kSTR2cWMzc0F5TE9uMHNKSHowa016Ym5pdnNtc1dG?=
 =?utf-8?B?dTRBZnhEcE1lcldsMGFsck5KR3VqUFZFVlNlRGdTeExITGMveC9JRTNWbGFF?=
 =?utf-8?B?YXc1eFk4cUUxT29SNnlmS0JUSXdXdGVtcjMvZU9SVEduK2tIa0YxdklLczBa?=
 =?utf-8?B?NWM5TkUxM05sak15MGJ3NHpzdUl0dVpzMG0rSFpDbDNrVC9xcFVGcW13Tjd6?=
 =?utf-8?B?SEx3UXNiWGdjTHlIaEF4TFRmQTVwbi9yM2Vxc0xmUCtTSTRDbk81bXN6OGw0?=
 =?utf-8?B?VFc2a0FoSW5YWmpEMU9iWUcvWmg1QkNwa1p3UDRaSzNqZDVGK0R0RU5PMlo0?=
 =?utf-8?B?bHQzSUp2anpZNlRvUkk2Z1BUckE2VXJ5R1kzdVNqQ2VHaE5Ealc2WHZ0dTZM?=
 =?utf-8?B?UHVWZTBLQWpBMVhCOFpUOHdNSk02cnVJblhucEJYMFBOOXF1Tll3bjd5YUVu?=
 =?utf-8?B?eUNmaVpEWmExYVJjSElmQkRWYkRMWmYzTG5RWG9HdW92WEkzMnlIdEdhRUhF?=
 =?utf-8?B?RmlDN052U2Zqell5TytxdnBBWTEvMnY0a1U2M3g0SWtSdzhYclpmL253MDB2?=
 =?utf-8?B?MWFURkFiSkxyUFdab1JCV3FJN2lmNXBJY3RRNWQ5UlVWdkpNMC9sQWM0OGI0?=
 =?utf-8?B?NGdGWHl0NGFWOWJiS090V3dsNVJscDFyaThIajllME9mSlFKSG55aW1QQzdQ?=
 =?utf-8?B?QU80NjI1QUxpelpOZWFlUHZ1U2wrM2F3Y2tLSGdqWTZPTktsNVJSWmd6L1Fv?=
 =?utf-8?B?RG1GNjUxcXlncFdDaE9YRWNJRVoyelVXTnpwRUhWcXJtVzFodEVrMmNUQjVI?=
 =?utf-8?B?dmtaQ0luRnhNdmgwWXNzOGVJMTZJNGVYa29WUGQ0dlZoam00b2FrbzUwZndt?=
 =?utf-8?B?VnJ5b1ZscXhmSjAyaUVuK0ZLSkRtTFZFdTN4MmZIZUg2UGRVS3NRUC9OV0R2?=
 =?utf-8?B?bHJZMGtmWVFxV044Z0t3MFQ3RE1qRTMrd2tsaVBpSHBQd3JiNkhyZnJOMzZY?=
 =?utf-8?B?Z0NxM1hNSEFDTUMzZVVwTXVTMjZ6NjQ1TzdsQytWZXBtYjlBdUVmR2QyQVJW?=
 =?utf-8?B?Umt2ZlN5cWJRSmxoT1d3dHhEdWJBSnBqMnJ1SFA4dWQxcGxLWENNZkhUMklm?=
 =?utf-8?B?QjR1cXU1VDNocUVGVkFrcUpsTU8veFM0c0l4eEt1Tis0SFc1SkZMNFBTNE9J?=
 =?utf-8?Q?xPyyju1y+Spz3dEBZqZNXP/4mweAYevaIhf8GpMze3bFX?=
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(39400400002)(39850400002)(39410400002)(39450400003)(39840400002)(24454002)(377454003)(42186005)(5660300001)(31686004)(77096006)(53546009)(33646002)(54356999)(86362001)(81166006)(8676002)(478600001)(6306002)(4326008)(189998001)(25786009)(47776003)(50466002)(66066001)(966005)(6486002)(72206003)(38730400002)(4001350100001)(90366009)(53936002)(2950100002)(83506001)(23676002)(2906002)(6246003)(6666003)(6116002)(110136004)(50986999)(3846002)(76176999)(31696002)(230700001)(229853002)(7736002)(305945005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3208;H:[10.0.0.4];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA4OzIzOmFxZjVXLyt3M1hZdDRXVFY2QWNiZk14Q2Vt?=
 =?utf-8?B?WVhtWndUMVA3ZkFXQ2FIdmsrUDJMYktxZzJUU05PZFBDWmxTUlBwTDVQOEFG?=
 =?utf-8?B?RGxKWTlHQ0VjZi9xVE00UjhUU3VrTGJZZ2Y0Y2UwZzNhSkVXc0tWVjB4eUZT?=
 =?utf-8?B?MWNUUWl3cE1NZ1A2SXpsNWptTERrRDVlNWVabnZNNVJmL3hKMnQrWXVOaDNu?=
 =?utf-8?B?K1FBbEpGYkdLT2hYeWZFTzJjc1B1UmlmNVM4WjVocmJYU1VnenJsaXRYQ0tn?=
 =?utf-8?B?a1VZVGJoQXE1SWlsV3FJcEFMMTVDeVppcFBETnRzWEE4UVp5MTRYVTNoYnhi?=
 =?utf-8?B?TXRaSDdmZWxYUndiRC9udk1WSTRBbTQzT0ZPcWRhU0g2MUJPUTlVY1owaG1K?=
 =?utf-8?B?KzFEME1PajV3T0lsOWRscHJITUdjVFo5bUtKck15M1cxNzcrSmRYSWJSYmR3?=
 =?utf-8?B?TWxDQTFpazhvZUZxc1RsWlBKWGR3UjZIYjRya1JHakt0bkV4R0dydUMyQmtE?=
 =?utf-8?B?TnVkSVZLTDFuVGU3Y1BxUVVTbWZ0cW03bS8rZ29EY2YrKytzS1YwUlRVWGxU?=
 =?utf-8?B?eko0ME96ZjRmWncrcXYwN0tqdFV2dzRNQ3Q3akIwMlZlbXBxR0NQZ0tLbis5?=
 =?utf-8?B?TTJ6ald0YlhCbW9RTktER090KzV0a1JtZjlNbkdWTDRGQm50WlVvWWtTSDNr?=
 =?utf-8?B?VXVCYy9vY2ZIRllmQ0pJS29YRmhXcVdNa0QwKy8yREdIZHNCL0I2TFJvRkFa?=
 =?utf-8?B?Z3VGSWNaVnBOWG5lSjlIbkpLZDVodnh3cFQ2Z1Z3U2o3ZlN3VTgveXNSaHow?=
 =?utf-8?B?a2FqYUZOdUhYOWtxU2NlQkJsUFA2ZEUwT21aczZoSk92YkpmSjlGSVZWLzVQ?=
 =?utf-8?B?bFdaaFZ4TjQ5alFCRmZDVCtNV203OVNkcER6MXZ3YVBTNCsvZW5Ld3QwSUM0?=
 =?utf-8?B?clF6R3dOVFlRcFQ0SGpPME9OTlU0UGZZeFZlMDYwZTRVVUZFdlN5emxNbmpH?=
 =?utf-8?B?aFN1a09zajdNMGtmT0RkQ040NVExWGFaVU9rQXVkVmphY0Rwbm9nMmN4dHBp?=
 =?utf-8?B?VXJZVTFjdkRWMmRKcjl4c1pxWlR4SEpDbmUxeEZkRXM5RmZuR2dpMnJaSWNC?=
 =?utf-8?B?VHcvaVVIYU10d0NGdFpPS0dzd2tTVlRQNjlHRXdHNWhsWEMyZVNHSi9WdW1n?=
 =?utf-8?B?SkpSRTFTUmxjZ3QwVno2RFBNZ0I3anBpSVg4T2xOVE9OdnEzMXE5WlltZnp3?=
 =?utf-8?B?bjhpRDBlUWNrU2VOdU81ZlZGNGFucllKRnFQRTd5TDhjcTRyWU1aajBsaU11?=
 =?utf-8?B?U3pFaEJvQ0FkaCs2aTdPT0NMMThQekxhdHdvc21lR0NJN2ZES2hraHg0dy8x?=
 =?utf-8?B?R3lOU2hQQmk4U1BmcWFsRVEwK09LcWRuVEpjOEh1S1FnMkFMeEoxVm1nV2tp?=
 =?utf-8?B?enVoUmZ3V2dobXUxZENxbm1kbzc0aFFGS3NPdWwxSWh3UjV5NnRYUm00TWxq?=
 =?utf-8?B?OTB6bkM2Y3JJY0NLMDBReDFJUFM3alhpMkd4UFMvSkRNYWJwQ0ZiM1M0eWZD?=
 =?utf-8?B?TXBnNWNYR1pmWHhrQ1lCSkp5SUV4Q2pUNWVTM1Q5Z3VnUzhQUy94dDBjVzhy?=
 =?utf-8?B?N0ZsN2R0dnRlbkVlaitjT3QwdG9xK3hZbVZLWkg5QVR6V21DZzFlYmRmcDFj?=
 =?utf-8?B?M29NYnBpaWpxQ05YWlZUM29VMlllZWEweXhRZHlDOXZ5MVVpYU5kSms4SDUr?=
 =?utf-8?B?R0M1T3AvVnp6UmxUYmNCdz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;6:tLy8qM81JdehiTWaX9r0ruAT/AMNidNWslInCCU/y5oWKZ/nVc9n0qBiDpyf8FbTg4kODlTGWmfBrOT64OxplbfMVrEhxEImvC5H5qcV/Oqg8/wpDPNewTu1f3RWNsSTvgG+hNncWvgNepXb4rkXssBri/pLpuLvl4oTBq3vQfzwcYOxqsuH2/epjbil0aV60ZJcpmmNUX2MIfqq2JtxREJCCbRkEtJZbeaBr+IsrXUMlZ0eC8FrEPLFxYtpDmPSPhmX6hdwJFtw/jfM4PP3HYL4huup3Erpwc8N0cVyu9ygBOpWpSzMlvoINKIYltSCWOPkvTl9GuSroJbOXEFoBxJlTEipAEAFbBZgvFxG060SBQPjWR0EYdJroHaWhr0z3MFTIiSABqz7XoVrBLOuCt3lloiYMiAmekGbU41KbJeerkwMG/wqWEuoTmxsGikNdutlxs2DXz9SdMORysI05MN9fE8v3/jF6GOn3r27HVIM3Flk6UZ89Na4zz2dQp2Ggdr+ibSEz10l4L/ovoW+3w==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;5:nnRbirq51/ruD3JKUpx3fFFghJ20AudsXjb23bNZDij0x3ahRgvxOtaEeP1limbJVO0qnH3vD0vXaZgGlwnVL611uPL54EoeiOO6saGEizbOdo6xXfXBXm3ykate3TdZhFyLO5MuMmWHGeHF5JjE6iG2vd7OvDIEK4tXM4zktTAUbmtmn40tUNmiK93moAh7OCzDR6YHEifrCaYXeNhHQ04eirqWLPK7TwY06lmW2z/dPRviUKik/2XuENSb7Wq59ZqB5g6DAvAV4OpTwuYHoFRGHhEBnowV42+e6NliBr6qNvHBnuBzf0x0n5bZxiWbKZ1i3Hr8jzs1IgyI0pBQjasPMZFsdEUiU3uiTpQe1fmIxSxH0hnP1Kb96mBOs9a4V1BoH69i2SbkMCWSVNxjL1u5+7EqupKiwvMbg+wbcihBGm8MGNP6vp43dSF6u1+te3gbw+sZsZyvGqkp8yFlxn8Ydrz6fD3FblAduOvdv8xfeLkNlItJtpRFquyTMGf2;24:oWXwlGpCQTN/QGWr0DP8jHzMlBZubRMQx/KtTBktSc59tY0k/Pw4mzb/NpLL+KQJNJcBZ95AeLHaE2rdrWbRA+ryFMySYe1I5c6L1Pp/DJQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;7:luzfIL6M7v7sMyre0Wu6Yv1EYTafcLBrvvgmtkwW+DjVCmsDxBxPdKVcQk2dCgZal1RIaXO+97Gigs67RphYAsheAzMmn517MslH5xhjGs47f+jRi50XjFyYZTBQ+JTqXFooXDB03zhrPdQp9pNVacrw9QExHDHssX9OqbYYYcm4b+l+VPHO77sZcMOwEYuVKom9Q1ihMpw2tS9VNhNTnybcKhSgX50OyycudnciUgbrzV2GYRjIayg+3TD5aXwG3aNgaFZFnBXJ929cFnxWL03waEaIuXMWpE2DAIct5sZuQ1vmA7CXGci7HryMwYjz462Xa/G5aG2KaJoHpb/2hw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2017 16:39:58.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3208
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58475
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

On 06/15/2017 09:16 AM, James Cowgill wrote:
> 
> This patch broke the EDAC_OCTEON_L2C driver which apparently uses some
> of these "unused" structures. I therefore think this patch (or the
> relevant parts of it which are still used) should be reverted for 4.12.
> 
Yeah, I posted the fix for 4.12 and apparently it was ignored.

https://patchwork.linux-mips.org/patch/16153/
