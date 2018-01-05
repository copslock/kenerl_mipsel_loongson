Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:12:11 +0100 (CET)
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:29216
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992916AbeAESL77VUU8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 19:11:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E59iCSih8pmyQtP/54l9n/rrXGy2ryG/62+MMORkXEQ=;
 b=bu8Y2bLyW5zQQgSEn4lPsgT/4bNLMVUkJw7k3b0/0Jl82m0bAso0eXiYItdHokBUzPl42WyEtmSf0PZaKbwQ54nr8JAu+QAa3xjnw0SX7hL7G5i9OLl/z6uV9uLSEo1lh1iVpt3GejZy85RHTM0JiD0p5b5ywWAeaAFbi/Ol7eU=
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.14; Fri, 5 Jan 2018 18:11:49 +0000
Subject: Re: [PATCH 2/2] MIPS: Watch: Avoid duplication of bits in
 mips_read_watch_registers
To:     Matt Redfearn <matt.redfearn@mips.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1514892682-30328-1-git-send-email-matt.redfearn@mips.com>
 <1514892682-30328-2-git-send-email-matt.redfearn@mips.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <eaeae3ba-11d7-778c-e536-6a086a6ade6f@caviumnetworks.com>
Date:   Fri, 5 Jan 2018 10:11:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1514892682-30328-2-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0050.namprd07.prod.outlook.com (10.163.126.18)
 To DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c27e94b6-259d-4445-73ed-08d55467ca63
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:DM5PR07MB3498;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;3:Cz9LwurQnrtG9ppVOA2P/zqFuQVygPnSVHvIzJ9EjzMrdaUSiBJMh+VAIxrdHkUP6v3Z64xJPDlXVoV/jWjNzzb9ll8FYa+rKiPyPdKvD4cgXrg/zoDIDWRCNGqXcU0/sOKyOeDSZXrKXG7uOGntS8+aqMEMIQjbX46+9Iq5KntpzTrM9e33XiFN5d/s7tsd0zi5daM8Jnt0rxmYOXPhGvTVt2IiZFTJgVPzaigZMHW0uR2meyAaU7vPWvT8PNDl;25:NDc2T+PD+Gxfw2MyDGcuVOvyzl9Ba+z2KjYNzBREOVVcMRrcr3w3tAW8bkX94LdjG+G2rhN3m2Og6kfuLuIX1/+r+WTga/XlYT9fnEywpg+CbKY9GF8bB728OhkTMSAlTEfxbxX6L3lDrXj1NMxnWT4T0T9UPk2e8OcTahebBW2qskHeG2suK11nxXSssh0KgaQRHTo/PUoqbew+LRWdOdAYDqxZNR10lg7KviZPYZekIJEj7evKm/3izvMX0TMxEXgHZuOsGmFpWmbAkU1p1v3N9gtR7krfb8YCYS1Df1qMhQ2tgYRQHIGVyVa8aqc1pRlu2ESwcFHMI0xDHOx7Mg==;31:fdlGSgl52+YAsgyR886u30ZlD2EaPY5haJk6CQZwb0YYqptfX9HpXNUP2VVlvFAP5vadrbspn9wmec90tLgcna9U9WyqeDk05dO6L+xijjUPMougE79aBMAQvsNOxXVyFd5Vec6JynWccA1zKXiiyrZFo0lzCU+GmYjMlZi7KuG6L7vYSRegLnWikBu7T3z6xJBvuIr21bCRcZoRvTGVDda3M1AdlstGAreYx7k3C80=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3498:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;20:eEMFCEAOoRz5nwoO6ay6IkxPUb/lA9ihnu9hTBmsbZ9qBD8TbwUCb1xlJCOCsJt7JmckOIScG5V0h8ygQbCx3zX2Ln6RRiy5TWM25YgAzCnjJ4B85lol9ivLZLIdaXWaFH1wKAUKNzKwN5e8VJegb/vKA5LbCFAQrASS4PpHxS5Ul1kPudZPR5UdXo5jrUiGTBxvjhBIsg6rQHVv9hKO9pftj6TqKoV9u+uRqag90JErhjM5oU2jc2FFqzJtf1BF1XLXSPqsZBJeSmzDZyucXrGEFNHzyN+15p1h2XIU3zQtoqa2Ql2DsEnOnMmzZAnEOysYnhGPoehWl8OKXYBK1g2gPj8KL+GQVp248rtvZAko+f+2nv2PDlLHUcvvmixahcHiZtwO8lC/y7LNrBFOH7AodfZF6OFrWvxclXOQY3uT45aCJnfIRbA1jjJGRFwiMt9m+3cKjTSvfvt1kS7ZiJvHkp5E1u6uR0DX1ZAdV8Y/JTBqLH6BkE1CPoDfH3sBjQQRZPHlstZPc0CVULT2wglPwuymNOuI/fpaV+yYkeuTvY19j4J7uSt2zF0i3Cf62Md342B23jt7wUSv44RlKOwiYAqbK/EPaye+COE4bYs=;4:DIJkUM4rRXOglvi4fY2gNXX62Qn6fNlbS65r9xBupCOMhKz9yXx/I/WW9BB3BpoaeqYZne6zq+cMYsTVluvb2udRxdWVm5Pe6Y3ZM7vRJlg96jQQIYYRJ7uWkkfXOraVURXDNV7600XkH72eDsU4U72dw4dYL6q76dtCFqCb37GEN7ROfRug6/TCjrqxXtPtJPHTGBTrAVuY7XQ4MoDtT1vXX5GMqNZ7dUySa4soD1yordRuq9/yQn7FERi/+0y36z7QKarzhqpwSU30tvc5fA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB34989B6EA5FBACCCD8321BBC971C0@DM5PR07MB3498.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231023)(944501075)(10201501046)(6041268)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3498;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3498;
X-Forefront-PRVS: 05437568AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(24454002)(42882006)(478600001)(68736007)(72206003)(31686004)(2906002)(50466002)(53416004)(53936002)(230700001)(69596002)(58126008)(65956001)(16526018)(66066001)(5660300001)(65806001)(83506002)(386003)(97736004)(2950100002)(4326008)(25786009)(53546011)(31696002)(65826007)(6506007)(6666003)(3846002)(6116002)(47776003)(316002)(305945005)(36756003)(81166006)(81156014)(8676002)(52116002)(23676004)(2486003)(52146003)(6486002)(6512007)(76176011)(105586002)(106356001)(64126003)(6246003)(7736002)(229853002)(67846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3498;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk4OzIzOlkrUDdKeHAxcm1qMkZUQlQ1NFZmcmhPeHEx?=
 =?utf-8?B?OGtkZHBUb3NKdGVQTGpCd1V1UGpGVXczSzZZUEMvVTYzb21LNXZQWkRRWk5N?=
 =?utf-8?B?YkMrUGZZY3hUTS9YVytzZGcxQTUzTnh6dEdzTlJUckM4RVY0d1hHUUdwK2lq?=
 =?utf-8?B?ZXZMTTlSNGFmY1FRalp2bkZFNEVyTDIxNU8xWmN5ZlJQR2FFYm9ETWVrYUh2?=
 =?utf-8?B?Wld5NGw4TXMySEQ0Vm5wbm91MnZZejNjUnJNMW8yeVBZU29LelFQdFd5b0lq?=
 =?utf-8?B?UStKZVE4TnhHN1Zld3loMzJHNHhrOXFLYllJMlV2WWkyMkJubllucXovQ1hl?=
 =?utf-8?B?SVVqM2N6U2pPeUU4MHFJbncwSGZBZ1k1bTJ3eXAzeHp6Uy9hUGVBTFVlemt6?=
 =?utf-8?B?aUxOVGJBSTFXZm4rbk00ZnVYVFFxV3FJK1NiZzVqd0s0Mkt6Y3Rkb1NPbnlh?=
 =?utf-8?B?NXorRWM1MCtQUHBvQUQydVJ0LzEvQUx5Qk5LVno5K2E2K0JpaHJNaE43cnB5?=
 =?utf-8?B?TDNhajRxbnQzV2NFN2NFZCtBcC92QmY2bEViTktFVEM5NWJ2alFDZDJEdXZz?=
 =?utf-8?B?d1crNUI5c2lHSC9kOUZIYlo3RXJhUGtsaE9aWDhiaFBrUmxpcjhFNnYzNnZ2?=
 =?utf-8?B?bFVoSW9IZzNmZFIxV01kY241Z0lxdStZK2h4Z1FrR2pUMGd5OEdCUUd1MVJV?=
 =?utf-8?B?eDh0NWRhZE9wSEdscFFJWng0T2h4bFE1U0pSWENraldhRkVJZWdUWjhOQWR6?=
 =?utf-8?B?L1F4bE5yaHBKOG15aVpQdFgwaVlMcXZwRTZER3lRY0twL0l4ZEc0WDN6ejBT?=
 =?utf-8?B?SE9NQkUyK1BYM3c2S3Zqa0d1clNCWVlEL2N4UDYwTSs1c1oyazdhNUtNd1Iy?=
 =?utf-8?B?NTBNazVuZHkxa3JRMnhtTlhLZjdtTEV6MGV3a2dUT2ZwemE2b1JiaXNPWnBD?=
 =?utf-8?B?bHVVSFRHMmlVWnluUmZjb0x1clYyVUxHbklzS2lDQWN1QzdFMU9nNGpnSnFm?=
 =?utf-8?B?YWxtNHlZcEVSOGFEWUR6R1RZS0xOZ0dudmFjK244WC9rZnFUWDRtYU5nZVc4?=
 =?utf-8?B?MmIyYlhnZXJlcm9CbUd2R1lDYkJ2QU81S0xmM2RlaEhhLzFkcGE0WXVoMVNm?=
 =?utf-8?B?NGI5dUtNSXo2dndnSkozUkszai9xWnk3UUtQSjJyb2hmbGtzSlhrNVVUV01T?=
 =?utf-8?B?RThOeGhzL2tSeWdLUk5BbFRmYWJpOUlHbHJYaFY0YkEwUStXZmNzYlk5YnA1?=
 =?utf-8?B?V2RPRUJTWnVLT2dxU2ZBZ0dMekpIcnBkWlZuUFhBL2lFZklaUWdxWXl1TDI4?=
 =?utf-8?B?L21PdUZ4T0xGVlRNSGxuWkdSSVVXZnE0U1p1MUI3WVhQeHpFMzRoZ201QWlV?=
 =?utf-8?B?TWE4NDJ5YU9pejdwMG5LZm1qNE1wbGZKamE4aXhyZGhWaGcrdnY5RjJUZDM0?=
 =?utf-8?B?SUJQd0VwZDdneGxhbEMvQjAvMTRERXNmekRyeVpyZEsvWGVodnVCTGQxOUww?=
 =?utf-8?B?dGZJeVJOQXcrcHZIcWF1ZllDem9UVUx0dzhpdVp0TVR5eWhlVnIzaktPV0Ix?=
 =?utf-8?B?TzNGYXZFVytxYVpGUmxEOFNqLzdlNWh4SWNHTzhicVIweUxrVXBKaElTeDFM?=
 =?utf-8?B?dVhXWTJiU01zTElwU0wrNVBwOUJqK3Z3OVFUMDFHZWVaZzRMczFKUy9hN2Fy?=
 =?utf-8?B?eHJGYmd3dDE5NVNMZkhHSlZjMHdSbWVJbHY2a3I5cHJ3Ukp1ckh1N2g2bkhX?=
 =?utf-8?B?QmkvR2FmMEp2SnNIOU5HZVdkWERyRFBCUEJhVm1vam1IZ1FiTmYwQ3FqcGlr?=
 =?utf-8?B?cllBeHVHdzB2ai9FQ0diclAwYzdpeURTMUsrTVJOd0RBQVhXaC9hbGRtWEY3?=
 =?utf-8?Q?mDnRkhNe0B27efpgNF5HuVbKmvN10H6J?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;6:ypHesCF2Fhcy8wWQg9L4grHx8f0jAc60ADT0g1k1DFajv047vLfbZNDFm1HirZcaNnpLOgYA+rp/ypioyPClIOe8k49ME/S7aJAWZwoK+KM/8puxnzQufCsIiLg692XznXrHhe+PZwCqIJkXt5Me27YYgs7d/wzcDfkz47TMwgj0QuAL7KuVbkrOpCNWjLGmsk0UBsxSn4KhLavduWL3srRn1TgroYPMNoDSm1ImJixJiu9LbXgtl9RfNIFXA1Q7WJymqpohQPz/S2SiBGRgS2+uQx249DMa1M4SKr/42frIm1ltdPMSMr+1DacihP589kg/FpnsOawWMe9r2kPTcxDvl0G3TzV6O4sZlElaJBQ=;5:NS+M8pxD3F69WdiQUlUvLy7SMzA/rMXjzNrJJwKqOSl1/QcMWECNBLZzJJ7sYIOwBfLcbVxwrX5yvL1KvYVQ7Rv+7CwrLQ6Vot4RDOEs9ueHwnDsEMxVE1G49ShiuntNtdj5NdNrcW8mu4HdWoAl9HiCybKk9rrIk6TRylK89dw=;24:aVFmKQJ2rX6ECt8YuDSrgIqhL0lP2NoHFBS7jGkIImD5mxuz/p5aqg6eT6kip2hrpPN7a60npe2ZwJjDdyUkrVKhkJv6tujcjaAGX2xHF0I=;7:kGIkzUxUuAJlGYOVL5aFtNcbVZTKYgIeb27g/DAUoldBiC/0l51Ir8NzAxQCKr4tLKCeIv1ocZMJtZpD6lKcQPujW9IodZ1+50eVinCRexYTN1WLRQrC7WnMZBCWp2dSARoTHt8H4Tj/5U84Y3R7w5mj4hqf/MAbLdOF9cZa8gIKEeuBpQgpL08PVHgVg1va+4nGJbkLLYfEifA1dTi9zg+315KzE0zLKO8DxjayqeTMHDZdX1vRSdZ4nlxkzDSd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2018 18:11:49.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27e94b6-259d-4445-73ed-08d55467ca63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3498
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61919
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
> Currently the bits to be masked when watchhi is read is defined inline
> for each register. To avoid this, define the bits once and mask each
> register with that value.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Acked-by: David Daney <david.daney@cavium.com>


> ---
> 
>   arch/mips/kernel/watch.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 329d2209521d..0e61a5b7647f 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -48,21 +48,19 @@ void mips_read_watch_registers(void)
>   {
>   	struct mips3264_watch_reg_state *watches =
>   		&current->thread.watch.mips3264;
> +	unsigned int watchhi_mask = MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW;
> +
>   	switch (current_cpu_data.watch_reg_use_cnt) {
>   	default:
>   		BUG();
>   	case 4:
> -		watches->watchhi[3] = (read_c0_watchhi3() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[3] = (read_c0_watchhi3() & watchhi_mask);
>   	case 3:
> -		watches->watchhi[2] = (read_c0_watchhi2() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[2] = (read_c0_watchhi2() & watchhi_mask);
>   	case 2:
> -		watches->watchhi[1] = (read_c0_watchhi1() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[1] = (read_c0_watchhi1() & watchhi_mask);
>   	case 1:
> -		watches->watchhi[0] = (read_c0_watchhi0() &
> -				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
> +		watches->watchhi[0] = (read_c0_watchhi0() & watchhi_mask);
>   	}
>   	if (current_cpu_data.watch_reg_use_cnt == 1 &&
>   	    (watches->watchhi[0] & MIPS_WATCHHI_IRW) == 0) {
> 
