Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 19:03:55 +0100 (CET)
Received: from mail-by2on0086.outbound.protection.outlook.com ([207.46.100.86]:36256
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012139AbcBCSDwkV-qz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2016 19:03:52 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143) with Microsoft SMTP
 Server (TLS) id 15.1.396.15; Wed, 3 Feb 2016 18:03:43 +0000
Message-ID: <56B240FD.4090400@caviumnetworks.com>
Date:   Wed, 3 Feb 2016 10:03:41 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     <david.daney@cavium.com>, <janne.huttunen@nokia.com>,
        <aaro.koskinen@nokia.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: Octeon: Add Octeon III CN7xxx interface detection
References: <1454522496-35794-1-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1454522496-35794-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0030.namprd07.prod.outlook.com (10.141.52.158) To
 DM3PR07MB2137.namprd07.prod.outlook.com (25.164.4.143)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;2:QuYDzI/HBdUfHKzZjGNPRx4cpZRpJw/TRvbwMtL6YyLg8iAXdthrhvz+0LsgYReLpTkAz9J1CIvYnrn6HE9qvAXQlJNQmyrr+vpzpysZD2+WbNwj01AMHDZkiROnfaDuCe3vCX1w4a++51bwen2FvA==;3:SWQccwrU3en+eC60kH0Qa8TasoGR7TsPtVF1B/+9NWl+8ioxmX4AbZlY12spQYDNXTQ8/RSO3eVx2BQb5af1Ll9qK3Ez5wEo5VPqchn5UZJZZSe2R6JwNNm+fg+HId1p;25:OiyOJ8aq5OLsY5ePmNyygGSghESLMCr6WcElYTpBSW5jSwFYkLq8kxmGqBUBcTvKm9sqJSBnvcScmeKngMOIsXaFh9iwdfXFZfSwsqg2e01vwL0PH78U7LtZU1Wr22YTEkYtGMOHI/oZuE7ms6Ry8Qo4hEapRTX2vUlt/8Tn+QD+04IPQw+RQc4NlQu3FP1rt7XVNmTt3W36hoMGbp0/fLTy+oOnfvaIajnwPNZww6cpaaTYwpA9h8Wj6oldhFXS
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-MS-Office365-Filtering-Correlation-Id: 6505907f-294e-4d2c-6cf8-08d32cc45b65
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;20:lGZqlcE/hZ9luZCNORYkJPv/D2eeAghDZXNb5blpipnWnWnejp1HaWp9vXcz0XITXRK1yFAqXTQPDRvSUOzCpC02IIQS4M/6R4tZTs822K5+POQSZhyqY1EBXMPQIvINaYhEujqnuhMFrp6MtRODEO2Tc4Mbdi4virV75rFwRree3ens5APRl865VoW5snayTujWOwPIH50Fh4ZKQ0wG7UfqvMggdHz2TBqLHfY8mMty9KCUIfYgHQZ7iCrWLMkcj3yjwsoquqW17apdOpxYtJydDGZyJQyjx/fvoDcvnHIOvmo26GEcHRqTXDjDb14m3qmuottW95yEvLOQi9QgF9qyPGHObXz4/LfRa5xYBlulRHv2JBnFvTyhRVNDZo9blRwCMVMdXSY8eCQ5rYacKg40kJSPY6AM+DZVqPQ0zwU3Uq/7kIh1mK/mm0VoTL/s4dvuFRcfDutSanhvtWYsV+RzwB6pXVwXpBLq0zIUYoKcnDfReDKKGZazzJkgVB8vOjg4kl2mJaKzVZEV4bl7EGxrkNRpiMRlOH6WYx/ZdZsss/fukrc9EqExnNeqbPHcURVhu/m1CZcc+TS8UYXAjp5qPku6GFTL7IOllwP34Rw=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213748449F81C7DC7C36CACC9AD00@DM3PR07MB2137.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:DM3PR07MB2137;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;4:N5LDQZy35kzPuS4DyAdLZ2sakf3bnrmzOatY3G3RkzmpQqf7OuhfPgJ8M11m/pfNN0ZBue2xkFOhyFcKQJo2tJR3yWFvkHlmPwz2UOAHAWszIc4URLYuFq2HPfGl5AtLzUtuA2/UyYdfqG7Oh9WbBY44Ee6+FMqxNJTdAWja2Xp11oDJADuG22wg7wCObwnziBGUDERw5Pp58ZSpnH/72Nym99JnRW2WdL9HVOHjkpxA4utslUH8jtpSUjfJFcZPM8f0qogXZ8zChn8KtLjyaqcUfSWZy1c+C/Not5WzEuFFYBk1oUfaGh9xFseGsIAf2C5niN4gPNymiWNZXZQbYDZ8yqN3JePysNxnDf8/MBAUq4X3TRyah052347BCfKN
X-Forefront-PRVS: 08417837C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(24454002)(377454003)(54356999)(76176999)(65956001)(5008740100001)(65806001)(1096002)(65816999)(2906002)(33656002)(87266999)(92566002)(66066001)(189998001)(36756003)(50986999)(122386002)(3846002)(5001960100002)(5004730100002)(110136002)(6116002)(586003)(42186005)(2870700001)(53416004)(19580395003)(4001350100001)(50466002)(19580405001)(4326007)(77096005)(47776003)(87976001)(64126003)(83506001)(2950100001)(80316001)(23676002)(40100003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2137;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjA3TUIyMTM3OzIzOnlaTGNlcHFlSm9WbWFQMWt6OHJHK0NSWEVw?=
 =?utf-8?B?clVETHZFV25MVWYxNGlKL2JZWk9nT0paWVJPQUtlSEk1RFRwdW54UEw5N2M0?=
 =?utf-8?B?UFNhWkpqZTlzQ1FsdGNIQjN0OE1ML3R6S2QvOWo1ZG5ZQURzcmRqdkEwYXIy?=
 =?utf-8?B?N1g1WEM5TE92TmlQTjhKRVllR2RvZytKeHpBU2EzcFAzem45N0ZKQWFieVZi?=
 =?utf-8?B?Mm1vVGdnTnJkUUEweUt4a0hYVE91aHh0T3Y0VzFsakFFNW9TZUtGMFlKblFU?=
 =?utf-8?B?eUtnQWVYOHNaSVpmVE52T0RiSlRDeXEyZ1pSUzhIR0JRaUs5eEk1MG15aXRo?=
 =?utf-8?B?am1wajlGdGRvbjBBeHU5cDZET1A4SW9meEhxZ3k4TmZMd0RBSGF5bzRESUdG?=
 =?utf-8?B?Z25Ec1RQSUcvNFh6T0luM0dLbXJmMWZOZVk2NDlzWTg3WGIyZzZZa0pGN2hV?=
 =?utf-8?B?NFo1RGxpb1M2eHhXdDlvSE9XTWNNaEZwTUd0c1pSNERaUU5TNy9lZGtVcjRC?=
 =?utf-8?B?RkNkWTFoOVpKVThla1NXMVBmZWpKNkprRFE3eTdZeUE2Q1l2ZHFVR09uSUNP?=
 =?utf-8?B?UFZBZGRLTHU5NytRTW45S0VMQU13OC9wYndvK2hMbnpoRGpUZzMwb21TQUlP?=
 =?utf-8?B?czk4Y1VHVFN4ZjJteWJMYWVvWFpIZ1ErcUp2dkVOR1FQYTByYnBzQXlyQThv?=
 =?utf-8?B?bDl6L3g2dGNTYkJnREd3TjNFeEVKeEJkS2hOakVxeUJsczd4TFJzcHhOakRq?=
 =?utf-8?B?bWhSZElOaExPdXhzcHBSMGhIaDZIS1NpY3dFREhOcnRlL2FvaGJEZWMySFl1?=
 =?utf-8?B?YzVnVlBsbk9MMlBGaWVONU1qV0hWaDZVcEM0U1FQcEoxY2NhTVdpUzBuVlJ0?=
 =?utf-8?B?WkNnQWREV1ZhT2VWN0RNdmlBUDV3cFFNc2tva2VCc3BTSHdIaDlkTVJha3hH?=
 =?utf-8?B?VExCNUZYWFdZU0swcEhhSE5wTzMweFQzYnJ6ZXBJY1liYnlUa2MzNFJUZ3J1?=
 =?utf-8?B?SHZSY0hSclo4ZE81bzhJU1NadUFDMlh6UEI3cFJJU1NUTXpGbDg3UHZkSWYy?=
 =?utf-8?B?d0FlcU1TaFVMTk94bm4ybmI3bHdINFdFbGxBU0NNSTR4TjNROEJhb0pkSldN?=
 =?utf-8?B?eDc1YTlLZjdlc3RoeHlZU0RzaHd0RHF3YkV6WkJnRWRaRkxOSFZLcmo3MjM1?=
 =?utf-8?B?cE9FUVR2S2J4dnQ5V2VaaE9HYlFWREp0RjNucVZ6WCtFeTdob2dJbmRTb1dV?=
 =?utf-8?B?UGdNTitWbWliaVgrQ1d3ZGlCeHpuTWZvdDlwR0N0eDNQQmlOMm54YmpHendD?=
 =?utf-8?B?aGJYRVlmaW1qZkZuYUsxSExGR015Q1ozRnNUS2k5dWlRYnBNMXlxVndldVBR?=
 =?utf-8?B?c3p0VFBPVExEU0c2R1UwcjkxV0lKTmVHOW1yekFQQWdZU3RmVXcyNDcrYldG?=
 =?utf-8?B?ZWx5d0tHK1hIWTY5aEdlTWordTM2R3FYY24veGVPM3g5L0poMjNZcjRVbkxD?=
 =?utf-8?B?a2JrRFZiYzk1eEd2YUNuWUY5ejZKNWFmSDFJZG90RXVJU3o4aUhyZ05GV3Rq?=
 =?utf-8?B?THFQNFhranMwb25vQUVxWnFtUG0rSlE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;5:SriTOeHc7w84zio2yRzx6+JHDZVV0F3kaOZUsiMmpu63zRfwECXy4UEeUOALUruli3gzuDA9tpxcTr+QQ6Eu9KbaI62jDxlQda0VTQO7e8ysBuJKOjE9NJ1muc3CYgv0WnUMUTwCdPatonwRfXD8Jg==;24:jGfrGzDR80jeSmvnZbvED0IO99hQVSSRf/0zZd4eCIwG1Q37nCZ92BWgNehHf8I8FUGIRSYjlo25yXw0mfVWJ4l1OxylG16RLniQTFEGlk0=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2016 18:03:43.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2137
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51710
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

On 02/03/2016 10:01 AM, Zubair Lutfullah Kakakhel wrote:
> Add basic CN7XXX interface detection.
>
> This allows the kernel to boot with ethernet working as it initializes
> the ethernet ports with SGMII instead of defaulting to RGMII routines.
>
> Tested on the utm8 from Rhino Labs with a CN7130.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: David Daney <david.daney@cavium.com>


>
> ---
> V1 -> V2
> - Rebase to v4.5-rc2
> - Used switch instead of too many if-else.
> - Change subject from XXX to xxx as lkml bounced the mail..  ¯\_(ツ)_/¯
> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 43 +++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index 376701f..ff26d02 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -87,6 +87,8 @@ int cvmx_helper_get_number_of_interfaces(void)
>   		return 9;
>   	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
>   		return 4;
> +	if (OCTEON_IS_MODEL(OCTEON_CN7XXX))
> +		return 5;
>   	else
>   		return 3;
>   }
> @@ -260,6 +262,41 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
>   }
>
>   /**
> + * @INTERNAL
> + * Return interface mode for CN7XXX.
> + */
> +static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int interface)
> +{
> +	union cvmx_gmxx_inf_mode mode;
> +
> +	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
> +
> +	switch (interface) {
> +	case 0:
> +	case 1:
> +		switch (mode.cn68xx.mode) {
> +		case 0:
> +			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
> +		case 1:
> +		case 2:
> +			return CVMX_HELPER_INTERFACE_MODE_SGMII;
> +		case 3:
> +			return CVMX_HELPER_INTERFACE_MODE_XAUI;
> +		default:
> +			return CVMX_HELPER_INTERFACE_MODE_SGMII;
> +		}
> +	case 2:
> +		return CVMX_HELPER_INTERFACE_MODE_NPI;
> +	case 3:
> +		return CVMX_HELPER_INTERFACE_MODE_LOOP;
> +	case 4:
> +		return CVMX_HELPER_INTERFACE_MODE_RGMII;
> +	default:
> +		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
> +	}
> +}
> +
> +/**
>    * Get the operating mode of an interface. Depending on the Octeon
>    * chip and configuration, this function returns an enumeration
>    * of the type of packet I/O supported by an interface.
> @@ -278,6 +315,12 @@ cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
>   		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
>
>   	/*
> +	 * OCTEON III models
> +	 */
> +	if (OCTEON_IS_MODEL(OCTEON_CN7XXX))
> +		return __cvmx_get_mode_cn7xxx(interface);
> +
> +	/*
>   	 * Octeon II models
>   	 */
>   	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) || OCTEON_IS_MODEL(OCTEON_CNF71XX))
>
