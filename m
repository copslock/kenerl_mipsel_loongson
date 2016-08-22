Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 00:56:08 +0200 (CEST)
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:12016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992227AbcHVW4A1ohoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Aug 2016 00:56:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+c5hDrswWKnWcx3yH8MEmRFZSQRRGAEeHjvarZObNrM=;
 b=eu9zDnZC2Z0QHE6rMM1qENBKnRAfnm3XcrURV7roxap1YwMri6zeXubw73BGPe1SPsBzqSfsq+ydeUzgEKSRRAtQo2akKcdlRS7ScgAL1EOgSvP916Q9e0oeofyK5DLRMMdcdBGPQCtChS5dfwrAlENorFrwMDI0WB/N5w4UgRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Mon, 22 Aug 2016 22:55:49 +0000
Message-ID: <57BB82F3.2030103@caviumnetworks.com>
Date:   Mon, 22 Aug 2016 15:55:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Steven J. Hill" <steven.hill@cavium.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH] MIPS: OCTEON: mangle-port: fix build failure with VDSO
 code
References: <20160822220735.13865-1-aaro.koskinen@iki.fi>
In-Reply-To: <20160822220735.13865-1-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA076.namprd07.prod.outlook.com (10.141.251.51) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 36f03f74-97e1-4611-b096-08d3cadf765f
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:IX0h5UmwojrDPVs2Z3iLlgG3CFsvtzBP+MxOUxm93ZAu37KuN5zIACY5DtZsjJRX2nDhnToB+wWSSsOWJBCAhAuIy3w0GVlLHonakeTmBgHW27LUlCt/GmVZ7xWLehHnaSd//jWw/dxjBAEPt6d0Ssa3u5R/cfl9KCPSvBpw2qw6QIp7iybTlLF1tiFKI1rS;3:eX0L+nUN7BXYtWhDChdEPGf24SCPqragYcnfcaHPQuNey36FwpgVGhLt+VgXNrnonuYVbBThtuXzExb32LsadRKWLHMrL5ZZ85LwMrusz0/j3uVm/42c2fhud6L7D1jR;25:6IGVQPCu4/mIOR/sNPrpbuYg/Pi8Nbk8lmHkS2bsB4Ty7A3VGjJ/xL53LUmkG3JsjGdur/tTZuz6tbwRRdUaJPAHbd2BJP6maIi+s0h+BQczVTKVnYsFHImM6dKsXdGVfEZilX2Z6Aeg48bTLTeVa27RdHTNL8RuKqpYH87TcaAwTeyajHwu5o+4b4m3YCOmJ9u38rM4Dbq6OqcNXAmMui63Jv9WKwPSDx8F6O1K30GaAzg3dhz9Rzma/Li2pGa5yD5GhcdVhzG95wLbUXhVodks2/Ut/pUD1+YfayvyMQQ3pMoKYDnnR3mbf2UrxpRWWsAmapphyOF4XW5JEWB04lAH6hk7b/nHw4GGj73W4wqkQpgm716vZ/8Cw/FPIqYLffejtLCA0+Xo/s/zW7rlXfr2VQOoxeOfxLhjV/w9BNw=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;31:tIWXGNsjq9u6fknLPS3Lipjtxm6t2IXpZqvfQJXtYFjEcWfN1AaJhWjUWxWd5YTPonSXAUXFQ8GJ4qzzg8hvYIk6BD/aKc9WxwNNiPLjqflUA3PKsp4dL9HwN+ahL0NCjtoltFSW0APkQmiPlAiq1BC+h7YcyM5FAWxYfegh6homZVeWCpS5SRMh7GvkQW8BngUVly7R6QOgfc6TutECtNflAXaOXxpBYoHApkoynjM=;20:z2veckjulw8Ybp5rDAjQu8mUKD2CsrYObyRahDcC5gryUsSVIjI37RvGya8jKSHU/94mpIvNRSCH1yBUC3dF2T8snCA1GdChimbITGD0pfYT9ilaNyhYfFFi5J8eW7F9z7Z0dPupRZcryyew7dRN7HV5MLB+CY2NOLMvSB4eQC0F0JERHCgm5aUxyXgUBY49QhSmZrTI53AYq5d5R6YpPhz7qPtr3wxBLD+N6tqUofgUDisVquWWRZBwnJ/Yy6ql0L/FTZvyJ3jyzz67jJYz1ywPQEaXEj4pHraumHEcuTXJLcNUMOsR18FuguksXsHWQk8C5d8rgNbIpMhSbr8uCcKI8hkR53MUhjDxadJvuKIvOMF3yblWUfcGw3mWEV3CDQGDqcA+3U7qGqc+PReTMuCo9XRs9h1hXEm5EDuPCEAQ7X/YgOl6WC9J/kF/ozBjjgK549C4sgqO9/N+vS9ZpFHGnm5S3TAkXue5LRei03AftW6R1nWLNR6ng5ZTAfge1y5dh3TG3NeNNJ9BIWlUBRc3UrE3Dq157aVm0fIl3rD3yAKmO9I6KhUs1wmdVMGvdzieblwD/+4iGNWtVgEm3zGBCEjYAqKCpBPGU4Zk1Rg=
X-Microsoft-Antispam-PRVS: <BN4PR07MB21295A7496FB9BE8A8AD356897E80@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:aBzedA5jbv0f3IFr8k5ge+Uwmf6mu+NCmS0iKGeOwQvRZwJtdWCGCFcz/vK5OUA2tVJ+BwLRouSS6EBCTWzfEG5cx+MvMOvlXw75slRi9ngL3sJuatDuI7QYa39X6GVoZNfvfGDjK3kmSFX+kTq0nxOnIUoLDn62Z0XMPFgSwLdXN4XvOUbKF2cG3XSAf8XhNam/kRiYd59NobokvL74d29pzsI0Mli7eXwraSXYhlw6zD1ffLywdSN5Ev62v7q9TLfJrSeO9KdBoWYtHbSwnmJkZvefXS8APRO2frBilV1BNas5crbjQIwoGS9978fC/0ZyoSN7rqL7+QMidOl43GxPMhzopSrcJkHEyQM3gaGRFSJHRdWfx814VjbjH/fL
X-Forefront-PRVS: 00429279BA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(377454003)(24454002)(33656002)(2950100001)(101416001)(189998001)(77096005)(105586002)(42186005)(64126003)(53416004)(65956001)(19580395003)(7736002)(81166006)(305945005)(81156014)(7846002)(83506001)(47776003)(66066001)(19580405001)(65806001)(4326007)(68736007)(50466002)(8676002)(2906002)(69596002)(5660300001)(80316001)(4001450100002)(230700001)(50986999)(65816999)(87266999)(6116002)(54356999)(76176999)(23756003)(5001770100001)(586003)(3846002)(4001350100001)(97736004)(106356001)(92566002)(36756003)(59896002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN4PR07MB2129;23:WDJZJZc+DRpiPiRNimdCRMHa0zSfOouCzYekEM9?=
 =?iso-8859-1?Q?MWhiveFRWOui9YTznFp7mNuVW7Xo8L4pM+CyqEF5akta1lCtZmPYlcOdSC?=
 =?iso-8859-1?Q?1sK9slLiQdTKspPbp69qAmD+BjshPebf/8MvYgebu41pPHLjT3ohnh/fPi?=
 =?iso-8859-1?Q?Gp7kERON3FGa/ZpVpe9qUhL5CiT2gfjQLjvHheVE+D7TmD/ZuuacI1k+hm?=
 =?iso-8859-1?Q?lViuIBpBpHUIAHHDTw+Rv4KizFE7HpqHpj1EFERRvPWux73He+3PFqGurE?=
 =?iso-8859-1?Q?J0YCy752iK/amZDHpEGuJ9bTC7D84pMtXszb4CyR8nXzPNQ3WEXTHveZiy?=
 =?iso-8859-1?Q?YXoQSgZoHF0GwKZrlD/MEEDvbaAlW6eWPMkBYHqqP3XOq3t4W0z170+DHf?=
 =?iso-8859-1?Q?UEW4FyCOeatIytQy1RWoeY07IqX4cEM84q1J43XqW0wW222SVLqxdZiZsL?=
 =?iso-8859-1?Q?zDdwpqKwAYwgT7IWWPHwyIX6bSEnZGfe61e87HdvPVjbtl5GVv1SrQlvsN?=
 =?iso-8859-1?Q?RpE3fKPycxPKJ/sD9e89UWUaM5A9jEDpHoOfyM8BjTtwfL5BVDWAeNnuMt?=
 =?iso-8859-1?Q?GE/5x9TgD+bzbSYkNTPsas3bWhHhxqUCKXzu5oadZM8YEfWNSJ78xoyNEC?=
 =?iso-8859-1?Q?gg9XPRZgMYYzBewySIQVptMkR7c3KZGhNLFpcjbq23s+9vkeuBXKEx5/Ce?=
 =?iso-8859-1?Q?EMVMD4cjQtkUhtqjXJFbtnJIIuPGxR+3E7nF6WAjHdgp5fHkXvhiNEMRwF?=
 =?iso-8859-1?Q?z9y+0HhY5ItfV9Fd2kSnI0HKEv/eoA8Wzs8hOK6pxExSJMq5reYaG9D2LC?=
 =?iso-8859-1?Q?Nl2mgSSsCKWu1HsPcQn9CAN41Lwa1n+FTiSf4SKcvwjKJtQI33KS8ZCRUH?=
 =?iso-8859-1?Q?3WDbXneP8qShEKJewc/GgAaV54fKcST4NzMLmNk7OJBzg9Lu7TZgDdzDPb?=
 =?iso-8859-1?Q?0VCSOvYsHIHIGjszMqW7u1FYGXwugyd+q1zGzCEMatlwfWpKhkxHJdwEiX?=
 =?iso-8859-1?Q?eDLMRAiP3v+qEk6/+suSxWAkqxgJOXLgArkOBw2RoIrryDSQ2Ao7I/iHv+?=
 =?iso-8859-1?Q?yPkcCIKuzEzrVPdDqzGPtQWIpkae74T7HawwWATXepC/5/7gtYxAJKxK2e?=
 =?iso-8859-1?Q?CiDhMgGYREvGdK05vZlIEjy14SkvHATkipgNiW2pq8LDCkNYFnpdSlmS0A?=
 =?iso-8859-1?Q?wX54rj2KH8N/5kcS+XEp8uHBk0RiAGcXl3nJizVcpHYUimj+U5tKPDTlU2?=
 =?iso-8859-1?Q?KI02Nwm6n/JiMdJxoTu/tyK6nwH1SwvImFFGpDVMDS7BEzKwxwRQyanyR6?=
 =?iso-8859-1?Q?Waytu2cbKaDS7QbJZ0pfcow4+Vt/ulQqM/d2tlJq0fYC6usZrJG6AUVL5w?=
 =?iso-8859-1?Q?+1+LZpg5mtgmySL4u56HLRJuozlIlrar8pnGPAxK+aqzXNWxoLg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;6:mtFmczApUooX2glCX3T24av1tlsOP/SUYkKUjOhhzOaM63Eu5lcxtemG2xTfn9XYKXx+k3fCyTwOLvd6vsQ3/fldgfEHEeN80eUyiGxHE2PSqjR4ADdAckQCNYMpiaxkjePIZvRcl8a5FxOXKWWQDAxmpLi91ea3GvEBGFpR1IM5Nh4bQZEF1uVGBWplF8O+qVy7UXzfsF7eAo/nfkDxTRhujP/h9cZjcZO2YgnxkfLDgqtr9de7/dGYfhn2jEL5smyX8hab+QgRCB9yJ9AdKobP/X65Jfy4OrmQ7kellXk=;5:iBJqFbJeBzQabipxX8adfEG7rinR8hvT72TrrivY5MbnZ2S+0PKJYLG/XqSWhJgWhS6FqOc+lMrDp3vHHqbICJZfblA0dU/7dIQeH90ttbKwG64XpRH4I6jBfvvPrkQ8hOgQFe0ncoMRVzmLJkl+pQ==;24:Q/hOgFTwQPfkMZJSRLc+Jvd15Lgke7rN6nBXNndgZqvnL6M7ir7tMJiW+iu4xFk1yfd/M/zOVGFtozDxpjDbzIhKbtgcoWtT52uGN+GVOB8=;7:qUfR9C0h9dcWjye5HCZCWkmyWvU/fG32r6vnYlH7vLj2FlJvwX1XHVn1b9giRyRT2eK22AtdzKcLXbHQPoGkHc7L5wjhm3qB5FOzySmxlJcOoeGglK22NjQ4BSQ3x+/8CqcoRsBM/zvtyVBK30+thNvrGzO+bt8Pq2h3RaaVvBPz6FNUawHMmtE2CnpQJIkSfTmvkDt4jLT+ivGYJ45qfq5ntV4uVxcGrpE06LABVfPw+iwXuBYNl2lP6v9LVsll
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2016 22:55:49.6637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54728
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

On 08/22/2016 03:07 PM, Aaro Koskinen wrote:
> Commit 1685ddbe35cd ("MIPS: Octeon: Changes to support readq()/writeq()
> usage.") added bitwise shift operations that assume that unsigned long
> is always 64-bits. This broke the build of VDSO code, as it gets compiled
> also in "faked" 32-bit mode. Althought the failing inline functions are
> never executed in 32-bit mode, they still need to pass the compilation.
> Fix by using 64-bit types explicitly.
>
> The patch fixes the following build failure:
>
>    CC      arch/mips/vdso/gettimeofday-o32.o
> In file included from los/git/devel/linux/arch/mips/include/asm/io.h:32:0,
>                   from los/git/devel/linux/arch/mips/include/asm/page.h:194,
>                   from los/git/devel/linux/arch/mips/vdso/vdso.h:26,
>                   from los/git/devel/linux/arch/mips/vdso/gettimeofday.c:11:
> los/git/devel/linux/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h: In function '__should_swizzle_bits':
> los/git/devel/linux/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
>    unsigned long did = ((unsigned long)a >> 40) & 0xff;
>                                          ^~
>
> Fixes: 1685ddbe35cd ("MIPS: Octeon: Changes to support readq()/writeq() usage.")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This looks like it should work.

Steven, can you test this patch for us to get independent confirmation 
that it works?

If testing shows that it is good, please add Acked-by: David Daney 
<david.daney@cavium.com>



> ---
>   arch/mips/include/asm/mach-cavium-octeon/mangle-port.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
> index 0cf5ac1..8ff2cbd 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
> @@ -15,8 +15,8 @@
>   static inline bool __should_swizzle_bits(volatile void *a)
>   {
>   	extern const bool octeon_should_swizzle_table[];
> +	u64 did = ((u64)(uintptr_t)a >> 40) & 0xff;
>
> -	unsigned long did = ((unsigned long)a >> 40) & 0xff;
>   	return octeon_should_swizzle_table[did];
>   }
>
> @@ -29,7 +29,7 @@ static inline bool __should_swizzle_bits(volatile void *a)
>
>   #define __should_swizzle_bits(a)	false
>
> -static inline bool __should_swizzle_addr(unsigned long p)
> +static inline bool __should_swizzle_addr(u64 p)
>   {
>   	/* boot bus? */
>   	return ((p >> 40) & 0xff) == 0;
>
