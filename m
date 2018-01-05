Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:11:50 +0100 (CET)
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:42943
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992368AbeAESLjnxbs8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 19:11:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yvn6gUE40Tpnj5CuNbPwclz0+X7rwBvUBtSObatBl/g=;
 b=PnUbKq/VATZGCBCQxG/+jTb3WAXGG2YmNBUH/3AzgxZi+9WNOUD6KctQ5ZgrpGYdbM+cx8UcwJBtK6pjqxX8TLcLZ8aTm+nqUMF4CUefIppglSjP5jEnVYS8+XVmX2a8EdcDsRo8EvmfVTvfNDZVNI6OdzS1fRNRANaNXxzqUaw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.366.8; Fri, 5 Jan 2018 18:11:28 +0000
Subject: Re: [PATCH 1/2] MIPS: Watch: Avoid duplication of bits in
 mips_install_watch_registers.
To:     Matt Redfearn <matt.redfearn@mips.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <cb4784cd-fce3-55fc-2281-88f5922ff309@caviumnetworks.com>
Date:   Fri, 5 Jan 2018 10:11:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0065.namprd07.prod.outlook.com (10.163.126.33)
 To CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204b2b0b-79c5-4612-7bb2-08d55467bdf2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;3:JVfeGzzch1kdIYZaVWEmEaLCIyEtKsKpCm5xorkiu8OftzcF0Nl21jcOhSs01bALX2NuqxdxDVgJ7T267er7ZvpX/p9+B3CX2tUXy9i/ehYgTFsltlWWICD911WP+hzU+uhlG8gJPNQHJ+myuehfyODQz1ktjeeWcokUzByCf3+Q1PtwALV5bevToGFGLq1J0qF7OSWjW55N1yZbqyDNOX/Zm2Z+zH6WdoGAi3qRv7K/0NQrpFUm6m9bcX0fcAoo;25:IEir2IwFsWxEsOVsDKvJFet3xMBbWBS0HjXsaUlpMPh+3jK9WlmAlbO03cK/C/XSdaBJvWGibv/cZVnSL8+rzRmgw4WmoeJYROFOeulBoGTxkOES9pZnc+HK70AcWJG7ZCI+Zou29g3g+A/wBMVxqAHVqIVw7MkTcfMwV2j5lN88808+RUlGniVAZeAkL4bRlGJXDyYUlkpxtgZ/dTJaHUVPBTED/Zh9w1kfQwx3oPrN93reBq+DnP/Ve2q3OxBxv998ffhM4f8WDWwnfon0R0i1gZenfoqwmZGntq8nCCeVjrPv/Z//RUvgB3gcA4GbhaA7Qz6kLwG5ejGMOsamIg==;31:z4aR4DWQrEivax7Qn8wF4wcBp2L/ix7XkLl4ke7Lfvy1prCXnCQoZTob79sSmtlJUSe8miUBECgMouR0R6OOi+8esCusNfoiFh8potENcb5dhAlCwD0swnppWIUhjRCKjkJhq2ttaERNvnDjWJ8IABELRnhlKMTI/3gdrca7KgKILNbyJbulszkLbkC3bQLdBAqo9m5teCjhX+hmR+43b9fcWvqWv3UjVZXLmPbqhtQ=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3493:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;20:1jHmofIm1KbbsWhTsIxKJAO1PvsHYQHDSQCvaJMprSuyaHUyU64zALsqLFD3Kq0+YRNlEPqBIeaTVgIAn5O6wmM+h0tBzPpPFzbbnVR9bI9inag6E02nvJcKZl8zdwaDTP2XBjy1+kVGbbjo7zElP9IVXNhDm4uWbqrgsjxtRPIlL/lzU+7wQP8Jts2ktOdRloWRJRW83sCMq9xjuN3TurpwRDqk+svm8EXeW4zMAI4cZRJ30ZL5wzImnXN3l1uE8Lo9HTY26fHtUUEJqKy3wJKa8VYuELcFfnoHjcZX1/p2VAAjF4A9wvf6tdnD+XoxC44IEFeV1H7RZxpaxVWRkIM/tLQ+LAWOwTtHxaDMS03LP+TURDTHWhK03rH/jkF/EAbakH9qC7E7DXPDIHnc+SNM3NSgNlzUoZ1TNHa+5aISyg7B80rcffRx8lNJLUPZ0uG0o4Wm3HF4v2uZWJfiumyHea992Fq6SSquFg9Aq7Tdwuu/HAcAH7WBmlWT/nriA/b+dbFK+Ia4msKetVkQz/NIVoYZ9YKjomxvhRsXeV8WFaLW7o3YVOqSzCgg0bTkBvGwFjhr0Dt7UtlqyIuZb3q84svCkj0eGuH6JDxUFtw=;4:v4m9S8mM5gVFozsT3tIz1rG1PNtRluNO8VnWE9auqowjRIecd0yBE1pRsy8TY7bQ6DDrH4P+K8VSbmgUL8L9xb5FBhWQBv5MSY4niS5DOiBkUDM0BqqRFGTojB0TaokpH25ZSCU2yfwwdcYCz5aLafP//znP027edX1pBTe9W0ZxDITkinbgdYvtNO+LATC7LXqKXHDCA9pwsDcYJ+NnzTCKffnGiOlh8U0hDQkunk4kEzhRwfWyBrb8UH++mVYly8EsNwVP1AIvbOaG7fDpwA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3493EB7907762B5908A30182971C0@CY4PR07MB3493.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(3002001)(10201501046)(93006095)(6041268)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR07MB3493;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3493;
X-Forefront-PRVS: 05437568AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(199004)(189003)(24454002)(6486002)(47776003)(81166006)(106356001)(81156014)(72206003)(6512007)(36756003)(65826007)(25786009)(5660300001)(65956001)(69596002)(2906002)(65806001)(16526018)(66066001)(229853002)(105586002)(6246003)(8936002)(6116002)(3846002)(8676002)(83506002)(7736002)(23676004)(52146003)(31696002)(2486003)(68736007)(52116002)(305945005)(67846002)(316002)(50466002)(230700001)(97736004)(386003)(2950100002)(6506007)(31686004)(6666003)(53546011)(42882006)(76176011)(58126008)(478600001)(53936002)(53416004)(64126003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3493;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzIzOmY3cVNYbzR5WlBkY05mMk9OWkNXcHJRdWpy?=
 =?utf-8?B?NTZ3WVNwRHZqaGpYVWFvSnB1LzZuRlEwTDJPV3BEblAxZFN0Vzlqa0lnYk8r?=
 =?utf-8?B?Z0hac2pLRDIwRzY5b2QvVG9ZSGFpVjFac2wrUHl6SzIxL05HWFZma0lqS2dm?=
 =?utf-8?B?MnVLNFBLWUszekpyajdEZ3M1Ym1NR0UvRFJKTExsdFRoNkxIei84ckZZYnVP?=
 =?utf-8?B?K3A3aktacXRzRGRSUUZwZEtDTzdMbDNkdWltaU5xWE50Ym1SSUFaTEQ0eFVl?=
 =?utf-8?B?cWVaTVBZK01aVTBTUC9pSGVSY3drZGFyb2dCdTVML1RlY0t6eXRTNUpNSGtj?=
 =?utf-8?B?S0hCbW1OUGRMalVDNUlTazA1dW5xeXFiQm0rMjRjWEgyQkFlUDRPZnArWUth?=
 =?utf-8?B?WjJvT1ptb1Y3eGpkODRhNTlMN0pxa2s1dExSRHQwK0pBQ0loN3VaejN6Rm13?=
 =?utf-8?B?K0RnWTBvbEV3Y0ZreWU1RFdZcHJHRDhJbEs3clhiNnNHeVl4a3NmRTBVWUFW?=
 =?utf-8?B?OGxsNXVDR2d3cEpRUGNjV3QxY0FtNzhBdGdMUVUxMDc3YjVKbUdNWFA4N1U2?=
 =?utf-8?B?WmM1Y24vREhQeTBxMlhsdXBsRk9GUGVyZk1VdlprYitRUkxldklqUmdnNEtR?=
 =?utf-8?B?bFgyV01GZVFCSWlXQkVTbStFeXJEU3o4Z1NCYXNFU1I4aEl0eDBabmdudWJY?=
 =?utf-8?B?TythRmgwVi9vVUNYZ01WUE4veUFYREttRnJOa3piNGZIMElNYnllZjNaUmg1?=
 =?utf-8?B?RzNraXRhc0g5Z2p2Wm44U01vN050aFpRRzU2UE9FZEtBNW15RUdmYlRGOE9v?=
 =?utf-8?B?d1djWlBYQ0xmU0FicDFsNmpnOUpjbDdQQ2ppTnAzcjlIYkdTaVVzZk9iZ3lz?=
 =?utf-8?B?MkJteGZ6Y0xwalBTMVJZT2FzdFR6OHcxZWhCaS9WOW1mQVZacU1ubTZWU00y?=
 =?utf-8?B?TWhqNUZJMEZxYmNQc0R5dHNucm9oaS9kMEgxd0dvRlprR2hxdk1NNVVtVDhP?=
 =?utf-8?B?RE9vL1BMMHBia2lYS2NvSmNyN3FwSko5aXBoZlhWeHJ2YVhIMEM4VEpJa3Y3?=
 =?utf-8?B?d0dwME5TZlRWWGxjdVFPQWxFYkYyWnV6NzU0SUZXa3NIQU9qblpkWkswb3lS?=
 =?utf-8?B?T29LQmpBTnBUQlYrRmhXWUI0R3QwZ3c1anhQU0VIaVpydndRVElKR3l6V2Na?=
 =?utf-8?B?SVFVVHlvZ3Zsd3U5dXljWWcvbWhpZyt0V05oNVlYU3NDSWorL29hNTVXWW9U?=
 =?utf-8?B?Z29qSGVtd0Rjei9aZjZoWWd1OEc0aVAvZnpIZGxyekFyYVRUVldyVWhNKzRC?=
 =?utf-8?B?U2h5TXhSWkp2NlZ0UkZlbjBjbGdtTHJGK0hmdndUVnhVcTg0Z1V6SWh6SEhK?=
 =?utf-8?B?b3FKN2RlSFE2Z2g2bERiNmRlVHI5MzZORDY2M3dXL1ArblRPOC9jODJJYy9a?=
 =?utf-8?B?eVdkWDVXSUk4RmE1WERMTnBGblNzWmExNXl0b1ZyNlFRT3FhNytROWlvQStx?=
 =?utf-8?B?dDVZTFd3R081VEkzVGpMM1FGOEQ4bXBJbGlPUitSYms0TFZIZ1hMSU1TY3Ay?=
 =?utf-8?B?K0NuaFFUUzBxTDBmZEE2V1h0RExwTzh6ZWlPRk9ZbGYvM1M1M2NlcSsrYllB?=
 =?utf-8?B?alorTnR6ek1WamhPZ21vQTU4R2Y4ZzF6SEtqTk9WdkQ5cDBRK2d5UldhQnBS?=
 =?utf-8?B?Tng1a1RuS0tPR1phQUx6RndjRjJGOHp5TmVaVE1jUFZ6alkwS2JQSVBvS1d0?=
 =?utf-8?B?ai9jck10QTBwQ3poazhSNXE0ejY0aUVsUjFmb1Fra0dPWVhUdTZYSVh6ZmNm?=
 =?utf-8?B?U3RwS3kyNS90MDZpUU04dmVyTjR0V1NkUVVXVUc3ODBkWWxFVlJ0ZlEyUTZ3?=
 =?utf-8?Q?NCs+dZmFf5xzjw6aseLwHngvTIDXwnCT?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;6:YajnLqVF+z21BqWJhrhUciZyoEmU+jzRGtVlTSOFsmv87EuP2lHNNhB4ftuOaGo7+odCRbwm6Rv5O4tDLF+ctGWOptt14CUrxWODZsAqXlvXzYEoKGEaXDDwvyYUzaJE3YEsmfqNME0ZktH//lqosqngn7ptcOI3jPW5oXt3rBBhmD5I5o/cIAYkFNppjdP5bUhOeAjuEF+38Ihd73dtPmVxGapVoCvNYe+2foEhvOUr9FSh5mWpZ3UcDCavl+y89KzooIaBRk1cJmSFeYzjq3a2W2+4TmmfOmKf2dqiiWr4lwLcpAtGrOo5f8CO2mS8PcG6yktFsaeCIFsoFT93/RUt+KBIEuRpDMcjgFVVWvg=;5:ii8Ntvqebd3v3twALE+nQ5RGKYS2KpPZ0lJhlK7GAjhBGAEjVgi4Piiqah94cv16iEeeE6Lb+FIX5XlrsNtyljmd5cVQgVHmEAnyeky945Ghs8PoCSO24F07HymPEDGz5TRO+s6aNHQzb7decFIEYL5bIYaM3ZWAwdO3B9xUKOE=;24:WcWImRtlXaFrHP9sOntSpskT0x6nGN8uCAkJox1u55UwHockxw5IIUhmt/LcbHITFxebFWeGvviFZ5+afm94NAOEqLskAUBcaZApU/Gp6Io=;7:wX2geml3jTx9IjV+a9QEG6OY1rh1dV3NUDnvyUgWA6DwqF2IVpVi8yCNOuaVu6ISK5TMe7TVZ2OTJkCcUBei6yy5EHmfcV9J0lMOGDc08BAA1ohyU20HxbImkl0paX59rEvs2jRAZzgJMf4ntxkqbGPoleiduO763e35Gtbn/ep7aVWis/DyHTBh29JsZZANiCit/Vg/uZB5dwwad9ScYgeMuynXknKFA0phkoJX/+mySL2YqATyoWiV3H97Fb41
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2018 18:11:28.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204b2b0b-79c5-4612-7bb2-08d55467bdf2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3493
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61918
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

On 01/02/2018 03:31 AM, Matt Redfearn wrote:
> Currently the bits to be set in the watchhi register in addition to that
> requested by the user is defined inline for each register. To avoid
> this, define the bits once and or that in for each register.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Looks like a good cleanup/simplification...

Acked-by: David Daney <david.daney@cavium.com>

> ---
> 
>   arch/mips/kernel/watch.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 19fcab7348b1..329d2209521d 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -18,27 +18,24 @@
>   void mips_install_watch_registers(struct task_struct *t)
>   {
>   	struct mips3264_watch_reg_state *watches = &t->thread.watch.mips3264;
> +	unsigned int watchhi = MIPS_WATCHHI_G |		/* Trap all ASIDs */
> +			       MIPS_WATCHHI_IRW;	/* Clear result bits */
> +
>   	switch (current_cpu_data.watch_reg_use_cnt) {
>   	default:
>   		BUG();
>   	case 4:
>   		write_c0_watchlo3(watches->watchlo[3]);
> -		/* Write 1 to the I, R, and W bits to clear them, and
> -		   1 to G so all ASIDs are trapped. */
> -		write_c0_watchhi3(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[3]);
> +		write_c0_watchhi3(watchhi | watches->watchhi[3]);
>   	case 3:
>   		write_c0_watchlo2(watches->watchlo[2]);
> -		write_c0_watchhi2(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[2]);
> +		write_c0_watchhi2(watchhi | watches->watchhi[2]);
>   	case 2:
>   		write_c0_watchlo1(watches->watchlo[1]);
> -		write_c0_watchhi1(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[1]);
> +		write_c0_watchhi1(watchhi | watches->watchhi[1]);
>   	case 1:
>   		write_c0_watchlo0(watches->watchlo[0]);
> -		write_c0_watchhi0(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
> -				  watches->watchhi[0]);
> +		write_c0_watchhi0(watchhi | watches->watchhi[0]);
>   	}
>   }
>   
> 
