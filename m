Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 01:56:14 +0200 (CEST)
Received: from mail-bn1on0099.outbound.protection.outlook.com ([157.56.110.99]:45312
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012460AbbHEX4MEvpH1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Aug 2015 01:56:12 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR0701MB1725.namprd07.prod.outlook.com (10.163.21.14) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Wed, 5 Aug 2015 23:56:00 +0000
Message-ID: <55C2A28C.7000809@caviumnetworks.com>
Date:   Wed, 5 Aug 2015 16:55:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <dahi@linux.vnet.ibm.com>,
        <markos.chandras@imgtec.com>, <eunb.song@samsung.com>,
        <kumba@gentoo.org>
Subject: Re: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin> <20150805234936.20722.60927.stgit@ubuntu-yegoshin>
In-Reply-To: <20150805234936.20722.60927.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA009.namprd07.prod.outlook.com (10.255.174.26) To
 CY1PR0701MB1725.namprd07.prod.outlook.com (25.163.21.14)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1725;2:Dp9pcG06iwPKb9q7EVdKf9lt7jQV53k9/VSXrjkjx8e7IY44Cg1YEYWsSLwAjhhp/xNYA+aax0k/JJA/osS8ez8iAoUzpa4s0sXbC7eGfLYRZ2IwM6essegmvtNPs/t+UnwOTLHGpvt98PdrzkJwwhNTx4LM1IPlkh7J+fsTMyU=;3:YoqeXZw20A+unD4aW9MzAvYCG0qkfx1zHciv1YD+wxIvHH9G4B0OZ9gaIosRD7yjYhdNQl5nQYkNMj9xJMEI49uVNA9AoffgTm8YUfvmboBjgnKcpFm16B9+YOHxItEsy2yPEBm1HtDHJl+RI+ypiQ==;25:wv75ZvHS6y68YAhKn1zZFsdL1W9tVbSLYr4NMzyXHHw6gTjYB9sWZ96rghb9Bz1LmbPu1mqzXca4rySqD9rDM9o/c4b0y0wGMf5c4VIrUzOWso87wZzKmyHFPf77E1OheFKvb8RUNFds7muqtJWvyFIPDcUDRuz7AITjDsCTxgco3DuR1bplQx43K2iIImUK0JI+t9ZEK7aSgcrVQDojoP8ec7hYxrmws6xB0QuiX8dkhEKI8h46xo4CM5NdfNeEwGsLdINiAUZLCZuu0tEcZw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1725;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1725;20:7u2NfbcRADGyk9n3xPpHvgKsiZ8+eOd0Bw0SG2D/rgZHb8CL382BmxLoF6jEeVf/nq9Fv3OwQOg6WLD+VcBSjleVVQ634k9eB2MVQ/A+LsP8Pvi5lDzq8rrNmmXlf4pLnIIROZVVXg67YyQaajiR5l4zaXP9g8oJEXGQDF1ll4G/D3SvztiD91L3Ukb7HMUE9lgVD7BK6wR2iLbUI2HvRwe7Hh+ZYVW59d7s4m6CYcr986KsSXm55/7OJqwi2AFDfsP3vq1W1KstNQKzaE+mX2OrZXdn3wAANiqPEQgJbyouizBTI3j/ekeQNRyXp3AwEd6O2y5Mn/jO4wS3kNmh0sigMY9VQd8S9dScU3LJ/Z7+k3N+4sYlyBux2mIDILDDv+X7Z5aoFeHgWcRn/l2DP0XrNistwmqrv7ww/UrFLtjQ/jZl3MuFTUSrNBMBoAGnMqzokJbEr5/+EkG6+xP9suPDe8cjdSbTGUulPYieLTW1c43BaEe7Zrr18cOInIm+oN/Ahy8euj48jZJTT/ZwvwSPAJw1iD5NE64ucTpQkkovHDYAbSAlg5Mh3vKOhq9+tt0TcD8fBRy7jmbTu4a0d8XFitrmIE3s51oseBSD6sc=;4:YVNluMLKLEoa7q84iCVAvbp0bLACGvp7oKTD2itLWN71Z8q4LffzLxXYJdvXFFyhDHSno1Ru+pDn9kqOzrmua6Wk+PIibN46+StqrvSqohEXOI2N3SKR151+m3EN09qPbbep+ra4kYUA+bsBXbMQorrclv6qwI6RlmuqzOB7WgSOmL4ci692xhPPZ+ZaX1slMDIKpdY9vTvM5HM2EFSxpY9uHGyeYen7OBvJou46mgjeQe+T+18Bv8aYUCgTSHw+omjaqpM8w1cosPBPVIzlcVMH63XeQHadEHivmiWXn78=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB172543221B42353F6C3368C49A750@CY1PR0701MB1725.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:CY1PR0701MB1725;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1725;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(24454002)(189002)(479174004)(199003)(5001960100002)(77156002)(110136002)(54356999)(106356001)(65816999)(76176999)(4001540100001)(50986999)(97736004)(36756003)(87266999)(23676002)(92566002)(68736005)(64126003)(4001350100001)(2950100001)(77096005)(5001860100001)(5001830100001)(81156007)(122386002)(64706001)(40100003)(66066001)(69596002)(80316001)(19580405001)(83506001)(65806001)(65956001)(189998001)(105586002)(42186005)(53416004)(47776003)(50466002)(46102003)(101416001)(33656002)(19580395003)(59896002)(62966003)(87976001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1725;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjE3MjU7MjM6NzdyYWNJRk92UllxU2VUN0xCaTlSOG9E?=
 =?utf-8?B?VEpoWWZKWjl6dm00WmN3OHBXZG05WkxLaU9TYVcxWEFUVWx5VytLeFB2YWhk?=
 =?utf-8?B?TGtXRkZqZExKUUIwRElhOVp2djFqOWRMY1YzbjRCYXI0K3QwNWo5ZWFGNFk3?=
 =?utf-8?B?ODZ5aUxVUXNpWHRzcWg1YWY5MmxnckJrTDdJczFZSkk3ckROMG81UGY3S05q?=
 =?utf-8?B?VWRRdEJKNFFsVjNuaFBac3FXYytaSGNrZVM3YmZlb0VjQlRTak94Zm9iQitK?=
 =?utf-8?B?a1JCakhNeWlVR0c5VVFpU1E1emdORkZMUlZHSU4xQjM5czF6U2NEQWtMY09Z?=
 =?utf-8?B?SEJXK1FLTW1jek1IZFBPa0NxUnRSbjVHYzJmY2p6QlNjNldPbUxmZzJsMnda?=
 =?utf-8?B?RWEzN0tab0E0UGtPdjRsSDZhRDV2QWVpdnRWanhGNkQwNzN4OVBiTlRZeEt5?=
 =?utf-8?B?NkdiRUJ5c2c1WTVVZTYyYTJ4Tzl3TjM3cGVLVDVSK2VtVmtqQlZVN2thZDhS?=
 =?utf-8?B?R2Q5eFkreWRUMVJtSzN1dUlnSmJMU0lLZnVvek9MVzRwNzJ2T2p4UUJWZGJC?=
 =?utf-8?B?bFFhdGlGbk1EQ0tkNFFBR3lwUW1FZ2NOc0xlQ1hxcmNySkxQQW1ZZlZuM1ZR?=
 =?utf-8?B?R09lZlZ4cHIvN3o0ZWRUNTFSNWk3OTlDQW50YXlVY0l2RUN0UWVRcE1pVmlY?=
 =?utf-8?B?WFUyMzRuWHhJRFkzSFcyTVI1bzJvaGhPdGNSZ3RUY3YrQUF2UE1yQlM4ajRV?=
 =?utf-8?B?NzN5MjhqcFlURnB5WFlQTDhhdTA2ZXA5YTM5SnVWaUM4TVl5Qy9sRkxzWXNQ?=
 =?utf-8?B?OENpMVpEWGpIb3hsUGZqUmhDUkRSRy9mbDQwcTIySHU1enpMazN2ajkzZTNs?=
 =?utf-8?B?eldTT093TEZ3OUZINmtSM09yb3FZcC9XbkVlZ2E1bC9UcytDLzlOaVpyK2tI?=
 =?utf-8?B?UU0xVEZBekozTVlsUmNxWTM1SzQ3UW1VTUU4QTlDZk5iSUhmZlJ5T2JvaHU0?=
 =?utf-8?B?LzYrMkN6VWpEbjMrczAxSURTNmNaT3ZDeE1yK2lsMUZjenE4Y2NXMW12WE1O?=
 =?utf-8?B?dU5uMHVpejlabXR5QVRsdjJBaEFxYVBFejZLZ2I2d0ZTd1hmTWZzVmluNTJa?=
 =?utf-8?B?SkVHWkljR29ubWhmWkYzK09ySFNYTGF4dHZGaVFPZ3h0ajY2SlBESHAyMDBL?=
 =?utf-8?B?TlZVandUdE9EQ2M5WHZhUjY1R2EyU29kM1lub1JJV0RzMXl2dThNTlV1bHg0?=
 =?utf-8?B?T0U4NGJZZ2czQjczYTJxbXhGSTBraHVIcFU2VmE5eWkxZkFQYmJKNUZzZklP?=
 =?utf-8?B?aHRzQ0xLZ2l4UTlGK1VKMHV0NktWcTYrRFY1M3JHa09Tb3grS1ZGNFlPdW5I?=
 =?utf-8?B?eVFnb2VSeXZuallhMFkvSVo3Q0Q5Rm9EUm9DKzk2T0V1SnhKM3JYNmx5UklI?=
 =?utf-8?B?WkxJRHp5NEtNYXRaSnFnRWdtYlJXajlyTWVuak4xajlrd296V3UyK0FpVVNu?=
 =?utf-8?B?VkJtQzI3MnNQSFhqdmZQaFByeFlGcDV6YTQzNDNVM0NWQmdnYkgySEY4dTYy?=
 =?utf-8?B?SFJOaHVBRXgrTzVpSkJQb3ByUlZDMHk3NldKZFc2YnVSTk5KblJKUmR2QWt0?=
 =?utf-8?B?ZVdiM3RKTjVraFBuaGRjaStLdHVDY3VkN3FtUTNMRGV3d0s2TDAxbTdGWS9V?=
 =?utf-8?B?TitLZkg2RUlpWTluWFlkMnZRVVJ0Y2F0Q0lYU0Z2MFZIOGRleEw0SExIV3hM?=
 =?utf-8?Q?Z0HlQ4FT3qNR5KuST0sivF5X2+ABvcEceCQ8g/8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1725;5:3MFHtZt6zKffINYLXHtcUgSWaV4sBUespuK20RDL+HXh0gNJzn+VAXMG6EY59EqyHMqK895JcPTmvRWXSFB/JTTXzWDvTwGbLTuxjqOk75xiPwiqXNgbYxcVR95V1q3OXWNDDbGo1vDkGqW+wK9LYQ==;24:nBh8N81LdlUat3GoiNco7k87xiqKFKOWKbVFBUl+ktoO6qneojRI6DSyKuFs0ey0uL7rfrkTZkJP6fuPFNO9ju24LN5I45UIk54OBWMqqLU=;20:cxAZQJ/ZXYvUwkBdykgiVhRLD58L/FjXw1myhUU3mCSMJF4cqqsdAHCyuLTFRZrHidL22/uFnj6KH9E6rCM01g==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2015 23:56:00.4142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1725
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48634
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

On 08/05/2015 04:49 PM, Leonid Yegoshin wrote:
> This is a last step of 3 patches which shift FPU emulation out of
> stack into protected area. So, it disables a default executable stack.
>

NAK.

You cannot change the default.

If you want a non-executable stack, the program has to request it with 
the proper annotations in its ELF file.

David Daney.


> Additionally, it sets a default data area non-executable protection.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>   arch/mips/include/asm/page.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 89dd7fed1a57..0b6cec4a1b80 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -228,7 +228,7 @@ extern int __virt_addr_valid(const volatile void *kaddr);
>   #define virt_addr_valid(kaddr)						\
>   	__virt_addr_valid((const volatile void *) (kaddr))
>
> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
>   				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
>   #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>
