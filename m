Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 19:57:24 +0100 (CET)
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:2644
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992127AbdB0S5Qne7Kr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 19:57:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dJZfhQji1MQ/06FEY3eqcAcVDx7ut5agU2DNVnjOEMM=;
 b=Sk4vgbaOeW/mP4tjt/qMtQWrZenOxVicYWBnIbtg5g+acZxUk2XJe8iu1eqBejwoaVfx3BjDCEf0F9VhFfP8JyxUvDhd0NMRJrqZvelW125cg4Ymi7CNhzpGBoFJEWqlI0AY79OSDeOXplLwakCin4Amsp+CdkOCNGmwyy8SzGs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 18:57:06 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>, rostedt@goodmis.org
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 10:57:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0028.namprd07.prod.outlook.com (10.168.109.14) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 03069721-c206-4149-72b9-08d45f426dec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:weeLjtFWuqa/XIiCg/3IB+tGTK5QThER0stFHMOuk241TskPugVFVX8b9g/Q9nSbCApta7R3ocseOwRkKiUDNLpTgFh7aqa8DxM3HqqRwZUyfhPIyfumIrIDJhL0ZyZsSkiw4q7+1TkrRfp3sXJLK2LbrKHp0D9U5RO7NbVnzNL0cLNI6Z+hMC35mhDOIYv5BoJ43HHkWMoRKGa+9MydnFf3wK//FW0ihuelrwPeiowDMdm3GhdRF+ZeUhicolw3YTsKUAWP2SrOG1o9Eettww==;25:yqUELyGD51gdYuuObPay4FDt5PB7yldWGHTmOvhmnZsF8mfos5242OQ9r48q+s86vAPwlA91asBi2XsFh4thcssJmT3MlAEDp97fYhGC4t+NzrXRwsYNUrF1nfKuhAp8NPkxRosW7nrHzQ0icVHNkOu3ylz4lMa+2dQCT++vHfen7qFMOLTK/tTmRrA9/qYq9eSgaKv4+RLEuhScJyxs5Nqn+PWd1ct1e8n/kiW4TEG4+dHH+jdCr5w0G1khsZIE8r0+9qxX3359tRb6DNUjhjhot8j6fh4lv2nV85oyRf6aHdpckGXWyAZ489VsHBfFq8plx4PU5COhEsJjh+HFaG/dUt6CU6B9/OzkRyrq1srdOZiWTN6NQWh/IDW0Xpq6QPDArAdzxM65b003Cn7eA05Oo1aDDyF/kPA5iZGHUoUU6a04ebANll1r8vX8g4RZVnCR1fl9WW2g04z6VFEo7g==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:ddCvcxVy7ABxQWhVpJO5Ak0uvuVwTAsxQwXKrekwIcriWD3eW9o3PjH4zzdX5yGcKUpj3RIoCetftxB5F8R2GuJYW7pI9EPYhfi2z/5LF+mnddfDIxJV3erjK1CvJRHb2ciU2C1bYu+fOC4rWmlXF7FDKI395xhRVoWN+wWXRSKkUe43SvC51Cg/dmmvNq31RwA6FWRTn4axO3aSzbK9nm9s+H9OJYrTgA22HF49aajdzfKxKNt/zyA9zPk0+kaj;20:pUt2gAk0lQstAsKV4pingzWJk4dLDdDXZFAIMmy87sNJyWH2oohY3fO9KppOVmaH+Kj4RMVgC+1pduXgmB4QjsBr5puWuqRIwmn+hiOb3nuKm7+MrNkglnpXm5EtAgnYL+MoH42AKpeL1ZLnTp2tdySL2YFsZbPMDiAfWd2WHvjQC2UCEMlmxA3VwAE71VjlM+iDzXHfYbef0krVfWZEOLW0DHK/s1RLhaprL80zUc4cxLXq1rZtgFHuiJCPwPU7QL8X9HwDJqlYkkFZFhXbZybwCsS7tyyIlDS2qqE+3z9I9hdbzTzIgd/PC/40fysKayENGgwoKnauGBoEadXkH5y1dRETpqWCHCGbz1KTwoFDmOUAUiLICOJ1ZTkqA0kB//UfD5t69Zqwjk7uBaM1NNrGXUtH7S+OUDSzF0urCR4vrK1qKbA0FyJl8iSlRBCnFKOdc+f8kFZqImiXfO0lVqjCYmB6DhUzwo8iEKuf4BIlpgXfbV50WjIEZWbV76WRQVagRmDWLvkIb5QpiBUiwu7URmCE2maP5BwN9IFnDwx7KNIggOdYQeaKjkeje+N97xagiB7vOIy2p4/TR7mMbuP2+0SDxyIejM1us1CGIGM=
X-Microsoft-Antispam-PRVS: <BL2PR07MB2420AFB57775160009A95B1697570@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123562025)(20161123555025)(20161123560025)(20161123564025)(20161123558025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:MU6IPbZVG4qnVw6mOXWvUW1vpcYJFtJUOyj6MbByaB9A4tYCGAkzaKa6n6BN7qdmTpJM2h0S7pEeHEfQmNRpov+GWA7C6metpIW7XwoL3fb8YIjcBK6uabSY1dUk+OeKeCiCzLOMdcRJSsIxkRThPRIi3zdUHRzykty/9v0m56cCjwARkBl//2s0emsFxKwzsNO8VYKCSW2fTvXmSbIxQx9jTEsHcTzy6tHoxfCG9SbEQBOCeo4fKBD7j7NdTTzb6SGsp53vTLvJVgZ78NT3BNsDi3onk+c6Il6pjjKUkqN6RS+9bA9UsRd/pLFZOEqEEFVXxSqnJIcDBuqp43dH12Br6G27jqpGqKuhyDOQVmYSBYpp4dvd+TIrzDDNx2ec+yKf6y38X6Rm03PlzxUUIr7nNAiLaG2AW9FChF4WDBLVmT4wHzYJ/7ssBXZqWGE4kX7YVULHO/L04rPURpZgZejjaTPAccTi2BmKq6aGa7dppry4B62AwDFSrjmCLeFtVu3BUw6S1epTyBy5dClCSIr3AIXkLpro29tozSu7qFUJRIH2jTf23f+ch3m2SeDnIQca/yKVmyC7mkREhCss9N1FPqb6tMC0XdoEDNrthus=
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(377454003)(199003)(189002)(24454002)(50986999)(54356999)(31696002)(53416004)(105586002)(106356001)(69596002)(36756003)(101416001)(42186005)(33646002)(31686004)(76176999)(2950100002)(6512007)(25786008)(6486002)(42882006)(6666003)(54906002)(5660300001)(65826007)(4326007)(68736007)(2906002)(6506006)(229853002)(65806001)(66066001)(47776003)(65956001)(7416002)(92566002)(7736002)(6116002)(3846002)(230700001)(189998001)(4001350100001)(97736004)(305945005)(81156014)(8676002)(53936002)(6246003)(53546006)(38730400002)(110136004)(23746002)(50466002)(83506001)(81166006)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BL2PR07MB2420;23:drg/k/naRsc02ZQlA5k9ftKHIcl8U8wdjehZe?=
 =?Windows-1252?Q?aoSrTjCAF14UzCmLdoqM0EAKQ+sEkaCShiEN0ieLnB1zHjeflNCaMX6G?=
 =?Windows-1252?Q?DV3xZn/EXYiaxivNU/2LhQxMsq9rrQQ8qKAAngI/Y83DcXVZ+zkxA9yG?=
 =?Windows-1252?Q?oDTYHqhCBKUt9K8pE+sQpN4/PlZ5eXiC0EqGV0pnLJmEzLeju5rAAJQj?=
 =?Windows-1252?Q?5CRlnpUrnYgl+Oms++vQbQgnLWlBl6K/nXILJdQbKZGVKMcgxBpNvkeB?=
 =?Windows-1252?Q?va1YB757RE10dYLqp/WBoe1+UeYRfPxoFg2k97NwzykR5CX/4+IZ7gXb?=
 =?Windows-1252?Q?xv0gty6tw+FPMyc6hM0Hgkk/m+bdY0peJPYTWo85+aTVIkgYuSZ2lYZf?=
 =?Windows-1252?Q?MuTGkFzqKTZg5RfRNm20pPgRS2or0HQif/P0SakJJsMVngO5Kr3omeuo?=
 =?Windows-1252?Q?jq/9yYfYLIWkQFQQlV5Lt0eo9h7NxEKNQIi/Twej8cAJui7ARS08vS03?=
 =?Windows-1252?Q?jzwg0oH8gyt0KYVcl1kzEC7xCn7vfY9hwMFhZh5CC/rVEi6n4QZ9qWyz?=
 =?Windows-1252?Q?pqqWxANfxNq9gtrcZq45qL0ihjhTwMBX3LOoXeVnODPSG6lAsDzlMzrS?=
 =?Windows-1252?Q?RhQnI48oJjDlkNL9iml5W8AsN838KJ3pKnEL+3ePyeX8YZ4OsG7tPjks?=
 =?Windows-1252?Q?azpcx4ZrisI5GwxokFIQSdqCqAdB23RyXGCLF8mQwLoDgWo/JfsC5D+Z?=
 =?Windows-1252?Q?TcGNfJ4wdFjFxAj/ojSkVTPJrvGC7Z2B3V+5ygxPgQfFWTfmPrS1lMLa?=
 =?Windows-1252?Q?bTKdVHsNSTUrTqvU+KoaOU/gO6bpoTRljfu0klfefp/Sw5JOc+VNckU8?=
 =?Windows-1252?Q?oU3VzsInG4Xzc5BxkPBHNrd58qUDyQXO1c3oHIh+eAKRV2wJCiReGtcD?=
 =?Windows-1252?Q?MaAaUeIWwxgZsPY64Krfm0HKy64TnZaJ4WcllleP5ZDWHConGuW3uXld?=
 =?Windows-1252?Q?JukSRvmCINWSzVwBDwqBTZdqMwrZ1UCxqnhDBtcer2L6T9G1ar1/T6a1?=
 =?Windows-1252?Q?mOoVOreZg1TwNovMHFdyMK2tXZ2GgDkPnLYXkKhLYiPK2suUz7q07HS3?=
 =?Windows-1252?Q?Qa0JAvejFPYpREAUt1UG7W+3l1B6bZhxlOeuQQ3d8XjXxI5Eb32aRG2f?=
 =?Windows-1252?Q?zqm4XI7m4AR0lr6KEIEJAo6/6dx16cJLy7vQe3M68vJZIn0L7Yttezch?=
 =?Windows-1252?Q?WassKHh44JV30foSgK/ZPwnpnP6jNPiiOl/A48DmGliM5rFPeQpwwOAs?=
 =?Windows-1252?Q?kjXgMqepw434Mv6QMXif18b1SlD81PiOso1MXoYJZYX07RqEG1x/4wKp?=
 =?Windows-1252?Q?iX8Cq3B44csZKXxoTb8c9nb3zMo787HOAXhts3+DeeVbyj8zj/3iTgAt?=
 =?Windows-1252?Q?sFfY/buP4lnJ9lwww0SABGkE3JUC2awBbX+82NnuEcFwwCoh0WVferck?=
 =?Windows-1252?Q?WY+V7K54T5nHLyUbLUSoprtPEIq2AFQQuIzZdYd+Oo1PRZxw0Hc5ZhKF?=
 =?Windows-1252?Q?HHwNifS66pCsPI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:Prugaug92+Xb0I0wYBxMRxKnMhTBXiHciuwSPiQttjtGpy+KzXWEWDK70Lz+okFtKLg42nCXZbGbMoA6oq0KaQKyYoKgN2IYPD5W2ZFV1Tnf38gm5FBeWjjciG6sj2lk3D5r7eW+4eT44Ol5Fr0S/FwEWOAz3URwuK4Z5P/I7nR/o4Cdu0qlvCwisFC/gCYzrZ3IEe3bKcbHp7jck7iX+VuljBagUNa0ZpMV8yktphI0m3mJuPXbwgDBwR0gDVvntyzGe1DFyRuNl41KFUUVmMMOfnhDXL3stURSgV3c/hDL1bf20bKqKkTdblBmv+UNn9fhU3TqSWfSPzU3VDCW3IsWENFOSS2bozBdCpkBQifarPkx9usom3q1osqBja8E86xEvkb6L/nve1pSHrvkEw==;5:M5JhPObdBtDkikX2XYpIpoVGJPDXq/96lk/Tlq5fL+otF6dX+exFIgGHf04M3iTjuZL9rnWB1EtXf2bfQDlOVxA4CcHJrfbf8iPXkGaugquRaZQFYbp+mT8IQKIXwlXExbdSptQZL8F/pl+hpE0mOw==;24:cuOinBx0Sve3esI9+R7UR5YLPmIgsptVxYhgCb3n9Ef+5uGpCYjiHWELJ8pKBddaCx7v653dpHyiKX2OsCgKWsVocA0IorWWp5v7OAO5ACc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:5eB8Vc8VZSBssTzAwVcL4pKeG755ca6sV333B8+paKbMs2f7PanAXAjtUv8kC5c7tF/9ZqXSCuKjhAiWd1rWukPnMsyEsQ6g+gHJmzRQebCRFv04kZXy8cGOdDB6u0QZ+3Ua6JCuTwjWn5RbnFfSPIYaImbocINiPdOzz69aRmw3ykHrivscpMYY/xWa4XANKIoSgVJnirnTUpkchx4bmlMuiPFV953rG9K/Lk0gaF2aVWuVnW90jW2ynks2rbjBnx0gVRRVFXjRBlgUBMwGY8IpvVYSTT9bfKqFKcotf156zWbJlQp1LqEKQPcAwYSUKR7Rf/lqpTBohYRG8G5CGQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 18:57:06.8087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56904
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

On 02/27/2017 10:49 AM, Jason Baron wrote:
> The core jump_label code makes use of the 2 lower bits of the
> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
> table is at least 4-byte aligned.
>
[...]
> diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
> index e77672539e8e..243791f3ae71 100644
> --- a/arch/mips/include/asm/jump_label.h
> +++ b/arch/mips/include/asm/jump_label.h
> @@ -31,6 +31,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>  		"nop\n\t"
>  		".pushsection __jump_table,  \"aw\"\n\t"
> +		".balign 4\n\t"
>  		WORD_INSN " 1b, %l[l_yes], %0\n\t"
>  		".popsection\n\t"
>  		: :  "i" (&((char *)key)[branch]) : : l_yes);
> @@ -45,6 +46,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>  	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>  		"nop\n\t"
>  		".pushsection __jump_table,  \"aw\"\n\t"
> +		".balign 4\n\t"
>  		WORD_INSN " 1b, %l[l_yes], %0\n\t"
>  		".popsection\n\t"
>  		: :  "i" (&((char *)key)[branch]) : : l_yes);


I will speak only for the MIPS part.

If the section is not already properly aligned, this change will add 
padding, which is probably not what we want.

Have you ever seen a problem with misalignment in the real world?

If so, I think a better approach might be to set properties on the 
__jump_table section to force the proper alignment, or do something in 
the linker script.

David Daney
