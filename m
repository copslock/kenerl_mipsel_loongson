Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 09:33:40 +0200 (CEST)
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:54832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992143AbcJMHdcTJ-Nb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Oct 2016 09:33:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lXNAXqIGpW9jobBoQuDL2/3TRNCMV1ub4clTcQwpzkc=;
 b=CR4DteUdI3z3HYK/MoJ/P/dTvLKK1oIOyzMmuL9T/ZAPw4pwCG702xQhuvZs2E5BxPwbRTtacuH5hJBSTNl66kEoTc2SZdEnzuzv2CKwiGCDnoFBW01q7Ok+XU7od3yE39WFawjli4kYcGDBWCrt2QnaJqCwsqg5mv4n/ppTFEQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1251:7981:cdda:efc6:6731:e0e1]
 (2a02:908:1251:7981:cdda:efc6:6731:e0e1) by
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.659.11; Thu, 13 Oct 2016 07:33:15 +0000
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
To:     Lorenzo Stoakes <lstoakes@gmail.com>, <linux-mm@kvack.org>
References: <20161013002020.3062-1-lstoakes@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-fbdev@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, <kvm@vger.kernel.org>,
        <linux-sh@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <x86@kernel.org>, Hugh Dickins <hughd@google.com>,
        <linux-media@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
        <intel-gfx@lists.freedesktop.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <ceph-devel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-cris-kernel@axis.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-alpha@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <914b917f-6871-2ba3-95ba-981dd2855743@amd.com>
Date:   Thu, 13 Oct 2016 09:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a02:908:1251:7981:cdda:efc6:6731:e0e1]
X-ClientProxiedBy: VI1PR06CA0011.eurprd06.prod.outlook.com (10.162.116.149) To
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21)
X-MS-Office365-Filtering-Correlation-Id: 7f596959-dbf5-4441-3d93-08d3f33b3657
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;2:Ul69zh9/xFfeOzv6d+sxsm5476x6yNzUvgzN74jCIZNzpBF5tR3o555iWTYxUwt781IdHI07rOt28nrbgKbXReMq7fyYmMt750rrbprt+XTwxQM+58qYraVvBQuycyCe6EulAMnrg348YgwRea2Q+FJXur5/cZ1OZYL573bSfrcsorK8rQLCI7juErkZMVxmNgERTlqG0N/yFq4pAwWeeQ==;3:sfngFe8NbziVcJUsQV0hIjQybgT24VDvPTgxlC/PeeycDD1r4Ufzw8ykWOGu9NJyFzDnpJBOVxAIV7sYkl9zayPFqUFac2LEOl4xzFjdud7rE3pBPhOz1tifoHY+vC0myjdyS6Qk3eQrZ/pc4wKuow==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;25:3vnDlytQDH8N13vkiJ9Z722wYWN3jvkiRvWgFiPBPWWbbxXAO4zMEDneqBXGo2hAcHQYBjvwnFZpUW/FNtGfw88ZrTl/AnR44B60QnqdQCTzRaUQJubIZy8QYaxQ59th/rOIC2nSK+rWSaqM7IqSddIm6hgnlRKHiPOAYgxCZemdQs/1Go1MIdP1dKKwSEfr3ZUP4c/7hpLigsqiisIgittcAwsGrqIl797SOAu+zemQQ0pK8ITmKU7SwhU0vYzCPaIxW3FBBzpsO1eQT+ktkDzMk1vighgQH+Oa+PLw9YKjSvw6+StVNavxbGP2MgCodw2oLugV2zV1p8daBUwQcCU3z/honrgA40FptaiZgZpBvbKtfiBYPF9VUbkv2YXWpJ0TOh6scDqDvcxl8+MUUZtEb8La1QJRn6myU0fnB7xG4SkaKypd4GXYmQ8b2LMKD2X19CnTnQ99iVtk1BytTT5O/SjUnesMSh2RWk5YAZxZZQ/+af/2VLufRoMMPhVNW3bQ+M2OCdnbGQKDImjOA5p4EziQVF6XcFrnyJyGjwU9hN0OjyxLGMKnN/MgKoiVK4I2kThdHyQmpeUyGtNwc+NCj51DIQpwRfGMj8tE7ZIdzcdBv9vm5fMhoivIhCszrQ/4eoMo22JBF4SaqTyIWRF6VIHMM4DqtHDbFYxa7r9m1eUd9cWactaJtO803Cmx7ZSb+nZQ/76mVwmQxSfA3xCzjmQNVftohYNK7UBe8o9p0gHtg37mPJtFX9IhdawI3Oqa/r60aTWaW7tWz4p8jhYgpnyrkmKXjLG14UdC4oF7/TQUX5UBpJwSzJ864DDy+qnzsteTsW6DSvSZgwFQdbrNjZf7/iccbEewLTUq8YdjuwlJWSfUOa7coCBgMZrG
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;31:w5vU0cT5+wyqFLGEOIMauy4xaZjrQcgIswPoHbihzGOSecc0d5Mhn3c4pkmJAelIF5VTTMHxxnWOwnznk/7Zj6GyLdYy3xd6aveh+okjO9Jk9mZb/vm90crzV4Dm71FiC2BLmLQLRIz+grCbfMy+u+UfYpgT7VvWro8LJS6bmlY9ie3T494C68sGLkfGYg9vs7iPVo/lWg0snOIrx6s+Qk4IwYmm0DrUKGKB5T8FcCXmSK77ChmjpOt5iygCIdzv8Ei/P4Jn4NH502tYtHkbgvZ3z0aIIuJQS50KkeZf21E=;20:2xulnEnxGpbGsEL2DpWJGk6HFl1HyfQeiDm68ALIHywwMRpKWwmEVbv74O7oWUza9bf+tFIY3pTOBYppuL+nOLbERusLESPjH58NguwpWmzUtjMNhTH2ZDOGjQwLW4kgaPYRfagZ+gS+ltmlhQPWVCNdQvKkHjn4h89h2rO3B6D0Jt5qw/LPvDCPhkgA2EpwoQy0M8nZLnV9z/esg/p+O7ERn5NEDz2K9XKiePckeBR9YkjyvKNNizjmxbHgNtYq2zW4Sj49gTkmqYYnGxm04IPHpOxCACz6Bw67gIGGuGwro2kxIRQBI4SELijuw6bBWOzo8fhXnS+0D9Xpcs6rVFYusCKbsTHOpFdJGJ5oz+PbCxTmarY+u9sjHVeggVKPLuZhA2ZFAglrwlUjY8cK8PhPk1nhyQU+V2G2gQm6xlPfFM1pkK4QOhUOu9E8sFFLVgWg6F+iG83qSqSwwZPKTOt+VmrH36tlGDIvDnJyoUDroU12Ze8IdWIXd+dkP1NB
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309CC138AD798574827437083DC0@MWHPR12MB1309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110)(788757137089)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:MWHPR12MB1309;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;4:p7BL+8t8XdUI+6pzr+7oLJyFb9maRP+gd247iCBoqbsV5S4PrYD8a/2ZkXDMsQW/dgsvw+CsKpX4d6tpCsoov0VuErWDcBBe8XlNkODB/4StHnSBTEMghH0bx6bCDftV3lhIqeUYZzV1iVM1fiDJGYIs64pNhF7Yeyyi3WoCYyvoP988BtTGaOZwB35AFdbEUOjMOh5hghixQBZXQDTIhfYZmwDxea5CGwv714612LC2Wbes7aEuqFTx/yNZaV362UChLPpjKSExWStykUWcRGm6sj67ZtV9FGzjp+397mJMBIieldRvcNgswPhY61XVJKm+BbQ6pgyI37MIpb9JtqE4MHVza6oD5vGCwAIbdlFwDA2ZBV+PdCSNF6m2L/sq3yA6Q5ldnnbFCQk/QQm08VoaNmzSwM6WjNOdueP8dpaa7rqzyk2QjxnkZf7IUr2ythg5mBMTRRpPd3KpUZ65pYnlFaRmnVupO1Df5q4jO8loMKzmzDrXb3TO887iUDMo1OLV0Ee08m5fRShsGPj14i7w7C3BMhIHq5GoZuH8AMOa6RGlg+71Xyko4fardQHp
X-Forefront-PRVS: 0094E3478A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(105586002)(4001350100001)(106356001)(65956001)(5001770100001)(97736004)(81166006)(81156014)(8676002)(19580395003)(6116002)(42186005)(305945005)(47776003)(83506001)(561944003)(31686004)(19580405001)(33646002)(2906002)(189998001)(4326007)(15975445007)(7406005)(23676002)(64126003)(50466002)(5660300001)(101416001)(7416002)(68736007)(36756003)(76176999)(86362001)(54356999)(2870700001)(2950100002)(50986999)(586003)(65806001)(7846002)(7736002)(92566002)(1706002)(65826007)(31696002)(77096005)(6666003)(3826002)(2101003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1309;H:[IPv6:2a02:908:1251:7981:cdda:efc6:6731:e0e1];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzA5OzIzOm1OT0IwcXFCSExyV2JjajhZMWd0aEIzeWgw?=
 =?utf-8?B?cVNIYllxWWhCRzF4S2VFMXg1cEFZMyt6NVYxelJVL2RGdHZSQVp5YzFHUjAr?=
 =?utf-8?B?bHhENnF4eCs2MUJJNm04U1VxMk5SWTZKQ011ZVBzRXl5WWVOZnloVXRCdVZG?=
 =?utf-8?B?aU12TWl6eXhsaVJ6bW9sQWNKb00zdXdPSUhMTEtKSmc1R2lNNnJkUEVGTERQ?=
 =?utf-8?B?c1dTQmpyYUtKRDVGeXhBb3RScThtWUFlWEVudkJoNHJVbXllU1djMUM2V25E?=
 =?utf-8?B?L3AzcXh5U25FZ1JUb3A1UVQxOVpvMkc2TkNRbUNWb3VtcFBWNjVneU1RT1o3?=
 =?utf-8?B?V3RRRU1KQ2Q2QzBOalNCVHRmVVg3ZWcrQzhudXdINlIrU2VyK1AyaVBoV1Ru?=
 =?utf-8?B?YVplM1h5MHNUZ1hvaUVtSngxQjlBRkNBTEFHMjU3TnhlK09wQzIrMnRYNzNr?=
 =?utf-8?B?U0MwSGdLem5qWC9oYkdkRkozOFV3cG50TDN6dTFVSFBxdjltaEl2WFZJS0Rm?=
 =?utf-8?B?Wmo5cEwwN1hmamg4anBFVitWNUh4M2N3Znc2S0w5a1ZFUlI5MEJPVExMV25M?=
 =?utf-8?B?VGw0TTRIYmU3VzZIUzVHZld0N053UWJ2UzF1WGFrRlBQZERkTUg4eGJSeXg4?=
 =?utf-8?B?NVpDSEtrd3BmSEUxVnBPRjhEWVdqQWM1eXhsR1RVZ3FPdXd0RmptN0ZGeW1R?=
 =?utf-8?B?T2NSR3BWOEpmNWJhbkdUbU5VRHFudHRuM2FlSXVoR2tIamJQVGdQazIxb2Rv?=
 =?utf-8?B?RDdNNkJhckVrSU5DTWxNOEkyZGhHUGNIWjd2NkV6YzBjSTRHUFYrSHpRdUtI?=
 =?utf-8?B?ZHdpMnkvRkY4VXB6Q2MvSXZaOVdXWjEyZUdlSzFXVWVjQUlHVlRXbWp3M29M?=
 =?utf-8?B?V0YraWlsUHhyV1doMU5oOWdzYmoyMXhrMWs4ZzhJcEdBOCs2OVhiVEw0REVN?=
 =?utf-8?B?czZ4amxaYlB2NVRpaW01UW9HZ3lwc0Nvb0pXWWFCbElOZ0RMcGVmZDRJdVZa?=
 =?utf-8?B?NUIyRWZ5R2JNTisvVEwrS2RWa25YcmR4UU12YnUzaDl5c2Z4YzY4bVVXTlRX?=
 =?utf-8?B?MVF5NEhGakFEMTc1U2xRTmk5eUdHVDh0a3NaN0tSRHQ1UmUrbDBPTUE4M3lj?=
 =?utf-8?B?dDRBTXJ2WmNJRm9jVk11cWliUDhRTVNRcUJET1lxQnZ6NnR4MmtwRDZWd1ZO?=
 =?utf-8?B?UDNQYXhSU2Evc2h6MGdKSUlIYjRydXNwbnY0K3ZpSVZVK1ZZZ251WlRURTZI?=
 =?utf-8?B?YTgvQnZCTEJuVGpVc3JYeFNvY250NTJLSmJnOHpoT29DRm1OQXN6VXRsN2cv?=
 =?utf-8?B?ZkRzdlNvamZ6bk1jMXhoQUZTVm0rdzdjaEcyU2dOOTRQZUZ1ZHc1ZGhIL0ZV?=
 =?utf-8?B?TWdqS1lvMjMzV0tNdS92SHFPUjExVnBrenRvcy9PVlFvdCtMdUp4aGs5NytS?=
 =?utf-8?B?Vi9JYWgxd2xKMnVkb3hLNG1OWXQrRW9jblBYcUM1RVp3cGZjZStTTmN5WWVq?=
 =?utf-8?B?Zjh2eFliNmdUZjJZeW0zQ2psQjcwVjVQV0QwVVY0REFrYjNSTVdJZENuVmVt?=
 =?utf-8?B?SXdMbWdNdStEb0Q1R2FRYlFlaHBaSlNOU2pQL0hGeVpmT1hWb0NpbDd2Q3pI?=
 =?utf-8?B?bHR3RWNWSHBmZ2NqR2FRNEtVd1htb1Q3SkswOStYVUcxRFJ6SmROR1VscG1F?=
 =?utf-8?B?azQ0bkFoWllaeGtjbmhXZ0pBR3ZRM1pGZDZhZWVTVVpqRFFjV2VNYjc1YWhP?=
 =?utf-8?B?N3Zwam1Xem9lRzdPNHNDTEpPT1U1bG9XaFZPVXJqZFpUMk4waWUvVlUrZHF2?=
 =?utf-8?B?bWFPSSswbGxaeUhDb0E4MmtqcTlvUE5oUmhSaGIzWlpDTTRPa2NqbExKOEVT?=
 =?utf-8?Q?aTnne52P0XGVsH53sP1cELe/09+aJIPn?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;6:Ndold4bG3Xtj/W6vJzZDhwFplu0l8aSIN/HZqWBMpACMnvjZN+DtzT3qOpgI9GMyo3uwjmD6YaUpVTq7g8DnF3BtjXBoT+55Fo37YvGxG3d4LD3KX6a+/rsWSBOdGihpwvGlV8sTdKKa2nru8z+Dns2Hs/17UqDSjVxo3CE9hh1bw0b22N+XNlQh7viaJ9s2u9PcPeCWZeBtQW/t5vGKWTtdTxUH1jlcuZl0lTs9oA6Tm4wuy/qdkq7t3wWqAdsETTxvZ8p3vqV9qvCRwoxzBVL7OuagmAorTY+3CLAwBNktSpDAH1xGYOgozlM6GTCG6apR1qprJ8TbNlrlNlqrmw==;5:0jasrAeXugvvuVg0HV7wr7/VbtscSbhshJRx7WA1uS5fCzbCikbdrD0ZccgTt12Kye7OEQFNzgTUYqzV1D2CLhmDNjqHvxU21fWAc7tYRKoHQmTcZvkgNJ0p3veO24UsOHTmqlTkddPkFfjEa/jVYXF4sFZGG2xsRrVDItQ0wHU=;24:5jY9trklzQ6o6525IYKmCWOlYv2E0sRhtbC2Hojaxn7J+udLVMvb2da13DHrV2hqUzFUFRD96UKbAzBR06zEqi3s1FLLFZtp5iBu6jAAXbE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;7:uMtn35ZvQYCRFSyMFi0cwsLzWlobxy8QCUtVpPMNyE6VDO7KjuOcXjtb8rC3cnKCaI0hEjeWXRF9+y/17FG2qKfYPlK2mWRWeh44MkoYhJm2k2CqpcILy1DIxMQkiGa2iI5ouxIpSeMXwRRXMmA+2TUIT20lWeC55LnNIwNGzZw2ocL31PJJdmBh2iLpa46/VpX9NwK8jZo3HGg4TFZ217GoNLUwTfJWRQmwE5SE48snI8Z0NmA7URC5jPGr+HTZ1W+l4hXBznqXCmRRFxNKhuWmgJOBKZSepx7v4y+5c5AF9w7/XLV5x5BW1cise0ZDobWhPxSvtivGF01R6x1FmJZNRU8czvXwjDXuMPwHeII=;20:K84z9lKU67o6oNmXygnmk+FBLXLABZZzIvlxwuBwD4ReHcht+rmb452NWeZMudY7FPKlHAWgUZ9Jx+b5aVMSLRs/7C9/nj/PXJtUoiGq8rOJx/+a1uQxm0+TEDTntcC7SsZdaX6sw44By0bT0m1sabqdhm3xMGz9cBGLiOqD8x1BJNPPbAyn7yxMP+eEK6c0DmTml3hxACoS3OYQbn0BG17NL2l0Iz2G2qI2IdAR7xxUOZ/ES7Ynj6HXdi6YtuWa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2016 07:33:15.5396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
Return-Path: <Christian.Koenig@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christian.koenig@amd.com
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

Am 13.10.2016 um 02:20 schrieb Lorenzo Stoakes:
> This patch series adjusts functions in the get_user_pages* family such that
> desired FOLL_* flags are passed as an argument rather than implied by flags.
>
> The purpose of this change is to make the use of FOLL_FORCE explicit so it is
> easier to grep for and clearer to callers that this flag is being used. The use
> of FOLL_FORCE is an issue as it overrides missing VM_READ/VM_WRITE flags for the
> VMA whose pages we are reading from/writing to, which can result in surprising
> behaviour.
>
> The patch series came out of the discussion around commit 38e0885, which
> addressed a BUG_ON() being triggered when a page was faulted in with PROT_NONE
> set but having been overridden by FOLL_FORCE. do_numa_page() was run on the
> assumption the page _must_ be one marked for NUMA node migration as an actual
> PROT_NONE page would have been dealt with prior to this code path, however
> FOLL_FORCE introduced a situation where this assumption did not hold.
>
> See https://marc.info/?l=linux-mm&m=147585445805166 for the patch proposal.
>
> Lorenzo Stoakes (10):
>    mm: remove write/force parameters from __get_user_pages_locked()
>    mm: remove write/force parameters from __get_user_pages_unlocked()
>    mm: replace get_user_pages_unlocked() write/force parameters with gup_flags
>    mm: replace get_user_pages_locked() write/force parameters with gup_flags
>    mm: replace get_vaddr_frames() write/force parameters with gup_flags
>    mm: replace get_user_pages() write/force parameters with gup_flags
>    mm: replace get_user_pages_remote() write/force parameters with gup_flags
>    mm: replace __access_remote_vm() write parameter with gup_flags
>    mm: replace access_remote_vm() write parameter with gup_flags
>    mm: replace access_process_vm() write parameter with gup_flags

Patch number 6 in this series (which touches drivers I co-maintain) is 
Acked-by: Christian König <christian.koenig@amd.com>.

In general looks like a very nice cleanup to me, but I'm not enlightened 
enough to full judge.

Regards,
Christian.

>
>   arch/alpha/kernel/ptrace.c                         |  9 ++--
>   arch/blackfin/kernel/ptrace.c                      |  5 ++-
>   arch/cris/arch-v32/drivers/cryptocop.c             |  4 +-
>   arch/cris/arch-v32/kernel/ptrace.c                 |  4 +-
>   arch/ia64/kernel/err_inject.c                      |  2 +-
>   arch/ia64/kernel/ptrace.c                          | 14 +++---
>   arch/m32r/kernel/ptrace.c                          | 15 ++++---
>   arch/mips/kernel/ptrace32.c                        |  5 ++-
>   arch/mips/mm/gup.c                                 |  2 +-
>   arch/powerpc/kernel/ptrace32.c                     |  5 ++-
>   arch/s390/mm/gup.c                                 |  3 +-
>   arch/score/kernel/ptrace.c                         | 10 +++--
>   arch/sh/mm/gup.c                                   |  3 +-
>   arch/sparc/kernel/ptrace_64.c                      | 24 +++++++----
>   arch/sparc/mm/gup.c                                |  3 +-
>   arch/x86/kernel/step.c                             |  3 +-
>   arch/x86/mm/gup.c                                  |  2 +-
>   arch/x86/mm/mpx.c                                  |  5 +--
>   arch/x86/um/ptrace_32.c                            |  3 +-
>   arch/x86/um/ptrace_64.c                            |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  7 ++-
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c              |  7 ++-
>   drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  3 +-
>   drivers/gpu/drm/i915/i915_gem_userptr.c            |  6 ++-
>   drivers/gpu/drm/radeon/radeon_ttm.c                |  3 +-
>   drivers/gpu/drm/via/via_dmablit.c                  |  4 +-
>   drivers/infiniband/core/umem.c                     |  6 ++-
>   drivers/infiniband/core/umem_odp.c                 |  7 ++-
>   drivers/infiniband/hw/mthca/mthca_memfree.c        |  2 +-
>   drivers/infiniband/hw/qib/qib_user_pages.c         |  3 +-
>   drivers/infiniband/hw/usnic/usnic_uiom.c           |  5 ++-
>   drivers/media/pci/ivtv/ivtv-udma.c                 |  4 +-
>   drivers/media/pci/ivtv/ivtv-yuv.c                  |  5 ++-
>   drivers/media/platform/omap/omap_vout.c            |  2 +-
>   drivers/media/v4l2-core/videobuf-dma-sg.c          |  7 ++-
>   drivers/media/v4l2-core/videobuf2-memops.c         |  6 ++-
>   drivers/misc/mic/scif/scif_rma.c                   |  3 +-
>   drivers/misc/sgi-gru/grufault.c                    |  2 +-
>   drivers/platform/goldfish/goldfish_pipe.c          |  3 +-
>   drivers/rapidio/devices/rio_mport_cdev.c           |  3 +-
>   drivers/scsi/st.c                                  |  5 +--
>   .../interface/vchiq_arm/vchiq_2835_arm.c           |  3 +-
>   .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  3 +-
>   drivers/video/fbdev/pvr2fb.c                       |  4 +-
>   drivers/virt/fsl_hypervisor.c                      |  4 +-
>   fs/exec.c                                          |  9 +++-
>   fs/proc/base.c                                     | 19 +++++---
>   include/linux/mm.h                                 | 18 ++++----
>   kernel/events/uprobes.c                            |  6 ++-
>   kernel/ptrace.c                                    | 16 ++++---
>   mm/frame_vector.c                                  |  9 ++--
>   mm/gup.c                                           | 50 ++++++++++------------
>   mm/memory.c                                        | 16 ++++---
>   mm/mempolicy.c                                     |  2 +-
>   mm/nommu.c                                         | 38 +++++++---------
>   mm/process_vm_access.c                             |  7 ++-
>   mm/util.c                                          |  8 ++--
>   net/ceph/pagevec.c                                 |  2 +-
>   security/tomoyo/domain.c                           |  2 +-
>   virt/kvm/async_pf.c                                |  3 +-
>   virt/kvm/kvm_main.c                                | 11 +++--
>   61 files changed, 260 insertions(+), 187 deletions(-)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
