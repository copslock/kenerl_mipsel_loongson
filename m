Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 19:00:44 +0100 (CET)
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:63872
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993884AbdBOSAfDqRK9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Feb 2017 19:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/BZhlDN1PWl3xsE3Yvsx/iBAFpx+moLwNzzA890KIjU=;
 b=cqji029FJogQkXHvpnnCaamcbWYGfzkQQkfMpERO13Wm2+RWyuvYVI3rVFzOOLaasHtQL2yVP62wVV18uFXB7JPj37DsrhZMRD57ZhgM2L+jR7T4FyCqVUFDzI1lNs24p4NVZfA9VJySiklR3RO0UkxovLTmKB3PvotWhdM3Psk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1977.namprd07.prod.outlook.com (10.163.141.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.888.16; Wed, 15 Feb 2017 18:00:27 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Enable DEVTMPFS
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <671051812ff6eee41f009753e22e79eed98f7502.1487178952.git-series.james.hogan@imgtec.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <6bdf5b3b-92c1-9fdd-8530-c72ca5e7dfd7@caviumnetworks.com>
Date:   Wed, 15 Feb 2017 10:00:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <671051812ff6eee41f009753e22e79eed98f7502.1487178952.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0036.namprd07.prod.outlook.com (10.168.109.22) To
 CY1PR0701MB1977.namprd07.prod.outlook.com (10.163.141.19)
X-MS-Office365-Filtering-Correlation-Id: 18d8b372-9538-4347-7398-08d455cc8658
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;3:2YTFhAnBzmet3hTutNxgxwONJGQIg/zpKXeKI0xHdGxHnke8KFGMCD29/qF49ht6GgA7KyUm19Nn4IVpOjKce/YdPVWBGUI9RIfmJHfPyfxtP/DZdAn2xU+zr485kTfcAR9+uBpvWdwUvR6exDCeRVtG2MmWO5YkuZzf657YvCdP0hSZcJiTy8Sp9XzF+5NwUrgsY4V4vDpfisqhBsFfZaGIQWSc8/kWpNb/B0+xnBllExB4gNJ9LAlXUQ8YYAxLHItUKgpA32QWiFl601dj3A==;25:WTcN0qv6kkSp0j2IjlXB3ebwOVFXRrWIFI3ghh9+EKiwllxMNlJ/0ZZ6NyZCwfAkIXCrFUm5KwG/YJ9FfcgDf7707Xg4Vc5M+LwICTMHrGNOZUDwew2m4el70lwQI+AXiu4IKoep9wvykWg8O1FfFxTk+htBcstiiQPqKFHcrLi2fyhCgFXGspAi1B9/D2MC+wq8pvRRCSqybnKgJpXDzsXeovMcDTzLseA+aTvKOPiQVZ/hyVYfCXA/sueyuydkAq5OIqkjdj+dhXCOsGbRJhJ/TaRxNcR2S5I1zdd2ZKzZPyErkWfaE9uYtB2xeDAiTkH7H9uAoReiN5iH+oWL+VkrdHHdWSkDB0NHX//FbaTI+jMVwiGPkhiiPE/gZmhBToXz6qKteICIqIdyynLjswEx0I2pwGJ0ODb9pe00m41/4Y7NsC39Nrt+rcXBSMS0STPqDeg5zwVITDGwxdX/9g==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;31:u8YduMpc3znQqa4NLV4KYa7m6to/bTvZTv8+wmvB7eexcXeXmyEOhI5ML7lQB7FUQYrmBv9rp0KIxcYPKrJ5fPNeRVCj/Ts8Q60LW8TrBIi5jUFyvIqYTlsvG1GMT6H1VFlQSPkUA8pSVIXJrlXu/cy++5f0PYINNXfETSzl9TdnzzehVc9kDWcbCLn2799HgeqoXTpl6E8npRrr8Uzr2+kDLH49JfGa5tuksG4TnnZtxngFhPrh/SgfmAT+mi7N;20:Ia5rHqttjdpM7vK7Vgvno/xHjUUJv/WeDSROxWWzx/bXa124C32yFQkejbVnILA/BqcWNIibVDbHlmXhqUU2PeczwWlb+Ps+e5w4QOo1TtXQzGkJlYosnacfx/eBRpw6fiaN5Kf8YZRyAmRxTHr2XYKo7w9B66sH0eGJBvM+8rYr9TyVQmS7pnzd+IcIqnGl5cygEGoAfriVnS3StU4ngyLhfY+UpGZhThb/RyASYx7dYpjGgCuwK7ti5u8Ymx4xztkt5mVMn5/+AzwH/EvZyHkBIFBZm6/ey4bB1DTMnMxiLGMCMis+Tb3UBZ/9U8X/ZvASdzUSeQSSWT6Y5mPtncRjwi4f+05g0wb2dm5lt3mth0qi8ejLSoyLgvlpzW1HJp4uGwAHyFYPPluNXlr31aHTDb9NcGLLYUEwmzfCd7zq0lJxRU4dsw5bwNtQrJ45AjX+gNcHWdinqBaW63yz0ePnocNF8FEYvsJzKJuHBZoh8CiZn9DRKtznZ6ReP/WGwu/xRpyKF8Z6p7F2emkik9gbnxrxiHtdTzrE/ffE2NwkrbLbVjZf1GugC8HWY9F3SXRwuxK0JN2ySX4kpdzErVaD8ab7HVkYHucQFTqeOe0=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB19774B6B9EC745AEFB69D7B2975B0@CY1PR0701MB1977.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123562025)(20161123555025)(20161123558025)(20161123560025)(20161123564025)(6042181)(6072148);SRVR:CY1PR0701MB1977;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;4:MOJydKRr+hBEAeEs1sSpjqg+OmrzTr+X6zhetg5RJzZww+N/+BljPT2contQ7ZIWsS3+m3OCKYFXSaCL/5+ANOr36ep12Kub2TqdHuD1luII+SBeHLFYO9jsUrA1Orri7q2PQMgZ8wSGm7maU8wQBRf65jCZQZgoMbtGXjREh1IsEMlMRbhFzD5ntIZrRCyuaevYKJtu8DROBZPSIgBTyq1mJsnEGTyrdxgA+t2BHOA4jpe3r8Y2tYA5KAspGWpthxjOdk/QaKXT07g4TFiXOd4BhQ4MBg3oemGSBK6zoEuNEMlIwTA/l6y0RIzjj6SRT1D6P7cKVeSzR4inPWWGIy7DHKfUDyu2Rviq28boW47V1NCqsBE+JB/pzgCDG7gQFsF10Tj+ZzXKi8ha+NJ0MfwZ+rvq8ET5l+qsd8SJvK8GLlWmvEsDhJJedVsMN4uOJlM78QLZ8CeCZMR5jjmmNPDwg1y+zGkuH3rBFpnHs2zDO2HJSJk4htBF3VyEjf9MLTQJ1SZclILgnV+IkHMgmkjxLNNbC9Yv4ZyHPyKcCKNYoZK5U2nZEPZRz3N+3S6j84z5WgsJ6YCjlfbY20KcZykc+9aJmNsoCD3RwhwqYJBe2iznehe7ImQ1TUkyzPyP
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(377454003)(24454002)(50986999)(23746002)(92566002)(76176999)(83506001)(189998001)(38730400002)(64126003)(5660300001)(6116002)(3846002)(97736004)(54356999)(7736002)(33646002)(31696002)(4001350100001)(389900002)(53936002)(305945005)(68736007)(50466002)(53546003)(42186005)(6246003)(81166006)(53416004)(47776003)(106356001)(101416001)(69596002)(2950100002)(42882006)(105586002)(230700001)(8676002)(81156014)(36756003)(65826007)(4326007)(2906002)(65806001)(6506006)(31686004)(229853002)(6512007)(25786008)(6486002)(66066001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1977;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR0701MB1977;23:VTP4WDhegr9jAnEkZxW8xiKojvI+VrDnc5u?=
 =?Windows-1252?Q?wnoUYhshoJuD0UMzq940xTMWBvAIuP/V1NX8ugDcvx26yPRT5EfDFXyP?=
 =?Windows-1252?Q?SjvubIDD1KMW0viIp5y1kpWNuUv3yaN9wJvrZlK0yA8kNZtpfBBkctE0?=
 =?Windows-1252?Q?p2y4+k+9NxwVKx0BgdFPw1qyHuAOS0xSFSs6RkRHLnG6NayXA4zEvLtN?=
 =?Windows-1252?Q?ADJkAtMu45l+H4DuG6ylGqHg2B0dOj7CvMfU4yOIKBEdxTlK61ZqvySV?=
 =?Windows-1252?Q?mi5o18e9czRYW2N3R9OE5E6K9Hew8uh63VNOB7t2bnEqHt9WdY+B8K1v?=
 =?Windows-1252?Q?h3mFKK7kWMKreifOLaoeeh/fdN3IonNh+6jAWU5FL7bkjMvAxSDrd20P?=
 =?Windows-1252?Q?WPnN7jtYlM0UPe4jWXU/YiMiX9SuKEw0AyKkCJD0XFSEU+p4xTUuTm4z?=
 =?Windows-1252?Q?vNKayzyKukJZ1vnoPeQCUZxgzLzhkZ8rROD59z3eSstkAuGpKqu38rLd?=
 =?Windows-1252?Q?dsXnDF63YZsb5JOf5Pfz+K9AmoHEJHHRZbOX6ls7KbrQiJtGERYVMdS3?=
 =?Windows-1252?Q?nCwRDJW3M/hwmGZWsXSlU1PFV3M8FYpTedDmlh2YC8k/rNbeBFilKAEx?=
 =?Windows-1252?Q?4QRS/3oymKAZcuo/GmyPjH/L4ZqZ2crxzchfuGr50cPldPegdMzYZZrX?=
 =?Windows-1252?Q?zWm1lItvbFu5/O3vlAyRhW5cNqM0OuCsvDplByCsV7KtSJDK4DDu+nWu?=
 =?Windows-1252?Q?64DFTDxGvDsaaa0VUhfjapuWpdssksMFIi1xsFMGfzLYNahUXbsFi/Co?=
 =?Windows-1252?Q?opTzCjm6u3hp2vn6p/bhUBkdv9+fGL8/PFP2AhWdQLIM1+TBGmqPPkRd?=
 =?Windows-1252?Q?6kVF4rVbS9yCpiAMHhVUKzVQ7veoU2gjgoQnOqcKxG5tvLIYUYXqyLnH?=
 =?Windows-1252?Q?yRidlQsuCIIspP348zYxOOqGt9z0MHd/8fuwmVEcoxVC3bydxVIi1GkZ?=
 =?Windows-1252?Q?ShhCRfROLBLiYnQPpalsUc3u2MLZIw95tAsneShUvUptL/4xjZMyDjIy?=
 =?Windows-1252?Q?CLKMdIYbbaOpbQmeNHU5J0dpdj8doOkZokertSeeHwcWr60sK7VTC/Ky?=
 =?Windows-1252?Q?TZJcrY0GiK5pOqHxVKyzcdp9xIz5JWTlXwWPeRrnTqop0K1zR6LHXofl?=
 =?Windows-1252?Q?77Vk2Uz6gGxBxCW+EPJDZr8Jm3WUYsZB10ZtJbteRBRldHcMUH8jo1BV?=
 =?Windows-1252?Q?p1IT+hDuxPz5WnGH/k/iMXnb2+0Vfspze8covotxjdC03PhwqbkVvaQb?=
 =?Windows-1252?Q?GgAhQv1fblZgY1/n/wskl27c7lJGM8U8mMXxld6wUyp32JHZFIUFn/DE?=
 =?Windows-1252?Q?3qL6LhlPdRQJEec8hPHTIOBB/cFvNapLm20B0EWlodSf3GbifcoSZstw?=
 =?Windows-1252?Q?NND56dEgYlSnSKLkV1mnioUqcxXbKGTY2z/oSNUnMVw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;6:47fce9gxx1PRxDfQ38vmITV/6VgC1HTrRIPz1B5SIPLAQgyTuKRBLUzcrgOjAxHJ+UoQOIKaTy7Elztat6r/Ttz3dLtQNtgHSxrxHVxtbyAzAq6ykhiDy62eFcpDdce5bsLardd4Nizb53gsKSiZUynSPj3MLnTV6RuJ4TGmrxadrowRZ8RwM40/k+jQVgxO6zifhRBfZuVTuBnNBx8PA3lcF+sL31PV4DgfQJJoEQ4UVDCzQDT0bBkIQZw/vhSysKb5cZK3Cl+doQKccZY9B7gpwJIKWnr2hbsYzaa02o6akEttJ8Ty59UgQJj1Klu2CvrLslDcUTof/KR/vR8U7Ixn1K0gzIutgjIx10RfLgstt36axMrF9QSc9dzt5r99N8NI6DOmuDdZQJEINS2I9w==;5:Zx6zQbb5MYa29ZGK9mCkDqQ2CwWNv/82cVHVa6Z8El0wzXGjzpN19DqyM8T36TDgChz1Q5gWGV0fM1BclsLYPBklSBMfI0dmWKBPUDwrf43tQ7OyAut3PryZs+t3gMnKtOomRZtUsHki7Ggg03GAUA==;24:dlRuZT+d5kRqmN3yBowXP5/zpoDSZqUwmFkH5bqG+xlvuO1PFKDzCfSQPAvF9Wi49l12Uy+KIFO6BAmUWIRUVsoM5qaYdVwczY1LnyIxkdw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1977;7:ZJ5SBrW4vTQTsgB8zfixTFgeLj4yU5CtoPwkDYlON1P5oMxmKznOPS0ukOO9iP+cS1G8hzNIPTOlww+fIYlkM6eJTkW7xWHomYTsNDwJfG+VVqilW8matiOov234cdfDvqwCDlqgx9c3BYPXz50aof+AbKFVQWHF6hg747QQjV3J3NHhDTxg+McjT+0+19EDuQhbM9obW+6TycPHtE/NASvFUAZTOby4acJAOVWALshxzrh7lP0rkzsmGzT57wEOQ77SZmrWtkdi7UzvEAqU8bRy+oWrGEsVCSY1qb2WFrvDtW2WJXFxY4Yas79NJ0Nks2/gs1TM2KHkqw/cUSgMcJA1nSrdt5PEgLoSyQSe7FVPQQpgjKVYrV/QlnULG+DgphjnrJ64UQfFHlYq8WQsEZHn/sK9RUvFv6AbJMrTtxJdDFGKD5oBTcwhB4EVbxEsCwWGp5CyY0LV4ITY3cUzHKY5QJG/Gzbvj6F7FUXFJlpqbTWOb2yS00p8Hk6m5oKsw1Vobzt3MI20NaM4lUsgug==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2017 18:00:27.7822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1977
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56831
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

On 02/15/2017 09:17 AM, James Hogan wrote:
> Recent versions of udev and systemd require the kernel to be compiled
> with CONFIG_DEVTMPFS in order to populate the /dev directory. Most MIPS
> platforms have it enabled by default, so enable it for the Cavium Octeon
> defconfig as well. This will assist with automated kernel boot testing.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: linux-mips@linux-mips.org

Sounds good,
Acked-by: David Daney <david.daney@cavium.com>

> ---
>  arch/mips/configs/cavium_octeon_defconfig | 1 +
>  1 file changed, 1 insertion(+), 0 deletions(-)
>
> diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
> index d470d08362c0..31e3c4d9adb0 100644
> --- a/arch/mips/configs/cavium_octeon_defconfig
> +++ b/arch/mips/configs/cavium_octeon_defconfig
> @@ -45,6 +45,7 @@ CONFIG_SYN_COOKIES=y
>  # CONFIG_INET_LRO is not set
>  CONFIG_IPV6=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_DEVTMPFS=y
>  # CONFIG_FW_LOADER is not set
>  CONFIG_MTD=y
>  # CONFIG_MTD_OF_PARTS is not set
>
