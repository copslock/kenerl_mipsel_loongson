Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 23:42:09 +0200 (CEST)
Received: from mail-bl2on0089.outbound.protection.outlook.com ([65.55.169.89]:43343
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028019AbcEEVmFrBvT5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 May 2016 23:42:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=I2q6107VoxC4uUChP1/xvo03U/zoBUWqG1th/7G60cs=;
 b=f5+50TOghtt40HsKPZxMv4rlouQDBcWFhb+Q1UI3aLT5DiNeBsdEEaoi6ZntBt8C9q56yZ6iPCtKczX8kwPLE5GtBGC3gW+T4pDcByKBy4TXHCnilXBr/40Ou4djlYLSNQCY8wgmQW9cQORmXohfI0PfImzUa6ojIogfd/PlLfA=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from localhost.caveonetworks.com (64.2.3.194) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (TLS) id 15.1.485.9; Thu, 5 May 2016 21:40:10 +0000
Subject: Re: [PATCH] MIPS: Octeon: byteswap initramfs in little endian mode
To:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
References: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
CC:     David Daney <david.daney@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <572BBDB8.8000300@caviumnetworks.com>
Date:   Thu, 5 May 2016 14:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA092.namprd07.prod.outlook.com (10.160.24.47) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 70ecf0ef-fb3d-4402-53f3-08d3752dd5da
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:M9LzwnYp2Ar49es1tvsssE0AKBsOumx/lPyc5iAllN0DS+ax8Ea5k6HXlS76msZwIZKhpQwym7jL1c1adHJgx5WArFcEtqPVNaIOIrVt6Z5bSMUcTabpkb0DxxHBjkmFtfFl+1K6lHiPtqGNb8vCgHebtaLaGvcB03e2M5kImHPOzcVBhGZQOgEvYLkD1bC9;3:OBBwBMXMXmD6RDuJPhBrlQbI569FuafRleCrf1T0G6/H+MhgDk6ISKI0GhGvg7nErPoa9fdcU+yqftMp/Wd/2WzHAoBtAFvRprcsMWW28v7xedj8Yi9ZSbScQRCwWXVD
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;25:IZrFmyTaAmoNdQQ8u+3cUqpmC1tngubE9t8N4+7W63ESjQ4ZXneYzcwagiaBzwBSiclZ5zvACBeRvltX6zxR+zepDnPXbbWT6nuSQpXnSix1VkGxGfWxHe6xBOd5ENwefYTPVsPB7zBUvimUfuAfmAUSgItpRWJ/fpLAnDwIkFWfdj5CKjudayOeG1sE9KNgEWKb1EjQqHH5omBB/m+e2ZX8bDuw5QTLR85r5tXp6xAAT2p+mjZUVcimoULNeplBFFfxzr+loGLc9n8tiAlyFXQOJAutDLcEqVppYEIprhXeAL+0oQQ50iXSm0v7bsACRm1Tgt5/2BPjabZVMFEwde2i7A24SCECtEKfvytSy2LniffTXjcl50GCZLAFy86vUGjeFi/mXCiOSXm9Ouci93SdQJwnO2YxeFYIc2sT5qztwujdivhYgflgMqlej0Lgl/loeKXm1KVIUqaptI5wsV43zlYDli/OrKhpl1tHXN9xigwB4yFkJS82pdQcAGJn905C7+0MU75zKXLEBfBDdgjxbiB4YI82kZDCEA2EzaOI/g5x5/XGwqfuOBvU+W3y9FLKtqNM0Sm1FiJZFOxKYaUZDNJHznyt9VoDRpPGCbO0V+StlCRdmhCkrwBxUUX+MK260pYHh7bvX5L9UIps+CVbzt5i/F1rGsBQgrJIyyd+Qa59/N0qkKieX8K2c4LWP3EE5CRFoWEwO3rj84iVqAcdIeuEXOsEoCKeKTwZHAcjQyDVXBCuqLkM0r/raI/M3PZGEFNtcl+yJSDKbljQnYZAepGuEOjqI2zdiTbYFBk=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:nxJZKGxtayJi+Ca6vKi3UUPxUTGXUK3FhkjcUmPc5tgUcD2fKHyADff7cM68Oyx0moMgy2mfEFD2N8kOt/OCUdUDh6L4yFIe9SfKB+DqMZFnSKf2ChpomCXDUQ1Z5tsFwDw/Six+Ue62Qqw1L7Rk6QkrzqHAVoDokVPATw7I5KPPR887uJVp94CrTljjOZBN4f62PMB8YfNoEFI7+5usn7e9gM8m1GBYNP4n8MrQG0GMF3Jz4WWmvArTF59gbrpn4YLzX69Aqf3SJtBxgK4mJBvqfC/ucOGNW54dvdF9gW4ikGu8kEfplkSZKlYwK8zcFv+AJF3xFf1QVhc0eN5my4rBVKVJPraG+kgDgPWdAXTcOT73IuFmnr2UlAsm2faKIZAXFK1+j8y5S/Xqq1QaTzpm7pgxJyf7CVzndQ5plDu9HwEKtGFmx78y7NlQaPSc67KBwQgkmQnYNDVQ5QFyBfnetET34seUm7w6cuixCSdmV0hqjl3374UN43qaZP5is6x6hR4Yf5uexoezHeSLw3SVBIVLumR3MKqUcbGZtZX7P2Jt0cZlFtopMEne/VYwNXxWj5lp7dD+8y8Y8Ckg1JuRyC2bMwZMosc02kVEs8Q=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2129FF252EA9488FA24C2B049A7C0@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(9101521098)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:ZXOYGk5V6y5umqry1BJMpFWCEiAfyMBWL9wGSrC6I9cyntbtY2M47dN8zXaBqK/IT5crqAbJ1cLzlZglS+JzfoX4Vozgb4g1e5mwqzUsbvXqjI/ydBPzTAkXMOEyu8JPjMpexVBXzElemQ8oCP3o9NRVHDiVFDp3zsTBxEJMETncBn923sVef7DKpP4PVHntX2/E9eGMLs/7AJSfU6LYD/eOkk7dlKa9pEMbOR8gzIPODu1iP0ij0pXTYfM3DNB+CqBTPpE0rtmXbmeo8P6SZ8/oOs83lUYco7jLBXnHYmerdhBEoOFf64VCGXTMSZrZ8XNxDtjOwFIP0ZF3btlmnOge+Hpb0Uui5M0G1AwFvLzAWdWQBzQGtPywy2FkejFrA1xSkh+yfkbe8suBogTlXA==
X-Forefront-PRVS: 0933E9FD8D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6069001)(24454002)(377454003)(5008740100001)(36756003)(65956001)(47776003)(189998001)(50466002)(4001430100002)(65806001)(66066001)(65816999)(76176999)(87266999)(107886002)(80316001)(19580405001)(2906002)(19580395003)(92566002)(50986999)(54356999)(4001350100001)(42186005)(4326007)(64126003)(59896002)(53416004)(76506005)(33656002)(23746002)(83506001)(5004730100002)(5001770100001)(586003)(77096005)(81166005)(6116002)(3846002)(2950100001)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:localhost.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN4PR07MB2129;23:4eWzENYfJIFh3Y3bErTqW4LpWxB3sWf/K/mU2?=
 =?Windows-1252?Q?+V0yL0Gp7Bu1E5Z+zXK8tnKPo5rkl3eopGSDewmblCDVvyHr1DiEXLaj?=
 =?Windows-1252?Q?FJ8IomS424O9K8p5IGrpyT7FS3XME2U4gf5QDr9vyetdJXyDhmulv+Mk?=
 =?Windows-1252?Q?Mj7eLm1s8lTTRzEL6XncCkbs3DPc2oQvCkFyqs/RUIYGwv1bi3jRl/kn?=
 =?Windows-1252?Q?8WC5OWunt9PCXruUE3Mb54DKVLILX1cs8lJeAkQ1LiOvazxrWoAiyJBi?=
 =?Windows-1252?Q?rObTFss1BCsEwSCT9jdrkXk6/g22z630KNoxmXqfc5sLPp23EeD97BTw?=
 =?Windows-1252?Q?qrCvj9voIvvkPvdIlFHPmkEvgfuJpKA5D/3u+JOrB5ThSfIqe9rgAj3R?=
 =?Windows-1252?Q?zEnRgyCqGDTdQYwXBpXgs3ZMwsXXonEV3hYfgr2ZLneqcZtImj2zW5Dg?=
 =?Windows-1252?Q?iE5xw32Cxg/wzsQZW2h3yZGJ1MfbW6iBvxVdE+7WXiIgiulC040l1cbD?=
 =?Windows-1252?Q?tXYgGYR5eR1iZ2pZJL405mZYZ4KCyWFPBy+i54I0/X/qgiTROdoW++1Q?=
 =?Windows-1252?Q?SD0tzaAHOMtX5nTv1W5ahOrzQPHw3O+iUHNeFrgGGubr+p5U7s28lYPc?=
 =?Windows-1252?Q?GSEcl5psObXZ8iH0Rsxl+KNf5pfpuzg8sw2toho1kjE48EY8X28EFTHk?=
 =?Windows-1252?Q?tsykQasxFZjQ+fyScolVQ8KBoMV/5Mki6cZkAteqNQRfQzBAh6LAjiI5?=
 =?Windows-1252?Q?iq5dCiIA/UDhO1/qdL0UTC4rbDtvcN4Nxt+qrCs53ZKMYvfeq08JY9Nl?=
 =?Windows-1252?Q?OuAcWubLmPnZlyTpoNim/iQyZXEV2L4GvoH1yAdY2zbFRcepGTdDw2Th?=
 =?Windows-1252?Q?Kkhm+yl/TFo+RmYjn7Z+RAiTIXtvz2tw1ZD8BgiUm4+631m9DFcAsS3+?=
 =?Windows-1252?Q?VolHQfJifagv5KeLVYAby15sCTvWtViJqdFvakTjmHGsKtVH1IYs7z4Q?=
 =?Windows-1252?Q?4ORlRmAZ+vNJAGWQStdKHY7EHclVpt4R5//vIeQNQbRZcw5SJwOhQguE?=
 =?Windows-1252?Q?WVTwnGtO/zde8lLl3p4DlENvTpuWLz2FcWUYHe5SziYWULoMztYRpPAN?=
 =?Windows-1252?Q?aJNne+KHQW/tbMR290Kr73c3QhNoxUP3Bj/eYaeE3paKKTr09COZ1uGe?=
 =?Windows-1252?Q?jmauWabt3BCDbnePHWc25KrnTOaYEqnLoIRzuYFKA4GsyjOjKU3q1Xx7?=
 =?Windows-1252?Q?KuCgb7UJlx0dLF1XtFV7RdPYJKfvRqEyNOu8qM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;5:KpLsZ9YcdlZ7Z4tNBd7gxjR5nnKJ1u5V6yxcS6qTZor3AnJZzJifvbhFasyhokpI3b1W4e1YQjAMZ95T7kxs4ZP2g9jQmQgBD7KtW4aCLB9AbPI7Y567MkTDjekCe1XEfcAAWxFR9La/ohuKYgFQgQ==;24:r1GWQvRTXLuhXsggYW1ezrE2K9DsvGdYgq28ISNqusURNVgV0CpeZUHuk82Q7t+UWEdIPUusLNSqPiLLEjCQLmp7hhLy4sUWhl73BlwtdHA=;7:Yn72umz3PJVOrfX8IFSEtEeDHYrYsPJL73ih3a6P/ACHkoo4/sWurPowvk6AwOQsA1BwS8uiNfn7G2FBaMAJbhML3C+mwRk6X72Lwt6kDYwQDUtP18cecffTk7G2WE7PxNDwLtDQlDM9VsFlsm2stl5WurQ7i9npOV5oFPK5E47LsBOG6zjz3/uHimTxkheA
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2016 21:40:10.7142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53285
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

On 05/05/2016 02:33 PM, Aurelien Jarno wrote:
> The initramfs if loaded in memory by U-Boot running in big endian mode.
> When the kernel is running in little endian mode, we need to byteswap it
> as it is accessed byte by byte.

Ouch!

Really it should be fixed in the bootloader, but that probably won't happen.

I wonder, is there a magic number that the initrd has?  If so, we could 
probe for a byteswapped initrd and not do the byte reversal unconditionally.

The logic seems correct, we need to byte swap each 8-byte aligned 8-byte 
word in the image.

>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   arch/mips/kernel/setup.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> Note: It might not be the best place to byteswap the initramfs not the
> best way to do it. At least it shows the problem and what shoudl be done.
> Suggestions to improve the patch are welcome.
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4f60734..e7d015e 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -263,6 +263,16 @@ static void __init finalize_initrd(void)
>   		goto disable;
>   	}
>
> +#if defined(CONFIG_CPU_CAVIUM_OCTEON) && defined(CONFIG_CPU_LITTLE_ENDIAN)
> +	{
> +		unsigned long i;
> +		pr_info("Cavium Octeon kernel in little endian mode "
> +			"detected, byteswapping ramdisk\n");
> +		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
> +			*((unsigned long *)i) = swab64(*((unsigned long *)i));
> +	}
> +#endif
> +
>   	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
>   	initrd_below_start_ok = 1;
>
>
