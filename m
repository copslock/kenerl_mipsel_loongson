Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 00:53:57 +0200 (CEST)
Received: from mail-bn1on0096.outbound.protection.outlook.com ([157.56.110.96]:21472
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028096AbcEEWxv2pDkb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2016 00:53:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pHW4Ezk+5x3TojsxWMs8R+dlVeDWfo9mLeCX8IbcW+c=;
 b=XfFUreecRIjbrqUemKeVn/y/kYbJ4uHOhnvVw3jGEnU+O4wGrOp3yazO4qELUGuAaHhxwxTBbDGUTUmIUG5Xo/kPVtsanYWlJu2OYy0kDd+deQGRa6qjdp8sEnSiJP4idCWUsU0jE2YmlnjXHj5Q22tsiPBNY1KEFFdW9eWCXgM=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from localhost.caveonetworks.com (64.2.3.194) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (TLS) id 15.1.485.9; Thu, 5 May 2016 22:53:05 +0000
Subject: Re: [PATCH] MIPS: Octeon: byteswap initramfs in little endian mode
To:     <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
References: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
 <572BBDB8.8000300@caviumnetworks.com> <20160505221649.GA29979@aurel32.net>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <572BCECE.7040600@caviumnetworks.com>
Date:   Thu, 5 May 2016 15:53:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <20160505221649.GA29979@aurel32.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: CO2PR07CA0030.namprd07.prod.outlook.com (10.141.194.168) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 99621327-6811-4104-a22c-08d375380552
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:l1+cVlsaiw2hp8ua9OVe+cx0pX/FEWbAYcYKO3nHM71Ak7QuJP546YA0tni4paG5RnfPm52hbWqaKfasfXYVmL0EdorENxRCDi+VUWnGXoBs2j30w5+n0Is9h7awowtFdaRjtMZCNFSCv5PFqAhEYqgTXnwyg3yKYBYE5M4UWqiVMxONc+xaYShUUKb69imM;3:ncP5q3Z3ccskEYrQgsSQ3dc3BYYeWv8jVpXFhs6Ds8xBeCEd7dK+b7OUN0OFfZxY3XAb7BR+L6juSVNInJ5x4UmdF/Lvgl861nyHXrfo5SLoBO0YY9BSJm3i3C2BciGL
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;25:fZwjL5hhkffBpsJ5Vi4ECC5AHX/S3Eg73XzEs4o1onlBQaDA7qr4JlWzxz+0T8sm78BDTw1mtpZgTbsWpsSj4inmWnfUzj0U+rRFboByfv4zCdy1rE85g6uiIPqWx8xOesC+9XX7fVAztbm7UgD44XmbD6lEPfG5Uda/iKeI+El+hcKLKvOOuFzdfcBhLD/J/6DuwZhfKDN27gOSwqfWb/uTs5+UyYWv7spwg6Lr4WqBctE0LbtaLuR4b6+fFffiFFQ5r148HoCOnTte42pfHkrk1oe8HPwIMqzxg1YydSX49L6wuv7hT566QbFmBRTOkvxnPGswWgI7CAdFb7XvRFtL8NsgcU4//pbcc0E1/5FAvbDvl3ENk0bClvKYlUxP4x1e2l6sllgVILWw2KrVu+S73VAqMQXMYcGM1nyeVY3A7wrQ+cIIAW/NG4yRQ9y+KQAUMPuE/64TTYGi2gvnNk0VeBuTIQo+rk3coKvLZWpxDx/JCNzV2RBBTBv3gNSbg6mVFSVoxUb0WUsAfNYAN1HlB/omICVYeymSeiNjmb3LgWRQjr1spozLq3jPsSx4BrOGOd3ykyYiuO1HO/PmHO1evDCAiE61E7di8Ciw3v/5HGGs/p5HNbHmaDObzSD9eKuYiTm6d1MdaHv7BdlSFN3CwgJwgq4M64OeuVtkOzDVexsoimZv9HdF4wcNEAW4OiOKThQ5EN+ud8XRYGVqX3fDdqA12/mAHd8YJF8WID3massduNYDfSznUEMuCa/CzegBGCCpqR8iEmafeo2tEg==
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:UXrEeyzfcQftV/9RVwCcJ0Bg7B+wqjUfzjzc4nb0CffGHbF/0IHqG/YjZ7wrDtcKeFpx/a/2smA3Yeg7G7arPINcB8oW3ZTJLewXHPzdxQuWAbFxRc+pY9tJF1auX2cbfFK/Q4Bf28Zxrz1/HwHvNHrbaGqnEgOpHqnv7vwKqrErca6yxW6JOC32FanF+3D/ABTs8kq/sD2r56pbHSqdoiKg+nUaPXX192X4tyQfsNrYBtr2+24Wwcm94BL+FEHX0Vru8kzQG5uM7gj8QbC7aP9eeWbko+MuePZTK9efRUbRPuwvRMQSBZ+pgpcvlt68Q+sHL+s4mvNeMkpSkp3j+vTizaemPiHqj+IEH43LxFgJA5L/PsTdTgS6aUVpBqlkG4ugB2Bjyq+fo8OeoCf4qXD4jKwCLjkbCpNVREULWaQNBTIEg8z/ZoyhZB8bY8X8sNFLCpXJjAP9GUvAh+j5wo6Pw6eET/JPj4RH2DfhICJjXKuxYaw0iE+vng1aZbO+HuTxg8EWzd1q+TWFVyF/ZNNiA8EkL93IPaIiy3O9xMZ/uSges93v5bzRxx+lmzBicvgJOgPNphvYMbJPZwmUBXOpSH3hQhLv9VAZwU/1JYQ=
X-Microsoft-Antispam-PRVS: <BN4PR07MB21295AD51EDF7699FA1D789B9A7C0@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:Bgkam7M6co/woQ8wl1eD+Rp/3yj/YuszZi5b92NfFH/6LOk2dZb6KTecNfym9lr6uBMQaEmtv5EhVE07jj18rpq2BtwsUUrl148qNzRzRHF13KlHyy5M9ganfSwCm+TMpSO69RxXD7cYclHvb9/omRr3a/aJANHhVr0A1m5oE6t+Q4PSREj60I8n3eEwhqGZXlZxSwJPsuUqBgScdhunNMI0LYb80Gf3U2KpgcwcrIOURU1YGT7OBmD1p54zLJ65nHeh/NsS8ED1NIFSDoy58Inl72/N59nbPRW2PD52ohvK96ztC0Ph+HPA8XGNP4A1oE3msSYx74nw8i3BP+uxJo1apxzoWsICtHhxG+zRZmaTx9IZsGhx8EJGNF9eU+bw
X-Forefront-PRVS: 0933E9FD8D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6069001)(377454003)(377424004)(24454002)(76506005)(53416004)(33656002)(23746002)(83506001)(4001350100001)(64126003)(42186005)(59896002)(77096005)(81166005)(4001450100002)(586003)(230700001)(2950100001)(3846002)(6116002)(5004730100002)(5001770100001)(66066001)(65806001)(65956001)(36756003)(5008740100001)(189998001)(50466002)(47776003)(19580395003)(450100001)(50986999)(92566002)(54356999)(107886002)(65816999)(76176999)(87266999)(19580405001)(2906002)(80316001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:localhost.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN4PR07MB2129;23:lCCX4qO9T+mT6hfYIPitC92cUSnnX5O2pORxo?=
 =?Windows-1252?Q?ha6bd6DVhQSfs4IoUI0K1ZbQ46fMnEivWisBSA4hCvgOntc/0CWsNmUC?=
 =?Windows-1252?Q?3NRp3Jb3cL8ZQCAb6Ku02PznI/lhuWOW1PdSP53IVAqkWUyHKwd9afs7?=
 =?Windows-1252?Q?ARKCuGX2inum/F6vjVOBS/iuVMzUYJYp78Q7/YkJrHHolo0NGpNLGAhR?=
 =?Windows-1252?Q?MH3PqmiP3gBIL4dgIK2wRYuU7fSwcjyEOoO52n4cB0w6wIUkpgnC4M2E?=
 =?Windows-1252?Q?9Sj7NApr9sVDRIJoPl0zkpiaxwqIOG7bDA3GI2nMOOvjCGWhNuT70oDi?=
 =?Windows-1252?Q?xXKEf8E62/qNCa1cZXqojzEXeJo8dBKHvYZnRpAQ8dbkh8qb+obAKa2/?=
 =?Windows-1252?Q?4ZXXWUo/M8LvnlHAejxUWzY9NQCk6yFJyXd+Fdl7PEDSW3odUoPsIqeF?=
 =?Windows-1252?Q?x8/GmW+ffnEEAkC8eM198YgLlbCH0GGuBbygNo1rVwEqeKb4XBJPMlYh?=
 =?Windows-1252?Q?3b6BaJo12WejJhHH8WVf/1gb7ukFtN85djjdJkX3ao/kO78U+kOAKHk1?=
 =?Windows-1252?Q?DbQLLV2HVGnUxm/BRWhVMTiy/EWScp1W8HSC90zxvu2O8fKRLJ8qD6Q2?=
 =?Windows-1252?Q?gpJRicwOMtZytaH/nKleIi9ovORzWAsHGDFRQztRM60FlgSRg1YaC3VH?=
 =?Windows-1252?Q?D2DaT3RhDiwJzAAb6GSYFhDXjacfScBp2DLYnQjBn+MrP5CIkxOl5zGa?=
 =?Windows-1252?Q?b10n24QkH4LwjYP4nBiMfJbOSXeQY6kOq4yMmnI26w3zeM12MKTotb/q?=
 =?Windows-1252?Q?j7jZXsO4v2JrCPXWOhRWd28om8Bg9grYCYz4ljVqb2XwlcFAk+bg3nVl?=
 =?Windows-1252?Q?bCMdCy0G02uBFI3xbqryOlaahiMZGnw+Os03EFgYWppwConEqtnEIRhL?=
 =?Windows-1252?Q?fLBzzYOdNwwSl6VZ+rz2qrh4BCr5MkCXq9OfnGFzNFO8mnkWbeJKeppg?=
 =?Windows-1252?Q?xsWjj5yyIF/WgHpqHJ2Yw73DrsSmFKhnJhQO4QglzrJFdggU+P4HegV8?=
 =?Windows-1252?Q?2ZU0We5R0ze4FkWwhBumna7ej703DcKmDmIr2rgR5sYpd9+VgvterikM?=
 =?Windows-1252?Q?qymm7fmlzGcGtc806l6UlTf6p2dL1wCL5j2H5IevkDx6IMHLe0n8C/y2?=
 =?Windows-1252?Q?LidSbBK+chpRp0zB2lgjbc3Vq0rkGxRKy/PF0XrCgboWXkRVEmUKWZ+B?=
 =?Windows-1252?Q?SqJnoPEIEx/7TCSIK1KKZY1gB1J4/tMeeD+PgJtYu/fylKy5e+9LTXND?=
 =?Windows-1252?Q?tUV?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;5:+JHDPq4qk2S8uoMb+18XxC7w5mK+cnOTQoU7of8ed/NGVz/aCULcmMfblG7+k0MBXqwDCmCjG9m32p3otmHntbH7lOFwyowEzcrlIhVc3Y5UvN6dnkHbieJkWp/W2Pheo1sLhUk06gDk77cNzkcAQw==;24:BK2Z4L8ZZFAx9zOILG2wsZpHqfvWIh8xi05ScNG+58pc/97EYJi/50aLvBqBAglAE99jm1vi/fG/UL7bpQA3Dhlf5G09VpY217KTuzlvIf4=;7:EEugQZCjgb/7MOA1DJm2obSF+UE+VuHDkGecp12312oVNaAFwWhnnFUAYsjbm1y0taHKlrpAoJxgekuM5aCTda22c+lGGJ8x8XEbaDZ/fhsYwj+4kVTzC6x9kv0bjkktM7qmsin3XljTfsXH7XQKWeuC9PIdELNXEgb/8yIPNRCpcpYaySJNwNuVI5HrnJ0t
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2016 22:53:05.3385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53288
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



On 05/05/2016 03:16 PM, Aurelien Jarno wrote:
> On 2016-05-05 14:40, David Daney wrote:
>> On 05/05/2016 02:33 PM, Aurelien Jarno wrote:
>>> The initramfs if loaded in memory by U-Boot running in big endian mode.
>>> When the kernel is running in little endian mode, we need to byteswap it
>>> as it is accessed byte by byte.
>>
>> Ouch!
>>
>> Really it should be fixed in the bootloader, but that probably won't happen.
>
> How would you see that fixed in the bootloader? I doubt it's difficult
> to autodetect that, as the initramfs is basically loaded in memory
> first, and later only the address and size are passed on the kernel
> command line using the rd_start= and rd_size= options.
>
> The other alternative would be to provide reversed endian fatload,
> ext2load, ext4load, ... versions. Or maybe a better alternative would be
> a function to byteswap a memory area, it could be inserted in a bootcmd
> between the load and the bootoctlinux.

The easiest thing might be to byteswap it before u-boot ever gets 
involved, and leave the kernel alone.

>
>> I wonder, is there a magic number that the initrd has?  If so, we could
>> probe for a byteswapped initrd and not do the byte reversal unconditionally.
>
> There is a magic number... after it has been uncompressed. The magics
> for the compressed version are defined in lib/decompress.c. Maybe we can
> call decompress_method() from the finalize_initrd with the first 8 bytes
> byteswapped and check for the result.

I guess you could look for magic numbers of the supported compression 
protocols (gzip, xz, etc), but that could be error prone.

I don't really object to the original patch, but was just trying to 
consider alternatives.


>
>> The logic seems correct, we need to byte swap each 8-byte aligned 8-byte
>> word in the image.
>>
>>>
>>> Cc: David Daney <david.daney@cavium.com>
>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>> ---
>>>   arch/mips/kernel/setup.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> Note: It might not be the best place to byteswap the initramfs not the
>>> best way to do it. At least it shows the problem and what shoudl be done.
>>> Suggestions to improve the patch are welcome.
>>>
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index 4f60734..e7d015e 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -263,6 +263,16 @@ static void __init finalize_initrd(void)
>>>   		goto disable;
>>>   	}
>>>
>>> +#if defined(CONFIG_CPU_CAVIUM_OCTEON) && defined(CONFIG_CPU_LITTLE_ENDIAN)
>>> +	{
>>> +		unsigned long i;
>>> +		pr_info("Cavium Octeon kernel in little endian mode "
>>> +			"detected, byteswapping ramdisk\n");
>>> +		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
>>> +			*((unsigned long *)i) = swab64(*((unsigned long *)i));
>>> +	}
>>> +#endif
>>> +
>>>   	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
>>>   	initrd_below_start_ok = 1;
>>>
>>>
>>
>>
>
