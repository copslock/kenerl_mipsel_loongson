Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 01:00:53 +0200 (CEST)
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:5024
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992307AbcIAXAqOdHbb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 01:00:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NV101bla7gF/QsxjaPo0YwYq7oXIH4SxTHr2tLsINKk=;
 b=Vy0YjDYMA0Q4I9qxTFuqCWhPZ59s0RlV5oWrLcFJPk/mUKgVsp2JttOpo84br5PUMuXBajl5PiopbFoK7h69IlJY6c0ACaOCJsMBjT80rAUgWx5gnKfiNn+x83ZNT6/aZPTLo8308pzgbCzVpMEzxn5q7vT4AvY9EzngT9sUZ9o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2135.namprd07.prod.outlook.com (10.164.112.13) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.13; Thu, 1 Sep 2016 23:00:38 +0000
Message-ID: <57C8B313.6030206@caviumnetworks.com>
Date:   Thu, 1 Sep 2016 16:00:35 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/6] MIPS: OCTEON: delete legacy code for PHY access
References: <20160901204400.16562-1-aaro.koskinen@iki.fi> <20160901204400.16562-6-aaro.koskinen@iki.fi>
In-Reply-To: <20160901204400.16562-6-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0034.namprd07.prod.outlook.com (10.172.104.20) To
 CY1PR07MB2135.namprd07.prod.outlook.com (10.164.112.13)
X-MS-Office365-Filtering-Correlation-Id: 8187469c-4940-4125-0512-08d3d2bbcaf7
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;2:dmjNB3sIuqKHOe2B4j+vU5Onfs6JaRyOJ6oguGYbaraK5DDmN2Eb/AzkFn1yLnZtL14dz3aL4rg1sBEMjIRhc6eyYEBptk1GKnZNE42RKOrcdRHgArDbfpeEx8239nFNcCk9EkpeDlO7uArVgdc9gnSryvKQilW/3N3MsGHxUjnPUcbDkLLJzIWKnsziBO4p;3:HcbDAB9Givu86SHkQVLlnJyTNhRpObzkYbL92cI0AKaegmerdlof3s0SGD7gQbPcTZer0d1Bn7bVSK/c1q4fDDqZF0DYVnmTS+Beb9WuwUSL6rcgS6HiXgzSxaRnWIEe;25:YUSAo0TTFWe7ZsBPau3uJqjg0SppmNmMcgrZ2EBt2J7FBnPseWLMyiedcB5blilaxlGCjWUt1j7kKiBxhEyFa5kWkSLr+Yrp6x80JQ/WKPUMuZKqQ3m7To25aL+8iYMcflxoGH0i1rFQboyaeiSpsFERynjUKfzoF/0Ca1RaKxb5vtlck/xWGVRZaXyY4U6AZuhP1bPgpA9YTmbdQNk1/y8sQcliXNg2XeTs87qAO5VTI8BIGQI1BVfIpoZ5MYTMvP34Np/IEAKxnU5iQjjLwxWgE8irjKDVB/APSuba3WqapK7t+Bvv6h9mHM21n3pKVMByUL5aLFudG7mHp5y+5fNwZKvZ6VxfmvnOqPTSQALBOyvC9R7yE5o+e+mJbIdAlaYROrWdEcjwEtUQpd9jYP1/J50hTOYdddwUkqb+sm4=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2135;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;31:J6Ua51/hdT/GL3t0+ScF55RCCywbvNxqMkfxaNtbUvacu54rIdhXAAD5hfBPwha0jeQgz+3vbEgoAusCpyQM6YJzI+V+b/Qvwo72s7a+P5n6yb+mei35ITxIjCyZwcf5vGiBbyrfQZSl5jtvxZUezPSZGCpwUT9KNbGReuAm+a3QMQh64eL3bsjbj4PhuRJ2TxweqhQqzqgjWdgUmh/MhMvbDcNO2rCE+2DacxCkE0w=;20:NMZJoxrrciS5EBsY0gZ8uIBfDfG0FwhMlYQoEWdiLdXHQ2yZHTiqphZSzrVL9AvcG101+jTVid59ksAhB6XZenULuszST2KInWyk4oaWO4sHiTHMloErSyvXJLpzOs+NyKO2sPbAbXUjvbZBpI2CZxrdIO8U13IZhxtbva7d+1oh0kHw+s70C7nCAD9KGYqhNk9qXd3o/X8BnlCNFeBkOsVJUEMtu16CldgRZDHEoN0HzigAWHtz7vtQ4Dcgm6Z5GGvHKRaT7O/67xNw5BXo8C0Lk/uRKjIhFECKUsPx8eet7s4Q4rdZjcqdihfMxmoRx+5P4oxGmTzRMaNfcR4+r7HuINLrN38RLAOpk9FDXGwpsz6bNsU5+85pu52iI9f/JbnKXNiqV60eUrSKFdpZNsvsxGEZR5dvqcLCjUhQx5eL5NUOLnPQjIKu/U20oU5/d7xwpQWmLfqaZEBR7M3nVXZD68AFkrVbE8extyTMs/Sj8qCFUR0n3NuVy3eIjb9ZKHFpLbP5N/fPwvZNG3U6EMBRmWHRRow7JfylAnWKQeuycNO9LJcGbwfEmct7LXZQHlRGX2CNeWbNKVYCVT72+XlWr7cuoJBkhcm22oylJCQ=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2135F31C8697B949AABDD34297E20@CY1PR07MB2135.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:CY1PR07MB2135;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2135;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;4:Uijb+8xDkRESaQdBULnxS3MQy6b8c3h9XJOmDV3YIlTRqRb95w7C/FtxyZvpBRlX/2mGdzhP3ewe1dAbsOPJRO1q8GntTggxYayltnef9r4LkH5hDJKNz6ziOOIwT28KsbAQ1NXOFGNmrwm1G7kiq69vzKNfItdwRipDEfjes/A4LnZ1G19RsblShncnkkC+zGpuugfU9ck/6VxF7dhHZuwW/VkWOrZ5d7zm4/WTfBupao2NB9XbOpO1/eIrGAxODTopINONEidqBHGD22MDHUt5dOzvnq1/ZVsnhunsZYbyW5E76NvPs64R8UeRtD1mPF+YeET2BP4cEKGqyzvb5duuL5/K1MBsyLq+BPXqxPqaHs5A7EMLdE6xQhYf8gBO
X-Forefront-PRVS: 0052308DC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(377454003)(189002)(199003)(24454002)(2950100001)(83506001)(19580395003)(4326007)(110136002)(105586002)(66066001)(47776003)(81156014)(7736002)(65956001)(77096005)(33656002)(19580405001)(101416001)(97736004)(7846002)(189998001)(42186005)(4001350100001)(53416004)(305945005)(80316001)(59896002)(92566002)(106356001)(81166006)(8676002)(2906002)(65806001)(3846002)(68736007)(69596002)(64126003)(230700001)(23756003)(50466002)(6116002)(5660300001)(76176999)(36756003)(586003)(87266999)(65816999)(54356999)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2135;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR07MB2135;23:ElXbtTsqMUW9ietyp3PGFo5tsjhKBd30ff5UYeh?=
 =?iso-8859-1?Q?HZ2dmu0sECVgEmeRvuJ8VaWHfza/w9wMm5Szensdjvma7XzIGsFNJBmI/l?=
 =?iso-8859-1?Q?Bsi4fV+vZnRQpDmO1MaHIkzJmcQg95YaHRAfma1IKvWULxhvo+MFW7UFJO?=
 =?iso-8859-1?Q?yX3AEsgAAz2phz+Aq6tJNZCx0SR29GaixJjGqUIJfIvCXAqtXpeIGUT61O?=
 =?iso-8859-1?Q?2NXLlYt7UjnXyI3+85kQ/RUueOxx2Jt0mTo9KBdJAPeNWJz4xxi1ipHXA5?=
 =?iso-8859-1?Q?CZgiLrz5xAmD4/WkOFrHjRPSy3DvWfivrxFlR2Z6l4TDCjz0+QLzVqFWRg?=
 =?iso-8859-1?Q?ICnaXUOoPQbqZC5Y9upxloiMGlWqUzhTL409OIMbu5aIB2umiwYeZQh9iB?=
 =?iso-8859-1?Q?UQNtlPE7iJptiYe9LrCEBjfJzVaVsXd+ycCI4AG9bX7zGREWurC7SCMwnK?=
 =?iso-8859-1?Q?hf6pg5FR10j4Q6S6ykA37WNghW2jUeVxLOkZ0O4TjX7pyKNx5psp72jc71?=
 =?iso-8859-1?Q?x9kUnXfcnX9kAPbObsBSAkQ+spULM5m8MsiZ1Y6dSnFDOdGiIfxUw0bTBg?=
 =?iso-8859-1?Q?+6xF+YK9V+YOOvdWdCOszgxSfHOwtmNpyrr0vGsrt0TFPV30xAGb3e/T6m?=
 =?iso-8859-1?Q?WYAE+WYZaFG8XoVQaHnxuRYDzFDa8/t7weJ7A+ly/0VPzJ91j7AcB3NZGZ?=
 =?iso-8859-1?Q?jyZDQmL6wdpSkfu7xdg5xLpdnvaNfk6ovek+t4ueX54RVjmEqKCu1CJKH0?=
 =?iso-8859-1?Q?YrQegNgSG4raS3T3B51mEXreCXDXhTcj2XfxPJS7/DM/eY9yZWFnv8dc0q?=
 =?iso-8859-1?Q?c75kyY5pQG8PEk7qzUVSObjImsIs2+79xHHR7rRqzQLfqTDgkNoCeNPqvw?=
 =?iso-8859-1?Q?mWlPjoMwXZFktR8h6xtCugRghyS+e0zSY4Uk6KDhqnMtNRc/uP9LC1hTDP?=
 =?iso-8859-1?Q?dwbQtLPY4KR/6uHDGUmw3x4WVy7XzTm13ScTVL7kbD8sRg2O16yOZOzfda?=
 =?iso-8859-1?Q?Tyqym/XP0cHOYTOQP034KTtsKqfj/YajAkxyqS3PJ9mbtnJGNt+ZSE0pyc?=
 =?iso-8859-1?Q?nS4ii4bz26NEHGj+uG7O3dSlKapzpfUKn40/IPzV3ZqWbnjq4jNTriXXo0?=
 =?iso-8859-1?Q?UglHu1750cpGrIA+QZ3/0FHE7XF6cwPMlhxZ6WLa9WXvISMYD4l61In0pI?=
 =?iso-8859-1?Q?GBHlj7VX79BIoAqmJ1KEKtLhcXJS4gYx+WEhmg+Z/2n9UZ9NK/HesqOX3s?=
 =?iso-8859-1?Q?t3kxmBu0Pnxwe4bnPA+On24bI1tma0w6hHkMkipGBakq38GnCQFVn3x9xo?=
 =?iso-8859-1?Q?gciDlPzxTXXDGorH2HdWEpeoUCiO5fEf5Y9Q2+KbHKD35qJag9CHzDvVvL?=
 =?iso-8859-1?Q?5FC8ZoeI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;6:PDLodHeeh5tdZLCSGh6Dc2ikgO7djYtFC0jmFzfnzcOfnGfyC3Y+r8p9SFEyjVg4wa/5pr/lMODaaAPTfbj+z0YCE4xdNb8A3lZ3Kv7R7Ne/gc8An16Id4cOk2rknSnn2TfnVb4FRUV1O6NPl3bc2c13j/COhMeLDxBd5TUxxullRRuKfV+FGJ5HTGmV225S3UdJhh7tPFmVRL4ZkrefzXAh6y3UdAhJxRlmbkjhGJi77uI0OS0Bf1DT5FaLJvy5/FNTwXW20K0sdMjt+YZJCBMXqVrWawqD/1XHmZVfdx0=;5:bM8AV5wjBWGzvQzLQl7HIYWT26Wlfc4zP1qj9pVthLe7B67UvHZLA1lclepeXIGHWbzbmCf21jQt1lTkEznpMjBHo/KPLzFImiidId2rzdMAC+w8C6geX5/3CSwNd8uQfrzxmW6zuq23WDTLr2oRQw==;24:m/GtR+pfnbTp16iVLPcdQB1f6sO5k559wRarQ3W/d1IPqXxt39dg8qx+Q1GPWx0uqU6EqWMaGnL6z6ddq00nvT6i0GO0QRbT53OKAlNwjjQ=;7:bRhTK1a0/e1bpCIOV3xsX+UCfjfRI4oYz41cPc4wPxUoSusSJyybwqV3J2EWuAvdK194oBs2KBzwoz14GBTDpoUFnUlRirwQP4Yy8OPTK6iveDIaMUTjfE9uOBG4MdG+1fUpc9xJRTuA9g+ogkPZM3rzo9eaoVsQZyFTnQT5C5v+zA88175oMLAiIL1fLphJn5HaYzGqUe8bQ4Zuopk7eqlEH1ffKi20h9xc0RbYvmMy681iM74tNgwK63ydGnKh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2016 23:00:38.9160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2135
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54961
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

On 09/01/2016 01:43 PM, Aaro Koskinen wrote:
> PHY access through the board helper should be impossible with the
> current drivers, so delete this code and add BUG_ON().
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   .../cavium-octeon/executive/cvmx-helper-board.c    | 110 +--------------------
>   1 file changed, 5 insertions(+), 105 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 5572e39..8d75242 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
[...]
> +	BUG_ON(cvmx_helper_board_get_mii_address(ipd_port) != -1);
>

Can we do WARN_ON instead?

No need to crash the kernel for this I think.

David Daney
